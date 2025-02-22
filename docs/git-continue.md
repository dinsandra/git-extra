# git-continue

A script to --continue a rebase, merge or cherry-pick

In order of preference:
1. If a cherry-pick is in progress: `git cherry-pick --continue`
2. Else if a merge is in progress: `git merge --continue`
3. Else if a rebase is in progress: `git rebase --continue`
4. Else: Print error message
