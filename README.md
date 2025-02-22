# git-extra

A set of tools that simplify working with git, especially if you use the rebase
workflow.

Included tools:
* [git-conflicting] - Operate on conflicting files
* [git-make-branchname] - Create a usable branch name from a commit
* [git-set] - Easily and safely force-push to forks or private branches

[git-conflicting]: docs/git-conflicting.md
[git-make-branchname]: docs/git-make-branchname.md
[git-set]: docs/git-set.md

## Testing

This repository relies on [shellspec] to verify the functionaly. To run tests
install and run `$ shellspec`

[shellspec]: https://github.com/shellspec/shellspec
