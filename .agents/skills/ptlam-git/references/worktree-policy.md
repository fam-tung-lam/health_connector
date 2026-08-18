# Worktree Policy

This reference owns the stay-or-create decision, the project-local layout,
lifecycle commands, and worktree safety checks.

This policy follows the official
[Git worktree manual](https://git-scm.com/docs/git-worktree), verified on
2026-08-16. The link identifies the canonical command; it is not required
reading. When installed behavior differs, inspect `git help worktree` and the
subcommand's local help before changing state.

## Choose the execution context

| Situation                                                              | Decision                                                  |
| ---------------------------------------------------------------------- | --------------------------------------------------------- |
| The user names a worktree or says to use the current checkout          | Use it when it is safe and suitable.                      |
| The task is read-only                                                  | Stay in the current worktree.                             |
| The current worktree already has a clean, dedicated task branch        | Reuse it.                                                 |
| The current worktree contains unrelated changes                        | Create a linked worktree.                                 |
| The current branch must remain available for other work                | Create a linked worktree.                                 |
| Another task or agent may run concurrently                             | Create a linked worktree.                                 |
| The task starts from a shared or protected branch and will write files | Create a linked worktree.                                 |
| The requested branch is already checked out elsewhere                  | Use that worktree or choose another branch with the user. |

Do not create a worktree merely because Git is available. When the user's chosen
checkout risks unrelated work, explain the conflict and stop before changing
state.

## Name and place a linked worktree

Use the repository's documented location and branch convention first. Otherwise
place linked worktrees at `<main-worktree-root>/.worktrees/<task-slug>` and use
the host's required branch prefix with the same short, descriptive slug. The
main-worktree root is stable even when this policy runs from a linked worktree.

Before creation:

1. Resolve the current worktree with `git rev-parse --show-toplevel`. Resolve
   `<main-worktree-root>` from the first `worktree` record in
   `git worktree list --porcelain`; confirm that record uses the same Git common
   directory returned by
   `git rev-parse --path-format=absolute --git-common-dir`.
2. Confirm `.worktrees/` is excluded with
   `git check-ignore -q <main-worktree-root>/.worktrees/` or an equivalent
   tracked-ignore check. Ask before editing ignore rules when that change is
   outside the task.
3. Inspect `git status --short --branch` and `git worktree list --porcelain` for
   collisions and unrelated state.
4. Validate the proposed branch with `git check-ref-format --branch <branch>`.
5. Resolve an existing local base commit. Fetch only when the user authorized
   network access or current remote state is required by the request.

Create a new task branch with:

```text
git worktree add <main-worktree-root>/.worktrees/<task-slug> -b <branch> <base>
```

Use `git worktree add <path> <branch>` only for an existing branch not checked
out in another worktree. Do not use `--force` or `-B` to bypass Git's branch,
path, dirty-state, or lock safeguards.

Verify creation with `git -C <path> status --short --branch` and
`git worktree list`. The new path becomes the working directory for the task.

## Move, repair, and clean up

Use `git worktree move <worktree> <new-path>` for a normal move. Use
`git worktree repair <path>` only to reconnect metadata after paths were moved
outside Git.

Remove a linked worktree only when the user asks and
`git -C <worktree> status --short` is empty. Use
`git worktree remove <worktree>` so Git removes its administrative metadata.
Never use `--force` to discard tracked or untracked work.

Delete a task branch separately only when the user asks and its commits are
verified as integrated or no longer needed. Worktree removal alone does not
authorize branch deletion.

Use `git worktree prune --dry-run` to inspect stale metadata. Run
`git worktree prune` only when the user asked for cleanup and the preview names
only entries known to be stale.
