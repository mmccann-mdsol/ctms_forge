# ---------------------------------------------------------------------------
# data.sh, General data functions
# CTMS Development Toolset
# ---------------------------------------------------------------------------
#
# Provides functions for working with CTMS data.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------


# --- Clears all data associated with a study
clearStudy() {

  if [ -z "$1" ] ; then
    echo "No study specified."
    return
  fi

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name - e "set @studyName='$1' ; source $forge/tools/db/clearStudy.sql"

}

# --- Set a study attribute to a specific value
setStudyAttribute() {

   true
   ## TO-DO

}

# --- Removes all orphaned records from the database
killOrphans() {

   true
   ## TO-DO

}

# --- Set a password for a user
setUserPass() {

  if [ -z "$1" ] ; then
    echo "You must specify a user"
  fi

  if [ -z "$2" ] ; then
    echo "You must specify a password"
  fi

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "update resource_def set user_pwd=upper(convert(sha('$2'), char)) where user_id='$1';"

}
