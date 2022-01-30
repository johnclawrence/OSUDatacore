*Developer: John Lawrence*
*Date: 12/19/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2005/Data/NIS_2005   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

***********************************************************;
*                                                          ;
*  LOAD_A.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT    ;
*                 THE ASCII NIS, RELEASE 2, INPATIENT      ;
*                 STAY CORE FILE A TO SAS.                 ;
*                                                          ;
***********************************************************;



***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE NUM2F
    '-9' = .
    '-8' = .A
    '-7' = .B
    '-6' = .C
    OTHER = (|2.|)
  ;
  INVALUE NUM3F
    '-99' = .
    '-88' = .A
    '-77' = .B
    '-66' = .C
    OTHER = (|3.|)
  ;
  INVALUE NUM5F
    '-9999' = .
    '-8888' = .A
    '-7777' = .B
    '-6666' = .C
    OTHER = (|5.|)
  ;
  INVALUE NUM8P4F
    '-99.9999' = .
    '-88.8888' = .A
    '-77.7777' = .B
    '-66.6666' = .C
    OTHER = (|8.4|)
  ;
  INVALUE NUM10F
    '-999999999' = .
    '-888888888' = .A
    '-777777777' = .B
    '-666666666' = .C
    OTHER = (|10.|)
  ;
  INVALUE NUM152F
    '-99999999999.99' = .
    '-88888888888.88' = .A
    '-77777777777.77' = .B
    '-66666666666.66' = .C
    OTHER = (|15.2|)
  ;
  RUN;



***********************************************;
*  Data step                                   ;
***********************************************;
DATA NIS_1993_A ;
  INFILE "%trim(&filepath)NIS/NIS_1993/Data/NIS93_A.ASC" LRECL=95;

  *** Declare the variables ***;
  LENGTH
       AGE      3
       AGEDAY   3
       DCCHPR1  3
       DIED     3
       DISP     3
       DQTR     3
       DRG      3
       DRG10    3
       DRGVER   3
       DX1      $5
       DXV1     3
       HOSPID   4
       LOS      4
       MDC      3
       MDC10    3
       NDX      3
       NPR      3
       PAY1     3
       PCCHPR1  3
       PR1      $4
       PRV1     3
       RACE     3
       SEQ      7
       SEX      3
       TOTCHG   6
       ZIPINC4  3
       DISCWT_U 8
  ;



  *** Labels for the variables in File A ***;
  LABEL
      AGE     ='I:Age in years at admission'
      AGEDAY  ='I:Age in days (when < 1 year)'
      DCCHPR1 ='I:CCHPR: principal diagnosis'
      DIED    ='I:Died during hospitalization'
      DISP    ='I:Disposition of patient'
      DQTR    ='I:Discharge quarter'
      DRG     ='I:DRG in effect on discharge date'
      DRG10   ='I:DRG, Version 10'
      DRGVER  ='I:DRG grouper version used on disch date'
      DX1     ='I:Principal diagnosis'
      DXV1    ='I:Validity flag: principal diagnosis'
      HOSPID  ='HCUP-3 hospital ID number (SSHHH)'
      LOS     ='I:Length of stay (cleaned)'
      MDC     ='I:MDC in effect on discharge date'
      MDC10   ='I:MDC, Version 10'
      NDX     ='I:Number of diagnoses on this discharge'
      NPR     ='I:Number of procedures on this discharge'
      PAY1    ='I:Primary expected payer, uniform'
      PCCHPR1 ='I:CCHPR: principal procedure'
      PR1     ='I:Principal procedure'
      PRV1    ='I:Validity flag: principal procedure'
      RACE    ='I:Race'
      SEQ     ='I:HCUP-3 record sequence number'
      SEX     ='I:Sex'
      TOTCHG  ='I:Total charges (cleaned)'
      ZIPINC4 ='I:Median income-pt''s zip code-4 categs'
      DISCWT_U = 'H:Weight to discharges in universe'
  ;


  *** Input the variables from the ASCII file ***;
  INPUT @1    AGE       NUM3F.
      @4      AGEDAY    NUM3F.
      @7      DCCHPR1   NUM3F.
      @10     DIED      NUM2F.
      @12     DISCWT_U  NUM8P4F.
      @20     DISP      NUM2F.
      @22     DQTR      1.
      @23     DRG       NUM3F.
      @26     DRG10     NUM3F.
      @29     DRGVER    NUM2F.
      @31     DX1       $CHAR5.
      @36     DXV1      NUM2F.
      @38     HOSPID    5.
      @43     LOS       NUM5F.
      @48     MDC       NUM2F.
      @50     MDC10     NUM2F.
      @52     NDX       NUM2F.
      @54     NPR       NUM2F.
      @56     PAY1      NUM2F.
      @58     PCCHPR1   NUM3F.
      @61     PR1       $CHAR4.
      @65     PRV1      NUM2F.
      @67     RACE      NUM2F.
      @69     SEQ       13.
      @82     SEX       NUM2F.
      @84     TOTCHG    NUM10F.
      @94     ZIPINC4   NUM2F.
  ;

  *** Create format for the numeric IDs ***;
  FORMAT HOSPID   Z5.
         SEQ      Z13.
  ;


