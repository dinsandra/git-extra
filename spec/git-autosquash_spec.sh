#!/bin/bash

Describe 'git-autosquash'
  It 'does nothing with no fixups'
    Mock git
      if [[ "$*" == 'config --get gitautosquash.remote' ]]; then
        exit 0
      elif [[ "$*" == 'log --grep ^fixup!  --pretty=format:%H %s refs/remotes/origin/HEAD..HEAD' ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-autosquash
    The stderr should equal 'Nothing to do'
    The status should be success
  End

  It 'uses different remote if configured'
    Mock git
      if [[ "$*" == 'config --get gitautosquash.remote' ]]; then
        echo "other-remote"
      elif [[ "$*" == 'log --grep ^fixup!  --pretty=format:%H %s refs/remotes/other-remote/HEAD..HEAD' ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-autosquash
    The stderr should equal 'Nothing to do'
    The status should be success
  End

  # This shouldn't really happen, but let's test it anyway
  It 'log without fixups does nothing'
    Mock git
      if [[ "$*" == 'config --get gitautosquash.remote' ]]; then
        exit 0
      elif [[ "$*" == 'log --grep ^fixup!  --pretty=format:%H %s refs/remotes/origin/HEAD..HEAD' ]]; then
        echo "4a5fad31 A commit"
        echo "cf01f2ca A different commit"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-autosquash
    The stderr should equal 'Nothing to do'
    The status should be success
  End

  It 'log with single fixup rebases'
    Mock git
      if [[ "$*" == 'config --get gitautosquash.remote' ]]; then
        exit 0
      elif [[ "$*" == 'log --grep ^fixup!  --pretty=format:%H %s refs/remotes/origin/HEAD..HEAD' ]]; then
        echo "d4597b22 fixup! A different commit"
      elif [[ "$*" == 'log -1 --pretty=format:%s d4597b22' ]]; then
        echo "fixup! A different commit"
      elif [[ "$*" == 'rev-parse d4597b22^{/^A\ different\ commit}' ]]; then
        echo "8a6fcd6d"
      elif [[ "$*" == 'rebase -i 8a6fcd6d^ --autosquash' ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-autosquash
    The output should equal ''
    The status should be success
  End

  It 'log with multiple fixups should rebase the earliest'
    Mock git
      if [[ "$*" == 'config --get gitautosquash.remote' ]]; then
        exit 0
      elif [[ "$*" == 'log --grep ^fixup!  --pretty=format:%H %s refs/remotes/origin/HEAD..HEAD' ]]; then
        echo "d4597b22 fixup! A different commit"
        echo "bc78ba24 fixup! A commit"
        echo "f4df6753 fixup! More changes"
      elif [[ "$*" == 'log -1 --pretty=format:%s d4597b22' ]]; then
        echo "fixup! A different commit"
      elif [[ "$*" == 'log -1 --pretty=format:%s bc78ba24' ]]; then
        echo "fixup! A commit"
      elif [[ "$*" == 'log -1 --pretty=format:%s f4df6753' ]]; then
        echo "fixup! More changes"
      elif [[ "$*" == 'rev-parse d4597b22^{/^A\ different\ commit}' ]]; then
        echo "8a6fcd6d"
      elif [[ "$*" == 'rev-parse bc78ba24^{/^A\ commit}' ]]; then
        echo "be0fdf16"
      elif [[ "$*" == 'rev-parse f4df6753^{/^More\ changes}' ]]; then
        echo "f29c8f21"
      elif [[ "$*" == 'log -1 --oneline 8a6fcd6d..be0fdf16' ]]; then
        echo "be0fdf16 A commit"
      elif [[ "$*" == 'log -1 --oneline 8a6fcd6d..f29c8f21' ]]; then
        exit 0
      elif [[ "$*" == 'rebase -i f29c8f21^ --autosquash' ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-autosquash
    The output should equal ''
    The status should be success
  End

End
