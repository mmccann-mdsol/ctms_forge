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

  if [ "$1" == "" ] ; then 
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

  if [ "$1" == "" ] ; then 
    echo "You must specify a user"
  fi 

  if [ "$2" == "" ] ; then 
    echo "You must specify a password" 
  fi 

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "update resource_def set user_pwd=upper(convert(sha('$2'), char)) where user_id='$1';" 
 
}

# --- Get next db Id 
getNextDbId() { 

  nextDbId=`$mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -A -e "update key_gen set current_id=current_id+1; select current_id from key_gen;" | grep '[0-9]'`

}

# --- Create a Study 
addStudy() {
  
  if [ "$1" = "" ] ; then 
    echo "You must supply a study name" 
  fi 
  
  getNextDbId 

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "insert into drugtrial_def (id, name, status, phase) VALUES ( $nextDbId, '$1', 1, 2 )"; 

}

addStudyAttribute() {

  if [ "$4" = "" ] ; then 
    echo "You must specify the study, attribute group, attribute, value, and an optional dd_value." 
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




