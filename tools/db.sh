# ---------------------------------------------------------------------------
# db.sh, Database tools
# CTMS database tools
# ---------------------------------------------------------------------------
# Provides a set of functions to interact directly with the CTMS database.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# --- start mysqld
startDatabase() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "startDatabase"
    echo "  Starts an instance of MySQL database daemon"
    return
  fi

  echo "Starting MySQL daemon"
  $mysqld_cmd &> /dev/null &
  mysqld_pid=$!
  if [ -z "$mysqld_pid" ] ; then
    failure
    error "Could not start MySQL daemon"
    return
  fi
  success

}

# --- stop mysqld
stopDatabase() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "stopDatabase"
    echo "  Stops a running instance of MySQL daemon"
    return
  fi

  echo "Stopping MySQL daemon"
  kill $mysqld_pid
  if [ $? -eq 0 ] ; then
    success
  else
    failure
  fi

}

# --- create the database set in the environment ---
createDatabase() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "createDatabase"
    echo "  Will create a new database called $ctms_db_name and give necessary"
    echo "  permissions to $ctms_db_user"
    return
  fi

  echo "Creating Database $ctms_db_name"
  $mysql_cmd -uroot -p$mysql_root_pass -e "create database $ctms_db_name";
  $mysql_cmd -uroot -p$mysql_root_pass -e "grant ALL on ${ctms_db_name}.* to '$ctms_db_user' identified by '$ctms_db_pass'"
  # TODO actually check for success
  success

}

# --- drop a database
dropDatabase() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "dropDatabase"
    echo "  Will drop the existing database $ctms_db_name"
    return
  fi

  echo "Dropping Database $ctms_db_name"
  $mysql_cmd -uroot -p$mysql_root_pass -e "drop database $ctms_db_name";
  # TODO actually check for success
  success

}

# --- Load the database schema
loadSchema() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "loadSchema"
    echo "  Load the schema $schema_file into the database"
    return
  fi

  echo "Loading schema"
  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name < $schema_file
  success

}

# --- Load the seeddata file
loadSeedData() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "loadSeedData"
    echo "  Load necessary seed data from $seed_data_file into the database"
    return
  fi

  echo "Loading seed data"
  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name < $seed_data_file
  success

}

# --- dump the database to the file specified (or auto generate the name
#     based on the current date and time)
dumpDb() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "dumpDb [file]"
    echo "  Create a backup of the database $ctms_db_name and save it either in"
    echo "  [file] or a file based on todays date"
    return
  fi

  bak="$1"
  if [ -z "$bak" ] ; then
    bak="$(date +"%Y%m%d%H%M%S")_${ctms_db_name}.sql"
  fi
  $dump_cmd -u$ctms_db_user -p$ctms_db_pass --databases $ctms_db_name > $bak

}

runSql() { 

  if [ "$1" = "" ] ; then 

    echo "You must specify a sql command to run" 
    return 

  fi 

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "$1" 

}