RUN;
***********************************************************;
*                                                          ;
*  LOAD_B.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT    ;
*                 THE ASCII NIS, RELEASE 2, INPATIENT      ;
*                 STAY CORE FILE B TO SAS.                 ;
*                                                          ;
***********************************************************;



***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE NUM2F
    '-9' = .
    '-8' = .A
    '-7' = .B
    '-6' = .C
    OTHER = (|2.|)
  ;
  INVALUE NUM5F
    '-9999' = .
    '-8888' = .A
    '-7777' = .B
    '-6666' = .C
    OTHER = (|5.|)
  ;
  INVALUE NUM6F
    '-99999' = .
    '-88888' = .A
    '-77777' = .B
    '-66666' = .C
    OTHER = (|6.|)
  ;
  INVALUE NUM152F
    '-99999999999.99' = .
    '-88888888888.88' = .A
    '-77777777777.77' = .B
    '-66666666666.66' = .C
    OTHER = (|15.2|)
  ;
  RUN;




***********************************************;
*  Data step                                   ;
***********************************************;
DATA NIS_1993_B ;
  INFILE "%trim(&filepath)NIS/NIS_1993/Data/NIS93_B.ASC" LRECL=91;

  *** Declare the variables ***;
  LENGTH
       ASOURCE  3
       ATYPE    3
       DSHOSPID $13
       LOS_X    4
       MDID_S   $16
       NEOMAT   3
       PRDAY1   4
       SEQ      7
       SURGID_S $16
       TOTCHG_X 7
       ZIPINC8  3
  ;


  *** Labels for the variables in File B ***;
  LABEL
      ASOURCE ='I:Admission source'
      ATYPE   ='I:Admission type'
      DSHOSPID='I:Data source hospital ID number'
      LOS_X   ='I:Length of stay (uncleaned)'
      MDID_S  ='I:Attending physician number (synthetic)'
      NEOMAT  ='I:Neonatal and/or maternal DX and/or PR'
      PRDAY1  ='I:No. of days from admission to PR1'
      SEQ     ='I:HCUP-3 record sequence number'
      SURGID_S='I:Primary surgeon number (synthetic)'
      TOTCHG_X='I:Total charges (from data source)'
      ZIPINC8 ='I:Median income-pt''s zip code-8 categs'
  ;


  *** Input the variables from the ASCII file ***;
  INPUT @1    ASOURCE   NUM2F.
      @3      ATYPE     NUM2F.
      @5      DSHOSPID  $CHAR13.
      @18     LOS_X     NUM6F.
      @24     MDID_S    $CHAR16.
      @40     NEOMAT    1.
      @41     PRDAY1    NUM5F.
      @46     SEQ       13.
      @59     SURGID_S  $CHAR16.
      @75     TOTCHG_X  NUM152F.
      @90     ZIPINC8   NUM2F.
  ;

  *** Create format for the numeric ID ***;
  FORMAT  SEQ   Z13.;


RUN;
***********************************************************;
*                                                          ;
*  LOAD_C.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT    ;
*                 THE ASCII NIS, RELEASE 2, INPATIENT      ;
*                 STAY CORE FILE C TO SAS.                 ;
*                                                          ;
***********************************************************;


