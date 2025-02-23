# git get

Shorthand for git reset --hard that goes with git-set

boils down to an invocation of `git reset` looking something like:

```sh
$ git reset --hard refs/remotes/<remote>/[branch-prefix]<branch-name>
```
