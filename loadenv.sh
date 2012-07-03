# ---------------------------------------------------------------------------
# loadenv.sh
# CTMS Development Toolset
# ---------------------------------------------------------------------------
# Loads a CTMS environment.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# We use the directory this file is stored in the reference our base folder
forge="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tracking_dir=$forge/track

set +e
funcs=""

# Load our global settings
echo "Loading global environment"
source $forge/env/global.sh
success

# Load our tools set
echo "Loading tool set:"
for tool in $forge/tools/*.sh ; do

  echo $(basename $tool)": "
  source "$tool"
  if [ $? -eq 0 ] ; then
    funcs=$(grep -h '^.*() {$' tools/*.sh | sed 's/^\(.*\)() {$/\1/')
    success
  else
    failure
  fi

done

# If an environment is specified, load it.
if [ -n "$1" ] ; then

  project_name="$1"

  echo "Loading environment settings: $1"

  if [ ! -e $forge/env/$1.sh ] ; then
    failure
    error "'$1.sh' does not exist in $forge/env/"
    return
  fi
  success

  source $forge/env/$1.sh
  initTracking

fi