***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE NUM2F
    '-9' = .
    '-8' = .A
    '-7' = .B
    '-6' = .C
    OTHER = (|2.|)
  ;
  INVALUE NUM5F
    '-9999' = .
    '-8888' = .A
    '-7777' = .B
    '-6666' = .C
    OTHER = (|5.|)
  ;
  INVALUE NUM11F
    '-9999999999' = .
    '-8888888888' = .A
    '-7777777777' = .B
    '-6666666666' = .C
    OTHER = (|11.|)
  ;
  RUN;



***********************************************;
*  Data step                                   ;
***********************************************;
DATA NIS_1993_C ;
  INFILE "%trim(&filepath)NIS/NIS_1993/Data/NIS93_C.ASC" LRECL=52;

  *** Declare the variables ***;
  LENGTH
       ADAYWK   3
       AMONTH   3
       DSNDX    3
       DSNPR    3
       DSNUM    3
       DSTYPE   3
       DXSYS    3
       HOSPST   $2
       HOSPSTCO 4
       PAY1_N   3
       PAY2     3
       PAY2_N   3
       PROCESS  6
       PRSYS    3
       SEQ      7
  ;


  *** Labels for the variables in File C ***;
  LABEL
      ADAYWK  ='I:Admission day of week'
      AMONTH  ='I:Admission month'
      DSNDX   ='I:Max number of diagnoses from source'
      DSNPR   ='I:Max number of procedures from source'
      DSNUM   ='I:Data source ID number'
      DSTYPE  ='I:Data source type'
      DXSYS   ='I:Diagnosis coding system'
      HOSPST  ='Hospital state postal code'
      HOSPSTCO='Hospital state/county FIPS code'
      PAY1_N  ='I:Primary expected payer, nonuniform'
      PAY2    ='I:Secondary expected payer, uniform'
      PAY2_N  ='I:Secondary expected payer, nonuniform'
      PROCESS ='I:HCUP-3 discharge processing ID number'
      PRSYS   ='I:Procedure coding system'
      SEQ     ='I:HCUP-3 record sequence number'
  ;

  *** Input the variables from the ASCII file ***;
  INPUT @1    ADAYWK    NUM2F.
      @3      AMONTH    NUM2F.
      @5      DSNDX     NUM2F.
      @7      DSNPR     NUM2F.
      @9      DSNUM     NUM2F.
      @11     DSTYPE    1.
      @12     DXSYS     NUM2F.
      @14     HOSPST    $CHAR2.
      @16     HOSPSTCO  NUM5F.
      @21     PAY1_N    NUM2F.
      @23     PAY2      NUM2F.
      @25     PAY2_N    NUM2F.
      @27     PROCESS   NUM11F.
      @38     PRSYS     NUM2F.
      @40     SEQ       13.
  ;

  *** Create format for the numeric IDs ***;
  FORMAT HOSPSTCO  Z5.
         SEQ       Z13.
  ;


RUN;



***********************************************************;
*                                                          ;
*  LOAD_DX.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT   ;
*                  THE ASCII NIS, RELEASE 2, CORE FILE DX  ;
*                  (DIAGNOSES) TO SAS.                     ;
*                                                          ;
***********************************************************;


***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE NUM2F
    '-9' = .
    '-8' = .A
    '-7' = .B
    '-6' = .C
    OTHER = (|2.|)
  ;
  RUN;



***********************************************;
*  Data step                                   ;
***********************************************;
DATA NIS_1993_DX ;
  INFILE "%trim(&filepath)NIS/NIS_1993/Data/NIS93_DX.ASC" LRECL=20;

  *** Declare the variables ***;
  LENGTH
       DX       $5
       DXV      3
       SEQ      7
  ;


  *** Labels for the variables in File DX (diagnoses) ***;
  LABEL
      DX  ='I:Diagnosis'
      DXV ='I:Validity flag: diagnosis'
      SEQ ='I:HCUP-3 record sequence number'
  ;

  *** Input the variables from the ASCII file ***;
  INPUT @1      DX        $CHAR5.
        @6      DXV       NUM2F.
        @8      SEQ       13.
  ;

  *** Create format for the numeric ID ***;
  FORMAT SEQ  Z13. ;


