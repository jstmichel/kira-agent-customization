import { readFile, readdir, stat } from 'node:fs/promises';
import path from 'node:path';
import process from 'node:process';

const rootDir = process.cwd();
const markdownFiles = [];
const errors = [];

const frontmatterRules = [
  {
    label: 'agent',
    dir: path.join(rootDir, 'copilot', 'agents'),
    match: (filePath) => filePath.endsWith('.agent.md'),
    required: ['name', 'description', 'user-invocable', 'model', 'tools']
  },
  {
    label: 'prompt',
    dir: path.join(rootDir, 'copilot', 'prompts'),
    match: (filePath) => filePath.endsWith('.prompt.md'),
    required: ['name', 'description']
  },
  {
    label: 'skill',
    dir: path.join(rootDir, 'copilot', 'skills'),
    match: (filePath) => path.basename(filePath) === 'SKILL.md',
    required: ['name', 'description']
  }
];

const sizeBudgets = new Map([
  [path.join('copilot', 'agents', 'kira.agent.md'), 10000],
  [path.join('copilot', 'agents', 'kira-build.agent.md'), 10000]
]);

async function walk(dirPath) {
  const entries = await readdir(dirPath, { withFileTypes: true });
  for (const entry of entries) {
    const fullPath = path.join(dirPath, entry.name);
    if (entry.isDirectory()) {
      await walk(fullPath);
      continue;
    }

    if (entry.isFile() && entry.name.endsWith('.md')) {
      markdownFiles.push(fullPath);
    }
  }
}

function parseFrontmatter(content, filePath) {
  if (!content.startsWith('---\n')) {
    errors.push(`${relative(filePath)}: missing opening frontmatter delimiter`);
    return '';
  }

  const endIndex = content.indexOf('\n---\n', 4);
  if (endIndex === -1) {
    errors.push(`${relative(filePath)}: missing closing frontmatter delimiter`);
    return '';
  }

  return content.slice(4, endIndex);
}

function hasKey(frontmatter, key) {
  const pattern = new RegExp(`^${escapeRegExp(key)}\\s*:`, 'm');
  return pattern.test(frontmatter);
}

function escapeRegExp(value) {
  return value.replace(/[.*+?^${}()|[\\]\\]/g, '\\$&');
}

function relative(filePath) {
  return path.relative(rootDir, filePath).split(path.sep).join('/');
}

function isExternalLink(target) {
  return /^(?:[a-z]+:|#)/i.test(target);
}

async function validateFrontmatter(filesByType) {
  for (const rule of frontmatterRules) {
    for (const filePath of filesByType.get(rule.label)) {
      const content = await readFile(filePath, 'utf8');
      const frontmatter = parseFrontmatter(content, filePath);
      if (!frontmatter) {
        continue;
      }

      for (const key of rule.required) {
        if (!hasKey(frontmatter, key)) {
          errors.push(`${relative(filePath)}: missing frontmatter key \"${key}\"`);
        }
      }
    }
  }
}

async function validateLinks() {
  const linkPattern = /\[[^\]]+\]\(([^)]+)\)/g;

  for (const filePath of markdownFiles) {
    const content = await readFile(filePath, 'utf8');
    const matches = content.matchAll(linkPattern);
    for (const match of matches) {
      const rawTarget = match[1].trim();
      if (!rawTarget || isExternalLink(rawTarget)) {
        continue;
      }

      const target = rawTarget.split('#')[0];
      if (!target) {
        continue;
      }

      const resolved = path.resolve(path.dirname(filePath), target);
      try {
        await stat(resolved);
      } catch {
        errors.push(`${relative(filePath)}: broken relative link -> ${rawTarget}`);
      }
    }
  }
}

async function validateAgentReferences(agentFiles) {
  const agentNames = new Set();
  const frontmatters = new Map();

  for (const filePath of agentFiles) {
    const content = await readFile(filePath, 'utf8');
    const frontmatter = parseFrontmatter(content, filePath);
    if (!frontmatter) {
      continue;
    }

    frontmatters.set(filePath, frontmatter);
    const nameMatch = frontmatter.match(/^name\s*:\s*(.+)$/m);
    if (nameMatch) {
      agentNames.add(stripQuotes(nameMatch[1].trim()));
    }
  }

  for (const [filePath, frontmatter] of frontmatters) {
    const lines = frontmatter.split('\n');
    for (const line of lines) {
      const match = line.match(/^\s*agent\s*:\s*(.+)$/);
      if (!match) {
        continue;
      }

      const agentName = stripQuotes(match[1].trim());
      if (!agentNames.has(agentName)) {
        errors.push(`${relative(filePath)}: agent reference points to unknown agent \"${agentName}\"`);
      }
    }

    const inlineAgentsMatch = frontmatter.match(/^agents\s*:\s*\[(.*)\]\s*$/m);
    if (!inlineAgentsMatch) {
      continue;
    }

    const rawNames = inlineAgentsMatch[1]
      .split(',')
      .map((value) => stripQuotes(value.trim()))
      .filter(Boolean);

    for (const agentName of rawNames) {
      if (!agentNames.has(agentName)) {
        errors.push(`${relative(filePath)}: subagent list references unknown agent \"${agentName}\"`);
      }
    }
  }
}

function stripQuotes(value) {
  return value.replace(/^['\"]|['\"]$/g, '');
}

async function validateBudgets() {
  for (const [relativePath, maxBytes] of sizeBudgets) {
    const absolutePath = path.join(rootDir, relativePath);
    const info = await stat(absolutePath);
    if (info.size > maxBytes) {
      errors.push(`${relativePath.split(path.sep).join('/')}: size ${info.size} exceeds budget ${maxBytes}`);
    }
  }
}

async function main() {
  await walk(path.join(rootDir, 'copilot'));
  await walk(path.join(rootDir, 'docs'));
  const githubDir = path.join(rootDir, '.github');
  try {
    await walk(githubDir);
  } catch {
    // Optional for early repository states.
  }
  markdownFiles.push(path.join(rootDir, 'README.md'));
  try {
    await stat(path.join(rootDir, 'CONTRIBUTING.md'));
    markdownFiles.push(path.join(rootDir, 'CONTRIBUTING.md'));
  } catch {
    // CONTRIBUTING.md is optional until it is added.
  }

  const filesByType = new Map(frontmatterRules.map((rule) => [rule.label, []]));
  for (const filePath of markdownFiles) {
    for (const rule of frontmatterRules) {
      if (filePath.startsWith(rule.dir) && rule.match(filePath)) {
        filesByType.get(rule.label).push(filePath);
      }
    }
  }

  await validateFrontmatter(filesByType);
  await validateLinks();
  await validateAgentReferences(filesByType.get('agent'));
  await validateBudgets();

  if (errors.length > 0) {
    console.error('Asset validation failed:\n');
    for (const error of errors) {
      console.error(`- ${error}`);
    }
    process.exitCode = 1;
    return;
  }

  console.log(`Validated ${markdownFiles.length} markdown files.`);
  console.log(`Checked ${filesByType.get('agent').length} agents, ${filesByType.get('prompt').length} prompts, and ${filesByType.get('skill').length} skills.`);
}

await main();
