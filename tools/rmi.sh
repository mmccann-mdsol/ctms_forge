# ---------------------------------------------------------------------------
# rmi.sh, Rave Monitor Integration specific tools
# CTMS Development Toolset
# ---------------------------------------------------------------------------
#
# Provides functions for working with CTMS RMI features.
#
# WARNING: These tools are intended as development aids and should not be
#          used in a production environment.
# ---------------------------------------------------------------------------

# --- Add an RMI study
addRmiStudy() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "addRmiStudy <study name> <remote connection reference>"
    echo "  Add a new study with RMI"
    return
  fi

  if [ -z "$2" ] ; then
    error "You must specify a study name and remote connection reference."
    return
  fi

  addStudy "$1"

  addStudyAttribute "$1" "01ImpActivityCRFTmpl" "lastTransactionId" "-1"
  addStudyAttribute "$1" "01ImpActivityCRFTmpl" "msgId"             "ImportRaveVisitCRFTemplates"
  addStudyAttribute "$1" "01ImpActivityCRFTmpl" "readOnlyEnabled"   "Y"
  addStudyAttribute "$1" "01ImpActivityCRFTmpl" "remoteConnectionReference"   "$2"
  addStudyAttribute "$1" "01ImpActivityCRFTmpl" "uri"  "Rave Activity & CRF Templates WebServices" "/RaveWebServices/datasets/CtmsGetFoldersForms.csv?Study=\$!sFormat.urlEncode(\$!jobData.drugtrialName)"
  addStudyAttribute "$1" "01ImpActivityCRFTmpl" "visitReportButton" "Y" 

  addStudyAttribute "$1" "02ImpSites" "lastTransactionId" "-1"
  addStudyAttribute "$1" "02ImpSites" "msgId"             "ImportRaveSites"
  addStudyAttribute "$1" "02ImpSites" "readOnlyEnabled"   "Y"
  addStudyAttribute "$1" "02ImpSites" "remoteConnectionReference"   "$2"
  addStudyAttribute "$1" "02ImpSites" "uri"  "Rave Sites WebService" "/RaveWebServices/datasets/CtmsGetSites.csv?study=\$!sFormat.urlEncode(\$!jobData.drugtrialName)"
  addStudyAttribute "$1" "02ImpSites" "visitReportButton" "Y" 

  addStudyAttribute "$1" "03ImpSiteContacts" "lastTransactionId" -"-1"
  addStudyAttribute "$1" "03ImpSiteContacts" "msgId"             "ImportRaveSitesContacts"
  addStudyAttribute "$1" "03ImpSiteContacts" "readOnlyEnabled"   "Y"
  addStudyAttribute "$1" "03ImpSiteContacts" "remoteConnectionReference"   "$2"
  addStudyAttribute "$1" "03ImpSiteContacts" "uri"  "Rave Site Contacts WebService" "/RaveWebServices/datasets/CtmsGetSitesContacts.csv?Study=\$!sFormat.urlEncode(\$!jobData.drugtrialName)"
  addStudyAttribute "$1" "03ImpSiteContacts" "visitReportButton" "Y"

  addStudyAttribute "$1" "04ImpSubjects " "lastTransactionId" 0
  addStudyAttribute "$1" "04ImpSubjects " "msgId"             "ImportRaveSubjects"
  addStudyAttribute "$1" "04ImpSubjects " "readOnlyEnabled"   "Y"
  addStudyAttribute "$1" "04ImpSubjects " "remoteConnectionReference"   "$2"
  addStudyAttribute "$1" "04ImpSubjects " "uri"  "Rave Subject Data WebService" "/RaveWebServices/datasets/CTMSGetSubjectData.odm?study=\$!sFormat.urlEncode(\$!jobData.drugtrialName)&startid=\$!jobData.lastTransactionId"
  addStudyAttribute "$1" "04ImpSubjects " "visitReportButton" "Y"

  addStudyAttribute "$1" "05ImpMetrics" "lastTransactionId" 0
  addStudyAttribute "$1" "05ImpMetrics" "isAuditPull"       "N"
  addStudyAttribute "$1" "05ImpMetrics" "auditIdAtStart"    "0"
  addStudyAttribute "$1" "05ImpMetrics" "msgId"             "ImportRaveMetrics"
  addStudyAttribute "$1" "05ImpMetrics" "readOnlyEnabled"   "Y"
  addStudyAttribute "$1" "05ImpMetrics" "remoteConnectionReference"   "$2"
  addStudyAttribute "$1" "05ImpMetrics" "uri" "Rave Metrics WebService" "/RaveWebServices/datasets/ctmsgetsubjectMetrics.csv?study=\$!sFormat.urlEncode(\$!jobData.drugtrialName)&startid=\$!jobData.lastTransactionId&isAuditPull=\$!jobData.isAuditPull"
  addStudyAttribute "$1" "05ImpMetrics" "visitReportButton" "Y"

}

# --- Add a remote connection reference
addRemoteConnection() {

  if [ $1 = "-h" -o $1 = "--help" ] ; then
    highlight "addRemoteConnection <connection reference> <protocol> <host name> <user name> <password>"
    echo "  Add and configure a new remote connection for RMI"
    return
  fi

  if [ -z "$5" ] ; then
    error "You must specify a name, protocol, host, username and password."
    return
  fi

  getNextDbId

  $mysql_cmd -u$ctms_db_user -p$ctms_db_pass $ctms_db_name -e "insert into remote_connect (id, reference, name, user_id, user_pwd, host_name, protocol) VALUES
								( $nextDbId,
								  '$1',
								  '$1',
								  '$4',
								  upper(convert(sha('$5'), char)),
								  '$3',
								  '$2')"


}

# --- Remove all data and resets incremntal pulls to zero
resetStudy() {

  true
  ## TO-DO

}
