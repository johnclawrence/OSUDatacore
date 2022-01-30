*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2005/Data/NIS_2005   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

***********************************************************;
*                                                          ;
*  LOADWT.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT    ;
*                 THE ASCII NIS, RELEASE 4, HOSPITAL       ;
*                 WEIGHTS FILE TO SAS.                     ;
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
  INVALUE NUM4F
    '-999' = .
    '-888' = .A
    '-777' = .B
    '-666' = .C
    OTHER = (|4.|)
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
  INVALUE NUM7F
    '-999999' = .
    '-888888' = .A
    '-777777' = .B
    '-666666' = .C
    OTHER = (|7.|)
  ;
  INVALUE NUM8F
    '-9999999' = .
    '-8888888' = .A
    '-7777777' = .B
    '-6666666' = .C
    OTHER = (|8.|)
  ;
  INVALUE NUM104F
    '-9999.9999' = .
    '-8888.8888' = .A
    '-7777.7777' = .B
    '-6666.6666' = .C
    OTHER = (|10.4|)
  ;
  RUN;



***********************************************;
*  Data step                                   ;
***********************************************;

DATA NIS_1995_WT ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/NIS95WT.ASC" LRECL=251;

  *** Declare the variables ***;
  LENGTH
      AHAID     $7
      DISCWT_F  8
      DISCWT_S  8
      DISCWT_U  8
      HOSPADDR  $30
      HOSPCITY  $20
      HOSPID    4
      HOSPNAME  $30
      HOSPST    $2
      HOSPWT_F  8
      HOSPWT_S  8
      HOSPWT_U  8
      HOSPZIP   $5
      H_BEDSZ   3
      H_CONTRL  3
      H_LOC     3
      H_LOCTCH  3
      H_REGION  3
      H_TCH     3
      IDNUMBER  $6
      N_DISC_F  8
      N_DISC_S  8
      N_DISC_U  8
      N_HOSP_F  8
      N_HOSP_S  8
      N_HOSP_U  8
      STRATUM   8
      STRAT_ST  8
      S_DISC_S  8
      S_DISC_U  8
      S_HOSP_S  8
      S_HOSP_U  8
      TOTDSCHG  8
      YEAR      3
  ;


  *** Labels for the variables in the Weights File ***;
  LABEL
      AHAID   ='H:AHA ID number with the leading 6'
      DISCWT_F='H:Weight to dschgs in the frame states'
      DISCWT_S='H:Weight to discharges in state'
      DISCWT_U='H:Weight to discharges in universe'
      HOSPADDR='H:Hospital address from AHA Survey'
      HOSPCITY='H:Hospital city from AHA Survey'
      HOSPID  ='HCUP-3 hospital ID number (SSHHH)'
      HOSPNAME='H:Hospital name from AHA Survey'
      HOSPST  ='Hospital state postal code'
      HOSPWT_F='H:Weight to hosps in the frame states'
      HOSPWT_S='H:Weight to hosps in the state'
      HOSPWT_U='H:Weight to hosps in the universe'
      HOSPZIP ='H:Hospital zip code from AHA Survey'
      H_BEDSZ ='H:Bedsize of hospital'
      H_CONTRL='H:Control/ownership of hospital'
      H_LOC   ='H:Location (urban/rural) of hospital'
      H_LOCTCH='H:Location/teaching status of hospital'
      H_REGION='H:Region of hospital'
      H_TCH   ='H:Teaching status of hospital'
      IDNUMBER='H:AHA ID number (no leading 6)'
      N_DISC_F='H:Num. frame state dischgs in STRATUM'
      N_DISC_S='H:Num. state''s discharges in STRAT_ST'
      N_DISC_U='H:Num. universe discharges in STRATUM'
      N_HOSP_F='H:Num. frame state hospitals in STRATUM'
      N_HOSP_S='H:Num. state''s hospitals in STRAT_ST'
      N_HOSP_U='H:Num. universe hospitals in STRATUM'
      STRATUM ='H:Stratum used to post-stratify hospital'
      STRAT_ST='H:Stratum for state-specific weights'
      S_DISC_S='H:Num. sample discharges in STRAT_ST'
      S_DISC_U='H:Num. sample discharges in STRATUM'
      S_HOSP_S='H:Num. sample hospitals in STRAT_ST'
      S_HOSP_U='H:Num. sample hospitals in STRATUM'
      TOTDSCHG='H:Total hospital discharges'
      YEAR    ='Calendar Year'
  ;


  *** Input the variables from the ASCII file ***;
  INPUT @1    AHAID     $CHAR7.
      @8      DISCWT_F  NUM104F.
      @18     DISCWT_S  NUM104F.
      @28     DISCWT_U  NUM104F.
      @38     HOSPADDR  $CHAR30.
      @68     HOSPCITY  $CHAR20.
      @88     HOSPID    5.
      @93     HOSPNAME  $CHAR30.
      @123    HOSPST    $CHAR2.
      @125    HOSPWT_F  NUM104F.
      @135    HOSPWT_S  NUM104F.
      @145    HOSPWT_U  NUM104F.
      @155    HOSPZIP   $CHAR5.
      @160    H_BEDSZ   NUM2F.
      @162    H_CONTRL  NUM2F.
      @164    H_LOC     NUM2F.
      @166    H_LOCTCH  NUM2F.
      @168    H_REGION  NUM2F.
      @170    H_TCH     NUM2F.
      @172    IDNUMBER  $CHAR6.
      @178    N_DISC_F  NUM8F.
      @186    N_DISC_S  NUM8F.
      @194    N_DISC_U  NUM8F.
      @202    N_HOSP_F  NUM4F.
      @206    N_HOSP_S  NUM4F.
      @210    N_HOSP_U  NUM4F.
      @214    STRATUM   NUM5F.
      @219    STRAT_ST  NUM5F.
      @224    S_DISC_S  NUM7F.
      @231    S_DISC_U  NUM7F.
      @238    S_HOSP_S  NUM3F.
      @241    S_HOSP_U  NUM3F.
      @244    TOTDSCHG  NUM6F.
      @250    YEAR      NUM2F.
  ;


  *** Create format for the numeric ID ***;
  FORMAT HOSPID Z5.;


