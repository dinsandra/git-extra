# git-autosquash

This utility automates application of `fixup!` commits. It finds the
earliest commit that is targeted by the fixup commits and
automatically calls `git rebase -i <commit> --autosquash` with the
commit. It also sets `GIT_EDITOR=true` temporarily, which means that
the interactivity is removed, but the todo script is still executed,
applying the fixups.

## Example usage

Let's assume we have the following history:
 
```log
bec7842 (HEAD -> master) fixup! commit4
3f6efb1 fixup! commit3
b044169 commit4
3ebda94 commit3
ea8ad74 (origin/master, origin/HEAD) commit2
f3ad622 commit1
```

At this point running the command

```sh
$ git autosquash
```

Will identify commit3 (`3ebda94`) as the earliest commit targeted by
a fixup. Which makes the command equivalent to running:

```sh
$ GIT_EDITOR=true git rebase -i 3ebda94 --autosquash
```
