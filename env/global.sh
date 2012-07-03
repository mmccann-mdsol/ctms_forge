# ---------------------------------------------------------------------------
# global.sh
# loads environment variables for working on project ctms.
# ---------------------------------------------------------------------------

# --- Tomcat settings
CATALINA_HOME=/usr/share/tomcat7; export CATALINA_HOME
CATALINA_BASE=$forge/tcbase; export CATALINA_BASE
ctms_doc_base=$project_dir/app

# --- Mysql settings
echo=echo
if [ "$(uname)" = "Darwin" ] ; then
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

# --- Top level help function
showHelp() {
  for f in $funcs ; do
    $f --help
  done
}

# --- Display functions
error() {
  $echo -e "${bold_on}${fore_red}ERROR: ${bold_off}${reset_color}$@"
}

success() {
  off=$(($(tput cols)-7))
  $echo -e "\033[1A\033[${off}C${fore_green}Success${reset_color}"
}

failure() {
  off=$(($(tput cols)-7))
  $echo -e "\033[1A\033[${off}C${fore_red}Failure${reset_color}"
}

highlight() {
  t=( $@ )
  $echo -en "${bold_on}${t[0]}${bold_off}"
  for x in ${t[@]} ; do
    [ "$x" != ${t[0]} ] && $echo -en " ${fore_cyan}$x${reset_color}"
  done
  $echo
}

# --- Display settings

fore_black="\033[0;30m"
fore_red="\033[0;31m"
fore_green="\033[0;32m"
fore_yellow="\033[0;33m"
fore_blue="\033[0;34m"
fore_purple="\033[0;35m"
fore_cyan="\033[0;36m"
fore_white="\033[0;37m"
      
back_black="\033[0;40m"
back_red="\033[0;41m"
back_green="\033[0;42m"
back_yellow="\033[0;43m"
back_blue="\033[0;44m"
back_purple="\033[0;45m"
back_cyan="\033[0;46m"
back_white="\033[0;47m"

bold_on="\033[0;1m"
bold_off="\033[0;22m"
italics_on="\033[0;3m"
italics_off="\033[0;23m"
underline_on="\033[0;4m"
underline_off="\033[0;24m"
invert_on="\033[0;7m"
invert_off="\033[0;27m"

reset_color="\033[0;0m"