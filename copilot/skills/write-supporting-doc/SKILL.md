---
name: write-supporting-doc
description: Write or update supporting markdown and text documents on disk, such as ADRs, README updates, design notes, and analysis documents. Use when the request is file-backed documentation rather than code.
user-invocable: false
---

# Supporting Document Writing

Use this skill when the user wants a supporting document written or updated on disk.

## Workflow

1. Determine the target file path from the user request or choose the smallest conventional location already present in the repository.
2. Read nearby docs before editing so the new artifact matches local style and structure.
3. Write the document directly to disk when the request is concrete.
4. Keep edits limited to markdown or other supporting text files.
5. Reply with a brief confirmation and the written path after the file change.

## Allowed Targets

- ADRs
- design notes
- tickets stored as markdown
- README updates
- analysis documents and decision records

## Prohibited Targets

- application source files
- tests
- executable scripts
- build or runtime configuration files

## Output Rules

- For ADRs, use concise sections such as Title, Status, Context, Decision, Consequences, and Alternatives.
- For README updates, preserve the existing document structure unless the user asks for a rewrite.
- Do not mix code implementation with documentation edits.