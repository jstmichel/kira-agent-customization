import { mkdtemp, readdir } from 'node:fs/promises';
import os from 'node:os';
import path from 'node:path';
import process from 'node:process';
import { spawn } from 'node:child_process';

const repoRoot = process.cwd();

function run(command, args, env) {
  return new Promise((resolve, reject) => {
    const child = spawn(command, args, {
      cwd: repoRoot,
      env: { ...process.env, ...env },
      stdio: ['ignore', 'pipe', 'pipe']
    });

    let stdout = '';
    let stderr = '';

    child.stdout.on('data', (chunk) => {
      stdout += chunk.toString();
    });

    child.stderr.on('data', (chunk) => {
      stderr += chunk.toString();
    });

    child.on('error', reject);
    child.on('close', (code) => {
      if (code !== 0) {
        reject(new Error(`${command} ${args.join(' ')} failed with ${code}\n${stdout}\n${stderr}`));
        return;
      }

      resolve({ stdout, stderr });
    });
  });
}

async function assertExists(dirPath, expectedNames) {
  const entries = new Set(await readdir(dirPath));
  for (const name of expectedNames) {
    if (!entries.has(name)) {
      throw new Error(`Expected ${name} in ${dirPath}`);
    }
  }
}

async function assertNotExists(dirPath, unexpectedPrefix) {
  let entries = [];
  try {
    entries = await readdir(dirPath);
  } catch {
    return;
  }

  const found = entries.find((entry) => entry.startsWith(unexpectedPrefix));
  if (found) {
    throw new Error(`Did not expect ${found} in ${dirPath}`);
  }
}

async function main() {
  const tempRoot = await mkdtemp(path.join(os.tmpdir(), 'kira-install-'));
  const kiraHome = path.join(tempRoot, 'copilot-home');
  const promptsDir = path.join(tempRoot, 'vscode-prompts');

  const command = process.platform === 'win32' ? 'pwsh' : 'bash';
  const installArgs = process.platform === 'win32' ? ['-File', 'install.ps1'] : ['install.sh'];
  const uninstallArgs = process.platform === 'win32' ? ['-File', 'uninstall.ps1'] : ['uninstall.sh'];

  const sharedEnv = {
    KIRA_HOME: kiraHome,
    VSCODE_PROMPTS_DIR: promptsDir,
    USERPROFILE: process.platform === 'win32' ? tempRoot : process.env.USERPROFILE,
    APPDATA: process.platform === 'win32' ? tempRoot : process.env.APPDATA,
    HOME: process.platform === 'win32' ? process.env.HOME : tempRoot,
    XDG_CONFIG_HOME: tempRoot
  };

  await run(command, installArgs, sharedEnv);

  await assertExists(path.join(kiraHome, 'agents'), [
    'kira.agent.md',
    'kira-intake.agent.md',
    'kira-draft.agent.md',
    'kira-architect.agent.md',
    'kira-codex.agent.md'
  ]);
  await assertNotExists(path.join(kiraHome, 'agents'), 'kira-build');
  await assertNotExists(path.join(kiraHome, 'agents'), 'kira-think');
  await assertExists(path.join(kiraHome, 'skills'), [
    'kira-change-docs',
    'kira-ticket-intake'
  ]);
  await assertExists(path.join(kiraHome, 'instructions'), [
    'kira-core.instructions.md',
    'kira-csharp.instructions.md',
    'kira-drafting.instructions.md'
  ]);
  await assertExists(promptsDir, [
    'kira-create-adr.prompt.md',
    'kira-create-analysis.prompt.md',
    'kira-draft-commit.prompt.md',
    'kira-draft-pr.prompt.md',
    'kira-draft-ticket.prompt.md',
    'kira-refactor.prompt.md'
  ]);

  await run(command, uninstallArgs, sharedEnv);

  await assertNotExists(path.join(kiraHome, 'agents'), 'kira');
  await assertNotExists(path.join(kiraHome, 'skills'), 'kira-');
  await assertNotExists(promptsDir, 'design-with-kira');
  await assertNotExists(promptsDir, 'document-pr-with-kira');
  await assertNotExists(promptsDir, 'implement-with-kira');
  await assertNotExists(promptsDir, 'kira');
  await assertNotExists(promptsDir, 'plan-with-kira');
  await assertNotExists(promptsDir, 'draft-commit-with-kira');
  await assertNotExists(path.join(kiraHome, 'instructions'), 'kira');

  console.log('Install smoke test passed.');
}

await main();
