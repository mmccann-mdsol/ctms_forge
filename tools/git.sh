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

  git clone -b $git_src_branch $git_repo $project_dir

  if [ -n "$git_lcl_branch" ] ; then

    cd $project_dir
    git branch -m $git_src_branch $git_lcl_branch

  fi

}

rmRemote() {

  if [ "$git_lcl_branch" = "" ] ; then
    echo "Unknown local branch name."
    return;
  fi

  cd $project_dir
  git push origin :$git_lcl_branch

}
