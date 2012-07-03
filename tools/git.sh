# ---------------------------------------------------------------------------
# git.sh, git support functions
# CTMS Development Toolset
# ---------------------------------------------------------------------------
#
# Provides functions for working with git.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# --- Fetch repo and rename if local branch name set
fetchRepo() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "fetchRepo"
    echo "  Fetch repo and rename if local branch name set"
    return
  fi

  git clone -b $git_src_branch $git_repo $project_dir

  if [ -n "$git_lcl_branch" ] ; then

    cwd=$(pwd)
    cd $project_dir
    git branch -m $git_src_branch $git_lcl_branch
    cd $cwd

  fi

}

rmRemote() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "rmRemote [optional branch name]"
    echo "  Remove remotely either the given branch or the current local branch"
    return
  fi

  b=git_lcl_branch
  if [ -n "$1" ] ; then
    b="$1"
  fi

  cwd=$(pwd)
  cd $project_dir
  git push origin :$b
  cd $cwd

}

changeBranch() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "changeBranch <new branch name>"
    echo "  Switch to a different working branch"
    return
  fi

  if [ -z "$1" ] ; then
    error "Missing branch name"
    return
  fi

  cwd=$(pwd)
  cd $project_dir
  git stash
  git checkout "$1"
  cd $cwd
  git_lcl_branch="$1"

}
