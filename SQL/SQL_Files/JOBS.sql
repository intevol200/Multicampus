--------------------------------------------------------
--  DDL for Table JOBS
--------------------------------------------------------

  CREATE TABLE "TEST"."JOBS" 
   (	"JOB_ID" VARCHAR2(10 BYTE), 
	"JOB_TITLE" VARCHAR2(35 BYTE), 
	"MIN_SALARY" NUMBER(6,0), 
	"MAX_SALARY" NUMBER(6,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TBS1" ;
REM INSERTING into TEST.JOBS
SET DEFINE OFF;
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_PRES','President',20080,40000);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_VP','Administration Vice President',15000,30000);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AD_ASST','Administration Assistant',3000,6000);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AC_MGR','Accounting Manager',8200,16000);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('AC_ACCOUNT','Public Accountant',4200,9000);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SA_MAN','Sales Manager',10000,20080);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('SA_REP','Sales Representative',6000,12008);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_MAN','Stock Manager',5500,8500);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('ST_CLERK','Stock Clerk',2008,5000);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('IT_PROG','Programmer',4000,10000);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_MAN','Marketing Manager',9000,15000);
Insert into TEST.JOBS (JOB_ID,JOB_TITLE,MIN_SALARY,MAX_SALARY) values ('MK_REP','Marketing Representative',4000,9000);
--------------------------------------------------------
--  DDL for Index JOBS_IX01
--------------------------------------------------------

  CREATE UNIQUE INDEX "TEST"."JOBS_IX01" ON "TEST"."JOBS" ("JOB_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TBS1" ;
--------------------------------------------------------
--  Constraints for Table JOBS
--------------------------------------------------------

  ALTER TABLE "TEST"."JOBS" ADD CONSTRAINT "JOBS_PK_JOBID" PRIMARY KEY ("JOB_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 65536 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "TBS1"  ENABLE;