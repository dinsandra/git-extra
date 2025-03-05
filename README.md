# git-extra

A set of tools that simplify working with git, especially if you use the rebase
workflow.

Included tools:
* [git-autosquash] - Tool to automate usage of git rebase --autosquash
* [git-branches] - List remote branches matching git-set config
* [git-conflicting] - Operate on conflicting files
* [git-continue] - Shorthand for rebase, merge or cherry-pick --continue
* [git-fixup] - Shorthand for git commit --fixup
* [git-fixup-targets] - Enumerate potential candidates for git-fixup
* [git-get] - Shorthand for git reset --hard that goes with git-set
* [git-make-branchname] - Create a usable branch name from a commit
* [git-set] - Easily and safely force-push to forks or private branches

[git-autosquash]: docs/git-autosquash.md
[git-branches]: docs/git-branches.md
[git-conflicting]: docs/git-conflicting.md
[git-continue]: docs/git-continue.md
[git-fixup]: docs/git-fixup.md
[git-fixup-targets]: docs/git-fixup-targets.md
[git-get]: docs/git-get.md
[git-make-branchname]: docs/git-make-branchname.md
[git-set]: docs/git-set.md

## Pitch

This set of tools are intended to simplify, secure and speed up working with
git, using a rebase workflow. The idea is to never have any local branches,
always work on the main branch, and only use remote branches.

What follows is a usage example:
```sh
$ git pull              # Refresh main branch to work on the latest changes
                        # Then do work
$ git add -p            # Add relevant changes
$ git commit            # Create commits
                        #   repeat as needed
$ git set -g            # Push and create remote branch
                        # .. after review comments, do fixes
$ git add -p            # Add fixes
$ git fixup-targets     # List fixup targets
$ git fixup cafeha5h    # Create commits
                        #   repeat as needed
$ git autosquash        # Apply fixups
$ git conflicting edit  # During the rebase, if there are conflicts quickly
                        #   edit them and fix the issues
$ git conflicting add   # Then resolve the conflicts
$ git continue          # Then continue the rebase
                        #   repeat as needed
$ git set -g            # Update the remote branch again
                        #
                        # The changes are either accepted and we can do
$ git pull              # to get the merged changes and start the process over
                        #
$ git get next-work     # Jump over to the next-work remote branch to apply
                        # work on that branch
```

There is less risk of accidentally force-pushing the wrong branch, and less
need for tedious branch-name typing. No local branches laying around after
they have been merged.

## Installation / setup

Currently, the easiest way to install the tools is by cloning the repo
and adding the path to the bin folder to `PATH`.

After that is done, some configuration is needed that depends on your typical
setup.

If you work across multiple repos with a personal fork, you very likely want to
configure `my-remote` to be the default for git-set

```sh
$ git config --global gitset.defaultremote my-remote
```

If you work in a single shared repository with personal branches you very likely
want to configure `origin` as the default remote and a branch prefix

```sh
$ git config gitset.defaultremote origin
$ git config gitset.branchPrefix my-prefix/
```

## Testing

This repository relies on [shellspec] to verify the functionality. To run tests
install and run `$ shellspec`

[shellspec]: https://github.com/shellspec/shellspec
