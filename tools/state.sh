# ---------------------------------------------------------------------------
# state.sh, State tools 
# CTMS database tools 
# ---------------------------------------------------------------------------
# Provides a set of functions to save & reload state information. 
#
# WARNING: These tools are intended as development aids and should not be 
#          used in a production environment. 
# ---------------------------------------------------------------------------

# --- load env to existing state 
loadState() {
   true; 
}

# --- save current state 
saveState() {
   
  if [ "$1" == "" ] ; then 

    echo "you must specify a stateName"

  fi

  if [ -d $forge/track/$project_name/states/$1 ] ; then 
  
    read -p "State already exists - do you want to overwrite?" -n 1 -r 

    if [[ $REPLY =~ ^[Yy]$ ]] 

      rm -fR $forge/track/$project_name/states/$1

    else

      return 

    fi 

  fi 

  mkdir -p $forge/track/$project_name/states/$1 ] 

  if [ "$2" != "-nodb" ] ; then 

    dumpDb $forge/track/$project_name/states/$1/db.sql 

  fi 

}

# --- Add a file to the list of those to save the state of 
addStateFile() {
   true; 
}

# --- Remove a file from the state 
remStateFile() {
   true; 
}
