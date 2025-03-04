#!/bin/bash

Describe 'git-set'
  It 'should fail with message if no defaultBranch'
    Mock git
      if [[ "$*" == 'config --get gitset.defaultremote' ]]; then
        echo ""
      elif [[ "$*" == 'config --get gitset.branchPrefix' ]]; then
        echo ""
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-set -g
    The output should equal "No remote configured. Use 'git config --global gitset.defaultremote <remotename>' to set default remote"
    The status should eq 1
  End

  It 'should fail with message if origin without prefix'
    Mock git
      if [[ "$*" == 'config --get gitset.defaultremote' ]]; then
        echo "origin"
      elif [[ "$*" == 'config --get gitset.branchPrefix' ]]; then
        echo ""
      elif [[ "$*" == 'config --get --type bool gitset.allowOriginWoPrefix' ]]; then
        echo ""
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-set -g
    The lines of output should eq 3
    The line 1 of output should eq "Remote is 'origin', but no branch prefix. This is very dangerous!"
    The line 2 of output should eq "Use 'git config gitset.branchPrefix <branch-prefix>'"
    The line 3 of output should eq "To ignore warning this: 'git config gitset.allowOriginWoPrefix 1'"
    The status should eq 2
  End

  It '-g should force push if remote is present'
    Mock git
      if [[ "$*" == 'config --get gitset.defaultremote' ]]; then
        echo "a-remote"
      elif [[ "$*" == 'config --get gitset.branchPrefix' ]]; then
        echo ""
      elif [[ "$*" == 'make-branchname HEAD' ]]; then
        echo "a-branch"
      elif [[ "$*" == 'push --force-with-lease a-remote HEAD:refs/heads/a-branch' ]]; then
        echo "push output"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-set -g
    The output should equal "push output"
    The status should be success
  End

  It '-g should force push if remote is present with prefix'
    Mock git
      if [[ "$*" == 'config --get gitset.defaultremote' ]]; then
        echo "a-remote"
      elif [[ "$*" == 'config --get gitset.branchPrefix' ]]; then
        echo "a-prefix-"
      elif [[ "$*" == 'make-branchname HEAD' ]]; then
        echo "a-branch"
      elif [[ "$*" == 'push --force-with-lease a-remote HEAD:refs/heads/a-prefix-a-branch' ]]; then
        echo "push output"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-set -g
    The output should equal "push output"
    The status should be success
  End

  It 'with branch name should force push if remote is present with prefix'
    Mock git
      if [[ "$*" == 'config --get gitset.defaultremote' ]]; then
        echo "a-remote"
      elif [[ "$*" == 'config --get gitset.branchPrefix' ]]; then
        echo "a-prefix-"
      elif [[ "$*" == 'push --force-with-lease a-remote HEAD:refs/heads/a-prefix-provided-branch' ]]; then
        echo "push output"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-set provided-branch
    The output should equal "push output"
    The status should be success
  End

  It 'with branch name should force push if remote is present with refspec'
    Mock git
      if [[ "$*" == 'config --get gitset.defaultremote' ]]; then
        echo "a-remote"
      elif [[ "$*" == 'config --get gitset.branchPrefix' ]]; then
        echo ""
      elif [[ "$*" == 'push --force-with-lease a-remote HEAD^^:refs/heads/provided-branch' ]]; then
        echo "push output"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-set provided-branch HEAD^^
    The output should equal "push output"
    The status should be success
  End
End
