*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2004/Data/NIS_2004   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

/*******************************************************************
*   SASload_NIS_2004_Hospital.SAS:
*      The following SAS code will load the ASCII NIS
*      Hospital File into SAS.
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
DATA NIS_2004_Hospital; 
INFILE "%trim(&filepath)NIS/NIS_2004/Data/NIS_2004_Hospital.ASC" LRECL = 185;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  AHAID                      LENGTH=$7
  LABEL="AHA hospital identifier with the leading 6"

  DISCWT                     LENGTH=8
  LABEL="Weight to discharges in AHA universe"

  HFIPSSTCO                  LENGTH=4
  LABEL="Hospital FIPS state/county code"

  HOSPADDR                   LENGTH=$30
  LABEL="Hospital address from AHA Survey (Z011)"

  HOSPCITY                   LENGTH=$20
  LABEL="Hospital city from AHA Survey (Z012)"

  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPNAME                   LENGTH=$30
  LABEL="Hospital name from AHA Survey (Z000)"

  HOSPST                     LENGTH=$2
  LABEL="Hospital state postal code"

  HOSPSTCO                   LENGTH=4            FORMAT=Z5.
  LABEL="Hospital modified FIPS state/county code"

  HOSPWT                     LENGTH=8
  LABEL="Weight to hospitals in AHA universe"

  HOSPZIP                    LENGTH=$5
  LABEL="Hospital ZIP Code from AHA Survey (Z014)"

  HOSP_BEDSIZE               LENGTH=3            FORMAT=1.
  LABEL="Bed size of hospital"

  HOSP_CONTROL               LENGTH=3            FORMAT=1.
  LABEL="Control/ownership of hospital"

  HOSP_LOCATION              LENGTH=3            FORMAT=1.
  LABEL="Location (urban/rural) of hospital"

  HOSP_LOCTEACH              LENGTH=3            FORMAT=1.
  LABEL="Location/teaching status of hospital"

  HOSP_REGION                LENGTH=3            FORMAT=1.
  LABEL="Region of hospital"

  HOSP_TEACH                 LENGTH=3            FORMAT=1.
  LABEL="Teaching status of hospital"

  IDNUMBER                   LENGTH=$6
  LABEL="AHA hospital identifier without the leading 6"

  NIS_STRATUM                LENGTH=3            FORMAT=4.
  LABEL="Stratum used to sample hospital"

  N_DISC_U                   LENGTH=4
  LABEL="Number of AHA universe discharges in NIS_STRATUM"

  N_HOSP_U                   LENGTH=3
  LABEL="Number of AHA universe hospitals in NIS_STRATUM"

  S_DISC_U                   LENGTH=4
  LABEL="Number of sample discharges in NIS_STRATUM"

  S_HOSP_U                   LENGTH=3
  LABEL="Number of sample hospitals in NIS_STRATUM"

  TOTAL_DISC                 LENGTH=4
  LABEL="Total number of discharges from this hospital in the NIS"

  YEAR                       LENGTH=3
  LABEL="Calendar Year"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      AHAID                    $CHAR7.
      @8      DISCWT                   N11P7F.
      @19     HFIPSSTCO                N5PF.
      @24     HOSPADDR                 $CHAR30.
      @54     HOSPCITY                 $CHAR20.
      @74     HOSPID                   5.
      @79     HOSPNAME                 $CHAR30.
      @109    HOSPST                   $CHAR2.
      @111    HOSPSTCO                 N5PF.
      @116    HOSPWT                   N11P7F.
      @127    HOSPZIP                  $CHAR5.
      @132    HOSP_BEDSIZE             N2PF.
      @134    HOSP_CONTROL             N2PF.
      @136    HOSP_LOCATION            N2PF.
      @138    HOSP_LOCTEACH            N2PF.
      @140    HOSP_REGION              N2PF.
      @142    HOSP_TEACH               N2PF.
      @144    IDNUMBER                 $CHAR6.
      @150    NIS_STRATUM              N4PF.
      @154    N_DISC_U                 N8PF.
      @162    N_HOSP_U                 N4PF.
      @166    S_DISC_U                 N6PF.
      @172    S_HOSP_U                 N4PF.
      @176    TOTAL_DISC               N6PF.
      @182    YEAR                     N4PF.
      ;


RUN;
/*******************************************************************
*   SASload_NIS_2004_Core.SAS:
*      The following SAS code will load the ASCII NIS
*      inpatient stay Core File into SAS.
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
DATA NIS_2004_Core; 
INFILE "%trim(&filepath)NIS/NIS_2004/Data/NIS_2004_Core.ASC" LRECL = 506;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  KEY                        LENGTH=8            FORMAT=Z14.
  LABEL="HCUP record identifier"

  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AGEDAY                     LENGTH=3
  LABEL="Age in days (when age < 1 year)"

  AMONTH                     LENGTH=3
  LABEL="Admission month"

  ASOURCE                    LENGTH=3
  LABEL="Admission source (uniform)"

  ASOURCEUB92                LENGTH=$1
  LABEL="Admission source (UB-92 standard coding)"

  ASOURCE_X                  LENGTH=$8
  LABEL="Admission source (as received from source)"

  ATYPE                      LENGTH=3
  LABEL="Admission type"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED                       LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT                     LENGTH=8
  LABEL="Weight to discharges in AHA universe"

  DISPUB92                   LENGTH=3
  LABEL="Disposition of patient (UB-92 standard coding)"

  DISPUNIFORM                LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRG18                      LENGTH=3
  LABEL="DRG, version 18"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DSHOSPID                   LENGTH=$13
  LABEL="Data source hospital identifier"

  DX1                        LENGTH=$5
  LABEL="Principal diagnosis"

  DX2                        LENGTH=$5
  LABEL="Diagnosis 2"

  DX3                        LENGTH=$5
  LABEL="Diagnosis 3"

  DX4                        LENGTH=$5
  LABEL="Diagnosis 4"

  DX5                        LENGTH=$5
  LABEL="Diagnosis 5"

  DX6                        LENGTH=$5
  LABEL="Diagnosis 6"

  DX7                        LENGTH=$5
  LABEL="Diagnosis 7"

  DX8                        LENGTH=$5
  LABEL="Diagnosis 8"

  DX9                        LENGTH=$5
  LABEL="Diagnosis 9"

  DX10                       LENGTH=$5
  LABEL="Diagnosis 10"

  DX11                       LENGTH=$5
  LABEL="Diagnosis 11"

  DX12                       LENGTH=$5
  LABEL="Diagnosis 12"

  DX13                       LENGTH=$5
  LABEL="Diagnosis 13"

  DX14                       LENGTH=$5
  LABEL="Diagnosis 14"

  DX15                       LENGTH=$5
  LABEL="Diagnosis 15"

  DXCCS1                     LENGTH=4
  LABEL="CCS: principal diagnosis"

  DXCCS2                     LENGTH=4
  LABEL="CCS: diagnosis 2"

  DXCCS3                     LENGTH=4
  LABEL="CCS: diagnosis 3"

  DXCCS4                     LENGTH=4
  LABEL="CCS: diagnosis 4"

  DXCCS5                     LENGTH=4
  LABEL="CCS: diagnosis 5"

  DXCCS6                     LENGTH=4
  LABEL="CCS: diagnosis 6"

  DXCCS7                     LENGTH=4
  LABEL="CCS: diagnosis 7"

  DXCCS8                     LENGTH=4
  LABEL="CCS: diagnosis 8"

  DXCCS9                     LENGTH=4
  LABEL="CCS: diagnosis 9"

  DXCCS10                    LENGTH=4
  LABEL="CCS: diagnosis 10"

  DXCCS11                    LENGTH=4
  LABEL="CCS: diagnosis 11"

  DXCCS12                    LENGTH=4
  LABEL="CCS: diagnosis 12"

  DXCCS13                    LENGTH=4
  LABEL="CCS: diagnosis 13"

  DXCCS14                    LENGTH=4
  LABEL="CCS: diagnosis 14"

  DXCCS15                    LENGTH=4
  LABEL="CCS: diagnosis 15"

  ECODE1                     LENGTH=$5
  LABEL="E code 1"

  ECODE2                     LENGTH=$5
  LABEL="E code 2"

  ECODE3                     LENGTH=$5
  LABEL="E code 3"

  ECODE4                     LENGTH=$5
  LABEL="E code 4"

  E_CCS1                     LENGTH=3
  LABEL="CCS: E Code 1"

  E_CCS2                     LENGTH=3
  LABEL="CCS: E Code 2"

  E_CCS3                     LENGTH=3
  LABEL="CCS: E Code 3"

  E_CCS4                     LENGTH=3
  LABEL="CCS: E Code 4"

  ELECTIVE                   LENGTH=3
  LABEL="Elective versus non-elective admission"

  FEMALE                     LENGTH=3
  LABEL="Indicator of sex"

  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPST                     LENGTH=$2
  LABEL="Hospital state postal code"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  LOS_X                      LENGTH=4
  LABEL="Length of stay (as received from source)"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC18                      LENGTH=3
  LABEL="MDC, version 18"

  MDNUM1_R                   LENGTH=5
  LABEL="Physician 1 number (re-identified)"

  MDNUM2_R                   LENGTH=5
  LABEL="Physician 2 number (re-identified)"

  NDX                        LENGTH=3
  LABEL="Number of diagnoses on this record"

  NECODE                     LENGTH=3
  LABEL="Number of E codes on this record"

  NEOMAT                     LENGTH=3
  LABEL="Neonatal and/or maternal DX and/or PR"

  NIS_STRATUM                LENGTH=3            FORMAT=4.
  LABEL="Stratum used to sample hospital"

  NPR                        LENGTH=3
  LABEL="Number of procedures on this record"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY1_X                     LENGTH=$10
  LABEL="Primary expected payer (as received from source)"

  PAY2                       LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PAY2_X                     LENGTH=$10
  LABEL="Secondary expected payer (as received from source)"

  PL_UR_CAT4                 LENGTH=3
  LABEL="Patient Location: Urban-Rural 4 Categories"

  PR1                        LENGTH=$4
  LABEL="Principal procedure"

  PR2                        LENGTH=$4
  LABEL="Procedure 2"

  PR3                        LENGTH=$4
  LABEL="Procedure 3"

  PR4                        LENGTH=$4
  LABEL="Procedure 4"

  PR5                        LENGTH=$4
  LABEL="Procedure 5"

  PR6                        LENGTH=$4
  LABEL="Procedure 6"

  PR7                        LENGTH=$4
  LABEL="Procedure 7"

  PR8                        LENGTH=$4
  LABEL="Procedure 8"

  PR9                        LENGTH=$4
  LABEL="Procedure 9"

  PR10                       LENGTH=$4
  LABEL="Procedure 10"

  PR11                       LENGTH=$4
  LABEL="Procedure 11"

  PR12                       LENGTH=$4
  LABEL="Procedure 12"

  PR13                       LENGTH=$4
  LABEL="Procedure 13"

  PR14                       LENGTH=$4
  LABEL="Procedure 14"

  PR15                       LENGTH=$4
  LABEL="Procedure 15"

  PRCCS1                     LENGTH=3
  LABEL="CCS: principal procedure"

  PRCCS2                     LENGTH=3
  LABEL="CCS: procedure 2"

  PRCCS3                     LENGTH=3
  LABEL="CCS: procedure 3"

  PRCCS4                     LENGTH=3
  LABEL="CCS: procedure 4"

  PRCCS5                     LENGTH=3
  LABEL="CCS: procedure 5"

  PRCCS6                     LENGTH=3
  LABEL="CCS: procedure 6"

  PRCCS7                     LENGTH=3
  LABEL="CCS: procedure 7"

  PRCCS8                     LENGTH=3
  LABEL="CCS: procedure 8"

  PRCCS9                     LENGTH=3
  LABEL="CCS: procedure 9"

  PRCCS10                    LENGTH=3
  LABEL="CCS: procedure 10"

  PRCCS11                    LENGTH=3
  LABEL="CCS: procedure 11"

  PRCCS12                    LENGTH=3
  LABEL="CCS: procedure 12"

  PRCCS13                    LENGTH=3
  LABEL="CCS: procedure 13"

  PRCCS14                    LENGTH=3
  LABEL="CCS: procedure 14"

  PRCCS15                    LENGTH=3
  LABEL="CCS: procedure 15"

  PRDAY1                     LENGTH=4
  LABEL="Number of days from admission to PR1"

  PRDAY2                     LENGTH=4
  LABEL="Number of days from admission to PR2"

  PRDAY3                     LENGTH=4
  LABEL="Number of days from admission to PR3"

  PRDAY4                     LENGTH=4
  LABEL="Number of days from admission to PR4"

  PRDAY5                     LENGTH=4
  LABEL="Number of days from admission to PR5"

  PRDAY6                     LENGTH=4
  LABEL="Number of days from admission to PR6"

  PRDAY7                     LENGTH=4
  LABEL="Number of days from admission to PR7"

  PRDAY8                     LENGTH=4
  LABEL="Number of days from admission to PR8"

  PRDAY9                     LENGTH=4
  LABEL="Number of days from admission to PR9"

  PRDAY10                    LENGTH=4
  LABEL="Number of days from admission to PR10"

  PRDAY11                    LENGTH=4
  LABEL="Number of days from admission to PR11"

  PRDAY12                    LENGTH=4
  LABEL="Number of days from admission to PR12"

  PRDAY13                    LENGTH=4
  LABEL="Number of days from admission to PR13"

  PRDAY14                    LENGTH=4
  LABEL="Number of days from admission to PR14"

  PRDAY15                    LENGTH=4
  LABEL="Number of days from admission to PR15"

  RACE                       LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG                     LENGTH=6
  LABEL="Total charges (cleaned)"

  TOTCHG_X                   LENGTH=7
  LABEL="Total charges (as received from source)"

  YEAR                       LENGTH=3
  LABEL="Calendar year"

  ZIPInc_Qrtl                LENGTH=3
  LABEL="Median household income quartile for patient's ZIP Code"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      KEY                      14.
      @15     AGE                      N3PF.
      @18     AGEDAY                   N3PF.
      @21     AMONTH                   N2PF.
      @23     ASOURCE                  N2PF.
      @25     ASOURCEUB92              $CHAR1.
      @26     ASOURCE_X                $CHAR8.
      @34     ATYPE                    N2PF.
      @36     AWEEKEND                 N2PF.
      @38     DIED                     N2PF.
      @40     DISCWT                   N11P7F.
      @51     DISPUB92                 N2PF.
      @53     DISPUNIFORM              N2PF.
      @55     DQTR                     N2PF.
      @57     DRG                      N3PF.
      @60     DRG18                    N3PF.
      @63     DRGVER                   N2PF.
      @65     DSHOSPID                 $CHAR13.
      @78     DX1                      $CHAR5.
      @83     DX2                      $CHAR5.
      @88     DX3                      $CHAR5.
      @93     DX4                      $CHAR5.
      @98     DX5                      $CHAR5.
      @103    DX6                      $CHAR5.
      @108    DX7                      $CHAR5.
      @113    DX8                      $CHAR5.
      @118    DX9                      $CHAR5.
      @123    DX10                     $CHAR5.
      @128    DX11                     $CHAR5.
      @133    DX12                     $CHAR5.
      @138    DX13                     $CHAR5.
      @143    DX14                     $CHAR5.
      @148    DX15                     $CHAR5.
      @153    DXCCS1                   N4PF.
      @157    DXCCS2                   N4PF.
      @161    DXCCS3                   N4PF.
      @165    DXCCS4                   N4PF.
      @169    DXCCS5                   N4PF.
      @173    DXCCS6                   N4PF.
      @177    DXCCS7                   N4PF.
      @181    DXCCS8                   N4PF.
      @185    DXCCS9                   N4PF.
      @189    DXCCS10                  N4PF.
      @193    DXCCS11                  N4PF.
      @197    DXCCS12                  N4PF.
      @201    DXCCS13                  N4PF.
      @205    DXCCS14                  N4PF.
      @209    DXCCS15                  N4PF.
      @213    ECODE1                   $CHAR5.
      @218    ECODE2                   $CHAR5.
      @223    ECODE3                   $CHAR5.
      @228    ECODE4                   $CHAR5.
      @233    E_CCS1                   N4PF.
      @237    E_CCS2                   N4PF.
      @241    E_CCS3                   N4PF.
      @245    E_CCS4                   N4PF.
      @249    ELECTIVE                 N2PF.
      @251    FEMALE                   N2PF.
      @253    HOSPID                   5.
      @258    HOSPST                   $CHAR2.
      @260    LOS                      N5PF.
      @265    LOS_X                    N6PF.
      @271    MDC                      N2PF.
      @273    MDC18                    N2PF.
      @275    MDNUM1_R                 N5PF.
      @280    MDNUM2_R                 N5PF.
      @285    NDX                      N2PF.
      @287    NECODE                   N3PF.
      @290    NEOMAT                   N2PF.
      @292    NIS_STRATUM              N4PF.
      @296    NPR                      N2PF.
      @298    PAY1                     N2PF.
      @300    PAY1_X                   $CHAR10.
      @310    PAY2                     N2PF.
      @312    PAY2_X                   $CHAR10.
      @322    PL_UR_CAT4               N2PF.
      @324    PR1                      $CHAR4.
      @328    PR2                      $CHAR4.
      @332    PR3                      $CHAR4.
      @336    PR4                      $CHAR4.
      @340    PR5                      $CHAR4.
      @344    PR6                      $CHAR4.
      @348    PR7                      $CHAR4.
      @352    PR8                      $CHAR4.
      @356    PR9                      $CHAR4.
      @360    PR10                     $CHAR4.
      @364    PR11                     $CHAR4.
      @368    PR12                     $CHAR4.
      @372    PR13                     $CHAR4.
      @376    PR14                     $CHAR4.
      @380    PR15                     $CHAR4.
      @384    PRCCS1                   N3PF.
      @387    PRCCS2                   N3PF.
      @390    PRCCS3                   N3PF.
      @393    PRCCS4                   N3PF.
      @396    PRCCS5                   N3PF.
      @399    PRCCS6                   N3PF.
      @402    PRCCS7                   N3PF.
      @405    PRCCS8                   N3PF.
      @408    PRCCS9                   N3PF.
      @411    PRCCS10                  N3PF.
      @414    PRCCS11                  N3PF.
      @417    PRCCS12                  N3PF.
      @420    PRCCS13                  N3PF.
      @423    PRCCS14                  N3PF.
      @426    PRCCS15                  N3PF.
      @429    PRDAY1                   N3PF.
      @432    PRDAY2                   N3PF.
      @435    PRDAY3                   N3PF.
      @438    PRDAY4                   N3PF.
      @441    PRDAY5                   N3PF.
      @444    PRDAY6                   N3PF.
      @447    PRDAY7                   N3PF.
      @450    PRDAY8                   N3PF.
      @453    PRDAY9                   N3PF.
      @456    PRDAY10                  N3PF.
      @459    PRDAY11                  N3PF.
      @462    PRDAY12                  N3PF.
      @465    PRDAY13                  N3PF.
      @468    PRDAY14                  N3PF.
      @471    PRDAY15                  N3PF.
      @474    RACE                     N2PF.
      @476    TOTCHG                   N10PF.
      @486    TOTCHG_X                 N15P2F.
      @501    YEAR                     N4PF.
      @505    ZIPInc_Qrtl              N2PF.
      ;


RUN;
/*******************************************************************
*   SASload_NIS_2004_10Pct_Sample_B.SAS:
*      The following SAS code will load the ASCII NIS
*      inpatient stay 10Pct_Sample_B File into SAS.
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
DATA NIS_2004_10Pct_Sample_B; 
INFILE "%trim(&filepath)NIS/NIS_2004/Data/NIS_2004_10Pct_Sample_B.ASC" LRECL = 506;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  KEY                        LENGTH=8            FORMAT=Z14.
  LABEL="HCUP record identifier"

  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AGEDAY                     LENGTH=3
  LABEL="Age in days (when age < 1 year)"

  AMONTH                     LENGTH=3
  LABEL="Admission month"

  ASOURCE                    LENGTH=3
  LABEL="Admission source (uniform)"

  ASOURCEUB92                LENGTH=$1
  LABEL="Admission source (UB-92 standard coding)"

  ASOURCE_X                  LENGTH=$8
  LABEL="Admission source (as received from source)"

  ATYPE                      LENGTH=3
  LABEL="Admission type"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED                       LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT10                   LENGTH=8
  LABEL="10% subsample weight to discharges in AHA universe"

  DISPUB92                   LENGTH=3
  LABEL="Disposition of patient (UB-92 standard coding)"

  DISPUNIFORM                LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRG18                      LENGTH=3
  LABEL="DRG, version 18"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DSHOSPID                   LENGTH=$13
  LABEL="Data source hospital identifier"

  DX1                        LENGTH=$5
  LABEL="Principal diagnosis"

  DX2                        LENGTH=$5
  LABEL="Diagnosis 2"

  DX3                        LENGTH=$5
  LABEL="Diagnosis 3"

  DX4                        LENGTH=$5
  LABEL="Diagnosis 4"

  DX5                        LENGTH=$5
  LABEL="Diagnosis 5"

  DX6                        LENGTH=$5
  LABEL="Diagnosis 6"

  DX7                        LENGTH=$5
  LABEL="Diagnosis 7"

  DX8                        LENGTH=$5
  LABEL="Diagnosis 8"

  DX9                        LENGTH=$5
  LABEL="Diagnosis 9"

  DX10                       LENGTH=$5
  LABEL="Diagnosis 10"

  DX11                       LENGTH=$5
  LABEL="Diagnosis 11"

  DX12                       LENGTH=$5
  LABEL="Diagnosis 12"

  DX13                       LENGTH=$5
  LABEL="Diagnosis 13"

  DX14                       LENGTH=$5
  LABEL="Diagnosis 14"

  DX15                       LENGTH=$5
  LABEL="Diagnosis 15"

  DXCCS1                     LENGTH=4
  LABEL="CCS: principal diagnosis"

  DXCCS2                     LENGTH=4
  LABEL="CCS: diagnosis 2"

  DXCCS3                     LENGTH=4
  LABEL="CCS: diagnosis 3"

  DXCCS4                     LENGTH=4
  LABEL="CCS: diagnosis 4"

  DXCCS5                     LENGTH=4
  LABEL="CCS: diagnosis 5"

  DXCCS6                     LENGTH=4
  LABEL="CCS: diagnosis 6"

  DXCCS7                     LENGTH=4
  LABEL="CCS: diagnosis 7"

  DXCCS8                     LENGTH=4
  LABEL="CCS: diagnosis 8"

  DXCCS9                     LENGTH=4
  LABEL="CCS: diagnosis 9"

  DXCCS10                    LENGTH=4
  LABEL="CCS: diagnosis 10"

  DXCCS11                    LENGTH=4
  LABEL="CCS: diagnosis 11"

  DXCCS12                    LENGTH=4
  LABEL="CCS: diagnosis 12"

  DXCCS13                    LENGTH=4
  LABEL="CCS: diagnosis 13"

  DXCCS14                    LENGTH=4
  LABEL="CCS: diagnosis 14"

  DXCCS15                    LENGTH=4
  LABEL="CCS: diagnosis 15"

  ECODE1                     LENGTH=$5
  LABEL="E code 1"

  ECODE2                     LENGTH=$5
  LABEL="E code 2"

  ECODE3                     LENGTH=$5
  LABEL="E code 3"

  ECODE4                     LENGTH=$5
  LABEL="E code 4"

  E_CCS1                     LENGTH=3
  LABEL="CCS: E Code 1"

  E_CCS2                     LENGTH=3
  LABEL="CCS: E Code 2"

  E_CCS3                     LENGTH=3
  LABEL="CCS: E Code 3"

  E_CCS4                     LENGTH=3
  LABEL="CCS: E Code 4"

  ELECTIVE                   LENGTH=3
  LABEL="Elective versus non-elective admission"

  FEMALE                     LENGTH=3
  LABEL="Indicator of sex"

  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPST                     LENGTH=$2
  LABEL="Hospital state postal code"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  LOS_X                      LENGTH=4
  LABEL="Length of stay (as received from source)"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC18                      LENGTH=3
  LABEL="MDC, version 18"

  MDNUM1_R                   LENGTH=5
  LABEL="Physician 1 number (re-identified)"

  MDNUM2_R                   LENGTH=5
  LABEL="Physician 2 number (re-identified)"

  NDX                        LENGTH=3
  LABEL="Number of diagnoses on this record"

  NECODE                     LENGTH=3
  LABEL="Number of E codes on this record"

  NEOMAT                     LENGTH=3
  LABEL="Neonatal and/or maternal DX and/or PR"

  NIS_STRATUM                LENGTH=3            FORMAT=4.
  LABEL="Stratum used to sample hospital"

  NPR                        LENGTH=3
  LABEL="Number of procedures on this record"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY1_X                     LENGTH=$10
  LABEL="Primary expected payer (as received from source)"

  PAY2                       LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PAY2_X                     LENGTH=$10
  LABEL="Secondary expected payer (as received from source)"

  PL_UR_CAT4                 LENGTH=3
  LABEL="Patient Location: Urban-Rural 4 Categories"

  PR1                        LENGTH=$4
  LABEL="Principal procedure"

  PR2                        LENGTH=$4
  LABEL="Procedure 2"

  PR3                        LENGTH=$4
  LABEL="Procedure 3"

  PR4                        LENGTH=$4
  LABEL="Procedure 4"

  PR5                        LENGTH=$4
  LABEL="Procedure 5"

  PR6                        LENGTH=$4
  LABEL="Procedure 6"

  PR7                        LENGTH=$4
  LABEL="Procedure 7"

  PR8                        LENGTH=$4
  LABEL="Procedure 8"

  PR9                        LENGTH=$4
  LABEL="Procedure 9"

  PR10                       LENGTH=$4
  LABEL="Procedure 10"

  PR11                       LENGTH=$4
  LABEL="Procedure 11"

  PR12                       LENGTH=$4
  LABEL="Procedure 12"

  PR13                       LENGTH=$4
  LABEL="Procedure 13"

  PR14                       LENGTH=$4
  LABEL="Procedure 14"

  PR15                       LENGTH=$4
  LABEL="Procedure 15"

  PRCCS1                     LENGTH=3
  LABEL="CCS: principal procedure"

  PRCCS2                     LENGTH=3
  LABEL="CCS: procedure 2"

  PRCCS3                     LENGTH=3
  LABEL="CCS: procedure 3"

  PRCCS4                     LENGTH=3
  LABEL="CCS: procedure 4"

  PRCCS5                     LENGTH=3
  LABEL="CCS: procedure 5"

  PRCCS6                     LENGTH=3
  LABEL="CCS: procedure 6"

  PRCCS7                     LENGTH=3
  LABEL="CCS: procedure 7"

  PRCCS8                     LENGTH=3
  LABEL="CCS: procedure 8"

  PRCCS9                     LENGTH=3
  LABEL="CCS: procedure 9"

  PRCCS10                    LENGTH=3
  LABEL="CCS: procedure 10"

  PRCCS11                    LENGTH=3
  LABEL="CCS: procedure 11"

  PRCCS12                    LENGTH=3
  LABEL="CCS: procedure 12"

  PRCCS13                    LENGTH=3
  LABEL="CCS: procedure 13"

  PRCCS14                    LENGTH=3
  LABEL="CCS: procedure 14"

  PRCCS15                    LENGTH=3
  LABEL="CCS: procedure 15"

  PRDAY1                     LENGTH=4
  LABEL="Number of days from admission to PR1"

  PRDAY2                     LENGTH=4
  LABEL="Number of days from admission to PR2"

  PRDAY3                     LENGTH=4
  LABEL="Number of days from admission to PR3"

  PRDAY4                     LENGTH=4
  LABEL="Number of days from admission to PR4"

  PRDAY5                     LENGTH=4
  LABEL="Number of days from admission to PR5"

  PRDAY6                     LENGTH=4
  LABEL="Number of days from admission to PR6"

  PRDAY7                     LENGTH=4
  LABEL="Number of days from admission to PR7"

  PRDAY8                     LENGTH=4
  LABEL="Number of days from admission to PR8"

  PRDAY9                     LENGTH=4
  LABEL="Number of days from admission to PR9"

  PRDAY10                    LENGTH=4
  LABEL="Number of days from admission to PR10"

  PRDAY11                    LENGTH=4
  LABEL="Number of days from admission to PR11"

  PRDAY12                    LENGTH=4
  LABEL="Number of days from admission to PR12"

  PRDAY13                    LENGTH=4
  LABEL="Number of days from admission to PR13"

  PRDAY14                    LENGTH=4
  LABEL="Number of days from admission to PR14"

  PRDAY15                    LENGTH=4
  LABEL="Number of days from admission to PR15"

  RACE                       LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG                     LENGTH=6
  LABEL="Total charges (cleaned)"

  TOTCHG_X                   LENGTH=7
  LABEL="Total charges (as received from source)"

  YEAR                       LENGTH=3
  LABEL="Calendar year"

  ZIPInc_Qrtl                LENGTH=3
  LABEL="Median household income quartile for patient's ZIP Code"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      KEY                      14.
      @15     AGE                      N3PF.
      @18     AGEDAY                   N3PF.
      @21     AMONTH                   N2PF.
      @23     ASOURCE                  N2PF.
      @25     ASOURCEUB92              $CHAR1.
      @26     ASOURCE_X                $CHAR8.
      @34     ATYPE                    N2PF.
      @36     AWEEKEND                 N2PF.
      @38     DIED                     N2PF.
      @40     DISCWT10                 N11P7F.
      @51     DISPUB92                 N2PF.
      @53     DISPUNIFORM              N2PF.
      @55     DQTR                     N2PF.
      @57     DRG                      N3PF.
      @60     DRG18                    N3PF.
      @63     DRGVER                   N2PF.
      @65     DSHOSPID                 $CHAR13.
      @78     DX1                      $CHAR5.
      @83     DX2                      $CHAR5.
      @88     DX3                      $CHAR5.
      @93     DX4                      $CHAR5.
      @98     DX5                      $CHAR5.
      @103    DX6                      $CHAR5.
      @108    DX7                      $CHAR5.
      @113    DX8                      $CHAR5.
      @118    DX9                      $CHAR5.
      @123    DX10                     $CHAR5.
      @128    DX11                     $CHAR5.
      @133    DX12                     $CHAR5.
      @138    DX13                     $CHAR5.
      @143    DX14                     $CHAR5.
      @148    DX15                     $CHAR5.
      @153    DXCCS1                   N4PF.
      @157    DXCCS2                   N4PF.
      @161    DXCCS3                   N4PF.
      @165    DXCCS4                   N4PF.
      @169    DXCCS5                   N4PF.
      @173    DXCCS6                   N4PF.
      @177    DXCCS7                   N4PF.
      @181    DXCCS8                   N4PF.
      @185    DXCCS9                   N4PF.
      @189    DXCCS10                  N4PF.
      @193    DXCCS11                  N4PF.
      @197    DXCCS12                  N4PF.
      @201    DXCCS13                  N4PF.
      @205    DXCCS14                  N4PF.
      @209    DXCCS15                  N4PF.
      @213    ECODE1                   $CHAR5.
      @218    ECODE2                   $CHAR5.
      @223    ECODE3                   $CHAR5.
      @228    ECODE4                   $CHAR5.
      @233    E_CCS1                   N4PF.
      @237    E_CCS2                   N4PF.
      @241    E_CCS3                   N4PF.
      @245    E_CCS4                   N4PF.
      @249    ELECTIVE                 N2PF.
      @251    FEMALE                   N2PF.
      @253    HOSPID                   5.
      @258    HOSPST                   $CHAR2.
      @260    LOS                      N5PF.
      @265    LOS_X                    N6PF.
      @271    MDC                      N2PF.
      @273    MDC18                    N2PF.
      @275    MDNUM1_R                 N5PF.
      @280    MDNUM2_R                 N5PF.
      @285    NDX                      N2PF.
      @287    NECODE                   N3PF.
      @290    NEOMAT                   N2PF.
      @292    NIS_STRATUM              N4PF.
      @296    NPR                      N2PF.
      @298    PAY1                     N2PF.
      @300    PAY1_X                   $CHAR10.
      @310    PAY2                     N2PF.
      @312    PAY2_X                   $CHAR10.
      @322    PL_UR_CAT4               N2PF.
      @324    PR1                      $CHAR4.
      @328    PR2                      $CHAR4.
      @332    PR3                      $CHAR4.
      @336    PR4                      $CHAR4.
      @340    PR5                      $CHAR4.
      @344    PR6                      $CHAR4.
      @348    PR7                      $CHAR4.
      @352    PR8                      $CHAR4.
      @356    PR9                      $CHAR4.
      @360    PR10                     $CHAR4.
      @364    PR11                     $CHAR4.
      @368    PR12                     $CHAR4.
      @372    PR13                     $CHAR4.
      @376    PR14                     $CHAR4.
      @380    PR15                     $CHAR4.
      @384    PRCCS1                   N3PF.
      @387    PRCCS2                   N3PF.
      @390    PRCCS3                   N3PF.
      @393    PRCCS4                   N3PF.
      @396    PRCCS5                   N3PF.
      @399    PRCCS6                   N3PF.
      @402    PRCCS7                   N3PF.
      @405    PRCCS8                   N3PF.
      @408    PRCCS9                   N3PF.
      @411    PRCCS10                  N3PF.
      @414    PRCCS11                  N3PF.
      @417    PRCCS12                  N3PF.
      @420    PRCCS13                  N3PF.
      @423    PRCCS14                  N3PF.
      @426    PRCCS15                  N3PF.
      @429    PRDAY1                   N3PF.
      @432    PRDAY2                   N3PF.
      @435    PRDAY3                   N3PF.
      @438    PRDAY4                   N3PF.
      @441    PRDAY5                   N3PF.
      @444    PRDAY6                   N3PF.
      @447    PRDAY7                   N3PF.
      @450    PRDAY8                   N3PF.
      @453    PRDAY9                   N3PF.
      @456    PRDAY10                  N3PF.
      @459    PRDAY11                  N3PF.
      @462    PRDAY12                  N3PF.
      @465    PRDAY13                  N3PF.
      @468    PRDAY14                  N3PF.
      @471    PRDAY15                  N3PF.
      @474    RACE                     N2PF.
      @476    TOTCHG                   N10PF.
      @486    TOTCHG_X                 N15P2F.
      @501    YEAR                     N4PF.
      @505    ZIPInc_Qrtl              N2PF.
      ;


RUN;
/*******************************************************************
*   SASload_NIS_2004_10Pct_Sample_A.SAS:
*      The following SAS code will load the ASCII NIS
*      inpatient stay 10Pct_Sample_A File into SAS.
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
DATA NIS_2004_10Pct_Sample_A; 
INFILE "%trim(&filepath)NIS/NIS_2004/Data/NIS_2004_10Pct_Sample_A.ASC" LRECL = 506;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  KEY                        LENGTH=8            FORMAT=Z14.
  LABEL="HCUP record identifier"

  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AGEDAY                     LENGTH=3
  LABEL="Age in days (when age < 1 year)"

  AMONTH                     LENGTH=3
  LABEL="Admission month"

  ASOURCE                    LENGTH=3
  LABEL="Admission source (uniform)"

  ASOURCEUB92                LENGTH=$1
  LABEL="Admission source (UB-92 standard coding)"

  ASOURCE_X                  LENGTH=$8
  LABEL="Admission source (as received from source)"

  ATYPE                      LENGTH=3
  LABEL="Admission type"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED                       LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT10                   LENGTH=8
  LABEL="10% subsample weight to discharges in AHA universe"

  DISPUB92                   LENGTH=3
  LABEL="Disposition of patient (UB-92 standard coding)"

  DISPUNIFORM                LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRG18                      LENGTH=3
  LABEL="DRG, version 18"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DSHOSPID                   LENGTH=$13
  LABEL="Data source hospital identifier"

  DX1                        LENGTH=$5
  LABEL="Principal diagnosis"

  DX2                        LENGTH=$5
  LABEL="Diagnosis 2"

  DX3                        LENGTH=$5
  LABEL="Diagnosis 3"

  DX4                        LENGTH=$5
  LABEL="Diagnosis 4"

  DX5                        LENGTH=$5
  LABEL="Diagnosis 5"

  DX6                        LENGTH=$5
  LABEL="Diagnosis 6"

  DX7                        LENGTH=$5
  LABEL="Diagnosis 7"

  DX8                        LENGTH=$5
  LABEL="Diagnosis 8"

  DX9                        LENGTH=$5
  LABEL="Diagnosis 9"

  DX10                       LENGTH=$5
  LABEL="Diagnosis 10"

  DX11                       LENGTH=$5
  LABEL="Diagnosis 11"

  DX12                       LENGTH=$5
  LABEL="Diagnosis 12"

  DX13                       LENGTH=$5
  LABEL="Diagnosis 13"

  DX14                       LENGTH=$5
  LABEL="Diagnosis 14"

  DX15                       LENGTH=$5
  LABEL="Diagnosis 15"

  DXCCS1                     LENGTH=4
  LABEL="CCS: principal diagnosis"

  DXCCS2                     LENGTH=4
  LABEL="CCS: diagnosis 2"

  DXCCS3                     LENGTH=4
  LABEL="CCS: diagnosis 3"

  DXCCS4                     LENGTH=4
  LABEL="CCS: diagnosis 4"

  DXCCS5                     LENGTH=4
  LABEL="CCS: diagnosis 5"

  DXCCS6                     LENGTH=4
  LABEL="CCS: diagnosis 6"

  DXCCS7                     LENGTH=4
  LABEL="CCS: diagnosis 7"

  DXCCS8                     LENGTH=4
  LABEL="CCS: diagnosis 8"

  DXCCS9                     LENGTH=4
  LABEL="CCS: diagnosis 9"

  DXCCS10                    LENGTH=4
  LABEL="CCS: diagnosis 10"

  DXCCS11                    LENGTH=4
  LABEL="CCS: diagnosis 11"

  DXCCS12                    LENGTH=4
  LABEL="CCS: diagnosis 12"

  DXCCS13                    LENGTH=4
  LABEL="CCS: diagnosis 13"

  DXCCS14                    LENGTH=4
  LABEL="CCS: diagnosis 14"

  DXCCS15                    LENGTH=4
  LABEL="CCS: diagnosis 15"

  ECODE1                     LENGTH=$5
  LABEL="E code 1"

  ECODE2                     LENGTH=$5
  LABEL="E code 2"

  ECODE3                     LENGTH=$5
  LABEL="E code 3"

  ECODE4                     LENGTH=$5
  LABEL="E code 4"

  E_CCS1                     LENGTH=3
  LABEL="CCS: E Code 1"

  E_CCS2                     LENGTH=3
  LABEL="CCS: E Code 2"

  E_CCS3                     LENGTH=3
  LABEL="CCS: E Code 3"

  E_CCS4                     LENGTH=3
  LABEL="CCS: E Code 4"

  ELECTIVE                   LENGTH=3
  LABEL="Elective versus non-elective admission"

  FEMALE                     LENGTH=3
  LABEL="Indicator of sex"

  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPST                     LENGTH=$2
  LABEL="Hospital state postal code"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  LOS_X                      LENGTH=4
  LABEL="Length of stay (as received from source)"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC18                      LENGTH=3
  LABEL="MDC, version 18"

  MDNUM1_R                   LENGTH=5
  LABEL="Physician 1 number (re-identified)"

  MDNUM2_R                   LENGTH=5
  LABEL="Physician 2 number (re-identified)"

  NDX                        LENGTH=3
  LABEL="Number of diagnoses on this record"

  NECODE                     LENGTH=3
  LABEL="Number of E codes on this record"

  NEOMAT                     LENGTH=3
  LABEL="Neonatal and/or maternal DX and/or PR"

  NIS_STRATUM                LENGTH=3            FORMAT=4.
  LABEL="Stratum used to sample hospital"

  NPR                        LENGTH=3
  LABEL="Number of procedures on this record"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY1_X                     LENGTH=$10
  LABEL="Primary expected payer (as received from source)"

  PAY2                       LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PAY2_X                     LENGTH=$10
  LABEL="Secondary expected payer (as received from source)"

  PL_UR_CAT4                 LENGTH=3
  LABEL="Patient Location: Urban-Rural 4 Categories"

  PR1                        LENGTH=$4
  LABEL="Principal procedure"

  PR2                        LENGTH=$4
  LABEL="Procedure 2"

  PR3                        LENGTH=$4
  LABEL="Procedure 3"

  PR4                        LENGTH=$4
  LABEL="Procedure 4"

  PR5                        LENGTH=$4
  LABEL="Procedure 5"

  PR6                        LENGTH=$4
  LABEL="Procedure 6"

  PR7                        LENGTH=$4
  LABEL="Procedure 7"

  PR8                        LENGTH=$4
  LABEL="Procedure 8"

  PR9                        LENGTH=$4
  LABEL="Procedure 9"

  PR10                       LENGTH=$4
  LABEL="Procedure 10"

  PR11                       LENGTH=$4
  LABEL="Procedure 11"

  PR12                       LENGTH=$4
  LABEL="Procedure 12"

  PR13                       LENGTH=$4
  LABEL="Procedure 13"

  PR14                       LENGTH=$4
  LABEL="Procedure 14"

  PR15                       LENGTH=$4
  LABEL="Procedure 15"

  PRCCS1                     LENGTH=3
  LABEL="CCS: principal procedure"

  PRCCS2                     LENGTH=3
  LABEL="CCS: procedure 2"

  PRCCS3                     LENGTH=3
  LABEL="CCS: procedure 3"

  PRCCS4                     LENGTH=3
  LABEL="CCS: procedure 4"

  PRCCS5                     LENGTH=3
  LABEL="CCS: procedure 5"

  PRCCS6                     LENGTH=3
  LABEL="CCS: procedure 6"

  PRCCS7                     LENGTH=3
  LABEL="CCS: procedure 7"

  PRCCS8                     LENGTH=3
  LABEL="CCS: procedure 8"

  PRCCS9                     LENGTH=3
  LABEL="CCS: procedure 9"

  PRCCS10                    LENGTH=3
  LABEL="CCS: procedure 10"

  PRCCS11                    LENGTH=3
  LABEL="CCS: procedure 11"

  PRCCS12                    LENGTH=3
  LABEL="CCS: procedure 12"

  PRCCS13                    LENGTH=3
  LABEL="CCS: procedure 13"

  PRCCS14                    LENGTH=3
  LABEL="CCS: procedure 14"

  PRCCS15                    LENGTH=3
  LABEL="CCS: procedure 15"

  PRDAY1                     LENGTH=4
  LABEL="Number of days from admission to PR1"

  PRDAY2                     LENGTH=4
  LABEL="Number of days from admission to PR2"

  PRDAY3                     LENGTH=4
  LABEL="Number of days from admission to PR3"

  PRDAY4                     LENGTH=4
  LABEL="Number of days from admission to PR4"

  PRDAY5                     LENGTH=4
  LABEL="Number of days from admission to PR5"

  PRDAY6                     LENGTH=4
  LABEL="Number of days from admission to PR6"

  PRDAY7                     LENGTH=4
  LABEL="Number of days from admission to PR7"

  PRDAY8                     LENGTH=4
  LABEL="Number of days from admission to PR8"

  PRDAY9                     LENGTH=4
  LABEL="Number of days from admission to PR9"

  PRDAY10                    LENGTH=4
  LABEL="Number of days from admission to PR10"

  PRDAY11                    LENGTH=4
  LABEL="Number of days from admission to PR11"

  PRDAY12                    LENGTH=4
  LABEL="Number of days from admission to PR12"

  PRDAY13                    LENGTH=4
  LABEL="Number of days from admission to PR13"

  PRDAY14                    LENGTH=4
  LABEL="Number of days from admission to PR14"

  PRDAY15                    LENGTH=4
  LABEL="Number of days from admission to PR15"

  RACE                       LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG                     LENGTH=6
  LABEL="Total charges (cleaned)"

  TOTCHG_X                   LENGTH=7
  LABEL="Total charges (as received from source)"

  YEAR                       LENGTH=3
  LABEL="Calendar year"

  ZIPInc_Qrtl                LENGTH=3
  LABEL="Median household income quartile for patient's ZIP Code"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      KEY                      14.
      @15     AGE                      N3PF.
      @18     AGEDAY                   N3PF.
      @21     AMONTH                   N2PF.
      @23     ASOURCE                  N2PF.
      @25     ASOURCEUB92              $CHAR1.
      @26     ASOURCE_X                $CHAR8.
      @34     ATYPE                    N2PF.
      @36     AWEEKEND                 N2PF.
      @38     DIED                     N2PF.
      @40     DISCWT10                 N11P7F.
      @51     DISPUB92                 N2PF.
      @53     DISPUNIFORM              N2PF.
      @55     DQTR                     N2PF.
      @57     DRG                      N3PF.
      @60     DRG18                    N3PF.
      @63     DRGVER                   N2PF.
      @65     DSHOSPID                 $CHAR13.
      @78     DX1                      $CHAR5.
      @83     DX2                      $CHAR5.
      @88     DX3                      $CHAR5.
      @93     DX4                      $CHAR5.
      @98     DX5                      $CHAR5.
      @103    DX6                      $CHAR5.
      @108    DX7                      $CHAR5.
      @113    DX8                      $CHAR5.
      @118    DX9                      $CHAR5.
      @123    DX10                     $CHAR5.
      @128    DX11                     $CHAR5.
      @133    DX12                     $CHAR5.
      @138    DX13                     $CHAR5.
      @143    DX14                     $CHAR5.
      @148    DX15                     $CHAR5.
      @153    DXCCS1                   N4PF.
      @157    DXCCS2                   N4PF.
      @161    DXCCS3                   N4PF.
      @165    DXCCS4                   N4PF.
      @169    DXCCS5                   N4PF.
      @173    DXCCS6                   N4PF.
      @177    DXCCS7                   N4PF.
      @181    DXCCS8                   N4PF.
      @185    DXCCS9                   N4PF.
      @189    DXCCS10                  N4PF.
      @193    DXCCS11                  N4PF.
      @197    DXCCS12                  N4PF.
      @201    DXCCS13                  N4PF.
      @205    DXCCS14                  N4PF.
      @209    DXCCS15                  N4PF.
      @213    ECODE1                   $CHAR5.
      @218    ECODE2                   $CHAR5.
      @223    ECODE3                   $CHAR5.
      @228    ECODE4                   $CHAR5.
      @233    E_CCS1                   N4PF.
      @237    E_CCS2                   N4PF.
      @241    E_CCS3                   N4PF.
      @245    E_CCS4                   N4PF.
      @249    ELECTIVE                 N2PF.
      @251    FEMALE                   N2PF.
      @253    HOSPID                   5.
      @258    HOSPST                   $CHAR2.
      @260    LOS                      N5PF.
      @265    LOS_X                    N6PF.
      @271    MDC                      N2PF.
      @273    MDC18                    N2PF.
      @275    MDNUM1_R                 N5PF.
      @280    MDNUM2_R                 N5PF.
      @285    NDX                      N2PF.
      @287    NECODE                   N3PF.
      @290    NEOMAT                   N2PF.
      @292    NIS_STRATUM              N4PF.
      @296    NPR                      N2PF.
      @298    PAY1                     N2PF.
      @300    PAY1_X                   $CHAR10.
      @310    PAY2                     N2PF.
      @312    PAY2_X                   $CHAR10.
      @322    PL_UR_CAT4               N2PF.
      @324    PR1                      $CHAR4.
      @328    PR2                      $CHAR4.
      @332    PR3                      $CHAR4.
      @336    PR4                      $CHAR4.
      @340    PR5                      $CHAR4.
      @344    PR6                      $CHAR4.
      @348    PR7                      $CHAR4.
      @352    PR8                      $CHAR4.
      @356    PR9                      $CHAR4.
      @360    PR10                     $CHAR4.
      @364    PR11                     $CHAR4.
      @368    PR12                     $CHAR4.
      @372    PR13                     $CHAR4.
      @376    PR14                     $CHAR4.
      @380    PR15                     $CHAR4.
      @384    PRCCS1                   N3PF.
      @387    PRCCS2                   N3PF.
      @390    PRCCS3                   N3PF.
      @393    PRCCS4                   N3PF.
      @396    PRCCS5                   N3PF.
      @399    PRCCS6                   N3PF.
      @402    PRCCS7                   N3PF.
      @405    PRCCS8                   N3PF.
      @408    PRCCS9                   N3PF.
      @411    PRCCS10                  N3PF.
      @414    PRCCS11                  N3PF.
      @417    PRCCS12                  N3PF.
      @420    PRCCS13                  N3PF.
      @423    PRCCS14                  N3PF.
      @426    PRCCS15                  N3PF.
      @429    PRDAY1                   N3PF.
      @432    PRDAY2                   N3PF.
      @435    PRDAY3                   N3PF.
      @438    PRDAY4                   N3PF.
      @441    PRDAY5                   N3PF.
      @444    PRDAY6                   N3PF.
      @447    PRDAY7                   N3PF.
      @450    PRDAY8                   N3PF.
      @453    PRDAY9                   N3PF.
      @456    PRDAY10                  N3PF.
      @459    PRDAY11                  N3PF.
      @462    PRDAY12                  N3PF.
      @465    PRDAY13                  N3PF.
      @468    PRDAY14                  N3PF.
      @471    PRDAY15                  N3PF.
      @474    RACE                     N2PF.
      @476    TOTCHG                   N10PF.
      @486    TOTCHG_X                 N15P2F.
      @501    YEAR                     N4PF.
      @505    ZIPInc_Qrtl              N2PF.
      ;


RUN;
/*******************************************************************
*   SASload_NIS_2004_Severity.SAS:
*      The following SAS code will load the ASCII NIS
*      inpatient stay Severity File into SAS.
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
DATA NIS_2004_Severity; 
INFILE "%trim(&filepath)NIS/NIS_2004/Data/NIS_2004_Severity.ASC" LRECL = 172;                                                                                                                                                                                                    

*** Variable attribute ***;
ATTRIB 
  KEY                        LENGTH=8            FORMAT=Z14.
  LABEL="HCUP record identifier"

  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  APRDRG                     LENGTH=3
  LABEL="All Patient Refined DRG"

  APRDRG_Risk_Mortality      LENGTH=3
  LABEL="All Patient Refined DRG: Risk of Mortality Subclass"

  APRDRG_Severity            LENGTH=3
  LABEL="All Patient Refined DRG: Severity of Illness Subclass"

  APSDRG                     LENGTH=4
  LABEL="All-Payer Severity-adjusted DRG"

  APSDRG_Charge_Weight       LENGTH=6
  LABEL="All-Payer Severity-adjusted DRG: Charge Weight"

  APSDRG_LOS_Weight          LENGTH=6
  LABEL="All-Payer Severity-adjusted DRG: Length of Stay Weight"

  APSDRG_Mortality_Weight    LENGTH=6
  LABEL="All-Payer Severity-adjusted DRG: Mortality Weight"

  CM_AIDS                    LENGTH=3
  LABEL="AHRQ comorbidity measure: Acquired immune deficiency syndrome"

  CM_ALCOHOL                 LENGTH=3
  LABEL="AHRQ comorbidity measure: Alcohol abuse"

  CM_ANEMDEF                 LENGTH=3
  LABEL="AHRQ comorbidity measure: Deficiency anemias"

  CM_ARTH                    LENGTH=3
  LABEL="AHRQ comorbidity measure: Rheumatoid arthritis/collagen vascular diseases"

  CM_BLDLOSS                 LENGTH=3
  LABEL="AHRQ comorbidity measure: Chronic blood loss anemia"

  CM_CHF                     LENGTH=3
  LABEL="AHRQ comorbidity measure: Congestive heart failure"

  CM_CHRNLUNG                LENGTH=3
  LABEL="AHRQ comorbidity measure: Chronic pulmonary disease"

  CM_COAG                    LENGTH=3
  LABEL="AHRQ comorbidity measure: Coagulopathy"

  CM_DEPRESS                 LENGTH=3
  LABEL="AHRQ comorbidity measure: Depression"

  CM_DM                      LENGTH=3
  LABEL="AHRQ comorbidity measure: Diabetes, uncomplicated"

  CM_DMCX                    LENGTH=3
  LABEL="AHRQ comorbidity measure: Diabetes with chronic complications"

  CM_DRUG                    LENGTH=3
  LABEL="AHRQ comorbidity measure: Drug abuse"

  CM_HTN_C                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Hypertension (combine uncomplicated and complicated)"

  CM_HYPOTHY                 LENGTH=3
  LABEL="AHRQ comorbidity measure: Hypothyroidism"

  CM_LIVER                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Liver disease"

  CM_LYMPH                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Lymphoma"

  CM_LYTES                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Fluid and electrolyte disorders"

  CM_METS                    LENGTH=3
  LABEL="AHRQ comorbidity measure: Metastatic cancer"

  CM_NEURO                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Other neurological disorders"

  CM_OBESE                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Obesity"

  CM_PARA                    LENGTH=3
  LABEL="AHRQ comorbidity measure: Paralysis"

  CM_PERIVASC                LENGTH=3
  LABEL="AHRQ comorbidity measure: Peripheral vascular disorders"

  CM_PSYCH                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Psychoses"

  CM_PULMCIRC                LENGTH=3
  LABEL="AHRQ comorbidity measure: Pulmonary circulation disorders"

  CM_RENLFAIL                LENGTH=3
  LABEL="AHRQ comorbidity measure: Renal failure"

  CM_TUMOR                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Solid tumor without metastasis"

  CM_ULCER                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Peptic ulcer disease excluding bleeding"

  CM_VALVE                   LENGTH=3
  LABEL="AHRQ comorbidity measure: Valvular disease"

  CM_WGHTLOSS                LENGTH=3
  LABEL="AHRQ comorbidity measure: Weight loss"

  DS_DX_Category1            LENGTH=$5
  LABEL="Disease Staging: Principal Disease Category"

  DS_LOS_Level               LENGTH=3
  LABEL="Disease Staging: Length of Stay Level"

  DS_LOS_Scale               LENGTH=8
  LABEL="Disease Staging: Length of Stay Scale"

  DS_Mrt_Level               LENGTH=3
  LABEL="Disease Staging: Mortality Level"

  DS_Mrt_Scale               LENGTH=8
  LABEL="Disease Staging: Mortality Scale"

  DS_RD_Level                LENGTH=3
  LABEL="Disease Staging: Resource Demand Level"

  DS_RD_Scale                LENGTH=8
  LABEL="Disease Staging: Resource Demand Scale"

  DS_Stage1                  LENGTH=5            FORMAT=4.2
  LABEL="Disease Staging: Principal Stage"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      KEY                      14.
      @15     HOSPID                   5.
      @20     APRDRG                   N4PF.
      @24     APRDRG_Risk_Mortality    N2PF.
      @26     APRDRG_Severity          N2PF.
      @28     APSDRG                   N5PF.
      @33     APSDRG_Charge_Weight     N10P5F.
      @43     APSDRG_LOS_Weight        N10P5F.
      @53     APSDRG_Mortality_Weight  N10P5F.
      @63     CM_AIDS                  N2PF.
      @65     CM_ALCOHOL               N2PF.
      @67     CM_ANEMDEF               N2PF.
      @69     CM_ARTH                  N2PF.
      @71     CM_BLDLOSS               N2PF.
      @73     CM_CHF                   N2PF.
      @75     CM_CHRNLUNG              N2PF.
      @77     CM_COAG                  N2PF.
      @79     CM_DEPRESS               N2PF.
      @81     CM_DM                    N2PF.
      @83     CM_DMCX                  N2PF.
      @85     CM_DRUG                  N2PF.
      @87     CM_HTN_C                 N2PF.
      @89     CM_HYPOTHY               N2PF.
      @91     CM_LIVER                 N2PF.
      @93     CM_LYMPH                 N2PF.
      @95     CM_LYTES                 N2PF.
      @97     CM_METS                  N2PF.
      @99     CM_NEURO                 N2PF.
      @101    CM_OBESE                 N2PF.
      @103    CM_PARA                  N2PF.
      @105    CM_PERIVASC              N2PF.
      @107    CM_PSYCH                 N2PF.
      @109    CM_PULMCIRC              N2PF.
      @111    CM_RENLFAIL              N2PF.
      @113    CM_TUMOR                 N2PF.
      @115    CM_ULCER                 N2PF.
      @117    CM_VALVE                 N2PF.
      @119    CM_WGHTLOSS              N2PF.
      @121    DS_DX_Category1          $CHAR5.
      @126    DS_LOS_Level             N2PF.
      @128    DS_LOS_Scale             N12P5F.
      @140    DS_Mrt_Level             N2PF.
      @142    DS_Mrt_Scale             N12P5F.
      @154    DS_RD_Level              N2PF.
      @156    DS_RD_Scale              N12P5F.
      @168    DS_Stage1                N5P2F.
      ;


RUN;
                                                                           
                                                                                

proc SQL;
create table isilon.NIS_2004_HOSPITAL
like work.NIS_2004_HOSPITAL;

proc SQL;
insert into isilon.NIS_2004_HOSPITAL
select * from work.NIS_2004_HOSPITAL;

proc SQL;
create table isilon.NIS_2004_CORE
like work.NIS_2004_CORE;

proc SQL;
insert into isilon.NIS_2004_CORE
select * from work.NIS_2004_CORE;

proc SQL;
create table isilon.NIS_2004_SEVERITY
like work.NIS_2004_SEVERITY;

proc SQL;
insert into isilon.NIS_2004_SEVERITY
select * from work.NIS_2004_SEVERITY;

proc SQL;
create table isilon.NIS_2004_10PCT_SAMPLE_B
like work.NIS_2004_10PCT_SAMPLE_B;

proc SQL;
insert into isilon.NIS_2004_10PCT_SAMPLE_B
select * from work.NIS_2004_10PCT_SAMPLE_B;

proc SQL;
create table isilon.NIS_2004_10PCT_SAMPLE_A
like work.NIS_2004_10PCT_SAMPLE_A;

proc SQL;
insert into isilon.NIS_2004_10PCT_SAMPLE_A
select * from work.NIS_2004_10PCT_SAMPLE_A;

proc delete data= work.NIS_2004_HOSPITAL; run;
proc delete data= work.NIS_2004_CORE; run;
proc delete data= work.NIS_2004_10PCT_SAMPLE_B; run;
proc delete data= work.NIS_2004_10PCT_SAMPLE_A; run;
proc delete data= work.NIS_2004_SEVERITY; run;