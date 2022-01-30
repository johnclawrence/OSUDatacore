*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2016/Data/NIS_2016   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

/*****************************************************************************
* SASload_NIS_2016_Core.SAS
* This program will load the NIS_2016_Core ASCII File into SAS.
*****************************************************************************/

*** Create SAS informats for missing values ***;
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
  INVALUE N4P1F
    '-9.9' = .
    '-8.8' = .A
    '-6.6' = .C
    OTHER = (|4.1|)
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
  INVALUE N13PF
    '-999999999999' = .
    '-888888888888' = .A
    '-666666666666' = .C
    OTHER = (|13.|)
  ;
  INVALUE N15P2F
    '-99999999999.99' = .
    '-88888888888.88' = .A
    '-66666666666.66' = .C
    OTHER = (|15.2|)
  ;
RUN;

*** Data Step to load the file ***;
DATA NIS_2016_Core; 
INFILE "%trim(&filepath)NIS/NIS_2016/Data/NIS_2016_Core.asc" LRECL = 497;

*** Define data element attributes ***;
ATTRIB 
  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AGE_NEONATE                LENGTH=3
  LABEL="Neonatal age (first 28 days after birth) indicator"

  AMONTH                     LENGTH=3
  LABEL="Admission month"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED                       LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT                     LENGTH=8
  LABEL="NIS discharge weight"

  DISPUNIFORM                LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DRG_NoPOA                  LENGTH=3
  LABEL="DRG in use on discharge date, calculated without POA"

  DXVER                      LENGTH=3
  LABEL="Diagnosis Version"

  ELECTIVE                   LENGTH=3
  LABEL="Elective versus non-elective admission"

  FEMALE                     LENGTH=3
  LABEL="Indicator of sex"

  HCUP_ED                    LENGTH=3
  LABEL="HCUP Emergency Department service indicator"

  HOSP_DIVISION              LENGTH=3            FORMAT=2.
  LABEL="Census Division of hospital"

  HOSP_NIS                   LENGTH=4            FORMAT=5.
  LABEL="NIS hospital number"

  I10_DX1                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 1"

  I10_DX2                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 2"

  I10_DX3                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 3"

  I10_DX4                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 4"

  I10_DX5                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 5"

  I10_DX6                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 6"

  I10_DX7                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 7"

  I10_DX8                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 8"

  I10_DX9                    LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 9"

  I10_DX10                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 10"

  I10_DX11                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 11"

  I10_DX12                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 12"

  I10_DX13                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 13"

  I10_DX14                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 14"

  I10_DX15                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 15"

  I10_DX16                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 16"

  I10_DX17                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 17"

  I10_DX18                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 18"

  I10_DX19                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 19"

  I10_DX20                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 20"

  I10_DX21                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 21"

  I10_DX22                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 22"

  I10_DX23                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 23"

  I10_DX24                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 24"

  I10_DX25                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 25"

  I10_DX26                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 26"

  I10_DX27                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 27"

  I10_DX28                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 28"

  I10_DX29                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 29"

  I10_DX30                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 30"

  I10_ECAUSE1                LENGTH=$7
  LABEL="ICD-10-CM External cause 1"

  I10_ECAUSE2                LENGTH=$7
  LABEL="ICD-10-CM External cause 2"

  I10_ECAUSE3                LENGTH=$7
  LABEL="ICD-10-CM External cause 3"

  I10_ECAUSE4                LENGTH=$7
  LABEL="ICD-10-CM External cause 4"

  I10_NDX                    LENGTH=3
  LABEL="ICD-10-CM Number of diagnoses on this record"

  I10_NECAUSE                LENGTH=3
  LABEL="ICD-10-CM Number of External cause codes on this record"

  I10_NPR                    LENGTH=3
  LABEL="ICD-10-PCS Number of procedures on this record"

  I10_PR1                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 1"

  I10_PR2                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 2"

  I10_PR3                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 3"

  I10_PR4                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 4"

  I10_PR5                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 5"

  I10_PR6                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 6"

  I10_PR7                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 7"

  I10_PR8                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 8"

  I10_PR9                    LENGTH=$7
  LABEL="ICD-10-PCS Procedure 9"

  I10_PR10                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 10"

  I10_PR11                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 11"

  I10_PR12                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 12"

  I10_PR13                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 13"

  I10_PR14                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 14"

  I10_PR15                   LENGTH=$7
  LABEL="ICD-10-PCS Procedure 15"

  KEY_NIS                    LENGTH=5            FORMAT=8.
  LABEL="NIS record number"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC_NoPOA                  LENGTH=3
  LABEL="MDC in use on discharge date, calculated without POA"

  NIS_STRATUM                LENGTH=4            FORMAT=4.
  LABEL="NIS hospital stratum"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PL_NCHS                    LENGTH=3
  LABEL="Patient Location: NCHS Urban-Rural Code"

  PRDAY1                     LENGTH=4
  LABEL="Number of days from admission to I10_PR1"

  PRDAY2                     LENGTH=4
  LABEL="Number of days from admission to I10_PR2"

  PRDAY3                     LENGTH=4
  LABEL="Number of days from admission to I10_PR3"

  PRDAY4                     LENGTH=4
  LABEL="Number of days from admission to I10_PR4"

  PRDAY5                     LENGTH=4
  LABEL="Number of days from admission to I10_PR5"

  PRDAY6                     LENGTH=4
  LABEL="Number of days from admission to I10_PR6"

  PRDAY7                     LENGTH=4
  LABEL="Number of days from admission to I10_PR7"

  PRDAY8                     LENGTH=4
  LABEL="Number of days from admission to I10_PR8"

  PRDAY9                     LENGTH=4
  LABEL="Number of days from admission to I10_PR9"

  PRDAY10                    LENGTH=4
  LABEL="Number of days from admission to I10_PR10"

  PRDAY11                    LENGTH=4
  LABEL="Number of days from admission to I10_PR11"

  PRDAY12                    LENGTH=4
  LABEL="Number of days from admission to I10_PR12"

  PRDAY13                    LENGTH=4
  LABEL="Number of days from admission to I10_PR13"

  PRDAY14                    LENGTH=4
  LABEL="Number of days from admission to I10_PR14"

  PRDAY15                    LENGTH=4
  LABEL="Number of days from admission to I10_PR15"

  PRVER                      LENGTH=3
  LABEL="Procedure Version"

  RACE                       LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG                     LENGTH=6
  LABEL="Total charges (cleaned)"

  TRAN_IN                    LENGTH=3
  LABEL="Transfer in indicator"

  TRAN_OUT                   LENGTH=3
  LABEL="Transfer out indicator"

  YEAR                       LENGTH=3
  LABEL="Calendar year"

  ZIPINC_QRTL                LENGTH=3
  LABEL="Median household income national quartile for patient ZIP Code"
  ;

