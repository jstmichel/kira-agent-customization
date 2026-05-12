---
name: kira-ef-migration-workflow
description: "Generate, review, and optionally apply an EF Core migration. Use when adding or modifying entity properties, relationships, keys, indexes, owned types, seed data, DbSet properties, value converters, or Fluent API mappings that may affect the EF model or database schema."
---

# EF Core Migration Workflow

## When to Use

Use this workflow when a change may affect the EF model or database schema: entity properties, relationships, keys, indexes, owned types, inheritance mappings, value converters, seed data, `DbSet` registration, or Fluent API configuration.

Skip this workflow when the change is purely behavioral and does not alter the EF model or schema.

## Safety Rules

1. Do not assume project names, startup projects, or migration folders.
2. Do not generate a migration until the model changes are in place and the solution builds for the relevant projects.
3. Do not run a database update unless the user explicitly asks for it.
4. If multiple `DbContext` or startup targets are plausible, resolve them from the solution structure first and ask only if the choice remains ambiguous.

## Procedure

1. Implement the model changes first: entities, configurations, `DbContext`, and any design-time factory or startup wiring required for EF tooling.
2. Resolve the migration inputs from the solution:
   - target `DbContext`
   - migrations project
   - startup project if one is required for design-time creation
   - output directory only when the project already uses a specific migrations folder structure
3. Run a preflight build for the relevant projects. Stop and fix build or design-time `DbContext` errors before generating the migration.
4. Choose a descriptive PascalCase migration name such as `AddBreeds`, `RenameInvoiceStatus`, or `AddOwnerPaymentsIndex`.
5. Run `dotnet ef migrations add <MigrationName>` and include `--context`, `--project`, `--startup-project`, and `--output-dir` only when the resolved solution layout requires them:
   ```
   dotnet ef migrations add <MigrationName>
   ```
6. Review the generated migration and the model snapshot:
   - verify `Up` and `Down`
   - look for accidental drop-and-recreate operations that should be renames
   - look for destructive changes, unexpected seed-data churn, or non-null column additions without a safe default or backfill plan
   - review any raw SQL or data-motion logic carefully
7. If the migration is wrong and it is still safe to undo, prefer `dotnet ef migrations remove`, fix the model configuration, and regenerate.
8. Apply project-specific follow-up conventions only when the project already uses them, such as coverage exclusions, partial migration classes, or a dedicated migrations folder.
9. Update the database only if the user explicitly asked for it.
10. Return the migration name, the files created or updated, any warnings found during review, and whether a database update was run.
