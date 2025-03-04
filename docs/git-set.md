# git set

Update single remote branch.

## The pitch

Have you ever found yourself creating multiple local branches, only to be able
to push a change for review to a remote. Ever been annoyed at having loads of
local branches littering around? Or ever had multiple clones of the same
repository and forgotten which one you made a change in?

Assuming you are comfortable with the workings of git, this tool allow to
shorten the workflow quite a bit.

When using a rebase workflow, the most recent commit's message summary quite
often makes sense as a branch name. This script also lessens the amount of times
one has to type the same thing for a change.

Typical usage looks like this:
Assuming you are on the `main` branch and the script is configured to use the
remote "my-remote"

```sh
$ git pull    # to get the latest changes, then work
$ git add -p  # to add the changes to be committed
$ git commit  # create the commit. For purposes of the doc assume the summary is
              #   "Integrate foobar with frobnicator"
$ git set -g  # force pushes the current commit to
              #   `my-remote/integrate-foobar-with-frobnicator`
```

Notice how no branch name is ever typed, but inferred from the commit name. If
there are requested changes to the branch, once can fixup and apply them and
then simply do `git set -g` again.

It is of course possible to specify a branch name or push a different ref than
HEAD.

```sh
$ git set custom-branch-name HEAD~3
```

## How it works

The tool works either by either specifying a remote or a branch name prefix,
and then uses [git-make-branchname] to generate branch names. In the end it all
boils down to an invocation of `git push` looking something like:

 ```sh
$ git push [--dry-run] --force-with-lease <remote>/origin <REF>:refs/heads/[branch-prefix]<branch-name>
```

## Examples invocation

```sh
# gitset.defaultremote = my-remote
# git commit summary "Create frazzle component"
git set -g

# -> git push --force-with-lease my-remote HEAD:refs/heads/create-frazzle-component
```

```sh
# gitset.defaultremote = origin
# gitset.branchPrefix = dinsandra/
git set fancy-branch HEAD^^

# -> git push --force-with-lease origin HEAD^^:refs/heads/dinsandra/fancy-branch
```

