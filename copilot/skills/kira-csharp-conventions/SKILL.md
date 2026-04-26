---
name: kira-csharp-conventions
description: "C# coding conventions for all layers. Use when writing any C# class in any layer. Rules: file-scoped namespaces; explicit types (no var unless type is obvious from the right-hand side); interface members must declare access modifiers; concise methods preferred; always use braces for all control flow; readable class and method names; primary constructors by default; static methods when no instance data is used; XML doc comments on all public members in production code."
---

# C# Conventions

Personal baseline conventions. Apply when no project-level C# instruction file is found; project instructions take precedence.

## Rules

- **File-scoped namespaces** — Use `namespace Foo.Bar;` (not block `{}`).
- **Explicit types** — Do not use `var` unless the type is immediately obvious from the right-hand side (e.g., `var items = new List<string>()`). Prefer explicit declarations everywhere else.
- **Interface access modifiers** — Interface member declarations must include an explicit access modifier (`public`, `protected`, etc.).
- **Concise methods** — Keep methods short and focused. Extract when a method does more than one clear thing.
- **Always use braces** — All control flow (`if`, `else`, `while`, `for`, `foreach`, etc.) must use braces, even for single-line bodies.
- **Readable names** — Prefer clarity over brevity in class and method names. Avoid abbreviations unless universally understood.
- **Primary constructors** — Use primary constructors by default. Use a full constructor only when initialization logic requires it.
- **Static methods** — Use static methods when no instance data is accessed. Use a static class when all methods are static and no state is held.
- **XML doc comments** — Add `<summary>` to all public methods and properties in production code. Do not add doc comments to xUnit test methods, test fixtures, or framework wiring (DI registration, middleware, program entry points).
