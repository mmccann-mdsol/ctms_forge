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

  if [ $1 = "-h" -o $1 = "--help" ] ; then
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

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "rmRemote"
    echo "  Remove a remote branch"
    return
  fi

  if [ -z "$git_lcl_branch" ] ; then
    error "Unknown local branch name"
    return
  fi

  cwd=$(pwd)
  cd $project_dir
  git push origin :$git_lcl_branch
  cd $cwd

}
