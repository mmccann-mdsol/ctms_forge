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

# --- Fetch repo
fetchRepo() {
  
  git clone -b $git_src_branch $git_repo $project_dir 

}

# --- switch to the specified branch 
switchBranch() {

   true  
   ## TO-DO 

}

# --- Synchronise with source branch 
syncBranch() {

   true 
   ## TO-DO 
   
}

