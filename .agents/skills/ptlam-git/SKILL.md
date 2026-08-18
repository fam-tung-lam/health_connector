---
name: ptlam-git
description:
  Carry out repository-local Git commit and worktree workflows without
  disturbing unrelated work. Use when creating a commit, writing or revising a
  commit message, creating or managing a worktree, or deciding whether a
  repository write belongs in the current checkout or a new linked worktree.
---

# PTLam Using Git

Carry out one requested commit or worktree workflow in the correct repository
and worktree without disturbing unrelated work. This skill may create local
branches, linked worktrees, and commits when the user's request authorizes that
state change.

It does not push, merge, rebase, delete a branch, or discard changes unless the
user explicitly asks for that operation. A read-only Git question never
authorizes a worktree or commit.

## 1. Resolve the repository and authority

Resolve one repository from the user's paths and current directory. Read the
current request and every applicable `AGENTS.md` or equivalent repository
instruction from the repository root to the files in scope.

Inspect `git status --short --branch` and `git worktree list --porcelain` before
choosing where to work. Keep user changes, active branches, and existing
worktrees outside the request untouched.

Complete this step when the repository, requested Git operation, permitted side
effects, and unrelated state are known.

## 2. Choose the worktree

Read [worktree policy](references/worktree-policy.md) whenever the user asks to
create, use, move, repair, remove, or prune a worktree, or before a repository
write when the existing worktree may not be the right execution context. Let it
decide whether to stay or create `.worktrees/<task-slug>` and how to manage that
linked worktree safely.

After creating or selecting a linked worktree, run all task commands from that
worktree. Do not continue editing from the checkout that dispatched the work.

Complete this step when one exact worktree and branch own the requested change.

## 3. Prepare the commit

Enter this step only when the user asks for a commit or commit message. Inspect
the complete diff, using the staged diff when it exists. If the user authorized
a commit and nothing is staged, stage only explicit paths that belong to the
requested outcome. Preserve unrelated changes and never widen the commit merely
to make the worktree clean.

Read [commit message preferences](references/commit-message-preferences.md).
Apply its precedence and portable defaults to the inspected change. If the user
asked only for wording, return the message without changing Git state.

Before committing, run the checks required by the request and repository rules.
Report any relevant check that could not be run; do not describe it as passed.

Complete this step when the exact staged patch, message, and verification state
all describe one coherent outcome.

## 4. Commit and report

Create the commit only when the user authorized it. Let repository hooks run. If
a hook changes files or rejects the commit, inspect the resulting status and
report the failure instead of bypassing the hook or silently retrying.

Verify the result with `git status --short --branch` and `git log -1 --oneline`.
Report the worktree path, branch, commit hash and subject when created, checks
run, and any remaining changes or uncertainty.

Complete the task when the requested Git state exists, unrelated work is
unchanged, and the report matches the verified repository state.
