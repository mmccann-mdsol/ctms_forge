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

# Load our global settings
echo 'Loading global environment'
source $forge/env/global.sh

# Load our tools set
echo 'Loading tool set'
for tool in $forge/tools/*.sh ; do

  echo " * $tool"
  source $tool

done

# If an environment is specified, load it.
if [ "$1" != "" ] ; then

  project_name="$1"

  echo "Loading environment settings: $1"

  if [ ! -e $forge/env/$1.sh ] ; then
    echo "'$1.sh' does not exist in $forge/env."
    return
  fi

  source $forge/env/$1.sh
  initTracking

fi
