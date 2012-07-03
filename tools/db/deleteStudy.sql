/* --------------------------------------------------------------------------
   deleteStudy.sql, delete a study 
   CTMS Development Toolset 
   --------------------------------------------------------------------------

   Removes all data associated with a study. 

   WARNING: These tools are intended as development aids and should not be 
            used in a production environment. 
 ------------------------------------------------------------------------- */
   
-- Delete all generic_ext subject_crf_page entries for a specific study 
delete from generic_ext where ASSOC_OBJ='subject_crf_page' and ASSOC_OBJ_ID in 
    (select scp.ID from subject_crf_page scp 
                   join subject_crf sc   on scp.SUBJECT_CRF_ID = sc.ID
                   join subject_def sd   on sc.SUBJECT_ID = sd.ID 
                   join site_address sdr on sd.LOCATION_ID = sdr.ID 
                   join site_def std     on sdr.SITE_ID = std.ID 
                   join drugtrial_def dd on std.DRUGTRIAL_ID = dd.ID 
      where dd.name = @studyName 
     );

-- Delete all subject_crf_page entries for a specific study 
delete from subject_crf_page where SUBJECT_CRF_ID in 
    (select sc.ID  from subject_crf sc   
                   join subject_def sd   on sc.SUBJECT_ID = sd.ID 
                   join site_address sdr on sd.LOCATION_ID = sdr.ID 
                   join site_def std     on sdr.SITE_ID = std.ID 
                   join drugtrial_def dd on std.DRUGTRIAL_ID = dd.ID 
      where dd.name = @studyName 
     );
     
-- Delete all subject_crf entries for a specific study 
delete from subject_crf where SUBJECT_ID in 
    (select sd.ID  from subject_def sd 
                   join site_address sdr on sd.LOCATION_ID = sdr.ID 
                   join site_def std     on sdr.SITE_ID = std.ID 
                   join drugtrial_def dd on std.DRUGTRIAL_ID = dd.ID 
      where dd.name = @studyName
     );

-- Delete all status_change_tracking entries for subjects 
delete from status_change_tracking where ASSOC_OBJ_ID in 
    (select sd.ID  from subject_def sd 
                   join site_address sdr on sd.LOCATION_ID = sdr.ID 
                   join site_def std     on sdr.SITE_ID = std.ID 
                   join drugtrial_def dd on std.DRUGTRIAL_ID = dd.ID 
      where dd.name = @studyName
     ) AND ASSOC_OBJ='subject_def';

-- Delete all subject_def entries for a specific study 
delete from subject_def where LOCATION_ID in 
    (select sdr.ID from site_address sdr
                   join site_def std     on sdr.SITE_ID = std.ID 
                   join drugtrial_def dd on std.DRUGTRIAL_ID = dd.ID 
      where dd.name = @studyName
     );
     
-- Delete all site_address entries for a specific study 
delete from site_address where SITE_ID in 
    (select std.ID from site_def std     
                   join drugtrial_def dd on std.DRUGTRIAL_ID = dd.ID 
      where dd.name = @studyName
     );

-- delete all site_contact entries 
delete from site_contact where SITE_ID in 
  (select std.ID from site_def std 
		  join drugtrial_def dd on std.DRUGTRIAL_ID = dd.ID 
    where dd.name = @studyName
  ); 

-- delete all site_def entries for a given study 
delete from site_def where drugtrial_id in 
    (select dd.ID from drugtrial_def dd 
      where dd.name = @studyName
    );

-- delete all assigned_crf_page_tmpl entries 
delete from assigned_crf_page_tmpl where ASSIGNED_CRF_BASE_TMPL_ID in 
    (select acbt.ID from assigned_crf_base_tmpl acbt 
                    join drugtrial_def dd on acbt.ASSIGNED_OBJ_ID = dd.ID and ASSIGNED_OBJ='drugtrial_def'
     where dd.name = @studyName 
    ); 

-- delete all assigned_crf_base_tmpl entries 
delete from assigned_crf_base_tmpl where ASSIGNED_OBJ_ID in 
    (select dd.ID from drugtrial_def dd where dd.NAME = @studyName) 
    and ASSIGNED_OBJ='drugtrial_def'; 


-- delete all assigned_activity_detail_tmpl 
delete from assigned_activity_detail_tmpl where ASSIGNED_ACTIVITY_TMPL_ID in 
    (select aat.ID from assigned_activity_tmpl aat 
                   join drugtrial_def dd on aat.ASSIGNED_OBJ_ID = dd.ID and ASSIGNED_OBJ='drugtrial_def'
     where dd.name = @studyName 
    );

-- reset lastTransactionId 
delete from  attribute_answers where ASSOC_OBJ = 'drugtrial_def' 
  and ASSOC_OBJ_ID in (select ID from drugtrial_def where name = @studyName);

delete from drugtrial_def where name = @studyName; 



     
                        