*** Read data elements from the ASCII file ***;
INPUT 
      @1      AGE                      N3PF.
      @4      AGE_NEONATE              N2PF.
      @6      AMONTH                   N2PF.
      @8      AWEEKEND                 N2PF.
      @10     DIED                     N2PF.
      @12     DISCWT                   N11P7F.
      @23     DISPUNIFORM              N2PF.
      @25     DQTR                     N2PF.
      @27     DRG                      N3PF.
      @30     DRGVER                   N2PF.
      @32     DRG_NoPOA                N3PF.
      @35     DXVER                    N2PF.
      @37     ELECTIVE                 N2PF.
      @39     FEMALE                   N2PF.
      @41     HCUP_ED                  N3PF.
      @44     HOSP_DIVISION            N2PF.
      @46     HOSP_NIS                 N5PF.
      @51     I10_DX1                  $CHAR7.
      @58     I10_DX2                  $CHAR7.
      @65     I10_DX3                  $CHAR7.
      @72     I10_DX4                  $CHAR7.
      @79     I10_DX5                  $CHAR7.
      @86     I10_DX6                  $CHAR7.
      @93     I10_DX7                  $CHAR7.
      @100    I10_DX8                  $CHAR7.
      @107    I10_DX9                  $CHAR7.
      @114    I10_DX10                 $CHAR7.
      @121    I10_DX11                 $CHAR7.
      @128    I10_DX12                 $CHAR7.
      @135    I10_DX13                 $CHAR7.
      @142    I10_DX14                 $CHAR7.
      @149    I10_DX15                 $CHAR7.
      @156    I10_DX16                 $CHAR7.
      @163    I10_DX17                 $CHAR7.
      @170    I10_DX18                 $CHAR7.
      @177    I10_DX19                 $CHAR7.
      @184    I10_DX20                 $CHAR7.
      @191    I10_DX21                 $CHAR7.
      @198    I10_DX22                 $CHAR7.
      @205    I10_DX23                 $CHAR7.
      @212    I10_DX24                 $CHAR7.
      @219    I10_DX25                 $CHAR7.
      @226    I10_DX26                 $CHAR7.
      @233    I10_DX27                 $CHAR7.
      @240    I10_DX28                 $CHAR7.
      @247    I10_DX29                 $CHAR7.
      @254    I10_DX30                 $CHAR7.
      @261    I10_ECAUSE1              $CHAR7.
      @268    I10_ECAUSE2              $CHAR7.
      @275    I10_ECAUSE3              $CHAR7.
      @282    I10_ECAUSE4              $CHAR7.
      @289    I10_NDX                  N2PF.
      @291    I10_NECAUSE              N3PF.
      @294    I10_NPR                  N2PF.
      @296    I10_PR1                  $CHAR7.
      @303    I10_PR2                  $CHAR7.
      @310    I10_PR3                  $CHAR7.
      @317    I10_PR4                  $CHAR7.
      @324    I10_PR5                  $CHAR7.
      @331    I10_PR6                  $CHAR7.
      @338    I10_PR7                  $CHAR7.
      @345    I10_PR8                  $CHAR7.
      @352    I10_PR9                  $CHAR7.
      @359    I10_PR10                 $CHAR7.
      @366    I10_PR11                 $CHAR7.
      @373    I10_PR12                 $CHAR7.
      @380    I10_PR13                 $CHAR7.
      @387    I10_PR14                 $CHAR7.
      @394    I10_PR15                 $CHAR7.
      @401    KEY_NIS                  N10PF.
      @411    LOS                      N5PF.
      @416    MDC                      N2PF.
      @418    MDC_NoPOA                N2PF.
      @420    NIS_STRATUM              N4PF.
      @424    PAY1                     N2PF.
      @426    PL_NCHS                  N3PF.
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
      @474    PRVER                    N2PF.
      @476    RACE                     N2PF.
      @478    TOTCHG                   N10PF.
      @488    TRAN_IN                  N2PF.
      @490    TRAN_OUT                 N2PF.
      @492    YEAR                     N4PF.
      @496    ZIPINC_QRTL              N2PF.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2016_Hospital.SAS
