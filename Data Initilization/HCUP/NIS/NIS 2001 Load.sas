*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2001/Data/NIS_2001   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

                                                                           
/*******************************************************************
*   SASload_NIS_2001_CORE.SAS:                                
*      THE SAS CODE SHOWN BELOW WILL LOAD THE ASCII NIS             
*      INPATIENT STAY CORE FILE INTO SAS                          
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
  INVALUE DATE10F
    '-999999999' = .
    '-888888888' = .A
    '-666666666' = .C
    OTHER = (|MMDDYY10.|)
  ;
  INVALUE N12P2F
    '-99999999.99' = .
    '-88888888.88' = .A
    '-66666666.66' = .C
    OTHER = (|12.2|)
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
DATA NIS_2001_CORE; 
INFILE "%trim(&filepath)NIS/NIS_2001/Data/NIS_2001_CORE.ASC" LRECL = 483;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  KEY                LENGTH=8          FORMAT=Z14.
  LABEL="HCUP record identifier"

  AGE                LENGTH=3
  LABEL="Age in years at admission"

  AGEDAY             LENGTH=3
  LABEL="Age in days (when age < 1 year)"

  AMONTH             LENGTH=3
  LABEL="Admission month"

  ASOURCE            LENGTH=3
  LABEL="Admission source (uniform)"

  ASOURCE_X          LENGTH=$3
  LABEL="Admission source (as received from source)"

  ATYPE              LENGTH=3
  LABEL="Admission type"

  AWEEKEND           LENGTH=3
  LABEL="Admission day is a weekend"

  DIED               LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT             LENGTH=8
  LABEL="Weight to discharges in AHA universe"

  DISPUB92           LENGTH=3
  LABEL="Disposition of patient (UB-92 standard coding)"

  DISPUNIFORM        LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR               LENGTH=3
  LABEL="Discharge quarter"

  DRG                LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRG18              LENGTH=3
  LABEL="DRG, version 18"

  DRGVER             LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DSHOSPID           LENGTH=$13
  LABEL="Data source hospital identifier"

  DX1                LENGTH=$5
  LABEL="Principal diagnosis"

  DX2                LENGTH=$5
  LABEL="Diagnosis 2"

  DX3                LENGTH=$5
  LABEL="Diagnosis 3"

  DX4                LENGTH=$5
  LABEL="Diagnosis 4"

  DX5                LENGTH=$5
  LABEL="Diagnosis 5"

  DX6                LENGTH=$5
  LABEL="Diagnosis 6"

  DX7                LENGTH=$5
  LABEL="Diagnosis 7"

  DX8                LENGTH=$5
  LABEL="Diagnosis 8"

  DX9                LENGTH=$5
  LABEL="Diagnosis 9"

  DX10               LENGTH=$5
  LABEL="Diagnosis 10"

  DX11               LENGTH=$5
  LABEL="Diagnosis 11"

  DX12               LENGTH=$5
  LABEL="Diagnosis 12"

  DX13               LENGTH=$5
  LABEL="Diagnosis 13"

  DX14               LENGTH=$5
  LABEL="Diagnosis 14"

  DX15               LENGTH=$5
  LABEL="Diagnosis 15"

  DXCCS1             LENGTH=4
  LABEL="CCS: principal diagnosis"

  DXCCS2             LENGTH=4
  LABEL="CCS: diagnosis 2"

  DXCCS3             LENGTH=4
  LABEL="CCS: diagnosis 3"

  DXCCS4             LENGTH=4
  LABEL="CCS: diagnosis 4"

  DXCCS5             LENGTH=4
  LABEL="CCS: diagnosis 5"

  DXCCS6             LENGTH=4
  LABEL="CCS: diagnosis 6"

  DXCCS7             LENGTH=4
  LABEL="CCS: diagnosis 7"

  DXCCS8             LENGTH=4
  LABEL="CCS: diagnosis 8"

  DXCCS9             LENGTH=4
  LABEL="CCS: diagnosis 9"

  DXCCS10            LENGTH=4
  LABEL="CCS: diagnosis 10"

  DXCCS11            LENGTH=4
  LABEL="CCS: diagnosis 11"

  DXCCS12            LENGTH=4
  LABEL="CCS: diagnosis 12"

  DXCCS13            LENGTH=4
  LABEL="CCS: diagnosis 13"

  DXCCS14            LENGTH=4
  LABEL="CCS: diagnosis 14"

  DXCCS15            LENGTH=4
  LABEL="CCS: diagnosis 15"

  FEMALE             LENGTH=3
  LABEL="Indicator of sex"

  HOSPID             LENGTH=4          FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPST             LENGTH=$2
  LABEL="Hospital state postal code"

  HOSPSTCO           LENGTH=4          FORMAT=Z5.
  LABEL="Hospital modified FIPS state/county code"

  LOS                LENGTH=4
  LABEL="Length of stay (cleaned)"

  LOS_X              LENGTH=4
  LABEL="Length of stay (as received from source)"

  MDC                LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC18              LENGTH=3
  LABEL="MDC, version 18"

  MDNUM1_S           LENGTH=$16
  LABEL="Physician 1 number (synthetic)"

  MDNUM2_S           LENGTH=$16
  LABEL="Physician 2 number (synthetic)"

  NDX                LENGTH=3
  LABEL="Number of diagnoses on this record"

  NEOMAT             LENGTH=3
  LABEL="Neonatal and/or maternal DX and/or PR"

  NIS_STRATUM        LENGTH=3          FORMAT=4.
  LABEL="Stratum used to sample hospital"

  NPR                LENGTH=3
  LABEL="Number of procedures on this record"

  PAY1               LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY1_X             LENGTH=$10
  LABEL="Primary expected payer (as received from source)"

  PAY2               LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PAY2_X             LENGTH=$10
  LABEL="Secondary expected payer (as received from source)"

  PR1                LENGTH=$4
  LABEL="Principal procedure"

  PR2                LENGTH=$4
  LABEL="Procedure 2"

  PR3                LENGTH=$4
  LABEL="Procedure 3"

  PR4                LENGTH=$4
  LABEL="Procedure 4"

  PR5                LENGTH=$4
  LABEL="Procedure 5"

  PR6                LENGTH=$4
  LABEL="Procedure 6"

  PR7                LENGTH=$4
  LABEL="Procedure 7"

  PR8                LENGTH=$4
  LABEL="Procedure 8"

  PR9                LENGTH=$4
  LABEL="Procedure 9"

  PR10               LENGTH=$4
  LABEL="Procedure 10"

  PR11               LENGTH=$4
  LABEL="Procedure 11"

  PR12               LENGTH=$4
  LABEL="Procedure 12"

  PR13               LENGTH=$4
  LABEL="Procedure 13"

  PR14               LENGTH=$4
  LABEL="Procedure 14"

  PR15               LENGTH=$4
  LABEL="Procedure 15"

  PRCCS1             LENGTH=3
  LABEL="CCS: principal procedure"

  PRCCS2             LENGTH=3
  LABEL="CCS: procedure 2"

  PRCCS3             LENGTH=3
  LABEL="CCS: procedure 3"

  PRCCS4             LENGTH=3
  LABEL="CCS: procedure 4"

  PRCCS5             LENGTH=3
  LABEL="CCS: procedure 5"

  PRCCS6             LENGTH=3
  LABEL="CCS: procedure 6"

  PRCCS7             LENGTH=3
  LABEL="CCS: procedure 7"

  PRCCS8             LENGTH=3
  LABEL="CCS: procedure 8"

  PRCCS9             LENGTH=3
  LABEL="CCS: procedure 9"

  PRCCS10            LENGTH=3
  LABEL="CCS: procedure 10"

  PRCCS11            LENGTH=3
  LABEL="CCS: procedure 11"

  PRCCS12            LENGTH=3
  LABEL="CCS: procedure 12"

  PRCCS13            LENGTH=3
  LABEL="CCS: procedure 13"

  PRCCS14            LENGTH=3
  LABEL="CCS: procedure 14"

  PRCCS15            LENGTH=3
  LABEL="CCS: procedure 15"

  PRDAY1             LENGTH=4
  LABEL="Number of days from admission to PR1"

  PRDAY2             LENGTH=4
  LABEL="Number of days from admission to PR2"

  PRDAY3             LENGTH=4
  LABEL="Number of days from admission to PR3"

  PRDAY4             LENGTH=4
  LABEL="Number of days from admission to PR4"

  PRDAY5             LENGTH=4
  LABEL="Number of days from admission to PR5"

  PRDAY6             LENGTH=4
  LABEL="Number of days from admission to PR6"

  PRDAY7             LENGTH=4
  LABEL="Number of days from admission to PR7"

  PRDAY8             LENGTH=4
  LABEL="Number of days from admission to PR8"

  PRDAY9             LENGTH=4
  LABEL="Number of days from admission to PR9"

  PRDAY10            LENGTH=4
  LABEL="Number of days from admission to PR10"

  PRDAY11            LENGTH=4
  LABEL="Number of days from admission to PR11"

  PRDAY12            LENGTH=4
  LABEL="Number of days from admission to PR12"

  PRDAY13            LENGTH=4
  LABEL="Number of days from admission to PR13"

  PRDAY14            LENGTH=4
  LABEL="Number of days from admission to PR14"

  PRDAY15            LENGTH=4
  LABEL="Number of days from admission to PR15"

  RACE               LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG             LENGTH=6
  LABEL="Total charges (cleaned)"

  TOTCHG_X           LENGTH=7
  LABEL="Total charges (as received from source)"

  YEAR               LENGTH=3
  LABEL="Calendar year"

  ZIPINC             LENGTH=3
  LABEL="Median household income category for patient's ZIP Code"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      KEY                 14.
      @15     AGE                 N3PF.
      @18     AGEDAY              N3PF.
      @21     AMONTH              N2PF.
      @23     ASOURCE             N2PF.
      @25     ASOURCE_X           $CHAR3.
      @28     ATYPE               N2PF.
      @30     AWEEKEND            N2PF.
      @32     DIED                N2PF.
      @34     DISCWT              N10P4F.
      @44     DISPUB92            N2PF.
      @46     DISPUNIFORM         N2PF.
      @48     DQTR                N2PF.
      @50     DRG                 N3PF.
      @53     DRG18               N3PF.
      @56     DRGVER              N2PF.
      @58     DSHOSPID            $CHAR13.
      @71     DX1                 $CHAR5.
      @76     DX2                 $CHAR5.
      @81     DX3                 $CHAR5.
      @86     DX4                 $CHAR5.
      @91     DX5                 $CHAR5.
      @96     DX6                 $CHAR5.
      @101    DX7                 $CHAR5.
      @106    DX8                 $CHAR5.
      @111    DX9                 $CHAR5.
      @116    DX10                $CHAR5.
      @121    DX11                $CHAR5.
      @126    DX12                $CHAR5.
      @131    DX13                $CHAR5.
      @136    DX14                $CHAR5.
      @141    DX15                $CHAR5.
      @146    DXCCS1              N4PF.
      @150    DXCCS2              N4PF.
      @154    DXCCS3              N4PF.
      @158    DXCCS4              N4PF.
      @162    DXCCS5              N4PF.
      @166    DXCCS6              N4PF.
      @170    DXCCS7              N4PF.
      @174    DXCCS8              N4PF.
      @178    DXCCS9              N4PF.
      @182    DXCCS10             N4PF.
      @186    DXCCS11             N4PF.
      @190    DXCCS12             N4PF.
      @194    DXCCS13             N4PF.
      @198    DXCCS14             N4PF.
      @202    DXCCS15             N4PF.
      @206    FEMALE              N2PF.
      @208    HOSPID              5.
      @213    HOSPST              $CHAR2.
      @215    HOSPSTCO            N5PF.
      @220    LOS                 N5PF.
      @225    LOS_X               N6PF.
      @231    MDC                 N2PF.
      @233    MDC18               N2PF.
      @235    MDNUM1_S            $CHAR16.
      @251    MDNUM2_S            $CHAR16.
      @267    NDX                 N2PF.
      @269    NEOMAT              N2PF.
      @271    NIS_STRATUM         N4PF.
      @275    NPR                 N2PF.
      @277    PAY1                N2PF.
      @279    PAY1_X              $CHAR10.
      @289    PAY2                N2PF.
      @291    PAY2_X              $CHAR10.
      @301    PR1                 $CHAR4.
      @305    PR2                 $CHAR4.
      @309    PR3                 $CHAR4.
      @313    PR4                 $CHAR4.
      @317    PR5                 $CHAR4.
      @321    PR6                 $CHAR4.
      @325    PR7                 $CHAR4.
      @329    PR8                 $CHAR4.
      @333    PR9                 $CHAR4.
      @337    PR10                $CHAR4.
      @341    PR11                $CHAR4.
      @345    PR12                $CHAR4.
      @349    PR13                $CHAR4.
      @353    PR14                $CHAR4.
      @357    PR15                $CHAR4.
      @361    PRCCS1              N3PF.
      @364    PRCCS2              N3PF.
      @367    PRCCS3              N3PF.
      @370    PRCCS4              N3PF.
      @373    PRCCS5              N3PF.
      @376    PRCCS6              N3PF.
      @379    PRCCS7              N3PF.
      @382    PRCCS8              N3PF.
      @385    PRCCS9              N3PF.
      @388    PRCCS10             N3PF.
      @391    PRCCS11             N3PF.
      @394    PRCCS12             N3PF.
      @397    PRCCS13             N3PF.
      @400    PRCCS14             N3PF.
      @403    PRCCS15             N3PF.
      @406    PRDAY1              N3PF.
      @409    PRDAY2              N3PF.
      @412    PRDAY3              N3PF.
      @415    PRDAY4              N3PF.
      @418    PRDAY5              N3PF.
      @421    PRDAY6              N3PF.
      @424    PRDAY7              N3PF.
      @427    PRDAY8              N3PF.
      @430    PRDAY9              N3PF.
      @433    PRDAY10             N3PF.
      @436    PRDAY11             N3PF.
      @439    PRDAY12             N3PF.
      @442    PRDAY13             N3PF.
      @445    PRDAY14             N3PF.
      @448    PRDAY15             N3PF.
      @451    RACE                N2PF.
      @453    TOTCHG              N10PF.
      @463    TOTCHG_X            N15P2F.
      @478    YEAR                N4PF.
      @482    ZIPINC              N2PF.
      ;


RUN;
/*******************************************************************
*   SASload_NIS_2001_10PCT_SAMPLE_B.SAS:                                
*      THE SAS CODE SHOWN BELOW WILL LOAD THE ASCII NIS             
*      INPATIENT STAY 10PCT_SAMPLE_B FILE INTO SAS                          
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
  INVALUE DATE10F
    '-999999999' = .
    '-888888888' = .A
    '-666666666' = .C
    OTHER = (|MMDDYY10.|)
  ;
  INVALUE N12P2F
    '-99999999.99' = .
    '-88888888.88' = .A
    '-66666666.66' = .C
    OTHER = (|12.2|)
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
DATA NIS_2001_10PCT_SAMPLE_B; 
INFILE "%trim(&filepath)NIS/NIS_2001/Data/NIS_2001_10PCT_SAMPLE_B.ASC" LRECL = 483;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  KEY                LENGTH=8          FORMAT=Z14.
  LABEL="HCUP record identifier"

  AGE                LENGTH=3
  LABEL="Age in years at admission"

  AGEDAY             LENGTH=3
  LABEL="Age in days (when age < 1 year)"

  AMONTH             LENGTH=3
  LABEL="Admission month"

  ASOURCE            LENGTH=3
  LABEL="Admission source (uniform)"

  ASOURCE_X          LENGTH=$3
  LABEL="Admission source (as received from source)"

  ATYPE              LENGTH=3
  LABEL="Admission type"

  AWEEKEND           LENGTH=3
  LABEL="Admission day is a weekend"

  DIED               LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT10           LENGTH=8
  LABEL="10% subsample weight to discharges in AHA universe"

  DISPUB92           LENGTH=3
  LABEL="Disposition of patient (UB-92 standard coding)"

  DISPUNIFORM        LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR               LENGTH=3
  LABEL="Discharge quarter"

  DRG                LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRG18              LENGTH=3
  LABEL="DRG, version 18"

  DRGVER             LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DSHOSPID           LENGTH=$13
  LABEL="Data source hospital identifier"

  DX1                LENGTH=$5
  LABEL="Principal diagnosis"

  DX2                LENGTH=$5
  LABEL="Diagnosis 2"

  DX3                LENGTH=$5
  LABEL="Diagnosis 3"

  DX4                LENGTH=$5
  LABEL="Diagnosis 4"

  DX5                LENGTH=$5
  LABEL="Diagnosis 5"

  DX6                LENGTH=$5
  LABEL="Diagnosis 6"

  DX7                LENGTH=$5
  LABEL="Diagnosis 7"

  DX8                LENGTH=$5
  LABEL="Diagnosis 8"

  DX9                LENGTH=$5
  LABEL="Diagnosis 9"

  DX10               LENGTH=$5
  LABEL="Diagnosis 10"

  DX11               LENGTH=$5
  LABEL="Diagnosis 11"

  DX12               LENGTH=$5
  LABEL="Diagnosis 12"

  DX13               LENGTH=$5
  LABEL="Diagnosis 13"

  DX14               LENGTH=$5
  LABEL="Diagnosis 14"

  DX15               LENGTH=$5
  LABEL="Diagnosis 15"

  DXCCS1             LENGTH=4
  LABEL="CCS: principal diagnosis"

  DXCCS2             LENGTH=4
  LABEL="CCS: diagnosis 2"

  DXCCS3             LENGTH=4
  LABEL="CCS: diagnosis 3"

  DXCCS4             LENGTH=4
  LABEL="CCS: diagnosis 4"

  DXCCS5             LENGTH=4
  LABEL="CCS: diagnosis 5"

  DXCCS6             LENGTH=4
  LABEL="CCS: diagnosis 6"

  DXCCS7             LENGTH=4
  LABEL="CCS: diagnosis 7"

  DXCCS8             LENGTH=4
  LABEL="CCS: diagnosis 8"

  DXCCS9             LENGTH=4
  LABEL="CCS: diagnosis 9"

  DXCCS10            LENGTH=4
  LABEL="CCS: diagnosis 10"

  DXCCS11            LENGTH=4
  LABEL="CCS: diagnosis 11"

  DXCCS12            LENGTH=4
  LABEL="CCS: diagnosis 12"

  DXCCS13            LENGTH=4
  LABEL="CCS: diagnosis 13"

  DXCCS14            LENGTH=4
  LABEL="CCS: diagnosis 14"

  DXCCS15            LENGTH=4
  LABEL="CCS: diagnosis 15"

  FEMALE             LENGTH=3
  LABEL="Indicator of sex"

  HOSPID             LENGTH=4          FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPST             LENGTH=$2
  LABEL="Hospital state postal code"

  HOSPSTCO           LENGTH=4          FORMAT=Z5.
  LABEL="Hospital modified FIPS state/county code"

  LOS                LENGTH=4
  LABEL="Length of stay (cleaned)"

  LOS_X              LENGTH=4
  LABEL="Length of stay (as received from source)"

  MDC                LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC18              LENGTH=3
  LABEL="MDC, version 18"

  MDNUM1_S           LENGTH=$16
  LABEL="Physician 1 number (synthetic)"

  MDNUM2_S           LENGTH=$16
  LABEL="Physician 2 number (synthetic)"

  NDX                LENGTH=3
  LABEL="Number of diagnoses on this record"

  NEOMAT             LENGTH=3
  LABEL="Neonatal and/or maternal DX and/or PR"

  NIS_STRATUM        LENGTH=3          FORMAT=4.
  LABEL="Stratum used to sample hospital"

  NPR                LENGTH=3
  LABEL="Number of procedures on this record"

  PAY1               LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY1_X             LENGTH=$10
  LABEL="Primary expected payer (as received from source)"

  PAY2               LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PAY2_X             LENGTH=$10
  LABEL="Secondary expected payer (as received from source)"

  PR1                LENGTH=$4
  LABEL="Principal procedure"

  PR2                LENGTH=$4
  LABEL="Procedure 2"

  PR3                LENGTH=$4
  LABEL="Procedure 3"

  PR4                LENGTH=$4
  LABEL="Procedure 4"

  PR5                LENGTH=$4
  LABEL="Procedure 5"

  PR6                LENGTH=$4
  LABEL="Procedure 6"

  PR7                LENGTH=$4
  LABEL="Procedure 7"

  PR8                LENGTH=$4
  LABEL="Procedure 8"

  PR9                LENGTH=$4
  LABEL="Procedure 9"

  PR10               LENGTH=$4
  LABEL="Procedure 10"

  PR11               LENGTH=$4
  LABEL="Procedure 11"

  PR12               LENGTH=$4
  LABEL="Procedure 12"

  PR13               LENGTH=$4
  LABEL="Procedure 13"

  PR14               LENGTH=$4
  LABEL="Procedure 14"

  PR15               LENGTH=$4
  LABEL="Procedure 15"

  PRCCS1             LENGTH=3
  LABEL="CCS: principal procedure"

  PRCCS2             LENGTH=3
  LABEL="CCS: procedure 2"

  PRCCS3             LENGTH=3
  LABEL="CCS: procedure 3"

  PRCCS4             LENGTH=3
  LABEL="CCS: procedure 4"

  PRCCS5             LENGTH=3
  LABEL="CCS: procedure 5"

  PRCCS6             LENGTH=3
  LABEL="CCS: procedure 6"

  PRCCS7             LENGTH=3
  LABEL="CCS: procedure 7"

  PRCCS8             LENGTH=3
  LABEL="CCS: procedure 8"

  PRCCS9             LENGTH=3
  LABEL="CCS: procedure 9"

  PRCCS10            LENGTH=3
  LABEL="CCS: procedure 10"

  PRCCS11            LENGTH=3
  LABEL="CCS: procedure 11"

  PRCCS12            LENGTH=3
  LABEL="CCS: procedure 12"

  PRCCS13            LENGTH=3
  LABEL="CCS: procedure 13"

  PRCCS14            LENGTH=3
  LABEL="CCS: procedure 14"

  PRCCS15            LENGTH=3
  LABEL="CCS: procedure 15"

  PRDAY1             LENGTH=4
  LABEL="Number of days from admission to PR1"

  PRDAY2             LENGTH=4
  LABEL="Number of days from admission to PR2"

  PRDAY3             LENGTH=4
  LABEL="Number of days from admission to PR3"

  PRDAY4             LENGTH=4
  LABEL="Number of days from admission to PR4"

  PRDAY5             LENGTH=4
  LABEL="Number of days from admission to PR5"

  PRDAY6             LENGTH=4
  LABEL="Number of days from admission to PR6"

  PRDAY7             LENGTH=4
  LABEL="Number of days from admission to PR7"

  PRDAY8             LENGTH=4
  LABEL="Number of days from admission to PR8"

  PRDAY9             LENGTH=4
  LABEL="Number of days from admission to PR9"

  PRDAY10            LENGTH=4
  LABEL="Number of days from admission to PR10"

  PRDAY11            LENGTH=4
  LABEL="Number of days from admission to PR11"

  PRDAY12            LENGTH=4
  LABEL="Number of days from admission to PR12"

  PRDAY13            LENGTH=4
  LABEL="Number of days from admission to PR13"

  PRDAY14            LENGTH=4
  LABEL="Number of days from admission to PR14"

  PRDAY15            LENGTH=4
  LABEL="Number of days from admission to PR15"

  RACE               LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG             LENGTH=6
  LABEL="Total charges (cleaned)"

  TOTCHG_X           LENGTH=7
  LABEL="Total charges (as received from source)"

  YEAR               LENGTH=3
  LABEL="Calendar year"

  ZIPINC             LENGTH=3
  LABEL="Median household income category for patient's ZIP Code"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      KEY                 14.
      @15     AGE                 N3PF.
      @18     AGEDAY              N3PF.
      @21     AMONTH              N2PF.
      @23     ASOURCE             N2PF.
      @25     ASOURCE_X           $CHAR3.
      @28     ATYPE               N2PF.
      @30     AWEEKEND            N2PF.
      @32     DIED                N2PF.
      @34     DISCWT10            N10P4F.
      @44     DISPUB92            N2PF.
      @46     DISPUNIFORM         N2PF.
      @48     DQTR                N2PF.
      @50     DRG                 N3PF.
      @53     DRG18               N3PF.
      @56     DRGVER              N2PF.
      @58     DSHOSPID            $CHAR13.
      @71     DX1                 $CHAR5.
      @76     DX2                 $CHAR5.
      @81     DX3                 $CHAR5.
      @86     DX4                 $CHAR5.
      @91     DX5                 $CHAR5.
      @96     DX6                 $CHAR5.
      @101    DX7                 $CHAR5.
      @106    DX8                 $CHAR5.
      @111    DX9                 $CHAR5.
      @116    DX10                $CHAR5.
      @121    DX11                $CHAR5.
      @126    DX12                $CHAR5.
      @131    DX13                $CHAR5.
      @136    DX14                $CHAR5.
      @141    DX15                $CHAR5.
      @146    DXCCS1              N4PF.
      @150    DXCCS2              N4PF.
      @154    DXCCS3              N4PF.
      @158    DXCCS4              N4PF.
      @162    DXCCS5              N4PF.
      @166    DXCCS6              N4PF.
      @170    DXCCS7              N4PF.
      @174    DXCCS8              N4PF.
      @178    DXCCS9              N4PF.
      @182    DXCCS10             N4PF.
      @186    DXCCS11             N4PF.
      @190    DXCCS12             N4PF.
      @194    DXCCS13             N4PF.
      @198    DXCCS14             N4PF.
      @202    DXCCS15             N4PF.
      @206    FEMALE              N2PF.
      @208    HOSPID              5.
      @213    HOSPST              $CHAR2.
      @215    HOSPSTCO            N5PF.
      @220    LOS                 N5PF.
      @225    LOS_X               N6PF.
      @231    MDC                 N2PF.
      @233    MDC18               N2PF.
      @235    MDNUM1_S            $CHAR16.
      @251    MDNUM2_S            $CHAR16.
      @267    NDX                 N2PF.
      @269    NEOMAT              N2PF.
      @271    NIS_STRATUM         N4PF.
      @275    NPR                 N2PF.
      @277    PAY1                N2PF.
      @279    PAY1_X              $CHAR10.
      @289    PAY2                N2PF.
      @291    PAY2_X              $CHAR10.
      @301    PR1                 $CHAR4.
      @305    PR2                 $CHAR4.
      @309    PR3                 $CHAR4.
      @313    PR4                 $CHAR4.
      @317    PR5                 $CHAR4.
      @321    PR6                 $CHAR4.
      @325    PR7                 $CHAR4.
      @329    PR8                 $CHAR4.
      @333    PR9                 $CHAR4.
      @337    PR10                $CHAR4.
      @341    PR11                $CHAR4.
      @345    PR12                $CHAR4.
      @349    PR13                $CHAR4.
      @353    PR14                $CHAR4.
      @357    PR15                $CHAR4.
      @361    PRCCS1              N3PF.
      @364    PRCCS2              N3PF.
      @367    PRCCS3              N3PF.
      @370    PRCCS4              N3PF.
      @373    PRCCS5              N3PF.
      @376    PRCCS6              N3PF.
      @379    PRCCS7              N3PF.
      @382    PRCCS8              N3PF.
      @385    PRCCS9              N3PF.
      @388    PRCCS10             N3PF.
      @391    PRCCS11             N3PF.
      @394    PRCCS12             N3PF.
      @397    PRCCS13             N3PF.
      @400    PRCCS14             N3PF.
      @403    PRCCS15             N3PF.
      @406    PRDAY1              N3PF.
      @409    PRDAY2              N3PF.
      @412    PRDAY3              N3PF.
      @415    PRDAY4              N3PF.
      @418    PRDAY5              N3PF.
      @421    PRDAY6              N3PF.
      @424    PRDAY7              N3PF.
      @427    PRDAY8              N3PF.
      @430    PRDAY9              N3PF.
      @433    PRDAY10             N3PF.
      @436    PRDAY11             N3PF.
      @439    PRDAY12             N3PF.
      @442    PRDAY13             N3PF.
      @445    PRDAY14             N3PF.
      @448    PRDAY15             N3PF.
      @451    RACE                N2PF.
      @453    TOTCHG              N10PF.
      @463    TOTCHG_X            N15P2F.
      @478    YEAR                N4PF.
      @482    ZIPINC              N2PF.
      ;


RUN;
/*******************************************************************
*   SASload_NIS_2001_10PCT_SAMPLE_A.SAS:                                
*      THE SAS CODE SHOWN BELOW WILL LOAD THE ASCII NIS             
*      INPATIENT STAY 10PCT_SAMPLE_A FILE INTO SAS                          
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
  INVALUE DATE10F
    '-999999999' = .
    '-888888888' = .A
    '-666666666' = .C
    OTHER = (|MMDDYY10.|)
  ;
  INVALUE N12P2F
    '-99999999.99' = .
    '-88888888.88' = .A
    '-66666666.66' = .C
    OTHER = (|12.2|)
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
DATA NIS_2001_10PCT_SAMPLE_A; 
INFILE "%trim(&filepath)NIS/NIS_2001/Data/NIS_2001_10PCT_SAMPLE_A.ASC" LRECL = 483;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  KEY                LENGTH=8          FORMAT=Z14.
  LABEL="HCUP record identifier"

  AGE                LENGTH=3
  LABEL="Age in years at admission"

  AGEDAY             LENGTH=3
  LABEL="Age in days (when age < 1 year)"

  AMONTH             LENGTH=3
  LABEL="Admission month"

  ASOURCE            LENGTH=3
  LABEL="Admission source (uniform)"

  ASOURCE_X          LENGTH=$3
  LABEL="Admission source (as received from source)"

  ATYPE              LENGTH=3
  LABEL="Admission type"

  AWEEKEND           LENGTH=3
  LABEL="Admission day is a weekend"

  DIED               LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT10           LENGTH=8
  LABEL="10% subsample weight to discharges in AHA universe"

  DISPUB92           LENGTH=3
  LABEL="Disposition of patient (UB-92 standard coding)"

  DISPUNIFORM        LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR               LENGTH=3
  LABEL="Discharge quarter"

  DRG                LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRG18              LENGTH=3
  LABEL="DRG, version 18"

  DRGVER             LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DSHOSPID           LENGTH=$13
  LABEL="Data source hospital identifier"

  DX1                LENGTH=$5
  LABEL="Principal diagnosis"

  DX2                LENGTH=$5
  LABEL="Diagnosis 2"

  DX3                LENGTH=$5
  LABEL="Diagnosis 3"

  DX4                LENGTH=$5
  LABEL="Diagnosis 4"

  DX5                LENGTH=$5
  LABEL="Diagnosis 5"

  DX6                LENGTH=$5
  LABEL="Diagnosis 6"

  DX7                LENGTH=$5
  LABEL="Diagnosis 7"

  DX8                LENGTH=$5
  LABEL="Diagnosis 8"

  DX9                LENGTH=$5
  LABEL="Diagnosis 9"

  DX10               LENGTH=$5
  LABEL="Diagnosis 10"

  DX11               LENGTH=$5
  LABEL="Diagnosis 11"

  DX12               LENGTH=$5
  LABEL="Diagnosis 12"

  DX13               LENGTH=$5
  LABEL="Diagnosis 13"

  DX14               LENGTH=$5
  LABEL="Diagnosis 14"

  DX15               LENGTH=$5
  LABEL="Diagnosis 15"

  DXCCS1             LENGTH=4
  LABEL="CCS: principal diagnosis"

  DXCCS2             LENGTH=4
  LABEL="CCS: diagnosis 2"

  DXCCS3             LENGTH=4
  LABEL="CCS: diagnosis 3"

  DXCCS4             LENGTH=4
  LABEL="CCS: diagnosis 4"

  DXCCS5             LENGTH=4
  LABEL="CCS: diagnosis 5"

  DXCCS6             LENGTH=4
  LABEL="CCS: diagnosis 6"

  DXCCS7             LENGTH=4
  LABEL="CCS: diagnosis 7"

  DXCCS8             LENGTH=4
  LABEL="CCS: diagnosis 8"

  DXCCS9             LENGTH=4
  LABEL="CCS: diagnosis 9"

  DXCCS10            LENGTH=4
  LABEL="CCS: diagnosis 10"

  DXCCS11            LENGTH=4
  LABEL="CCS: diagnosis 11"

  DXCCS12            LENGTH=4
  LABEL="CCS: diagnosis 12"

  DXCCS13            LENGTH=4
  LABEL="CCS: diagnosis 13"

  DXCCS14            LENGTH=4
  LABEL="CCS: diagnosis 14"

  DXCCS15            LENGTH=4
  LABEL="CCS: diagnosis 15"

  FEMALE             LENGTH=3
  LABEL="Indicator of sex"

  HOSPID             LENGTH=4          FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPST             LENGTH=$2
  LABEL="Hospital state postal code"

  HOSPSTCO           LENGTH=4          FORMAT=Z5.
  LABEL="Hospital modified FIPS state/county code"

  LOS                LENGTH=4
  LABEL="Length of stay (cleaned)"

  LOS_X              LENGTH=4
  LABEL="Length of stay (as received from source)"

  MDC                LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC18              LENGTH=3
  LABEL="MDC, version 18"

  MDNUM1_S           LENGTH=$16
  LABEL="Physician 1 number (synthetic)"

  MDNUM2_S           LENGTH=$16
  LABEL="Physician 2 number (synthetic)"

  NDX                LENGTH=3
  LABEL="Number of diagnoses on this record"

  NEOMAT             LENGTH=3
  LABEL="Neonatal and/or maternal DX and/or PR"

  NIS_STRATUM        LENGTH=3          FORMAT=4.
  LABEL="Stratum used to sample hospital"

  NPR                LENGTH=3
  LABEL="Number of procedures on this record"

  PAY1               LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY1_X             LENGTH=$10
  LABEL="Primary expected payer (as received from source)"

  PAY2               LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PAY2_X             LENGTH=$10
  LABEL="Secondary expected payer (as received from source)"

  PR1                LENGTH=$4
  LABEL="Principal procedure"

  PR2                LENGTH=$4
  LABEL="Procedure 2"

  PR3                LENGTH=$4
  LABEL="Procedure 3"

  PR4                LENGTH=$4
  LABEL="Procedure 4"

  PR5                LENGTH=$4
  LABEL="Procedure 5"

  PR6                LENGTH=$4
  LABEL="Procedure 6"

  PR7                LENGTH=$4
  LABEL="Procedure 7"

  PR8                LENGTH=$4
  LABEL="Procedure 8"

  PR9                LENGTH=$4
  LABEL="Procedure 9"

  PR10               LENGTH=$4
  LABEL="Procedure 10"

  PR11               LENGTH=$4
  LABEL="Procedure 11"

  PR12               LENGTH=$4
  LABEL="Procedure 12"

  PR13               LENGTH=$4
  LABEL="Procedure 13"

  PR14               LENGTH=$4
  LABEL="Procedure 14"

  PR15               LENGTH=$4
  LABEL="Procedure 15"

  PRCCS1             LENGTH=3
  LABEL="CCS: principal procedure"

  PRCCS2             LENGTH=3
  LABEL="CCS: procedure 2"

  PRCCS3             LENGTH=3
  LABEL="CCS: procedure 3"

  PRCCS4             LENGTH=3
  LABEL="CCS: procedure 4"

  PRCCS5             LENGTH=3
  LABEL="CCS: procedure 5"

  PRCCS6             LENGTH=3
  LABEL="CCS: procedure 6"

  PRCCS7             LENGTH=3
  LABEL="CCS: procedure 7"

  PRCCS8             LENGTH=3
  LABEL="CCS: procedure 8"

  PRCCS9             LENGTH=3
  LABEL="CCS: procedure 9"

  PRCCS10            LENGTH=3
  LABEL="CCS: procedure 10"

  PRCCS11            LENGTH=3
  LABEL="CCS: procedure 11"

  PRCCS12            LENGTH=3
  LABEL="CCS: procedure 12"

  PRCCS13            LENGTH=3
  LABEL="CCS: procedure 13"

  PRCCS14            LENGTH=3
  LABEL="CCS: procedure 14"

  PRCCS15            LENGTH=3
  LABEL="CCS: procedure 15"

  PRDAY1             LENGTH=4
  LABEL="Number of days from admission to PR1"

  PRDAY2             LENGTH=4
  LABEL="Number of days from admission to PR2"

  PRDAY3             LENGTH=4
  LABEL="Number of days from admission to PR3"

  PRDAY4             LENGTH=4
  LABEL="Number of days from admission to PR4"

  PRDAY5             LENGTH=4
  LABEL="Number of days from admission to PR5"

  PRDAY6             LENGTH=4
  LABEL="Number of days from admission to PR6"

  PRDAY7             LENGTH=4
  LABEL="Number of days from admission to PR7"

  PRDAY8             LENGTH=4
  LABEL="Number of days from admission to PR8"

  PRDAY9             LENGTH=4
  LABEL="Number of days from admission to PR9"

  PRDAY10            LENGTH=4
  LABEL="Number of days from admission to PR10"

  PRDAY11            LENGTH=4
  LABEL="Number of days from admission to PR11"

  PRDAY12            LENGTH=4
  LABEL="Number of days from admission to PR12"

  PRDAY13            LENGTH=4
  LABEL="Number of days from admission to PR13"

  PRDAY14            LENGTH=4
  LABEL="Number of days from admission to PR14"

  PRDAY15            LENGTH=4
  LABEL="Number of days from admission to PR15"

  RACE               LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG             LENGTH=6
  LABEL="Total charges (cleaned)"

  TOTCHG_X           LENGTH=7
  LABEL="Total charges (as received from source)"

  YEAR               LENGTH=3
  LABEL="Calendar year"

  ZIPINC             LENGTH=3
  LABEL="Median household income category for patient's ZIP Code"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      KEY                 14.
      @15     AGE                 N3PF.
      @18     AGEDAY              N3PF.
      @21     AMONTH              N2PF.
      @23     ASOURCE             N2PF.
      @25     ASOURCE_X           $CHAR3.
      @28     ATYPE               N2PF.
      @30     AWEEKEND            N2PF.
      @32     DIED                N2PF.
      @34     DISCWT10            N10P4F.
      @44     DISPUB92            N2PF.
      @46     DISPUNIFORM         N2PF.
      @48     DQTR                N2PF.
      @50     DRG                 N3PF.
      @53     DRG18               N3PF.
      @56     DRGVER              N2PF.
      @58     DSHOSPID            $CHAR13.
      @71     DX1                 $CHAR5.
      @76     DX2                 $CHAR5.
      @81     DX3                 $CHAR5.
      @86     DX4                 $CHAR5.
      @91     DX5                 $CHAR5.
      @96     DX6                 $CHAR5.
      @101    DX7                 $CHAR5.
      @106    DX8                 $CHAR5.
      @111    DX9                 $CHAR5.
      @116    DX10                $CHAR5.
      @121    DX11                $CHAR5.
      @126    DX12                $CHAR5.
      @131    DX13                $CHAR5.
      @136    DX14                $CHAR5.
      @141    DX15                $CHAR5.
      @146    DXCCS1              N4PF.
      @150    DXCCS2              N4PF.
      @154    DXCCS3              N4PF.
      @158    DXCCS4              N4PF.
      @162    DXCCS5              N4PF.
      @166    DXCCS6              N4PF.
      @170    DXCCS7              N4PF.
      @174    DXCCS8              N4PF.
      @178    DXCCS9              N4PF.
      @182    DXCCS10             N4PF.
      @186    DXCCS11             N4PF.
      @190    DXCCS12             N4PF.
      @194    DXCCS13             N4PF.
      @198    DXCCS14             N4PF.
      @202    DXCCS15             N4PF.
      @206    FEMALE              N2PF.
      @208    HOSPID              5.
      @213    HOSPST              $CHAR2.
      @215    HOSPSTCO            N5PF.
      @220    LOS                 N5PF.
      @225    LOS_X               N6PF.
      @231    MDC                 N2PF.
      @233    MDC18               N2PF.
      @235    MDNUM1_S            $CHAR16.
      @251    MDNUM2_S            $CHAR16.
      @267    NDX                 N2PF.
      @269    NEOMAT              N2PF.
      @271    NIS_STRATUM         N4PF.
      @275    NPR                 N2PF.
      @277    PAY1                N2PF.
      @279    PAY1_X              $CHAR10.
      @289    PAY2                N2PF.
      @291    PAY2_X              $CHAR10.
      @301    PR1                 $CHAR4.
      @305    PR2                 $CHAR4.
      @309    PR3                 $CHAR4.
      @313    PR4                 $CHAR4.
      @317    PR5                 $CHAR4.
      @321    PR6                 $CHAR4.
      @325    PR7                 $CHAR4.
      @329    PR8                 $CHAR4.
      @333    PR9                 $CHAR4.
      @337    PR10                $CHAR4.
      @341    PR11                $CHAR4.
      @345    PR12                $CHAR4.
      @349    PR13                $CHAR4.
      @353    PR14                $CHAR4.
      @357    PR15                $CHAR4.
      @361    PRCCS1              N3PF.
      @364    PRCCS2              N3PF.
      @367    PRCCS3              N3PF.
      @370    PRCCS4              N3PF.
      @373    PRCCS5              N3PF.
      @376    PRCCS6              N3PF.
      @379    PRCCS7              N3PF.
      @382    PRCCS8              N3PF.
      @385    PRCCS9              N3PF.
      @388    PRCCS10             N3PF.
      @391    PRCCS11             N3PF.
      @394    PRCCS12             N3PF.
      @397    PRCCS13             N3PF.
      @400    PRCCS14             N3PF.
      @403    PRCCS15             N3PF.
      @406    PRDAY1              N3PF.
      @409    PRDAY2              N3PF.
      @412    PRDAY3              N3PF.
      @415    PRDAY4              N3PF.
      @418    PRDAY5              N3PF.
      @421    PRDAY6              N3PF.
      @424    PRDAY7              N3PF.
      @427    PRDAY8              N3PF.
      @430    PRDAY9              N3PF.
      @433    PRDAY10             N3PF.
      @436    PRDAY11             N3PF.
      @439    PRDAY12             N3PF.
      @442    PRDAY13             N3PF.
      @445    PRDAY14             N3PF.
      @448    PRDAY15             N3PF.
      @451    RACE                N2PF.
      @453    TOTCHG              N10PF.
      @463    TOTCHG_X            N15P2F.
      @478    YEAR                N4PF.
      @482    ZIPINC              N2PF.
      ;


RUN;
/*******************************************************************
*   SASload_NIS_2001_HOSPITAL.SAS:                                
*      THE SAS CODE SHOWN BELOW WILL LOAD THE ASCII NIS             
*      HOSPITAL FILE INTO SAS                                         
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
  INVALUE DATE10F
    '-999999999' = .
    '-888888888' = .A
    '-666666666' = .C
    OTHER = (|MMDDYY10.|)
  ;
  INVALUE N12P2F
    '-99999999.99' = .
    '-88888888.88' = .A
    '-66666666.66' = .C
    OTHER = (|12.2|)
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
DATA NIS_2001_HOSPITAL; 
INFILE "%trim(&filepath)NIS/NIS_2001/Data/NIS_2001_HOSPITAL.ASC" LRECL = 173;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  AHAID              LENGTH=$7
  LABEL="AHA hospital identifier with the leading 6"

  DISCWT             LENGTH=8
  LABEL="Weight to discharges in AHA universe"

  HOSPADDR           LENGTH=$30
  LABEL="Hospital address from AHA Survey (Z011)"

  HOSPCITY           LENGTH=$20
  LABEL="Hospital city from AHA Survey (Z012)"

  HOSPID             LENGTH=4          FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPNAME           LENGTH=$30
  LABEL="Hospital name from AHA Survey (Z000)"

  HOSPST             LENGTH=$2
  LABEL="Hospital state postal code"

  HOSPWT             LENGTH=8
  LABEL="Weight to hospitals in AHA universe"

  HOSPZIP            LENGTH=$5
  LABEL="Hospital ZIP Code from AHA Survey (Z014)"

  HOSP_BEDSIZE       LENGTH=3          FORMAT=1.
  LABEL="Bed size of hospital"

  HOSP_CONTROL       LENGTH=3          FORMAT=1.
  LABEL="Control/ownership of hospital"

  HOSP_LOCATION      LENGTH=3          FORMAT=1.
  LABEL="Location (urban/rural) of hospital"

  HOSP_LOCTEACH      LENGTH=3          FORMAT=1.
  LABEL="Location/teaching status of hospital"

  HOSP_REGION        LENGTH=3          FORMAT=1.
  LABEL="Region of hospital"

  HOSP_TEACH         LENGTH=3          FORMAT=1.
  LABEL="Teaching status of hospital"

  IDNUMBER           LENGTH=$6
  LABEL="AHA hospital identifier without the leading 6"

  NIS_STRATUM        LENGTH=3          FORMAT=4.
  LABEL="Stratum used to sample hospital"

  N_DISC_U           LENGTH=4
  LABEL="Number of AHA universe discharges in NIS_STRATUM"

  N_HOSP_U           LENGTH=3
  LABEL="Number of AHA universe hospitals in NIS_STRATUM"

  S_DISC_U           LENGTH=4
  LABEL="Number of sample discharges in NIS_STRATUM"

  S_HOSP_U           LENGTH=3
  LABEL="Number of sample hospitals in NIS_STRATUM"

  TOTAL_DISC         LENGTH=4
  LABEL="Total number of discharges from this hospital in the NIS"

  YEAR               LENGTH=3
  LABEL="Calendar Year"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      AHAID               $CHAR7.
      @8      DISCWT              N10P4F.
      @18     HOSPADDR            $CHAR30.
      @48     HOSPCITY            $CHAR20.
      @68     HOSPID              5.
      @73     HOSPNAME            $CHAR30.
      @103    HOSPST              $CHAR2.
      @105    HOSPWT              N10P4F.
      @115    HOSPZIP             $CHAR5.
      @120    HOSP_BEDSIZE        N2PF.
      @122    HOSP_CONTROL        N2PF.
      @124    HOSP_LOCATION       N2PF.
      @126    HOSP_LOCTEACH       N2PF.
      @128    HOSP_REGION         N2PF.
      @130    HOSP_TEACH          N2PF.
      @132    IDNUMBER            $CHAR6.
      @138    NIS_STRATUM         N4PF.
      @142    N_DISC_U            N8PF.
      @150    N_HOSP_U            N4PF.
      @154    S_DISC_U            N6PF.
      @160    S_HOSP_U            N4PF.
      @164    TOTAL_DISC          N6PF.
      @170    YEAR                N4PF.
      ;


RUN;
                                                                                

proc SQL;
create table isilon.NIS_2001_Core
like work.NIS_2001_Core;

proc SQL;
insert into isilon.NIS_2001_Core
select * from work.NIS_2001_Core;

proc SQL;
create table isilon.NIS_2001_10PCT_SAMPLE_A
like work.NIS_2001_10PCT_SAMPLE_A;

proc SQL;
insert into isilon.NIS_2001_10PCT_SAMPLE_A
select * from work.NIS_2001_10PCT_SAMPLE_A;

proc SQL;
create table isilon.NIS_2001_10PCT_SAMPLE_B
like work.NIS_2001_10PCT_SAMPLE_B;

proc SQL;
insert into isilon.NIS_2001_10PCT_SAMPLE_B
select * from work.NIS_2001_10PCT_SAMPLE_B;

proc SQL;
create table isilon.NIS_2001_Hospital
like work.NIS_2001_Hospital;

proc SQL;
insert into isilon.NIS_2001_Hospital
select * from work.NIS_2001_Hospital;

proc delete data= work.NIS_2001_Core; run;
proc delete data= work.NIS_2001_10PCT_SAMPLE_A; run;
proc delete data= work.NIS_2001_10PCT_SAMPLE_B; run;
proc delete data= work.NIS_2001_Hospital; run;