# ---------------------------------------------------------------------------
# system.sh
# CTMS forge system tools
# ---------------------------------------------------------------------------
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# --- Top level help function
showHelp() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "showHelp [optional function name]"
    echo "  Show list of all functions, or if provided a single function"
    return
  fi

  if [ -n "$1" ] ; then
    $1 --help
  else
    for f in $funcs ; do
      $f --help
    done
  fi

}

# --- Update all forge files
selfUpdate() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "selfUpdate"
    echo "  Perform a self update of all forege tools"
    return
  fi

  cwd=$(pwd)
  cd $forge
  git pull
  cd $cwd
}
