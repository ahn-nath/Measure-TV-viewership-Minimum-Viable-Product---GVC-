/*==============================================================*/
/* DBMS name:      ORACLE Version 11g                           */
/* Created on:     1/11/2021 7:18:59 PM                         */
/*==============================================================*/


alter table DIM_CONTENT
   drop constraint FK_DIM_CONT_PLAYING_DIM_CHAN;

alter table DIM_DEVICE
   drop constraint FK_DIM_DEVI_USAGE_DIM_DEVI;

alter table FACT_USER_SESSION
   drop constraint FK_FACT_USE_DEVICE_DIM_DEVI;

alter table FACT_USER_SESSION
   drop constraint FK_FACT_USE_WATCHING_DIM_CHAN;

  

drop index PLAYING_FK;

drop table DIM_CONTENT cascade constraints;

drop index USAGE_FK;

drop table DIM_DEVICE cascade constraints;

drop table DIM_DEVICEUSER cascade constraints;

drop index DEVICE_FK;

drop index WATCHING_FK;

drop table FACT_USER_SESSION cascade constraints;

/*==============================================================*/
/* Table: DIM_CHANNEL                                           */
/*==============================================================*/
create table DIM_CHANNEL 
(
   CHANNEL_ID           VARCHAR2(50)         not null,
   CHANNEL_NAME         VARCHAR2(100),
   ACTIVE               SMALLINT,
   constraint PK_DIM_CHANNEL primary key (CHANNEL_ID)
);

/*==============================================================*/
/* Table: DIM_CONTENT                                           */
/*==============================================================*/
create table DIM_CONTENT 
(
   CONTENT_ID           VARCHAR2(50)         not null,
   CHANNEL_ID           VARCHAR2(50),
   DURATION             INTEGER,
   CONTENT_END         DATE,
   CONTENT_START        DATE,
   CONTENT_TITLE        VARCHAR2(200),
   BCCATEGORY           VARCHAR2(50),
   BCID                 VARCHAR2(50),
   ADID                 VARCHAR2(50),
   constraint PK_DIM_CONTENT primary key (CONTENT_ID)
);

/*==============================================================*/
/* Index: PLAYING_FK                                            */
/*==============================================================*/
create index PLAYING_FK on DIM_CONTENT (
   CHANNEL_ID ASC
);

/*==============================================================*/
/* Table: DIM_DEVICE                                            */
/*==============================================================*/
create table DIM_DEVICE 
(
   DEVICE_ID            VARCHAR2(50)         not null,
   DEVICEUSER_ID        VARCHAR2(50),
   DEVICE_UUID          VARCHAR2(50),
   IP_ADDRESS           VARCHAR2(20),
   USER_AGENT           VARCHAR2(512),
   constraint PK_DIM_DEVICE primary key (DEVICE_ID)
);

/*==============================================================*/
/* Index: USAGE_FK                                     */
/*==============================================================*/
create index USAGE_FK on DIM_DEVICE (
   DEVICEUSER_ID ASC
);

/*==============================================================*/
/* Table: DIM_DEVICEUSER                                        */
/*==============================================================*/
create table DIM_DEVICEUSER 
(
   DEVICEUSER_ID        VARCHAR2(50)         not null,
   UAIPHASH             VARCHAR2(100),
   constraint PK_DIM_DEVICEUSER primary key (DEVICEUSER_ID)
);

/*==============================================================*/
/* Table: FACT_USER_SESSION                                     */
/*==============================================================*/
create table FACT_USER_SESSION 
(
   SESSION_ID           VARCHAR2(50)         not null,
   DEVICEUSER_ID        VARCHAR2(50),
   CHANNEL_ID           VARCHAR2(50),
   SESSION_START        DATE,
   SESSION_END          DATE,
   DURATION             INTEGER,
   constraint PK_FACT_USER_SESSION primary key (SESSION_ID)
);

/*==============================================================*/
/* Index: WATCHING_FK                                           */
/*==============================================================*/
create index WATCHING_FK on FACT_USER_SESSION (
   CHANNEL_ID ASC
);

/*==============================================================*/
/* Index: DEVICE_FK                                             */
/*==============================================================*/
create index DEVICE_FK on FACT_USER_SESSION (
   DEVICEUSER_ID ASC
);

alter table DIM_CONTENT
   add constraint FK_DIM_CONT_PLAYING_DIM_CHAN foreign key (CHANNEL_ID)
      references DIM_CHANNEL (CHANNEL_ID);

alter table DIM_DEVICE
   add constraint FK_DIM_DEVI_USAGE_DIM_DEVI foreign key (DEVICEUSER_ID)
      references DIM_DEVICEUSER (DEVICEUSER_ID);

alter table FACT_USER_SESSION
   add constraint FK_FACT_USE_DEVICE_DIM_DEVI foreign key (DEVICEUSER_ID)
      references DIM_DEVICEUSER (DEVICEUSER_ID);

alter table FACT_USER_SESSION
   add constraint FK_FACT_USE_WATCHING_DIM_CHAN foreign key (CHANNEL_ID)
      references DIM_CHANNEL (CHANNEL_ID);

