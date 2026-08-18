# Commit Message Preferences

This reference owns preference precedence, message content, and the final
message check.

## Apply preferences in order

1. Follow the current user's explicit message instructions.
2. Follow applicable `AGENTS.md` or equivalent repository instructions for
   choices the user left open.
3. Follow a repository policy file that those instructions identify.
4. Use the portable defaults below for every remaining choice.

Report a conflict instead of silently applying a lower-precedence preference. Do
not treat neighboring commit history as policy unless the user or repository
instructions tell you to use it.

## Use portable defaults

- Use Conventional Commits: `<type>(<scope>): <description>`. Omit the scope
  when it adds no useful context.
- Prefer `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `chore`,
  and `ci` as types.
- Make the subject name the outcome, capability, fixed behavior, or refactor
  reason rather than only the implementation.
- Start `<description>` with a lowercase imperative verb: `update dependencies`,
  not `Update dependencies`.
- Use imperative mood, omit the final period, aim for 50 characters, and never
  exceed 72 characters.
- Add a short body when the subject cannot carry necessary rationale or impact.
  Prefer why the change exists over a step-by-step account.
- Add `Fixes #<issue>` or `Closes #<issue>` only when the commit resolves a
  verified issue. Use `Relates #<issue>` when it contributes without closing.
- Use the full issue URL when the issue belongs to another repository.

## Verify the message

Read the subject in isolation. Confirm that it matches the staged change, uses
the selected type and scope accurately, starts its description with a lowercase
imperative verb, satisfies active length and style rules, and agrees with the
body.

Verify every issue reference from the request or repository evidence. Return the
exact subject and body with real line breaks, and disclose anything not fully
verified.
