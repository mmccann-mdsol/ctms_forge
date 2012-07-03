# ---------------------------------------------------------------------------
# onfig.sh, General CTMS configuration functions
# CTMS Development Toolset
# ---------------------------------------------------------------------------
#
# Provides functions for working with CTMS configuration.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# --- Disable iMedidata login
disableImedidata() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "disableImedidata"
    echo "  Disable iMedidata login"
    return
  fi

  res="$(sed 's/^##authenticationRule=1$/authenticationRule=1/;s/^authenticationRule=3$/##authenticationRule=3/;s/^##authenticatorClass= uhuru.bizx.security.SVSimple$/authenticatorClass= uhuru.bizx.security.SVSimple/;s/^authenticatorClass= uhuru.bizx.security.SVCas$/##authenticatorClass= uhuru.bizx.security.SVCas/' <$bootstrap)"
  echo "$res" >$bootstrap

}

# --- Enable iMedidata login
enableImedidata() {

  if [ "$1" = "-h" -o "$1" = "--help" ] ; then
    highlight "disableImedidata"
    echo "  Disable iMedidata login"
    return
  fi

  res="$(sed 's/^authenticationRule=1$/##authenticationRule=1/;s/^##authenticationRule=3$/authenticationRule=3/;s/^authenticatorClass= uhuru.bizx.security.SVSimple$/##authenticatorClass= uhuru.bizx.security.SVSimple/;s/^##authenticatorClass= uhuru.bizx.security.SVCas$/authenticatorClass= uhuru.bizx.security.SVCas/' <$bootstrap)"
  echo "$res" >$bootstrap

}