RUN;
***********************************************************;
*                                                          ;
*  LOAD_PR.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT   ;
*                  THE ASCII NIS, RELEASE 2, CORE FILE PR  ;
*                  (PROCEDURES) TO SAS.                    ;
*                                                          ;
***********************************************************;


***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE NUM2F
    '-9' = .
    '-8' = .A
    '-7' = .B
    '-6' = .C
    OTHER = (|2.|)
  ;
  RUN;



***********************************************;
*  Data step                                   ;
***********************************************;
DATA NIS_1993_PR ;
  INFILE "%trim(&filepath)NIS/NIS_1993/Data/NIS93_PR.ASC" LRECL=19;

  *** Declare the variables ***;
  LENGTH
       PR       $4
       PRV      3
       SEQ      7
  ;

  *** Labels for the variables in File pr (procedures) ***;
  LABEL
      PR  ='I:Procedure'
      PRV ='I:Validity flag: procedure'
      SEQ ='I:HCUP-3 record sequence number'
  ;

  *** Input the variables from the ASCII file ***;
  INPUT @1      PR        $CHAR4.
        @5      PRV       NUM2F.
        @7      SEQ       13.
  ;

  *** Create format for the numeric ID ***;
  FORMAT SEQ Z13. ;


RUN;
*************************************************************;
*                                                            ;
*  LOADCMDC.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT    ;
*                   THE ASCII NIS, RELEASE 2, CASEMIX COUNTS ;
*                   FILE (HOSPITAL-LEVEL COUNTS, BY DCCHPR1, ;
*                   THE PRINCIPAL DIAGNOSIS) TO SAS.         ;
*                                                            ;
*************************************************************;


***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE NUM3F
    '-99' = .
    '-88' = .A
    '-77' = .B
    '-66' = .C
    OTHER = (|3.|)
  ;
  INVALUE NUM5F
    '-9999' = .
    '-8888' = .A
    '-7777' = .B
    '-6666' = .C
    OTHER = (|5.|)
  ;
  INVALUE NUM6F
    '-99999' = .
    '-88888' = .A
    '-77777' = .B
    '-66666' = .C
    OTHER = (|6.|)
  ;
  INVALUE NUM8P4F
    '-99.9999' = .
    '-88.8888' = .A
    '-77.7777' = .B
    '-66.6666' = .C
    OTHER = (|8.4|)
  ;
  INVALUE NUM9F
    '-99999999' = .
    '-88888888' = .A
    '-77777777' = .B
    '-66666666' = .C
    OTHER = (|9.|)
  ;
  RUN;



***********************************************;
*  Data step                                   ;
***********************************************;
DATA NIS_1993_CMDCCHPR1 ;
  INFILE "%trim(&filepath)NIS/NIS_1993/Data/N93_HDC1.ASC" LRECL=46;

  *** Declare the variables ***;
  LENGTH
       DCCHPR1  3
       DISCWT_U 8
       HOSPID   4
       N_LOS    8
       N_TOTAL  8
       N_TOTCHG 8
       SUMCHG   8
       SUMLOS   8
  ;


  *** Labels for the variables in the Casemix Counts File (by hospital DCCHPR1) ***;
  LABEL
    DCCHPR1  = 'I:CCHPR: principal diagnosis'
    DISCWT_U = 'H:Weight to discharges in universe'
    HOSPID   = 'HCUP-3 hospital ID number (SSHHH)'
    N_LOS    = 'I:Discharges reporting cleaned LOS'
    N_TOTAL  = 'I:Total number of discharges'
    N_TOTCHG = 'I:Discharges reporting cleaned TOTCHG'
    SUMCHG   = 'I:Sum of cleaned TOTCHG'
    SUMLOS   = 'I:Sum of cleaned LOS'
  ;

  *** Input the variables from the ASCII file ***;
  INPUT @1    DCCHPR1   NUM3F.
      @4      DISCWT_U  NUM8P4F.
      @12     HOSPID    5.
      @17     N_LOS     NUM5F.
      @22     N_TOTAL   NUM5F.
      @27     N_TOTCHG  NUM5F.
      @32     SUMCHG    NUM9F.
      @41     SUMLOS    NUM6F.
  ;


  *** Create format for the numeric ID ***;
  FORMAT HOSPID Z5. ;


