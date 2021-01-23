/*==============================================================*/
/* Project:        AFTERSPOT                                    */
/* Created on:     1/15/2021                                    */
/*==============================================================*/

/*==============================================================*/
/* View: VIEW_FILTER_TMOBILE_AD                                 */
/*==============================================================*/

drop view VIEW_FILTER_TMOBILE_AD;

create view VIEW_FILTER_TMOBILE_AD as;
select USER_SESSION.DEVICEUSER_ID        as DEVICEUSER_ID, 
        USER_SESSION.UAIPHASH            as UAIPHASH , 
        CHANNEL_CONTENT.CONTENT_ID       as CONTENT_ID, 
        CHANNEL_CONTENT.CONTENT_TITLE    as CONTENT_TITLE, 
        CHANNEL_CONTENT.CONTENT_START    as CONTENT_START,
        CHANNEL_CONTENT.CONTENT_END      as CONTENT_END, 
        CHANNEL_CONTENT.CONTENT_DURATION as CONTENT_DURATION, 
        CHANNEL_CONTENT.CHANNEL_ID       as CHANNEL_ID, 
        CHANNEL_CONTENT.CHANNEL_NAME     as CHANNEL_NAME, 
        USER_SESSION.SESSION_START       as SESSION_START, 
        USER_SESSION.SESSION_END         as SESSION_END, 
        USER_SESSION.SESSION_DURATION    as SESSION_DURATION, 
        CHANNEL_CONTENT.ADID             as ADID, 
        CHANNEL_CONTENT.BCID             as BCID, 
        CHANNEL_CONTENT.BCCATEGORY       as BCCATEGORY
from (select SESSION_ID, DU.DEVICEUSER_ID AS DEVICEUSER_ID, CHANNEL_ID, SESSION_START, 
             SESSION_END, DURATION AS SESSION_DURATION, UAIPHASH  
              from "AFTERSPOT_DB"."RAW_SCHEMA"."FACT_USER_SESSION" US
              join "AFTERSPOT_DB"."RAW_SCHEMA"."DIM_DEVICEUSER" DU
              on US.DEVICEUSER_ID = DU.DEVICEUSER_ID
              ) USER_SESSION
    join (select CONTENT_ID, DURATION AS CONTENT_DURATION, CONTENT_END, CONTENT_START, 
                 CONTENT_TITLE, BCCATEGORY, BCID, ADID, CONTENT.CHANNEL_ID AS CHANNEL_ID, 
                 CHANNEL_NAME, ACTIVE AS ACTIVE_CHANNEL 
                  from "AFTERSPOT_DB"."RAW_SCHEMA"."DIM_CONTENT" CONTENT 
                  join "AFTERSPOT_DB"."RAW_SCHEMA"."DIM_CHANNEL" CHANNEL
                  on CHANNEL.CHANNEL_ID = CONTENT.CHANNEL_ID
                  ) CHANNEL_CONTENT
on CHANNEL_CONTENT.CHANNEL_ID = USER_SESSION.CHANNEL_ID
where 
(CHANNEL_CONTENT.BCID = 'rE43549')
and 
((USER_SESSION.SESSION_START <= CHANNEL_CONTENT.CONTENT_START
    and USER_SESSION.SESSION_END > CHANNEL_CONTENT.CONTENT_START)
        or (USER_SESSION.SESSION_START > CHANNEL_CONTENT.CONTENT_START
            and USER_SESSION.SESSION_END < CHANNEL_CONTENT.CONTENT_END)
                or (USER_SESSION.SESSION_START < CHANNEL_CONTENT.CONTENT_END
                    and USER_SESSION.SESSION_END >= CHANNEL_CONTENT.CONTENT_END));
