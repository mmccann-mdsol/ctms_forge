# ---------------------------------------------------------------------------
# tomcat.sh, tomcat tools
# CTMS database tools
# ---------------------------------------------------------------------------
# Provides a set of functions to interact directly with the CTMS database.
#
# WARNING: These tools are provided as development aid and are not suitable
# for use in a production environment.
#
# ---------------------------------------------------------------------------

# --- Startup Tomcat
startTomcat() {
  $CATALINA_HOME/bin/catalina.sh jpda start
}

# --- Stop Tomcat
stopTomcat() {
  $CATALINA_HOME/bin/catalina.sh stop
}

# --- View Tomcat Logs
viewTomcatLog() {
  less $CATALINA_BASE/logs/catalina.out
}

# --- Create Root XML config file for tomcat
createRootXml() {
  echo "building ROOT.xml "
  echo "<?xml version='1.0' encoding='utf-8'?>"           >  $CATALINA_BASE/conf/Catalina/localhost/ROOT.xml
  echo "     <Context docBase='$ctms_doc_base' path=''>"  >> $CATALINA_BASE/conf/Catalina/localhost/ROOT.xml
  echo "</Context>"                                       >> $CATALINA_BASE/conf/Catalina/localhost/ROOT.xml
}
