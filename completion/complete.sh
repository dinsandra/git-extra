#!/bin/bash

_git_get () {
  if test "${cword:-0}" -eq 2; then
    branch_options="-i $(git branches)"
    __gitcomp "${branch_options}"
  fi
}

_git_set () {
  case ${cur:-} in
    -*)
      __gitcomp "-n --dry-run -g --guess -v --verbose $(git branches)"
    ;;
    *)
      __gitcomp "$(git branches)"
    ;;
  esac
}

_git_conflicting () {
  if test "${cword:-0}" -eq 2; then
    _gitcomp "add edit ls"
  fi
}
