# ---------------------------------------------------------------------------
# logs.sh, log tools
# CTMS log tools
# ---------------------------------------------------------------------------
# Provides a set of functions to interact directly with the CTMS logs.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# --- view a specified log
viewLog() {

  if [ "$1" == "" ] ; then
     echo "no log specified";
     return
  fi

  if [ ! -e $ctms_log_dir/ctms_${1}.log ] ; then
     echo "$ctms_log_dir/ctms_${1}.log does not exist"
     return
  fi

  less "$ctms_log_dir/ctms_${1}.log"

}

# --- search for a string. If a second parameter is specified, it will search that specifi file
#     otherwise it will search all log files.
searchLog() {

  if [ "$1" == "" ] ; then
    echo "No search string specified"
    return
  fi

  tgt=$2

  if [ "$tgt" == ""  ] ; then
     tgt=$ctms_log_dir*
  else
    tgt=$ctms_log_dir/ctms_${tgt}.log
  fi

  eval "grep '$1' $tgt"

}
