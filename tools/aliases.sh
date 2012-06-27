# ---------------------------------------------------------------------------
# aliases.sh, Common command aliases
# CTMS Development Toolset  
# ---------------------------------------------------------------------------
#
# Provides aliases for commonly used functions 
#
# WARNING: These tools are intended as development aids and should not be 
#          used in a production environment. 
# ---------------------------------------------------------------------------

# --- Tomcat 
alias tcup=startTomcat 
alias tcdn=stopTomcat 
alias tclg=viewTomcatLog 

# --- mysql 
alias db="$mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -A" 
