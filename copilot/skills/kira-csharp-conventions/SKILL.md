---
name: kira-csharp-conventions
description: "C# constructor, static method, and documentation conventions. Use when writing any C# class in any layer. Rules: primary constructors by default; static methods when no instance data is used; static class when all methods are static and no state is held; XML doc comments on all public methods and properties in production code."
---

# C# Conventions

Use primary constructors by default. Favor static methods when no instance data is used. Use a static class when all methods are static and no state is held.

Add XML doc comments (`<summary>`) to all public methods and properties in production code. Do not add doc comments to xUnit test methods, test fixture classes, or framework wiring (DI registration, middleware, program entry points).
