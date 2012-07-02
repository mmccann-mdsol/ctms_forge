# ---------------------------------------------------------------------------
# global.sh
# loads environment variables for working on project ctms.
# ---------------------------------------------------------------------------

# --- Tomcat settings
CATALINA_HOME=/usr/share/tomcat7; export CATALINA_HOME
CATALINA_BASE=$forge/tcbase; export CATALINA_BASE
ctms_doc_base=$project_dir/app

# --- Mysql settings
if [ "$(uname)" = "Darwin" ] ; then
  mysqld_cmd=/usr/local/bin/mysqld
  mysql_cmd=/usr/local/bin/mysql
  dump_cmd=/usr/local/bin/mysqldump
else
  mysqld_cmd=/usr/bin/mysqld
  mysql_cmd=/usr/bin/mysql
  dump_cmd=/usr/bin/mysqldump
fi
mysql_root_pass=root