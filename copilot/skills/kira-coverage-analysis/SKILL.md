---
name: kira-coverage-analysis
description: "Run full solution test coverage analysis. Use when checking coverage, finding untested code, running coverage reports, or identifying missing tests. Looks for coverage.runsettings under tests/, analyzes gaps, and immediately implements all tests that require no structural refactoring."
---

# Coverage Analysis Workflow

## Procedure

1. Run `dotnet test` with the coverage settings file — look for `coverage.runsettings` under `tests/` in the active project.
2. Analyze the coverage report for untested public methods, branches, and paths.
3. For each gap, determine if a new test can be written without structural refactoring:
   - **Yes**: write and add the test immediately.
   - **No**: document the gap with a recommended refactoring approach.
4. Return a summary: coverage baseline, tests added, and remaining gaps with recommended actions.
