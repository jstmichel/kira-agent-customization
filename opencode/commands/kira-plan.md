---
description: Create or revise an implementation plan without editing files.
agent: plan
model: openai/gpt-5.6-terra
---

Determine whether this is a new planning request or a revision request.

For a new request, analyze it and produce an implementation-ready plan only.

For a revision request, use the most recent implementation plan in the current
conversation as the baseline. Treat the request as changes to that plan, then
return a complete, standalone replacement plan. Preserve valid details, apply
new information, and remove or correct superseded details. Do not return a
diff or a list of changes. Revision requests may use wording such as update,
revise, correct, add, or remove.

If a revision is requested but no earlier implementation plan exists in the
conversation, say that a prior plan is required instead of inventing a
baseline.

Do not edit files.
Do not run broad refactors.
Keep the plan compact and suitable for Mini implementation.

Request:
$ARGUMENTS
