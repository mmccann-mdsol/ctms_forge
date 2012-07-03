# ---------------------------------------------------------------------------
# state.sh, State tools
# CTMS database tools
# ---------------------------------------------------------------------------
# Provides a set of functions to save & reload state information.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# --- loadState -------------------------------------------
#     Loads a previously saved state back into the environment
loadState() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "loadState <state name>"
    echo "  Restore a previously saved state"
    return
  fi

  if [ -z "$1" ] ; then
    error "You must specify a state name"
    return
  fi

  local state_dir=$forge/track/$project_name/states/$1

  if [ ! -d $state_dir ] ; then
    error "State $1 does not exist."
    return
  fi

  if [ -f $state_dir/db.sql && "$2" != "-nodb" ] ; then
    echo "Resetting dsatabase"
    $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name < $state_dir/db.sql
    success
  fi

  if [ -f $forge/track/$project_name/statefiles.txt && "$2" != "-nofiles" ] ; then

    while read line ; do

      echo "Resetting $line"
      mkdir -p $(dirname $forge/$line)
      cp $state_dir/$line $forge/$line
      if [ $? -eq 0 ] ; then
        success
      else
        failure
      fi

    done < "$forge/track/$project_name/statefiles.txt"

  fi

}

# --- save current state
saveState() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "saveState <state name>"
    echo "  Save the complete state of the current environment"
    return
  fi

  if [ -z "$1" ] ; then
    error "you must specify a stateName"
    return
  fi

  local state_dir=$forge/track/$project_name/states/$1
  if [ -d $state_dir ] ; then

    read -p "State already exists - do you want to overwrite?" -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]] ; then

      rm -fR $state_dir

    else

      return

    fi

  fi

  mkdir -p $state_dir

  if [ "$2" != "-nodb" ] ; then

    dumpDb $state_dir/db.sql

  fi

  if [ -f $forge/track/$project_name/statefiles.txt ] ; then

    while read line ; do

      echo "resetting $line"

      mkdir -p $(dirname $state_dir/$line)
      cp $forge/$line $state_dir/$line
      if [ $? -eq 0 ] ; then
        success
      else
        failure
      fi 

    done < "$forge/track/$project_name/statefiles.txt"

  fi

}

# --- Add a file to the list of those to save the state of
addStateFile() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "addStateFile <file>"
    echo "  Add a new file to have its state saved"
    return
  fi

  if [ -z "$1" ] ; then
    error "You must specify a file."
    return
  fi

  echo "$1" > $forge/track/$project_name/statefiles.txt

}

# --- Remove a file from the state
remStateFile() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "remStateFile <file>"
    echo "  Remove the given file from state control"
    return
  fi

  x=$(grep -v $1)
  echo -e "$x" > $forge/track/$project_name/statefiles.txt

}