RUN;
*************************************************************;
*                                                            ;
*  LOADCMDR.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT    ;
*                   THE ASCII NIS, RELEASE 2, CASEMIX COUNTS ;
*                   FILE (HOSPITAL-LEVEL COUNTS, BY DRG10)   ;
*                   TO SAS.                                  ;
*                                                            ;
*************************************************************;


***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE NUM3F
    '-99' = .
    '-88' = .A
    '-77' = .B
    '-66' = .C
    OTHER = (|3.|)
  ;
  INVALUE NUM5F
    '-9999' = .
    '-8888' = .A
    '-7777' = .B
    '-6666' = .C
    OTHER = (|5.|)
  ;
  INVALUE NUM6F
    '-99999' = .
    '-88888' = .A
    '-77777' = .B
    '-66666' = .C
    OTHER = (|6.|)
  ;
  INVALUE NUM8P4F
    '-99.9999' = .
    '-88.8888' = .A
    '-77.7777' = .B
    '-66.6666' = .C
    OTHER = (|8.4|)
  ;
  INVALUE NUM9F
    '-99999999' = .
    '-88888888' = .A
    '-77777777' = .B
    '-66666666' = .C
    OTHER = (|9.|)
  ;
  RUN;



***********************************************;
*  Data step                                   ;
***********************************************;
DATA NIS_1993_CMDRG ;

  INFILE "%trim(&filepath)NIS/NIS_1993/Data/N93_HDRG.ASC" LRECL=46;

  *** Declare the variables ***;
  LENGTH
       DISCWT_U 8
       DRG10    3
       HOSPID   4
       N_LOS    8
       N_TOTAL  8
       N_TOTCHG 8
       SUMCHG   8
       SUMLOS   8
  ;

  *** Labels for the variables in the Casemix Counts File (by hospital DRG10) ***;
  LABEL
    DISCWT_U = 'H:Weight to discharges in universe'
    DRG10    = 'I:DRG, Version 10'
    HOSPID   = 'HCUP-3 hospital ID number (SSHHH)'
    N_LOS    = 'I:Discharges reporting cleaned LOS'
    N_TOTAL  = 'I:Total number of discharges'
    N_TOTCHG = 'I:Discharges reporting cleaned TOTCHG'
    SUMCHG   = 'I:Sum of cleaned TOTCHG'
    SUMLOS   = 'I:Sum of cleaned LOS'
  ;

  *** Input the variables from the ASCII file ***;
  INPUT
      @1      DISCWT_U  NUM8P4F.
      @9      DRG10     NUM3F.
      @12     HOSPID    5.
      @17     N_LOS     NUM5F.
      @22     N_TOTAL   NUM5F.
      @27     N_TOTCHG  NUM5F.
      @32     SUMCHG    NUM9F.
      @41     SUMLOS    NUM6F.
  ;

  *** Create format for the numeric ID ***;
  FORMAT HOSPID Z5. ;


RUN;
*************************************************************;
*                                                            ;
*  LOADCMPC.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT    ;
*                   THE ASCII NIS, RELEASE 2, CASEMIX COUNTS ;
*                   FILE (HOSPITAL-LEVEL COUNTS, BY PCCHPR1, ;
*                   THE PRINCIPAL PROCEDURE) TO SAS.         ;
*                                                            ;
*************************************************************;



***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE NUM3F
    '-99' = .
    '-88' = .A
    '-77' = .B
    '-66' = .C
    OTHER = (|3.|)
  ;
  INVALUE NUM5F
    '-9999' = .
    '-8888' = .A
    '-7777' = .B
    '-6666' = .C
    OTHER = (|5.|)
  ;
  INVALUE NUM6F
    '-99999' = .
    '-88888' = .A
    '-77777' = .B
    '-66666' = .C
    OTHER = (|6.|)
  ;
  INVALUE NUM8P4F
    '-99.9999' = .
    '-88.8888' = .A
    '-77.7777' = .B
    '-66.6666' = .C
    OTHER = (|8.4|)
  ;
  INVALUE NUM9F
    '-99999999' = .
    '-88888888' = .A
    '-77777777' = .B
    '-66666666' = .C
    OTHER = (|9.|)
  ;
  RUN;



