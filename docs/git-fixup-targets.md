# git-fixup-targets

A tool to enumerate potential fixup targets for git-fixup

Usually when working with the rebase workflow, the most recent commit that
changed what is in the index is the desired target. This tool is essentially a
glorified `git log` invocation, listing matching commits.

Assume we have the following state:

```sh
$ git log --oneline --name-only --first-parent -5
3e8c8a8b (HEAD -> master) Add to a
a.txt
bf78d007 Add to b
b.txt
68a93a4d Merge remote-tracking branch 'origin/a-branch' into HEAD
c.txt
e2e967ee Change b
b.txt
ea8ad74 (origin/main, origin/HEAD) Fix b
b.txt

$ git diff --staged --name-only
b.txt
```

then making the following call would result in:

```sh
$ git fixup-targets
bf78d007 Add to b
```

Which is good, because it is the only "valid" target for a fixup. A commit
that alters `b.txt`, that is not past any merges or the remote HEAD.
