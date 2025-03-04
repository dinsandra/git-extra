# git-conflicting

Operate on conflicting files.

This utility allows quick and easy operating on conflicting files.

More often than not, when there is a conflict what one wants to do
is to open all the files with conflict, find the conflict markers
and resolve them.

The typical workflow with this tool turns that into the commands
```sh
git conflicting edit
git conflicting add
```

The command also validates that there are no conflict markers left
in the files before applying the add.

