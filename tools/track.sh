# ---------------------------------------------------------------------------
# track.sh, tracking tools
# CTMS database tools
# ---------------------------------------------------------------------------
# Provides a set of functions to track environment steps to track.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# --- Initialise tracking setup
initTracking() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "initTracking"
    echo "  Initialise state tracking"
    return
  fi

  if [ ! -d "$tracking_dir/$project_name" ] ; then
    mkdir -p "$tracking_dir/$project_name/states"
  fi

}
