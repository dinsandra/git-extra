# git-branchname

A script that produces a valid branch name from the summary of a git commit

## Usage:
`git branchname [REF]`

> If `REF` is unspecified, defaults to `HEAD`

## Steps taken
1. Read summary of `REF` or `HEAD`
2. Replaces `"%"` with `"pct"`
3. Replaces any of `"[](){}. _/"` with `"-"`
4. Lowercases
5. Removes any characters other than `"a-z0-9-"`
6. Compacts subsequent dashes into single dash

## Examples transformations
- `"Add new feature"` -> `"add-new-feature"`
- `"Roll out new feature to 100% of users" -> `"roll-out-new-feature-to-100pct-of-users"`
- `"fix(system/component): Address memory issue"` -> `"fix-system-component-address-memory-issue"`
