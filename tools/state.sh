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

  if [ -z "$1" ] ; then

    echo "you must specify a state name"

  fi

  local state_dir=$forge/track/$project_name/states/$1

  if [ ! -d $state_dir ] ; then

    echo "State $1 does not exist."
    return

  fi

  if [ -f $state_dir/db.sql && "$2" != "-nodb" ] ; then

    echo "resetting dsatabase."
    $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name < $state_dir/db.sql

  fi

  if [ -f $forge/track/$project_name/statefiles.txt && "$2" != "-nofiles" ] ; then

    while read line ; do

      echo "resetting $line"

      mkdir -p $(dirname $forge/$line)
      cp $state_dir/$line $forge/$line

    done < "$forge/track/$project_name/statefiles.txt"

  fi

}

# --- save current state
saveState() {

  if [ -z "$1" ] ; then

    echo "you must specify a stateName"

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

    done < "$forge/track/$project_name/statefiles.txt"

  fi

}

# --- Add a file to the list of those to save the state of
addStateFile() {

  if [ -z "$1" ] ; then
    echo "You must specify a file."
  fi

  echo "$1" > $forge/track/$project_name/statefiles.txt

}

# --- Remove a file from the state
remStateFile() {
  true
}
