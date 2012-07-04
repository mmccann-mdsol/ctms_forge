# ---------------------------------------------------------------------------
# global.sh
# loads environment variables for working on project ctms.
# ---------------------------------------------------------------------------


# --- Check our environment -------------------------------------------------
hostOS="$(uname)"

# --- Tomcat settings
if [ -z $CATALINA_HOME ] ; then
  export CATALINA_HOME=/usr/share/tomcat7
fi
export CATALINA_BASE=$forge/tcbase
ctms_doc_base=$project_dir/app

# --- Mysql settings
echo=echo
if [ "$hostOS" = "Darwin" ] ; then

  mysqld_cmd=/usr/local/bin/mysqld
  mysql_cmd=/usr/local/bin/mysql
  dump_cmd=/usr/local/bin/mysqldump
  [ -e "/usr/local/Cellar/coreutils/8.17/libexec/gnubin/echo" ] && echo=gecho

else

  mysqld_cmd=/usr/bin/mysqld
  mysql_cmd=/usr/bin/mysql
  dump_cmd=/usr/bin/mysqldump

fi

mysql_root_pass=root
