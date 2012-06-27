# ---------------------------------------------------------------------------
# ctms.sh 
# loads environment variables for working on project ctms. 
# ---------------------------------------------------------------------------

# --- General settings 
project_dir=$forge/ctms/ 
ctms_log_dir=$project_dir/logs/

# --- Database settings 
ctms_db_name=ctms
ctms_db_user=ctms
ctms_db_pass=ctms 

schema_file=$project_dir/DBSchema/DDL/cforce-schema.mysql.sql 
seed_data_file=$project_dir/DBSchema/Source/seed_data.sql 

# --- Tomcat settings 

# Set this if you want to use a different base folder. 
#CATALINA_BASE=$forge/ctms_tc_base
ctms_doc_base=$project_dir/app

# --- Git settings 
git_src_branch="release/2012.1.0"
git_repo="git@github.com:mdsol/ctms.git" 
