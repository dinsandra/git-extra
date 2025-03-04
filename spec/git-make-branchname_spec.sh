#!/bin/bash

Describe 'git-make-branchname'
  It 'creates from trivial example'
    Mock git
      if [[ "$*" != 'log -1 --pretty=format:%s HEAD' ]]; then
        echo "Unexpected params: $*" >&2
        exit 1
      fi
      echo 'Fix bug'
    End

    When call git-make-branchname
    The output should equal 'fix-bug'
  End

  It 'creates from ref'
    Mock git
      if [[ "$*" != 'log -1 --pretty=format:%s HEAD^^' ]]; then
        echo "Unexpected params: $*" >&2
        exit 1
      fi
      echo 'Parent commit!'
    End

    When call git-make-branchname 'HEAD^^'
    The output should equal 'parent-commit'
  End

  It 'creates from complex example'
    Mock git
      echo 'fix(system/component): Deal with the [] to 100%!'
    End

    When call git-make-branchname
    The output should equal 'fix-system-component-deal-with-the-to-100pct'
  End
End