* This program will load the NIS_2016_Hospital ASCII File into SAS.
*****************************************************************************/

*** Create SAS informats for missing values ***;
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
  INVALUE N4P1F
    '-9.9' = .
    '-8.8' = .A
    '-6.6' = .C
    OTHER = (|4.1|)
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
  INVALUE N13PF
    '-999999999999' = .
    '-888888888888' = .A
    '-666666666666' = .C
    OTHER = (|13.|)
  ;
  INVALUE N15P2F
    '-99999999999.99' = .
    '-88888888888.88' = .A
    '-66666666666.66' = .C
    OTHER = (|15.2|)
  ;
RUN;

*** Data Step to load the file ***;
DATA NIS_2016_Hospital; 
INFILE "%trim(&filepath)NIS/NIS_2016/Data/NIS_2016_Hospital.asc" LRECL = 64;

*** Define data element attributes ***;
ATTRIB 
  DISCWT                     LENGTH=8
  LABEL="NIS discharge weight"

  HOSP_BEDSIZE               LENGTH=3            FORMAT=2.
  LABEL="Bed size of hospital (STRATA)"

  HOSP_DIVISION              LENGTH=3            FORMAT=2.
  LABEL="Census Division of hospital (STRATA)"

  HOSP_LOCTEACH              LENGTH=3            FORMAT=2.
  LABEL="Location/teaching status of hospital (STRATA)"

  HOSP_NIS                   LENGTH=4            FORMAT=5.
  LABEL="NIS hospital number"

  HOSP_REGION                LENGTH=3            FORMAT=2.
  LABEL="Region of hospital"

  H_CONTRL                   LENGTH=3            FORMAT=2.
  LABEL="Control/ownership of hospital (STRATA)"

  NIS_STRATUM                LENGTH=4            FORMAT=4.
  LABEL="NIS hospital stratum"

  N_DISC_U                   LENGTH=5
  LABEL="Number of universe discharges in the stratum"

  N_HOSP_U                   LENGTH=3
  LABEL="Number of universe hospitals in the stratum"

  S_DISC_U                   LENGTH=4
  LABEL="Number of sample discharges in the stratum"

  S_HOSP_U                   LENGTH=3
  LABEL="Number of sample hospitals in the stratum"

  TOTAL_DISC                 LENGTH=4
  LABEL="Total number of discharges from this hospital in the NIS"

  YEAR                       LENGTH=3
  LABEL="Calendar year"
  ;