RUN;
***********************************************************;
*                                                          ;
*  LOAD_A.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT    ;
*                 THE ASCII NIS, RELEASE 4, INPATIENT      ;
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
DATA NIS_1995_A ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/NIS95_A.ASC" LRECL=95;

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
*                 THE ASCII NIS, RELEASE 4, INPATIENT      ;
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
DATA NIS_1995_B ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/NIS95_B.ASC" LRECL=91;

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
*                 THE ASCII NIS, RELEASE 4, INPATIENT      ;
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
DATA NIS_1995_C ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/NIS95_C.ASC" LRECL=65;

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
       SEQ_SID  7
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
      SEQ_SID ='I:HCUP-3 SID record sequence number'
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
      @53     SEQ_SID   13.
  ;

  *** Create format for the numeric IDs ***;
  FORMAT HOSPSTCO  Z5.
         SEQ       Z13.
         SEQ_SID   Z13.
  ;


RUN;
***********************************************************;
*                                                          ;
*  LOAD_DX.ASC --- THE SAS CODE SHOWN BELOW WILL CONVERT   ;
*                  THE ASCII NIS, RELEASE 4, CORE FILE DX  ;
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
DATA NIS_1995_DX ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/NIS95_DX.ASC" LRECL=20;

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
*                  THE ASCII NIS, RELEASE 4, CORE FILE PR  ;
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
DATA NIS_1995_PR ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/NIS95_PR.ASC" LRECL=19;

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
*                   THE ASCII NIS, RELEASE 4, CASEMIX COUNTS ;
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
DATA NIS_1995_CMDCCHPR1 ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/N95_HDC1.ASC" LRECL=46;

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


  *** Labels for the variables in the Casemix Counts File (by hospital DCCHPR1)
***;
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
*                   THE ASCII NIS, RELEASE 4, CASEMIX COUNTS ;
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
DATA NIS_1995_CMDRG ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/N95_HDRG.ASC" LRECL=46;

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

  *** Labels for the variables in the Casemix Counts File (by hospital DRG10)
***;
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
*                   THE ASCII NIS, RELEASE 4, CASEMIX COUNTS ;
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
DATA NIS_1995_CMPCCHPR1 ;
  INFILE "%trim(&filepath)NIS/NIS_1995/Data/N95_HPC1.ASC" LRECL=46;

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


  *** Labels for the variables in the Casemix Counts File (by hospital PCCHPR1)
***;
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




proc SQL;
create table isilon.NIS_1995_C
like work.NIS_1995_C;

proc SQL;
insert into isilon.NIS_1995_C
select * from work.NIS_1995_C;

proc SQL;
create table isilon.NIS_1995_B
like work.NIS_1995_B;

proc SQL;
insert into isilon.NIS_1995_B
select * from work.NIS_1995_B;

proc SQL;
create table isilon.NIS_1995_A
like work.NIS_1995_A;

proc SQL;
insert into isilon.NIS_1995_A
select * from work.NIS_1995_A;

proc SQL;
create table isilon.NIS_1995_PR
like work.NIS_1995_PR;

proc SQL;
insert into isilon.NIS_1995_PR
select * from work.NIS_1995_PR;

proc SQL;
create table isilon.NIS_1995_DX
like work.NIS_1995_DX;

proc SQL;
insert into isilon.NIS_1995_DX
select * from work.NIS_1995_DX;

proc SQL;
create table isilon.NIS_1995_WT
like work.NIS_1995_WT;

proc SQL;
insert into isilon.NIS_1995_WT
select * from work.NIS_1995_WT;

proc SQL;
create table isilon.NIS_1995_CMDRG
like work.NIS_1995_CMDRG;

proc SQL;
insert into isilon.NIS_1995_CMDRG
select * from work.NIS_1995_CMDRG;

proc SQL;
create table isilon.NIS_1995_CMDCCHPR1
like work.NIS_1995_CMDCCHPR1;

proc SQL;
insert into isilon.NIS_1995_CMDCCHPR1
select * from work.NIS_1995_CMDCCHPR1;

proc SQL;
create table isilon.NIS_1995_CMPCCHPR1
like work.NIS_1995_CMPCCHPR1;

proc SQL;
insert into isilon.NIS_1995_CMPCCHPR1
select * from work.NIS_1995_CMPCCHPR1;




proc delete data= work.NIS_1995_A; run;
proc delete data= work.NIS_1995_B; run;
proc delete data= work.NIS_1995_C; run;
proc delete data= work.NIS_1995_DX; run;
proc delete data= work.NIS_1995_PR; run;
proc delete data= work.NIS_1995_WT; run;
proc delete data= work.NIS_1995_CMPCCHPR1; run;
proc delete data= work.NIS_1995_CMDCCHPR1; run;
proc delete data= work.NIS_1995_CMDRG; run;