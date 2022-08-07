#!/bin/sh

# Git command line goodies.

_gd() {
    ( test "$#" -eq 0 && git diff ) || git diff "$*"
}

_g_inside_work_tree_p() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
}

_gclean() {
    # https://stackoverflow.com/questions/1146973/how-do-i-revert-all-local-changes-in-git-managed-project-to-previous-state#answer-42903805
    #
    # - Deletes local, non-pushed commits
    # + Reverts changes you made to tracked files
    # + Restores tracked files you deleted
    # + Deletes files/dirs listed in .gitignore (like build files)
    # + Deletes files/dirs that are not tracked and not in .gitignore

    git clean --force -d -x
    git reset --hard
}

# Case sensitive search.
_gmessage_search () {
    git log --all --grep="$*"
}

# Reset to revision.
# In a normal way, it's need to:
# Usage: grevert 741083d
# Usage: grevert 741083d file1 file2
_grevert() {
    [ $# -lt 2 ] && >&2 echo "Commit hash should should be specified" && return 1

    method="$1"
    hash="$2"
    shift
    files=""
    if ! test "$#" -eq 1; then
        shift
        files="$*"
    fi
    bash -c "git apply <(git $method $hash -R $files)"
}

_gl() {
    _g_inside_work_tree_p || (>&2 echo "Not in git repo."; return 1)
    cmd="(progn
           (magit-log-all)
           (delete-other-windows))"
    [ "$#" -eq 1 ] && cmd="(progn
                             (find-file \"$1\")
                             (magit-log-buffer-file)
                             (delete-other-windows))"
    emacs-runner -e "$cmd"
}

alias gd="_gd"
alias gclean="_gclean"
alias ga="git add"
alias gc="git commit"
alias gg="git pull"
alias gp="git push"
alias gs="git status"
alias gf="git log -p --all -S"
alias gu="_grevert show"  # undo a commit
alias gr="_grevert diff"  # remove up to a hash
alias gm="_gmessage_search"
alias gl="_gl"