***********************************************;
*  Data step                                   ;
***********************************************;
DATA NIS_1993_CMPCCHPR1 ;
  INFILE "%trim(&filepath)NIS/NIS_1993/Data/N93_HPC1.ASC" LRECL=46;

  *** Declare the variables ***;
  LENGTH
       DISCWT_U 8
       HOSPID   4
       N_LOS    8
       N_TOTAL  8
       N_TOTCHG 8
       PCCHPR1  3
       SUMCHG   8
       SUMLOS   8
  ;


  *** Labels for the variables in the Casemix Counts File (by hospital PCCHPR1) ***;
  LABEL
    PCCHPR1  = 'I:CCHPR: principal procedure'
    DISCWT_U = 'H:Weight to discharges in universe'
    HOSPID   = 'HCUP-3 hospital ID number (SSHHH)'
    N_LOS    = 'I:Discharges reporting cleaned LOS'
    N_TOTAL  = 'I:Total number of discharges'
    N_TOTCHG = 'I:Discharges reporting cleaned TOTCHG'
    SUMCHG   = 'I:Sum of cleaned TOTCHG'
    SUMLOS   = 'I:Sum of cleaned LOS'
  ;

  *** Input the variables from the ASCII file ***;
  INPUT
      @1      DISCWT_U  NUM8P4F.
      @9      HOSPID    5.
      @14     N_LOS     NUM5F.
      @19     N_TOTAL   NUM5F.
      @24     N_TOTCHG  NUM5F.
      @29     PCCHPR1   NUM3F.
      @32     SUMCHG    NUM9F.
      @41     SUMLOS    NUM6F.
  ;


  *** Create format for the numeric ID ***;
  FORMAT HOSPID Z5. ;


RUN;
/*******************************************************************
*   LOADWT.ASC:                                        
*      THE SAS CODE SHOWN BELOW WILL LOAD THE UPDATED ASCII NIS,             
*      RELEASE 2, HOSPITAL WEIGHTS FILE INTO SAS                         
*******************************************************************/


***********************************************;
*  Create SAS informats for missing values     ;
***********************************************;
PROC FORMAT;
  INVALUE N2PF
    '-9' = .
    '-8' = .A
    '-6' = .C
    '-5' = .N
    OTHER = (|2.|)
  ;
  INVALUE N3PF
    '-99' = .
    '-88' = .A
    '-66' = .C
    OTHER = (|3.|)
  ;
  INVALUE N4PF
    '-999' = .
    '-888' = .A
    '-666' = .C
    OTHER = (|4.|)
  ;
  INVALUE N5PF
    '-9999' = .
    '-8888' = .A
    '-6666' = .C
    OTHER = (|5.|)
  ;
  INVALUE N5P2F
    '-9.99' = .
    '-8.88' = .A
    '-6.66' = .C
    OTHER = (|5.2|)
  ;
  INVALUE N6PF
    '-99999' = .
    '-88888' = .A
    '-66666' = .C
    OTHER = (|6.|)
  ;
  INVALUE N6P2F
    '-99.99' = .
    '-88.88' = .A
    '-66.66' = .C
    OTHER = (|6.2|)
  ;
  INVALUE N7P2F
    '-999.99' = .
    '-888.88' = .A
    '-666.66' = .C
    OTHER = (|7.2|)
  ;
  INVALUE N8PF
    '-9999999' = .
    '-8888888' = .A
    '-6666666' = .C
    OTHER = (|8.|)
  ;
  INVALUE N8P2F
    '-9999.99' = .
    '-8888.88' = .A
    '-6666.66' = .C
    OTHER = (|8.2|)
  ;
  INVALUE N8P4F
    '-99.9999' = .
    '-88.8888' = .A
    '-66.6666' = .C
    OTHER = (|8.4|)
  ;
  INVALUE N10PF
    '-999999999' = .
    '-888888888' = .A
    '-666666666' = .C
    OTHER = (|10.|)
  ;
  INVALUE N10P4F
    '-9999.9999' = .
    '-8888.8888' = .A
    '-6666.6666' = .C
    OTHER = (|10.4|)
  ;
  INVALUE N10P5F
    '-999.99999' = .
    '-888.88888' = .A
    '-666.66666' = .C
    OTHER = (|10.5|)
  ;
  INVALUE DATE10F
    '-999999999' = .
    '-888888888' = .A
    '-666666666' = .C
    OTHER = (|MMDDYY10.|)
  ;
  INVALUE N11P7F
    '-99.9999999' = .
    '-88.8888888' = .A
    '-66.6666666' = .C
    OTHER = (|11.7|)
  ;
  INVALUE N12P2F
    '-99999999.99' = .
    '-88888888.88' = .A
    '-66666666.66' = .C
    OTHER = (|12.2|)
  ;
  INVALUE N12P5F
    '-99999.99999' = .
    '-88888.88888' = .A
    '-66666.66666' = .C
    OTHER = (|12.5|)
  ;
  INVALUE N15P2F
    '-99999999999.99' = .
    '-88888888888.88' = .A
    '-66666666666.66' = .C
    OTHER = (|15.2|)
  ;
  RUN;


