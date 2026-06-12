---
applyTo: "**/*.cs"
---

# C# Coding Conventions (brief)

Purpose: short, actionable rules for C# source files in this repository. Apply to all .cs files.

1. XML comments for public APIs
   - Public types and public/protected members must have XML documentation (triple-slash `///`).
   - Keep summaries short: one sentence for intent, one sentence for key behavior or side-effects.

   Example:

   ```csharp
   /// <summary>
   /// Retrieves a customer by identifier.
   /// </summary>
   /// <param name="id">The customer identifier.</param>
   /// <returns>The customer or null if not found.</returns>
   public Customer? GetCustomer(Guid id) { ... }
   ```

2. Naming
   - Types (classes, structs, enums, delegates, interfaces): PascalCase (interfaces prefixed with `I`).
   - Methods, properties, events: PascalCase.
   - Constants: PascalCase or ALL_CAPS for true compile-time constants is acceptable; prefer PascalCase.
   - Fields: private fields use _camelCase (leading underscore), protected/internal fields may use camelCase without underscore only when conventional.
   - Locals and parameters: camelCase.

   Example:
   ```csharp
   public class OrderService
   {
       private readonly ILogger<OrderService> _logger;
       private const int DefaultPageSize = 20;
       public void Process(Order order) { ... }
   }
   ```

3. File & type organization
   - One top-level (public) type per file. File name should match the primary type name (OrderService.cs).
   - Small internal/private helper types may live in the same file when tightly coupled to the primary type.
   - Keep using directives at the top, inside the namespace only if the project convention requires it — be consistent per project.

4. Namespaces
   - Prefer file-scoped namespaces for modern projects (C# 10+) unless the project has an established alternative.
     Example (file-scoped):

     ```csharp
     namespace MyCompany.MyProject.Services;
     ```

   - Mirror folder structure where practical: RootNamespace.Subfolder[.Subfolder].
   - Use PascalCase for namespace segments.

5. Error handling & logging
   - Throw the most specific exception appropriate. Do not throw System.Exception or swallow exceptions silently.
   - Validate public method arguments and throw ArgumentException/ArgumentNullException early.
   - Use dependency-injected ILogger<T> for structured logging and avoid string concatenation; prefer message templates.

   Example:
   ```csharp
   if (id == Guid.Empty) throw new ArgumentException("id must be a non-empty GUID", nameof(id));
   _logger.LogWarning("Order {OrderId} not found", orderId);
   ```

6. Formatting
   - Indentation: 4 spaces (no tabs).
   - Brace style: open brace on same line for methods/types, K&R style is preferred.
   - Keep line length reasonable (~120 chars recommended).

   Example:
   ```csharp
   public class Example
   {
       public void DoWork()
       {
           // Implementation
       }
   }
   ```

7. Misc
   - Prefer expression-bodied members for short getters or methods where it improves readability.
   - Favor immutability for DTOs where practical (init-only properties).
   - Keep methods small and focused; a single responsibility makes code easier to test.

    - Prefer static for methods that do not access instance state. Use static classes or static members where it improves clarity and avoids unnecessary allocations.
    - Avoid unnecessary class-scoped fields: prefer local variables when possible. If a field is required, make it readonly when immutable.

Quick checklist for PRs touching .cs files:
 - Public APIs documented with XML comments
 - File name matches primary type
 - Naming rules followed for types, methods, fields, locals
 - Exceptions are specific and logged appropriately
 - Formatting uses 4-space indent and the project's brace style

Further customization: If a project within the repo has an .editorconfig or style rules, follow those project-level settings and add any deviations to the project's README.