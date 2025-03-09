# git-fixup

This tool is effectively an alias for `git commit --fixup`, and lessens the
amount of typing necessary when working with a rebase flow.

Alternatively it can be used in interactive mode by specifying the option `-i`.
This will list all fixup-targets, and let you numerically choose the target.

```sh
$ git fixup -i
[1]: b9e0e78 (HEAD -> master) Here's a commit
[2]: 41f2c83 fix(a-thing): Fix the a thing
[3]: a32b218 More A
Select target: [q/0-9+]
> 2
[master 5ccafd2] fixup! fix(a-thing): Fix the a thing
 1 file changed, 1 insertion(+), 1 deletion(-)
```
