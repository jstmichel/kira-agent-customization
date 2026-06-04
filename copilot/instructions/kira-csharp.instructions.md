---
applyTo: "**/*.cs"
description: "C# coding best practices for Kira, scoped to C# source files so language guidance does not inflate unrelated sessions."
---

# Kira C# Rules

- Match the existing target framework, package set, naming, and solution layout before introducing new patterns.
- Prefer small, testable types and constructor-injected dependencies over hidden global or static state.
- Use `async` and `await` end-to-end for I/O-bound work; avoid blocking on task results unless the surrounding code already requires it.
- Respect nullable reference types. Prefer guard clauses and explicit null handling over suppressing warnings.
- Dispose `IDisposable` and `IAsyncDisposable` resources correctly, preferably with `using` declarations.
- Pass `CancellationToken` through async flows when the surrounding API already exposes one.
- Prefer structured logging and typed options or configuration patterns already used by the repo.
- Keep public APIs explicit and avoid broad package or project-file changes unless the task requires them.