*** Read data elements from the ASCII file ***;
INPUT 
      @1      DISCWT                   N11P7F.
      @12     HOSP_BEDSIZE             N2PF.
      @14     HOSP_DIVISION            N2PF.
      @16     HOSP_LOCTEACH            N2PF.
      @18     HOSP_NIS                 N5PF.
      @23     HOSP_REGION              N2PF.
      @25     H_CONTRL                 N2PF.
      @27     NIS_STRATUM              N4PF.
      @31     N_DISC_U                 N8PF.
      @39     N_HOSP_U                 N4PF.
      @43     S_DISC_U                 N8PF.
      @51     S_HOSP_U                 N4PF.
      @55     TOTAL_DISC               N6PF.
      @61     YEAR                     N4PF.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2016_Severity.SAS
* This program will load the NIS_2016_Severity ASCII File into SAS.
*****************************************************************************/

*** Create SAS informats for missing values ***;
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
  INVALUE N4P1F
    '-9.9' = .
    '-8.8' = .A
    '-6.6' = .C
    OTHER = (|4.1|)
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
  INVALUE N13PF
    '-999999999999' = .
    '-888888888888' = .A
    '-666666666666' = .C
    OTHER = (|13.|)
  ;
  INVALUE N15P2F
    '-99999999999.99' = .
    '-88888888888.88' = .A
    '-66666666666.66' = .C
    OTHER = (|15.2|)
  ;
RUN;

*** Data Step to load the file ***;
DATA NIS_2016_Severity; 
INFILE "%trim(&filepath)NIS/NIS_2016/Data/NIS_2016_Severity.asc" LRECL = 23;

*** Define data element attributes ***;
ATTRIB 
  HOSP_NIS                   LENGTH=4            FORMAT=5.
  LABEL="NIS hospital number"

  KEY_NIS                    LENGTH=5            FORMAT=8.
  LABEL="NIS record number"

  APRDRG                     LENGTH=3
  LABEL="All Patient Refined DRG"

  APRDRG_Risk_Mortality      LENGTH=3
  LABEL="All Patient Refined DRG: Risk of Mortality Subclass"

  APRDRG_Severity            LENGTH=3
  LABEL="All Patient Refined DRG: Severity of Illness Subclass"
  ;

*** Read data elements from the ASCII file ***;
INPUT 
      @1      HOSP_NIS                 N5PF.
      @6      KEY_NIS                  N10PF.
      @16     APRDRG                   N4PF.
      @20     APRDRG_Risk_Mortality    N2PF.
      @22     APRDRG_Severity          N2PF.
      ;
RUN;
                                                                           
                                                                                

                                                                                

proc SQL;
create table isilon.NIS_2016_HOSPITAL
like work.NIS_2016_HOSPITAL;

proc SQL;
insert into isilon.NIS_2016_HOSPITAL
select * from work.NIS_2016_HOSPITAL;

proc SQL;
create table isilon.NIS_2016_CORE
like work.NIS_2016_CORE;

proc SQL;
insert into isilon.NIS_2016_CORE
select * from work.NIS_2016_CORE;

proc SQL;
create table isilon.NIS_2016_SEVERITY
like work.NIS_2016_SEVERITY;

proc SQL;
insert into isilon.NIS_2016_SEVERITY
select * from work.NIS_2016_SEVERITY;


proc delete data= work.NIS_2016_CORE; run;
proc delete data= work.NIS_2016_HOSPITAL; run;
proc delete data= work.NIS_2016_SEVERITY; run;