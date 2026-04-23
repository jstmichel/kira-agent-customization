---
name: kira-ef-migration-workflow
description: "Generate and configure an EF Core migration. Use when adding or modifying DbSet properties, entity configurations, or Fluent API mappings in a DbContext. Covers command, migration naming, Up/Down review, and coverage exclusion. For project-specific paths and rules, check the project EF Core instruction file first."
---

# EF Core Migration Workflow

## When to Use

Apply when the task adds or modifies `DbSet` properties, entity configurations, or Fluent API mappings. Skip when no schema changes are involved.

## Procedure

1. Implement all entity classes, repository classes, and `DbContext` changes first.
2. Run the migration command from the workspace root — adjust `<InfraProject>` and `<StartupProject>` to match your solution:
   ```
   dotnet ef migrations add <MigrationName> --project <InfraProject> --startup-project <StartupProject>
   ```
3. Use a descriptive PascalCase name (e.g. `AddBreeds`, `AddOwnerPayments`).
4. Review the generated `Up`/`Down` methods for correctness.
5. If the migration is empty or incorrect, delete it and diagnose the `DbContext` configuration.
6. Exclude the migration from coverage — add an `[ExcludeFromCodeCoverage] partial class <MigrationName>` entry to the migrations coverage exclusions file in your Infrastructure project.
