# Copilot Instructions

- This repository authors the Kira customization pack under `copilot/` and validates it with the local scripts.
- Repo-local instruction files take precedence over installed user-level Kira defaults; when the repo has no local instruction for a case, user-level instructions remain the fallback.
- Keep always-on guidance lean and move language-specific rules into scoped `.instructions.md` files with `applyTo`.
- After changing agent, prompt, skill, or instruction assets, run `npm run validate`.
- After changing install or uninstall behavior, run `npm run test:install`.