---
name: "kira-csharp-conventions"
description: "Use when writing or editing C# code and no project-specific C# convention instruction overrides it."
applyTo: "**/*.cs"
---

# C# Conventions

Personal baseline conventions. Apply when no project-level C# instruction file is present; project instructions take precedence.

- Use file-scoped namespaces.
- Prefer explicit types unless the type is immediately obvious from the right-hand side.
- Interface members must declare an explicit access modifier.
- Keep methods short and focused.
- Always use braces for control flow, even for single-line bodies.
- Prefer clear class and method names over abbreviations.
- Use primary constructors by default; use a full constructor only when initialization logic needs it.
- Use static methods when no instance data is accessed, and a static class when all members are static.
- Add `<summary>` comments to public methods and properties in production code, but not to test methods, test fixtures, or framework wiring.