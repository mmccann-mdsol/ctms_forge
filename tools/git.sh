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

  if [ "$git_lcl_branch" != "" ] ; then

    git branch -m $git_src_branch $git_lvl_branch

  fi

}