*******************************;
*  Data Step                  *;
*******************************;
DATA NIS_1993_WT; 
INFILE "%trim(&filepath)NIS/NIS_1993/Data/NIS93WT.ASC" LRECL = 257;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  AHAID                      LENGTH=$7
  LABEL="H:AHA ID number with the leading 6"

  DISCWT_F                   LENGTH=8
  LABEL="H:Weight to dschgs in the frame states"

  DISCWT_S                   LENGTH=8
  LABEL="H:Weight to discharges in state"

  DISCWT_U                   LENGTH=8
  LABEL="H:Weight to discharges in universe"

  HOSPADDR                   LENGTH=$30
  LABEL="H:Hospital address from AHA Survey"

  HOSPCITY                   LENGTH=$20
  LABEL="H:Hospital city from AHA Survey"

  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP-3 hospital ID number (SSHHH)"

  HOSPNAME                   LENGTH=$30
  LABEL="H:Hospital name from AHA Survey"

  HOSPST                     LENGTH=$2
  LABEL="Hospital state postal code"

  HOSPWT_F                   LENGTH=8
  LABEL="H:Weight to hosps in the frame states"

  HOSPWT_S                   LENGTH=8
  LABEL="H:Weight to hosps in the state"

  HOSPWT_U                   LENGTH=8
  LABEL="H:Weight to hosps in the universe"

  HOSPZIP                    LENGTH=$5
  LABEL="H:Hospital zip code from AHA Survey"

  H_BEDSZ                    LENGTH=3
  LABEL="H:Bedsize of hospital"

  H_CONTRL                   LENGTH=3
  LABEL="H:Control/ownership of hospital"

  H_LOC                      LENGTH=3
  LABEL="H:Location (urban/rural) of hospital"

  H_LOCTCH                   LENGTH=3
  LABEL="H:Location/teaching status of hospital"

  H_REGION                   LENGTH=3
  LABEL="H:Region of hospital"

  H_TCH                      LENGTH=3
  LABEL="H:Teaching status of hospital"

  IDNUMBER                   LENGTH=$6
  LABEL="H:AHA ID number (no leading 6)"

  N_DISC_F                   LENGTH=8
  LABEL="H:Num. frame state dischgs in STRATUM"

  N_DISC_S                   LENGTH=8
  LABEL="H:Num. state's discharges in STRAT_ST"

  N_DISC_U                   LENGTH=8
  LABEL="H:Num. universe discharges in STRATUM"

  N_HOSP_F                   LENGTH=8
  LABEL="H:Num. frame state hospitals in STRATUM"

  N_HOSP_S                   LENGTH=8
  LABEL="H:Num. state's hospitals in STRAT_ST"

  N_HOSP_U                   LENGTH=8
  LABEL="H:Num. universe hospitals in STRATUM"

  STRATUM                    LENGTH=8
  LABEL="H:Stratum used to post-stratify hospital"

  STRAT_ST                   LENGTH=8
  LABEL="H:Stratum for state-specific weights"

  S_DISC_S                   LENGTH=8
  LABEL="H:Num. sample discharges in STRAT_ST"

  S_DISC_U                   LENGTH=8
  LABEL="H:Num. sample discharges in STRATUM"

  S_HOSP_S                   LENGTH=8
  LABEL="H:Num. sample hospitals in STRAT_ST"

  S_HOSP_U                   LENGTH=8
  LABEL="H:Num. sample hospitals in STRATUM"

  TOTDSCHG                   LENGTH=8
  LABEL="H:Total hospital discharges"

  YEAR                       LENGTH=3
  LABEL="Calendar year"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      AHAID                    $CHAR7.
      @8      DISCWT_F                 N11P7F.
      @19     DISCWT_S                 N11P7F.
      @30     DISCWT_U                 N11P7F.
      @41     HOSPADDR                 $CHAR30.
      @71     HOSPCITY                 $CHAR20.
      @91     HOSPID                   5.
      @96     HOSPNAME                 $CHAR30.
      @126    HOSPST                   $CHAR2.
      @128    HOSPWT_F                 N11P7F.
      @139    HOSPWT_S                 N11P7F.
      @150    HOSPWT_U                 N11P7F.
      @161    HOSPZIP                  $CHAR5.
      @166    H_BEDSZ                  N2PF.
      @168    H_CONTRL                 N2PF.
      @170    H_LOC                    N2PF.
      @172    H_LOCTCH                 N2PF.
      @174    H_REGION                 N2PF.
      @176    H_TCH                    N2PF.
      @178    IDNUMBER                 $CHAR6.
      @184    N_DISC_F                 N8PF.
      @192    N_DISC_S                 N8PF.
      @200    N_DISC_U                 N8PF.
      @208    N_HOSP_F                 N4PF.
      @212    N_HOSP_S                 N4PF.
      @216    N_HOSP_U                 N4PF.
      @220    STRATUM                  N4PF.
      @224    STRAT_ST                 N4PF.
      @228    S_DISC_S                 N6PF.
      @234    S_DISC_U                 N6PF.
      @240    S_HOSP_S                 N4PF.
      @244    S_HOSP_U                 N4PF.
      @248    TOTDSCHG                 N6PF.
      @254    YEAR                     N4PF.
      ;


