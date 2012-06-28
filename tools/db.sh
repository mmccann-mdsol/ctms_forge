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
	echo "Starting MySQL daemon"
	$mysqld_cmd &> /dev/null &
	mysqld_pid=$!
}

# --- stop mysqld
stopDatabase() {
	echo "Stopping MySQL daemon"
	kill $mysqld_pid
}

# --- create the database set in the environment ---
createDatabase() {

  echo "Creating Database $ctms_db_name:"

  $mysql_cmd -uroot -p$mysql_root_pass -e "create database $ctms_db_name";
  $mysql_cmd -uroot -p$mysql_root_pass -e "grant ALL on ${ctms_db_name}.* to '$ctms_db_user' identified by '$ctms_db_pass'"

}

# --- drop a database
dropDatabase() {

  echo "Dropping Database $ctms_db_name:"
  $mysql_cmd -uroot -p$mysql_root_pass -e "drop database $ctms_db_name";

}

# --- Load the database schema
loadSchema() {

  echo -n 'Loading schema...'
  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name < $schema_file
  echo "done."

}

# --- Load the seeddata file
loadSeedData() {

  echo 'Loading seed data...'
  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name < $seed_data_file
  echo 'done.'
}

# --- dump the database to the file specified
dumpDb() {

  if [ -z "$1" ] ; then
    echo "You must specify the destination file"
    return
  fi

  $dump_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name > $1

}
