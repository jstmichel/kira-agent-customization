---
name: kira-publish-github-issue
description: "Publish a drafted GitHub issue using the GitHub CLI. Use when: publishing to GitHub, creating a GitHub issue, pushing a drafted story to GitHub, or opening an issue in a GitHub-hosted repository. Auto-select labels from issue content, use the milestone if exactly one exists, and honor project-defined assignee rules when present."
user-invocable: true
---

# Publish GitHub Issue

This is a portable personal skill. If the active project defines issue metadata rules, templates, labels, or default assignees, the project rules override this workflow.

## Steps

1. **Resolve provider**: Verify the destination is GitHub from explicit user wording or the remote host. If the repo host is Azure DevOps, stop and use the Azure DevOps publishing workflow instead.

2. **Resolve repo**: Get owner and repo name from project instructions, `README.md`, or the workspace attachment. If not found, run `git remote get-url origin` to extract them (e.g. `git remote get-url origin` → `https://github.com/<owner>/<repo>.git`).

3. **Labels**: Run `gh label list --repo <owner>/<repo>` to fetch available labels. Auto-select labels by matching the available list against the issue content — do not prompt the user:
   - Pick the type label that best fits the content (`bug`, `enhancement`, `documentation`, etc.).
   - Pick any `layer:*` labels mentioned or implied by the issue body.
   - Pick `tests` if the issue includes a testing section or acceptance criteria referencing tests.

4. **Milestone**: Run `gh api repos/<owner>/<repo>/milestones` to fetch open milestones. If exactly one milestone exists, use it. Otherwise skip — do not prompt the user.

5. **Assignee**: If the active project explicitly defines a default assignee in project instructions, issue templates, or repo workflow docs, use it. Otherwise omit `--assignee`. Never hardcode a personal username in this personal skill.

6. **Create**: Run `gh issue create` immediately:
   ```
    gh issue create \
      --title "<title>" \
      --body "<body>" \
      --label "<label1>,<label2>" \
      --repo <owner>/<repo> \
      [--milestone "<milestone title>"] \
      [--assignee "<assignee>"]
    ```
    Omit `--milestone` if no milestone was selected. Omit `--assignee` if no project default assignee was found.

7. **Output**: Display the created issue URL returned by the command.