RUN;



proc SQL;
create table isilon.NIS_1993_C
like work.NIS_1993_C;

proc SQL;
insert into isilon.NIS_1993_C
select * from work.NIS_1993_C;

proc SQL;
create table isilon.NIS_1993_B
like work.NIS_1993_B;

proc SQL;
insert into isilon.NIS_1993_B
select * from work.NIS_1993_B;

proc SQL;
create table isilon.NIS_1993_A
like work.NIS_1993_A;

proc SQL;
insert into isilon.NIS_1993_A
select * from work.NIS_1993_A;

proc SQL;
create table isilon.NIS_1993_PR
like work.NIS_1993_PR;

proc SQL;
insert into isilon.NIS_1993_PR
select * from work.NIS_1993_PR;

proc SQL;
create table isilon.NIS_1993_DX
like work.NIS_1993_DX;

proc SQL;
insert into isilon.NIS_1993_DX
select * from work.NIS_1993_DX;

proc SQL;
create table isilon.NIS_1993_WT
like work.NIS_1993_WT;

proc SQL;
insert into isilon.NIS_1993_WT
select * from work.NIS_1993_WT;

proc SQL;
create table isilon.NIS_1993_CMDRG
like work.NIS_1993_CMDRG;

proc SQL;
insert into isilon.NIS_1993_CMDRG
select * from work.NIS_1993_CMDRG;

proc SQL;
create table isilon.NIS_1993_CMDCCHPR1
like work.NIS_1993_CMDCCHPR1;

proc SQL;
insert into isilon.NIS_1993_CMDCCHPR1
select * from work.NIS_1993_CMDCCHPR1;

proc SQL;
create table isilon.NIS_1993_CMPCCHPR1
like work.NIS_1993_CMPCCHPR1;

proc SQL;
insert into isilon.NIS_1993_CMPCCHPR1
select * from work.NIS_1993_CMPCCHPR1;




proc delete data= work.NIS_1993_A; run;
proc delete data= work.NIS_1993_B; run;
proc delete data= work.NIS_1993_C; run;
proc delete data= work.NIS_1993_DX; run;
proc delete data= work.NIS_1993_PR; run;
proc delete data= work.NIS_1993_WT; run;
proc delete data= work.NIS_1993_CMPCCHPR1; run;
proc delete data= work.NIS_1993_CMDCCHPR1; run;
proc delete data= work.NIS_1993_CMDRG; run;