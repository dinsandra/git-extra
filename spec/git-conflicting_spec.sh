#!/bin/bash

Describe 'git-conflicting ls'
  It 'only outputs conflicting files'
    Mock git
      if [[ "$*" != 'status --porcelain=v2' ]]; then
        echo "Unexpected params: $*" >&2
        exit 1
      fi
      echo '1 MM N... 100644 100644 100644 f8f6b11fa5513114e34153c8f84f2aa501368b72 2c2f9347baf72d412ab9425040b72b8decc7e4b8 a.txt'
      echo '2 R. N... 100644 100644 100644 13ab7b1961f4715b4bcb31604e7b8490e169e134 13ab7b1961f4715b4bcb31604e7b8490e169e134 R100 cc.txt	c.txt'
      echo 'u UU N... 100644 100644 100644 100644 f8f6b11fa5513114e34153c8f84f2aa501368b72 bf324dde2ea1cff810d983f6df2366f234c0161b edafe6bc965dd1eef64045e1c805df06be66641b u.txt'
      echo '? x.txt'
    End

    When call git-conflicting ls
    The output should equal 'u.txt'
  End
End

Describe 'git-conflicting add'
  It 'should check before add by default and fails with markers'
    Mock git 
      if [[ "$*" == 'status --porcelain=v2' ]]; then
        echo 'u UU N... 100644 100644 100644 100644 f8f6b11fa5513114e34153c8f84f2aa501368b72 bf324dde2ea1cff810d983f6df2366f234c0161b edafe6bc965dd1eef64045e1c805df06be66641b u.txt'
      elif [[ "$*" == 'config --get --type=bool gitconflicting.check' ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    Mock xargs
      if [[ "$*" == "grep -E -l <<<<<<<|=======|>>>>>>> --" ]]; then
        echo "u.txt"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-conflicting add
    The stderr should equal 'Warning conflict markers left in files: u.txt'
    The status should eq 2
  End

  It 'should skip check before add with no check config flag'
    Mock git 
      if [[ "$*" == 'status --porcelain=v2' ]]; then
        echo 'u UU N... 100644 100644 100644 100644 f8f6b11fa5513114e34153c8f84f2aa501368b72 bf324dde2ea1cff810d983f6df2366f234c0161b edafe6bc965dd1eef64045e1c805df06be66641b u.txt'
      elif [[ "$*" == 'config --get --type=bool gitconflicting.check' ]]; then
        echo "false"
      elif [[ "$*" == 'add u.txt' ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    Mock xargs
      if [[ "$*" == "grep -E -l <<<<<<<|=======|>>>>>>> --" ]]; then
        echo "u.txt"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-conflicting add
    The output should equal ''
    The status should eq 0
  End

  It 'should check before add by default and succeds without markers'
    Mock git 
      if [[ "$*" == 'status --porcelain=v2' ]]; then
        echo 'u UU N... 100644 100644 100644 100644 f8f6b11fa5513114e34153c8f84f2aa501368b72 bf324dde2ea1cff810d983f6df2366f234c0161b edafe6bc965dd1eef64045e1c805df06be66641b u.txt'
      elif [[ "$*" == 'config --get --type=bool gitconflicting.check' ]]; then
        exit 0
      elif [[ "$*" == 'add u.txt' ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    Mock xargs
      if [[ "$*" == "grep -E -l <<<<<<<|=======|>>>>>>> --" ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-conflicting add
    The output should equal ''
    The status should eq 0
  End
End

Describe 'git-conflicting edit'
  It 'should check after edit by default and fails with markers'
    Mock git 
      if [[ "$*" == 'status --porcelain=v2' ]]; then
        echo 'u UU N... 100644 100644 100644 100644 f8f6b11fa5513114e34153c8f84f2aa501368b72 bf324dde2ea1cff810d983f6df2366f234c0161b edafe6bc965dd1eef64045e1c805df06be66641b u.txt'
      elif [[ "$*" == 'config --get --type=bool gitconflicting.check' ]]; then
        exit 0
      elif [[ "$*" == 'config --get gitconflicting.editor' ]]; then
        exit 0
      elif [[ "$*" == 'var GIT_EDITOR' ]]; then
        echo "my_editor"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    Mock xargs
      if [[ "$*" == "grep -E -l <<<<<<<|=======|>>>>>>> --" ]]; then
        echo "u.txt"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    Mock my_editor
      if [[ "$*" == "u.txt" ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-conflicting edit
    The stderr should equal 'Warning conflict markers left in files: u.txt'
    The status should eq 2
  End

  It 'should skip check after edit with no check config flag'
    Mock git 
      if [[ "$*" == 'status --porcelain=v2' ]]; then
        echo 'u UU N... 100644 100644 100644 100644 f8f6b11fa5513114e34153c8f84f2aa501368b72 bf324dde2ea1cff810d983f6df2366f234c0161b edafe6bc965dd1eef64045e1c805df06be66641b u.txt'
      elif [[ "$*" == 'config --get --type=bool gitconflicting.check' ]]; then
        echo "false"
      elif [[ "$*" == 'config --get gitconflicting.editor' ]]; then
        exit 0
      elif [[ "$*" == 'add u.txt' ]]; then
        exit 0
      elif [[ "$*" == 'var GIT_EDITOR' ]]; then
        echo "my_editor"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    Mock xargs
      if [[ "$*" == "grep -E -l <<<<<<<|=======|>>>>>>> --" ]]; then
        echo "u.txt"
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    Mock my_editor
      if [[ "$*" == "u.txt" ]]; then
        exit 0
      else
        echo "Unexpected params: $*" >&2
        exit 1
      fi
    End

    When call git-conflicting edit
    The output should equal ''
    The status should eq 0
  End
End

