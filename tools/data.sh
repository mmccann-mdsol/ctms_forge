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

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "clearStudy <study>"
    echo "  Clear all data associated with a study"
    return
  fi

  if [ -z "$1" ] ; then
    error "No study specified"
    return
  fi

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "set @studyName='$1' ; source $forge/tools/db/clearStudy.sql;"

}

# --- Deletes a study
deleteStudy() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "deleteStudy <study>"
    echo "  Delete a study"
    return
  fi

  if [ -z "$1" ] ; then
    echo "No study specified."
    return
  fi

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "set @studyName='$1' ; source $forge/tools/db/deleteStudy.sql;"

}

# --- Set a study attribute to a specific value
setStudyAttribute() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "setStudyAttribute"
    echo "  Set a study attribute to a specific value"
    return
  fi

  true
  ## TO-DO

}

# --- Removes all orphaned records from the database
killOrphans() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "killOrphans"
    echo "  Removes all orphaned records from the database"
    return
  fi

  true
  ## TO-DO

}

# --- Set a password for a user
setUserPass() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "setUserPass <username> <password>"
    echo "  Set a password for a user"
    return
  fi

  if [ -z "$1" ] ; then
    error "You must specify a user"
    return
  fi

  if [ -z "$2" ] ; then
    error "You must specify a password"
    return
  fi

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "update resource_def set user_pwd=upper(convert(sha('$2'), char)) where user_id='$1';"

}

# --- Get next db Id
getNextDbId() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "getNextDbId"
    echo "  Get next DB ID"
    return
  fi

  nextDbId=`$mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -A -e "update key_gen set current_id=current_id+1; select current_id from key_gen;" | grep '[0-9]'`
  echo $nextDbId

}

# --- Create a Study
addStudy() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "addStudy <study>"
    echo "  Create a study"
    return
  fi

  if [ -z "$1" ] ; then
    error "You must supply a study name"
    return
  fi

  getNextDbId

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "insert into drugtrial_def (id, name, status, phase) VALUES ( $nextDbId, '$1', 1, 2 )";

}

addStudyAttribute() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "addStudyAttribute <study> <attribute group> <attribute template> <attribute name> <attribute value>"
    echo "  Add new study attribute"
    return
  fi

  if [ -z "$4" ] ; then
    error "You must specify the study, attribute group, attribute, value, and an optional dd_value."
    return
  fi

  getNextDbId

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "insert into attribute_answers (id, attribute_tmpl_id, assoc_obj, assoc_obj_id, name, dd_value) VALUES
							      ( $nextDbId,
							      (select id from attribute_tmpl where name='$3' and attribute_group_tmpl_id =
								(select id from attribute_group_tmpl where name='$2')),
							      'drugtrial_def',
							      (select id from drugtrial_def where name='$1'),
							      '$4', '$5')";
}


addSite() { 

  if [ -z "$2" ] ; then 
    error "You must specify a study and a site. " 
  fi 
  
  getNextDbId 
  runSql "insert into site_def (ID, NAME, DRUGTRIAL_ID) VALUES ( 
				$nextDbId, 
				'$2', 
				(select ID from drugtrial_def where NAME='$1'))" 

  getNextDbId 
  runSql "insert into address_def (ID) VALUES (
				$nextDbId )" 
  addressId=$nextDbId 
  getNextDbId 
  runSql "insert into site_address (ID, ADDRESS_ID, SITE_ID, IDENTIFIER, SUBJECT_LOCATION) VALUES (
				$nextDbId, 
				$addressId, 
				(select ID from site_def where NAME='$2'), 
				'$2', 
				'Y')"

}


addSubject() { 

  if [ -z "$2" ] ; then 
    error "You must specify a site and subject to add" 
  fi 

  getNextDbId 
  runSql "insert into subject_def (ID, SCREENING_NO, LOCATION_ID) VALUES ( 
				  $nextDbId, 
				  '$2',
				  (select id from site_address where IDENTIFIER='$1'))" 
}

addSubjectCrf() { 

  if [ -z "$2" ] ; then 
    error "You must specify a subject and a name" 
  fi 

  getNextDbId
  runSql "insert into subject_crf (ID, NAME, SUBJECT_ID) VALUES ( 
				$nextDbId, 
				'$2', 
				(select ID from subject_def where SCREENING_NO='$1'))"; 
}

