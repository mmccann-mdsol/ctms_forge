# ---------------------------------------------------------------------------
# db.sh, Database tools 
# CTMS database tools 
# ---------------------------------------------------------------------------
# Provides a set of functions to interact directly with the CTMS database. 
#
# WARNING: These tools are intended as development aids and should not be 
#          used in a production environment. 
# ---------------------------------------------------------------------------

# --- create the database set in the environment --- 
createDatabase() {

  # --- Ensure we have the environment set appropriately 
  checkEnv errMsg DB 
  if [ "$errMsg" != "" ] ; then 
    echo $errMsg 
    return
  fi 
  
  echo 'Creating Database with settings:' 
  printEnv DB 
  
  $mysql_cmd -uroot -p$mysql_root_pass -e "create database $ctms_db_name"; 
  $mysql_cmd -uroot -p$mysql_root_pass -e "grant ALL on ${ctms_db_name}.* to '$ctms_db_user' identified by '$ctms_db_pass'" 
    
}

# --- drop a database 
dropDatabase() {

  # --- Ensure we have the environment set appropriately 
  checkEnv errMsg DB 
  if [ "$errMsg" != "" ] ; then 
    echo $errMsg 
    return
  fi 
  
  echo 'Dropping Database with settings:' 
  printEnv DB 

  $mysql_cmd -uroot -p$mysql_root_pass -e "drop database $ctms_db_name"; 

}

# --- Load the database schema 
loadSchema() { 

  # --- Ensure we have the environment set appropriately 
  checkEnv errMsg DB 
  if [ "$errMsg" != "" ] ; then 
    echo $errMsg 
    return
  fi 
  
  echo -n 'Loading schema...' 
  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name < $schema_file 
  echo "done." 
  
}

loadSeedData() {

  # --- Ensure we have the environment set appropriately 
  checkEnv errMsg DB 
  if [ "$errMsg" != "" ] ; then 
    echo $errMsg 
    return
  fi 

  echo 'Loading seed data...' 
  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name < $seed_data_file 
  echo 'done.'
}





