# git-extra

A set of tools that simplify working with git, especially if you use the rebase
workflow.

Included tools:
* [git-autosquash] - Tool to automate usage of git rebase --autosquash
* [git-conflicting] - Operate on conflicting files
* [git-continue] - Shorthand for rebase, merge or cherry-pick --continue
* [git-get] - Shorthand for git reset --hard that goes with git-set
* [git-make-branchname] - Create a usable branch name from a commit
* [git-set] - Easily and safely force-push to forks or private branches

[git-autosquash]: docs/git-autosquash.md
[git-conflicting]: docs/git-conflicting.md
[git-continue]: docs/git-continue.md
[git-get]: docs/git-get.md
[git-make-branchname]: docs/git-make-branchname.md
[git-set]: docs/git-set.md

## Testing

This repository relies on [shellspec] to verify the functionaly. To run tests
install and run `$ shellspec`

[shellspec]: https://github.com/shellspec/shellspec
