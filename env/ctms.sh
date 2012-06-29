# ---------------------------------------------------------------------------
# ctms.sh 
# loads environment variables for working on project ctms. 
# ---------------------------------------------------------------------------

# --- General settings 
project_dir=$forge/$project_name
ctms_log_dir=$project_dir/logs/

# --- Database settings 
ctms_db_name=$project_name
ctms_db_user=$project_name
ctms_db_pass=$project_name

schema_file=$project_dir/DBSchema/DDL/cforce-schema.mysql.sql 
seed_data_file=$project_dir/DBSchema/Source/seed_data.sql 

# --- Tomcat settings 

# Set this if you want to use a different base folder. 
#CATALINA_BASE=$forge/ctms_tc_base
ctms_doc_base=$project_dir/app

# --- Git settings 
git_repo="git@github.com:mdsol/ctms.git" 
git_src_branch="release/2012.1.0"
# set this to rename local branch 
git_lcl_branch="feature/$USER"
