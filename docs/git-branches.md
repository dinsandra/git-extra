# git branches

List remote branches matching the currently configured parameters

boils down to an invocation of `git branch` looking something like:

```sh
$ git branch -a -l <remote>/[branch-prefix]*
```
