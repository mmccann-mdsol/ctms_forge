# ---------------------------------------------------------------------------
# global.sh 
# loads environment variables for working on project ctms. 
# ---------------------------------------------------------------------------

# --- Tomcat settings 
CATALINA_BASE=$forge/tcbase; export CATALINA_BASE 
ctms_doc_base=$project_dir/app

# --- Mysql settings 
mysql_cmd=/usr/bin/mysql 
mysql_root_pass=root 