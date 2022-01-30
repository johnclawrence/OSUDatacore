*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

/*****************************************************************************
 * SASload_NRD_2010_Core.SAS
 * This program will load the 2010 NRD csv Core File into SAS.
 *****************************************************************************/

/* Create SAS informats for missing values */
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

/* Data Step to load the file */
DATA NRD_2010_Core; 
INFILE "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010_Core.csv" dsd dlm=',' LRECL = 594;

/* Define data element attributes */
ATTRIB 
  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED                       LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT                     LENGTH=8
  LABEL="Weight to discharges in AHA universe"

  DISPUNIFORM                LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DMONTH                     LENGTH=3
  LABEL="Discharge month"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DRG_NoPOA                  LENGTH=3
  LABEL="DRG in use on discharge date, calculated without POA"

  DX1                        LENGTH=$5
  LABEL="Diagnosis 1"

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

  DX16                       LENGTH=$5
  LABEL="Diagnosis 16"

  DX17                       LENGTH=$5
  LABEL="Diagnosis 17"

  DX18                       LENGTH=$5
  LABEL="Diagnosis 18"

  DX19                       LENGTH=$5
  LABEL="Diagnosis 19"

  DX20                       LENGTH=$5
  LABEL="Diagnosis 20"

  DX21                       LENGTH=$5
  LABEL="Diagnosis 21"

  DX22                       LENGTH=$5
  LABEL="Diagnosis 22"

  DX23                       LENGTH=$5
  LABEL="Diagnosis 23"

  DX24                       LENGTH=$5
  LABEL="Diagnosis 24"

  DX25                       LENGTH=$5
  LABEL="Diagnosis 25"

  DXCCS1                     LENGTH=4
  LABEL="CCS: diagnosis 1"

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

  DXCCS16                    LENGTH=4
  LABEL="CCS: diagnosis 16"

  DXCCS17                    LENGTH=4
  LABEL="CCS: diagnosis 17"

  DXCCS18                    LENGTH=4
  LABEL="CCS: diagnosis 18"

  DXCCS19                    LENGTH=4
  LABEL="CCS: diagnosis 19"

  DXCCS20                    LENGTH=4
  LABEL="CCS: diagnosis 20"

  DXCCS21                    LENGTH=4
  LABEL="CCS: diagnosis 21"

  DXCCS22                    LENGTH=4
  LABEL="CCS: diagnosis 22"

  DXCCS23                    LENGTH=4
  LABEL="CCS: diagnosis 23"

  DXCCS24                    LENGTH=4
  LABEL="CCS: diagnosis 24"

  DXCCS25                    LENGTH=4
  LABEL="CCS: diagnosis 25"

  ECODE1                     LENGTH=$5
  LABEL="E code 1"

  ECODE2                     LENGTH=$5
  LABEL="E code 2"

  ECODE3                     LENGTH=$5
  LABEL="E code 3"

  ECODE4                     LENGTH=$5
  LABEL="E code 4"

  ELECTIVE                   LENGTH=3
  LABEL="Elective versus non-elective admission"

  E_CCS1                     LENGTH=3
  LABEL="CCS: E Code 1"

  E_CCS2                     LENGTH=3
  LABEL="CCS: E Code 2"

  E_CCS3                     LENGTH=3
  LABEL="CCS: E Code 3"

  E_CCS4                     LENGTH=3
  LABEL="CCS: E Code 4"

  FEMALE                     LENGTH=3
  LABEL="Indicator of sex"

  HCUP_ED                    LENGTH=3
  LABEL="HCUP Emergency Department service indicator"

  HOSP_NRD                   LENGTH=4
  LABEL="NRD hospital identifier"

  KEY_NRD                    LENGTH=8
  LABEL="NRD record identifier"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC_NoPOA                  LENGTH=3
  LABEL="MDC in use on discharge date, calculated without POA"

  NCHRONIC                   LENGTH=3
  LABEL="Number of chronic conditions"

  NDX                        LENGTH=3
  LABEL="Number of diagnoses on this record"

  NECODE                     LENGTH=3
  LABEL="Number of E codes on this record"

  NPR                        LENGTH=3
  LABEL="Number of procedures on this record"

  NRD_DaysToEvent            LENGTH=8
  LABEL="Timing variable used to identify days between admissions"

  NRD_STRATUM                LENGTH=3
  LABEL="NRD stratum used for weighting"

  NRD_VisitLink              LENGTH=$7
  LABEL="NRD visitlink"

  ORPROC                     LENGTH=3
  LABEL="Major operating room procedure indicator"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PL_NCHS2006                LENGTH=3
  LABEL="Patient Location: NCHS Urban-Rural Code (V2006)"

  PR1                        LENGTH=$4
  LABEL="Procedure 1"

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
  LABEL="CCS: procedure 1"

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

  REHABTRANSFER              LENGTH=3
  LABEL="A combined record involving rehab transfer"

  RESIDENT                   LENGTH=3
  LABEL="Patient State is the same as Hospital State"

  SAMEDAYEVENT               LENGTH=$2
  LABEL="Transfer flag indicating combination of discharges involve same day events"

  TOTCHG                     LENGTH=6
  LABEL="Total charges (cleaned)"

  YEAR                       LENGTH=3
  LABEL="Calendar year"

  ZIPINC_QRTL                LENGTH=3
  LABEL="Median household income national quartile for patient ZIP Code"
  ;

/* Read data elements from the CSV file */
INPUT 
      AGE                      :N3PF.
      AWEEKEND                 :N2PF.
      DIED                     :N2PF.
      DISCWT                   :N11P7F.
      DISPUNIFORM              :N2PF.
      DMONTH                   :N2PF.
      DQTR                     :N2PF.
      DRG                      :N3PF.
      DRGVER                   :N2PF.
      DRG_NoPOA                :N3PF.
      DX1                      :$CHAR5.
      DX2                      :$CHAR5.
      DX3                      :$CHAR5.
      DX4                      :$CHAR5.
      DX5                      :$CHAR5.
      DX6                      :$CHAR5.
      DX7                      :$CHAR5.
      DX8                      :$CHAR5.
      DX9                      :$CHAR5.
      DX10                     :$CHAR5.
      DX11                     :$CHAR5.
      DX12                     :$CHAR5.
      DX13                     :$CHAR5.
      DX14                     :$CHAR5.
      DX15                     :$CHAR5.
      DX16                     :$CHAR5.
      DX17                     :$CHAR5.
      DX18                     :$CHAR5.
      DX19                     :$CHAR5.
      DX20                     :$CHAR5.
      DX21                     :$CHAR5.
      DX22                     :$CHAR5.
      DX23                     :$CHAR5.
      DX24                     :$CHAR5.
      DX25                     :$CHAR5.
      DXCCS1                   :N3PF.
      DXCCS2                   :N3PF.
      DXCCS3                   :N3PF.
      DXCCS4                   :N3PF.
      DXCCS5                   :N3PF.
      DXCCS6                   :N3PF.
      DXCCS7                   :N3PF.
      DXCCS8                   :N3PF.
      DXCCS9                   :N3PF.
      DXCCS10                  :N3PF.
      DXCCS11                  :N3PF.
      DXCCS12                  :N3PF.
      DXCCS13                  :N3PF.
      DXCCS14                  :N3PF.
      DXCCS15                  :N3PF.
      DXCCS16                  :N3PF.
      DXCCS17                  :N3PF.
      DXCCS18                  :N3PF.
      DXCCS19                  :N3PF.
      DXCCS20                  :N3PF.
      DXCCS21                  :N3PF.
      DXCCS22                  :N3PF.
      DXCCS23                  :N3PF.
      DXCCS24                  :N3PF.
      DXCCS25                  :N3PF.
      ECODE1                   :$CHAR5.
      ECODE2                   :$CHAR5.
      ECODE3                   :$CHAR5.
      ECODE4                   :$CHAR5.
      ELECTIVE                 :N2PF.
      E_CCS1                   :N4PF.
      E_CCS2                   :N4PF.
      E_CCS3                   :N4PF.
      E_CCS4                   :N4PF.
      FEMALE                   :N2PF.
      HCUP_ED                  :N2PF.
      HOSP_NRD                 :5.
      KEY_NRD                  :15.
      LOS                      :N5PF.
      MDC                      :N2PF.
      MDC_NoPOA                :N2PF.
      NCHRONIC                 :N2PF.
      NDX                      :N3PF.
      NECODE                   :N3PF.
      NPR                      :N3PF.
      NRD_DaysToEvent          :N10PF.
      NRD_STRATUM              :N5PF.
      NRD_VisitLink            :$CHAR7.
      ORPROC                   :N2PF.
      PAY1                     :N2PF.
      PL_NCHS2006              :N3PF.
      PR1                      :$CHAR4.
      PR2                      :$CHAR4.
      PR3                      :$CHAR4.
      PR4                      :$CHAR4.
      PR5                      :$CHAR4.
      PR6                      :$CHAR4.
      PR7                      :$CHAR4.
      PR8                      :$CHAR4.
      PR9                      :$CHAR4.
      PR10                     :$CHAR4.
      PR11                     :$CHAR4.
      PR12                     :$CHAR4.
      PR13                     :$CHAR4.
      PR14                     :$CHAR4.
      PR15                     :$CHAR4.
      PRCCS1                   :N3PF.
      PRCCS2                   :N3PF.
      PRCCS3                   :N3PF.
      PRCCS4                   :N3PF.
      PRCCS5                   :N3PF.
      PRCCS6                   :N3PF.
      PRCCS7                   :N3PF.
      PRCCS8                   :N3PF.
      PRCCS9                   :N3PF.
      PRCCS10                  :N3PF.
      PRCCS11                  :N3PF.
      PRCCS12                  :N3PF.
      PRCCS13                  :N3PF.
      PRCCS14                  :N3PF.
      PRCCS15                  :N3PF.
      REHABTRANSFER            :N2PF.
      RESIDENT                 :N2PF.
      SAMEDAYEVENT             :$CHAR2.
      TOTCHG                   :N10PF.
      YEAR                     :N4PF.
      ZIPINC_QRTL              :N2PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2010_Core_V2.SAS
 * Created on 09/28/2017.
 * This program will load the 2010 NRD csv Core_V2 File into SAS.
 *****************************************************************************/

/* Create SAS informats for missing values */
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

/* Data Step to load the file */
DATA NRD_2010_Core_V2; 
INFILE "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010_Core_V2.csv" dsd dlm=',' LRECL = 592;

/* Define data element attributes */
ATTRIB 
  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED                       LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT                     LENGTH=8
  LABEL="Weight to discharges in AHA universe"

  DISPUNIFORM                LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DMONTH                     LENGTH=3
  LABEL="Discharge month"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DRG_NoPOA                  LENGTH=3
  LABEL="DRG in use on discharge date, calculated without POA"

  DX1                        LENGTH=$5
  LABEL="Diagnosis 1"

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

  DX16                       LENGTH=$5
  LABEL="Diagnosis 16"

  DX17                       LENGTH=$5
  LABEL="Diagnosis 17"

  DX18                       LENGTH=$5
  LABEL="Diagnosis 18"

  DX19                       LENGTH=$5
  LABEL="Diagnosis 19"

  DX20                       LENGTH=$5
  LABEL="Diagnosis 20"

  DX21                       LENGTH=$5
  LABEL="Diagnosis 21"

  DX22                       LENGTH=$5
  LABEL="Diagnosis 22"

  DX23                       LENGTH=$5
  LABEL="Diagnosis 23"

  DX24                       LENGTH=$5
  LABEL="Diagnosis 24"

  DX25                       LENGTH=$5
  LABEL="Diagnosis 25"

  DXCCS1                     LENGTH=4
  LABEL="CCS: diagnosis 1"

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

  DXCCS16                    LENGTH=4
  LABEL="CCS: diagnosis 16"

  DXCCS17                    LENGTH=4
  LABEL="CCS: diagnosis 17"

  DXCCS18                    LENGTH=4
  LABEL="CCS: diagnosis 18"

  DXCCS19                    LENGTH=4
  LABEL="CCS: diagnosis 19"

  DXCCS20                    LENGTH=4
  LABEL="CCS: diagnosis 20"

  DXCCS21                    LENGTH=4
  LABEL="CCS: diagnosis 21"

  DXCCS22                    LENGTH=4
  LABEL="CCS: diagnosis 22"

  DXCCS23                    LENGTH=4
  LABEL="CCS: diagnosis 23"

  DXCCS24                    LENGTH=4
  LABEL="CCS: diagnosis 24"

  DXCCS25                    LENGTH=4
  LABEL="CCS: diagnosis 25"

  ECODE1                     LENGTH=$5
  LABEL="E code 1"

  ECODE2                     LENGTH=$5
  LABEL="E code 2"

  ECODE3                     LENGTH=$5
  LABEL="E code 3"

  ECODE4                     LENGTH=$5
  LABEL="E code 4"

  ELECTIVE                   LENGTH=3
  LABEL="Elective versus non-elective admission"

  E_CCS1                     LENGTH=3
  LABEL="CCS: E Code 1"

  E_CCS2                     LENGTH=3
  LABEL="CCS: E Code 2"

  E_CCS3                     LENGTH=3
  LABEL="CCS: E Code 3"

  E_CCS4                     LENGTH=3
  LABEL="CCS: E Code 4"

  FEMALE                     LENGTH=3
  LABEL="Indicator of sex"

  HCUP_ED                    LENGTH=3
  LABEL="HCUP Emergency Department service indicator"

  HOSP_NRD                   LENGTH=4
  LABEL="NRD hospital identifier"

  KEY_NRD                    LENGTH=8
  LABEL="NRD record identifier"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC_NoPOA                  LENGTH=3
  LABEL="MDC in use on discharge date, calculated without POA"

  NCHRONIC                   LENGTH=3
  LABEL="Number of chronic conditions"

  NDX                        LENGTH=3
  LABEL="Number of diagnoses on this record"

  NECODE                     LENGTH=3
  LABEL="Number of E codes on this record"

  NPR                        LENGTH=3
  LABEL="Number of procedures on this record"

  NRD_DaysToEvent            LENGTH=8
  LABEL="Timing variable used to identify days between admissions"

  NRD_STRATUM                LENGTH=3
  LABEL="NRD stratum used for weighting"

  NRD_VisitLink              LENGTH=$7
  LABEL="NRD visitlink"

  ORPROC                     LENGTH=3
  LABEL="Major operating room procedure indicator"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PL_NCHS2006                LENGTH=3
  LABEL="Patient Location: NCHS Urban-Rural Code (V2006)"

  PR1                        LENGTH=$4
  LABEL="Procedure 1"

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
  LABEL="CCS: procedure 1"

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

  REHABTRANSFER              LENGTH=3
  LABEL="A combined record involving rehab transfer"

  RESIDENT                   LENGTH=3
  LABEL="Patient State is the same as Hospital State"

  SAMEDAYEVENT               LENGTH=$2
  LABEL="Transfer flag indicating combination of discharges involve same day events"

  TOTCHG                     LENGTH=6
  LABEL="Total charges (cleaned)"

  YEAR                       LENGTH=3
  LABEL="Calendar year"

  ZIPINC_QRTL                LENGTH=3
  LABEL="Median household income national quartile for patient ZIP Code"
  ;

/* Read data elements from the CSV file */
INPUT 
      AGE                      :N3PF.
      AWEEKEND                 :N2PF.
      DIED                     :N2PF.
      DISCWT                   :N11P7F.
      DISPUNIFORM              :N2PF.
      DMONTH                   :N2PF.
      DQTR                     :N2PF.
      DRG                      :N3PF.
      DRGVER                   :N2PF.
      DRG_NoPOA                :N3PF.
      DX1                      :$CHAR5.
      DX2                      :$CHAR5.
      DX3                      :$CHAR5.
      DX4                      :$CHAR5.
      DX5                      :$CHAR5.
      DX6                      :$CHAR5.
      DX7                      :$CHAR5.
      DX8                      :$CHAR5.
      DX9                      :$CHAR5.
      DX10                     :$CHAR5.
      DX11                     :$CHAR5.
      DX12                     :$CHAR5.
      DX13                     :$CHAR5.
      DX14                     :$CHAR5.
      DX15                     :$CHAR5.
      DX16                     :$CHAR5.
      DX17                     :$CHAR5.
      DX18                     :$CHAR5.
      DX19                     :$CHAR5.
      DX20                     :$CHAR5.
      DX21                     :$CHAR5.
      DX22                     :$CHAR5.
      DX23                     :$CHAR5.
      DX24                     :$CHAR5.
      DX25                     :$CHAR5.
      DXCCS1                   :N3PF.
      DXCCS2                   :N3PF.
      DXCCS3                   :N3PF.
      DXCCS4                   :N3PF.
      DXCCS5                   :N3PF.
      DXCCS6                   :N3PF.
      DXCCS7                   :N3PF.
      DXCCS8                   :N3PF.
      DXCCS9                   :N3PF.
      DXCCS10                  :N3PF.
      DXCCS11                  :N3PF.
      DXCCS12                  :N3PF.
      DXCCS13                  :N3PF.
      DXCCS14                  :N3PF.
      DXCCS15                  :N3PF.
      DXCCS16                  :N3PF.
      DXCCS17                  :N3PF.
      DXCCS18                  :N3PF.
      DXCCS19                  :N3PF.
      DXCCS20                  :N3PF.
      DXCCS21                  :N3PF.
      DXCCS22                  :N3PF.
      DXCCS23                  :N3PF.
      DXCCS24                  :N3PF.
      DXCCS25                  :N3PF.
      ECODE1                   :$CHAR5.
      ECODE2                   :$CHAR5.
      ECODE3                   :$CHAR5.
      ECODE4                   :$CHAR5.
      ELECTIVE                 :N2PF.
      E_CCS1                   :N4PF.
      E_CCS2                   :N4PF.
      E_CCS3                   :N4PF.
      E_CCS4                   :N4PF.
      FEMALE                   :N2PF.
      HCUP_ED                  :N2PF.
      HOSP_NRD                 :5.
      KEY_NRD                  :15.
      LOS                      :N5PF.
      MDC                      :N2PF.
      MDC_NoPOA                :N2PF.
      NCHRONIC                 :N2PF.
      NDX                      :N3PF.
      NECODE                   :N3PF.
      NPR                      :N3PF.
      NRD_DaysToEvent          :N10PF.
      NRD_STRATUM              :N5PF.
      NRD_VisitLink            :$CHAR7.
      ORPROC                   :N2PF.
      PAY1                     :N2PF.
      PL_NCHS2006              :N3PF.
      PR1                      :$CHAR4.
      PR2                      :$CHAR4.
      PR3                      :$CHAR4.
      PR4                      :$CHAR4.
      PR5                      :$CHAR4.
      PR6                      :$CHAR4.
      PR7                      :$CHAR4.
      PR8                      :$CHAR4.
      PR9                      :$CHAR4.
      PR10                     :$CHAR4.
      PR11                     :$CHAR4.
      PR12                     :$CHAR4.
      PR13                     :$CHAR4.
      PR14                     :$CHAR4.
      PR15                     :$CHAR4.
      PRCCS1                   :N3PF.
      PRCCS2                   :N3PF.
      PRCCS3                   :N3PF.
      PRCCS4                   :N3PF.
      PRCCS5                   :N3PF.
      PRCCS6                   :N3PF.
      PRCCS7                   :N3PF.
      PRCCS8                   :N3PF.
      PRCCS9                   :N3PF.
      PRCCS10                  :N3PF.
      PRCCS11                  :N3PF.
      PRCCS12                  :N3PF.
      PRCCS13                  :N3PF.
      PRCCS14                  :N3PF.
      PRCCS15                  :N3PF.
      REHABTRANSFER            :N2PF.
      RESIDENT                 :N2PF.
      SAMEDAYEVENT             :$CHAR2.
      TOTCHG                   :N10PF.
      YEAR                     :N4PF.
      ZIPINC_QRTL              :N2PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2010_DX_PR_GRPS.SAS
 * This program will load the 2010 NRD csv DX_PR_GRPS File into SAS.
 *****************************************************************************/

/* Create SAS informats for missing values */
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

/* Data Step to load the file */
DATA NRD_2010_DX_PR_GRPS; 
INFILE "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010_DX_PR_GRPS.csv" dsd dlm=',' LRECL = 315;

/* Define data element attributes */
ATTRIB 
  CHRON1                     LENGTH=3
  LABEL="Chronic condition indicator 1"

  CHRON2                     LENGTH=3
  LABEL="Chronic condition indicator 2"

  CHRON3                     LENGTH=3
  LABEL="Chronic condition indicator 3"

  CHRON4                     LENGTH=3
  LABEL="Chronic condition indicator 4"

  CHRON5                     LENGTH=3
  LABEL="Chronic condition indicator 5"

  CHRON6                     LENGTH=3
  LABEL="Chronic condition indicator 6"

  CHRON7                     LENGTH=3
  LABEL="Chronic condition indicator 7"

  CHRON8                     LENGTH=3
  LABEL="Chronic condition indicator 8"

  CHRON9                     LENGTH=3
  LABEL="Chronic condition indicator 9"

  CHRON10                    LENGTH=3
  LABEL="Chronic condition indicator 10"

  CHRON11                    LENGTH=3
  LABEL="Chronic condition indicator 11"

  CHRON12                    LENGTH=3
  LABEL="Chronic condition indicator 12"

  CHRON13                    LENGTH=3
  LABEL="Chronic condition indicator 13"

  CHRON14                    LENGTH=3
  LABEL="Chronic condition indicator 14"

  CHRON15                    LENGTH=3
  LABEL="Chronic condition indicator 15"

  CHRON16                    LENGTH=3
  LABEL="Chronic condition indicator 16"

  CHRON17                    LENGTH=3
  LABEL="Chronic condition indicator 17"

  CHRON18                    LENGTH=3
  LABEL="Chronic condition indicator 18"

  CHRON19                    LENGTH=3
  LABEL="Chronic condition indicator 19"

  CHRON20                    LENGTH=3
  LABEL="Chronic condition indicator 20"

  CHRON21                    LENGTH=3
  LABEL="Chronic condition indicator 21"

  CHRON22                    LENGTH=3
  LABEL="Chronic condition indicator 22"

  CHRON23                    LENGTH=3
  LABEL="Chronic condition indicator 23"

  CHRON24                    LENGTH=3
  LABEL="Chronic condition indicator 24"

  CHRON25                    LENGTH=3
  LABEL="Chronic condition indicator 25"

  CHRONB1                    LENGTH=3
  LABEL="Chronic condition body system 1"

  CHRONB2                    LENGTH=3
  LABEL="Chronic condition body system 2"

  CHRONB3                    LENGTH=3
  LABEL="Chronic condition body system 3"

  CHRONB4                    LENGTH=3
  LABEL="Chronic condition body system 4"

  CHRONB5                    LENGTH=3
  LABEL="Chronic condition body system 5"

  CHRONB6                    LENGTH=3
  LABEL="Chronic condition body system 6"

  CHRONB7                    LENGTH=3
  LABEL="Chronic condition body system 7"

  CHRONB8                    LENGTH=3
  LABEL="Chronic condition body system 8"

  CHRONB9                    LENGTH=3
  LABEL="Chronic condition body system 9"

  CHRONB10                   LENGTH=3
  LABEL="Chronic condition body system 10"

  CHRONB11                   LENGTH=3
  LABEL="Chronic condition body system 11"

  CHRONB12                   LENGTH=3
  LABEL="Chronic condition body system 12"

  CHRONB13                   LENGTH=3
  LABEL="Chronic condition body system 13"

  CHRONB14                   LENGTH=3
  LABEL="Chronic condition body system 14"

  CHRONB15                   LENGTH=3
  LABEL="Chronic condition body system 15"

  CHRONB16                   LENGTH=3
  LABEL="Chronic condition body system 16"

  CHRONB17                   LENGTH=3
  LABEL="Chronic condition body system 17"

  CHRONB18                   LENGTH=3
  LABEL="Chronic condition body system 18"

  CHRONB19                   LENGTH=3
  LABEL="Chronic condition body system 19"

  CHRONB20                   LENGTH=3
  LABEL="Chronic condition body system 20"

  CHRONB21                   LENGTH=3
  LABEL="Chronic condition body system 21"

  CHRONB22                   LENGTH=3
  LABEL="Chronic condition body system 22"

  CHRONB23                   LENGTH=3
  LABEL="Chronic condition body system 23"

  CHRONB24                   LENGTH=3
  LABEL="Chronic condition body system 24"

  CHRONB25                   LENGTH=3
  LABEL="Chronic condition body system 25"

  DXMCCS1                    LENGTH=$11
  LABEL="Multi-Level CCS:  Diagnosis 1"

  E_MCCS1                    LENGTH=$11
  LABEL="Multi-Level CCS:  E Code 1"

  HOSP_NRD                   LENGTH=4
  LABEL="NRD hospital identifier"

  KEY_NRD                    LENGTH=8
  LABEL="NRD record identifier"

  PCLASS1                    LENGTH=3
  LABEL="Procedure class 1"

  PCLASS2                    LENGTH=3
  LABEL="Procedure class 2"

  PCLASS3                    LENGTH=3
  LABEL="Procedure class 3"

  PCLASS4                    LENGTH=3
  LABEL="Procedure class 4"

  PCLASS5                    LENGTH=3
  LABEL="Procedure class 5"

  PCLASS6                    LENGTH=3
  LABEL="Procedure class 6"

  PCLASS7                    LENGTH=3
  LABEL="Procedure class 7"

  PCLASS8                    LENGTH=3
  LABEL="Procedure class 8"

  PCLASS9                    LENGTH=3
  LABEL="Procedure class 9"

  PCLASS10                   LENGTH=3
  LABEL="Procedure class 10"

  PCLASS11                   LENGTH=3
  LABEL="Procedure class 11"

  PCLASS12                   LENGTH=3
  LABEL="Procedure class 12"

  PCLASS13                   LENGTH=3
  LABEL="Procedure class 13"

  PCLASS14                   LENGTH=3
  LABEL="Procedure class 14"

  PCLASS15                   LENGTH=3
  LABEL="Procedure class 15"

  PRMCCS1                    LENGTH=$8
  LABEL="Multi-Level CCS:  Procedure 1"
  ;

/* Read data elements from the CSV file */
INPUT 
      CHRON1                   :N3PF.
      CHRON2                   :N3PF.
      CHRON3                   :N3PF.
      CHRON4                   :N3PF.
      CHRON5                   :N3PF.
      CHRON6                   :N3PF.
      CHRON7                   :N3PF.
      CHRON8                   :N3PF.
      CHRON9                   :N3PF.
      CHRON10                  :N3PF.
      CHRON11                  :N3PF.
      CHRON12                  :N3PF.
      CHRON13                  :N3PF.
      CHRON14                  :N3PF.
      CHRON15                  :N3PF.
      CHRON16                  :N3PF.
      CHRON17                  :N3PF.
      CHRON18                  :N3PF.
      CHRON19                  :N3PF.
      CHRON20                  :N3PF.
      CHRON21                  :N3PF.
      CHRON22                  :N3PF.
      CHRON23                  :N3PF.
      CHRON24                  :N3PF.
      CHRON25                  :N3PF.
      CHRONB1                  :N3PF.
      CHRONB2                  :N3PF.
      CHRONB3                  :N3PF.
      CHRONB4                  :N3PF.
      CHRONB5                  :N3PF.
      CHRONB6                  :N3PF.
      CHRONB7                  :N3PF.
      CHRONB8                  :N3PF.
      CHRONB9                  :N3PF.
      CHRONB10                 :N3PF.
      CHRONB11                 :N3PF.
      CHRONB12                 :N3PF.
      CHRONB13                 :N3PF.
      CHRONB14                 :N3PF.
      CHRONB15                 :N3PF.
      CHRONB16                 :N3PF.
      CHRONB17                 :N3PF.
      CHRONB18                 :N3PF.
      CHRONB19                 :N3PF.
      CHRONB20                 :N3PF.
      CHRONB21                 :N3PF.
      CHRONB22                 :N3PF.
      CHRONB23                 :N3PF.
      CHRONB24                 :N3PF.
      CHRONB25                 :N3PF.
      DXMCCS1                  :$CHAR11.
      E_MCCS1                  :$CHAR11.
      HOSP_NRD                 :5.
      KEY_NRD                  :15.
      PCLASS1                  :N3PF.
      PCLASS2                  :N3PF.
      PCLASS3                  :N3PF.
      PCLASS4                  :N3PF.
      PCLASS5                  :N3PF.
      PCLASS6                  :N3PF.
      PCLASS7                  :N3PF.
      PCLASS8                  :N3PF.
      PCLASS9                  :N3PF.
      PCLASS10                 :N3PF.
      PCLASS11                 :N3PF.
      PCLASS12                 :N3PF.
      PCLASS13                 :N3PF.
      PCLASS14                 :N3PF.
      PCLASS15                 :N3PF.
      PRMCCS1                  :$CHAR8.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2010_DX_PR_GRPS_V2.SAS
 * Created on 09/28/2017.
 * This program will load the 2010 NRD csv DX_PR_GRPS_V2 File into SAS.
 *****************************************************************************/

/* Create SAS informats for missing values */
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

/* Data Step to load the file */
DATA NRD_2010_DX_PR_GRPS_V2; 
INFILE "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010_DX_PR_GRPS_V2.csv" dsd dlm=',' LRECL = 315;

/* Define data element attributes */
ATTRIB 
  CHRON1                     LENGTH=3
  LABEL="Chronic condition indicator 1"

  CHRON2                     LENGTH=3
  LABEL="Chronic condition indicator 2"

  CHRON3                     LENGTH=3
  LABEL="Chronic condition indicator 3"

  CHRON4                     LENGTH=3
  LABEL="Chronic condition indicator 4"

  CHRON5                     LENGTH=3
  LABEL="Chronic condition indicator 5"

  CHRON6                     LENGTH=3
  LABEL="Chronic condition indicator 6"

  CHRON7                     LENGTH=3
  LABEL="Chronic condition indicator 7"

  CHRON8                     LENGTH=3
  LABEL="Chronic condition indicator 8"

  CHRON9                     LENGTH=3
  LABEL="Chronic condition indicator 9"

  CHRON10                    LENGTH=3
  LABEL="Chronic condition indicator 10"

  CHRON11                    LENGTH=3
  LABEL="Chronic condition indicator 11"

  CHRON12                    LENGTH=3
  LABEL="Chronic condition indicator 12"

  CHRON13                    LENGTH=3
  LABEL="Chronic condition indicator 13"

  CHRON14                    LENGTH=3
  LABEL="Chronic condition indicator 14"

  CHRON15                    LENGTH=3
  LABEL="Chronic condition indicator 15"

  CHRON16                    LENGTH=3
  LABEL="Chronic condition indicator 16"

  CHRON17                    LENGTH=3
  LABEL="Chronic condition indicator 17"

  CHRON18                    LENGTH=3
  LABEL="Chronic condition indicator 18"

  CHRON19                    LENGTH=3
  LABEL="Chronic condition indicator 19"

  CHRON20                    LENGTH=3
  LABEL="Chronic condition indicator 20"

  CHRON21                    LENGTH=3
  LABEL="Chronic condition indicator 21"

  CHRON22                    LENGTH=3
  LABEL="Chronic condition indicator 22"

  CHRON23                    LENGTH=3
  LABEL="Chronic condition indicator 23"

  CHRON24                    LENGTH=3
  LABEL="Chronic condition indicator 24"

  CHRON25                    LENGTH=3
  LABEL="Chronic condition indicator 25"

  CHRONB1                    LENGTH=3
  LABEL="Chronic condition body system 1"

  CHRONB2                    LENGTH=3
  LABEL="Chronic condition body system 2"

  CHRONB3                    LENGTH=3
  LABEL="Chronic condition body system 3"

  CHRONB4                    LENGTH=3
  LABEL="Chronic condition body system 4"

  CHRONB5                    LENGTH=3
  LABEL="Chronic condition body system 5"

  CHRONB6                    LENGTH=3
  LABEL="Chronic condition body system 6"

  CHRONB7                    LENGTH=3
  LABEL="Chronic condition body system 7"

  CHRONB8                    LENGTH=3
  LABEL="Chronic condition body system 8"

  CHRONB9                    LENGTH=3
  LABEL="Chronic condition body system 9"

  CHRONB10                   LENGTH=3
  LABEL="Chronic condition body system 10"

  CHRONB11                   LENGTH=3
  LABEL="Chronic condition body system 11"

  CHRONB12                   LENGTH=3
  LABEL="Chronic condition body system 12"

  CHRONB13                   LENGTH=3
  LABEL="Chronic condition body system 13"

  CHRONB14                   LENGTH=3
  LABEL="Chronic condition body system 14"

  CHRONB15                   LENGTH=3
  LABEL="Chronic condition body system 15"

  CHRONB16                   LENGTH=3
  LABEL="Chronic condition body system 16"

  CHRONB17                   LENGTH=3
  LABEL="Chronic condition body system 17"

  CHRONB18                   LENGTH=3
  LABEL="Chronic condition body system 18"

  CHRONB19                   LENGTH=3
  LABEL="Chronic condition body system 19"

  CHRONB20                   LENGTH=3
  LABEL="Chronic condition body system 20"

  CHRONB21                   LENGTH=3
  LABEL="Chronic condition body system 21"

  CHRONB22                   LENGTH=3
  LABEL="Chronic condition body system 22"

  CHRONB23                   LENGTH=3
  LABEL="Chronic condition body system 23"

  CHRONB24                   LENGTH=3
  LABEL="Chronic condition body system 24"

  CHRONB25                   LENGTH=3
  LABEL="Chronic condition body system 25"

  DXMCCS1                    LENGTH=$11
  LABEL="Multi-Level CCS:  Diagnosis 1"

  E_MCCS1                    LENGTH=$11
  LABEL="Multi-Level CCS:  E Code 1"

  HOSP_NRD                   LENGTH=4
  LABEL="NRD hospital identifier"

  KEY_NRD                    LENGTH=8
  LABEL="NRD record identifier"

  PCLASS1                    LENGTH=3
  LABEL="Procedure class 1"

  PCLASS2                    LENGTH=3
  LABEL="Procedure class 2"

  PCLASS3                    LENGTH=3
  LABEL="Procedure class 3"

  PCLASS4                    LENGTH=3
  LABEL="Procedure class 4"

  PCLASS5                    LENGTH=3
  LABEL="Procedure class 5"

  PCLASS6                    LENGTH=3
  LABEL="Procedure class 6"

  PCLASS7                    LENGTH=3
  LABEL="Procedure class 7"

  PCLASS8                    LENGTH=3
  LABEL="Procedure class 8"

  PCLASS9                    LENGTH=3
  LABEL="Procedure class 9"

  PCLASS10                   LENGTH=3
  LABEL="Procedure class 10"

  PCLASS11                   LENGTH=3
  LABEL="Procedure class 11"

  PCLASS12                   LENGTH=3
  LABEL="Procedure class 12"

  PCLASS13                   LENGTH=3
  LABEL="Procedure class 13"

  PCLASS14                   LENGTH=3
  LABEL="Procedure class 14"

  PCLASS15                   LENGTH=3
  LABEL="Procedure class 15"

  PRMCCS1                    LENGTH=$8
  LABEL="Multi-Level CCS:  Procedure 1"
  ;

/* Read data elements from the CSV file */
INPUT 
      CHRON1                   :N3PF.
      CHRON2                   :N3PF.
      CHRON3                   :N3PF.
      CHRON4                   :N3PF.
      CHRON5                   :N3PF.
      CHRON6                   :N3PF.
      CHRON7                   :N3PF.
      CHRON8                   :N3PF.
      CHRON9                   :N3PF.
      CHRON10                  :N3PF.
      CHRON11                  :N3PF.
      CHRON12                  :N3PF.
      CHRON13                  :N3PF.
      CHRON14                  :N3PF.
      CHRON15                  :N3PF.
      CHRON16                  :N3PF.
      CHRON17                  :N3PF.
      CHRON18                  :N3PF.
      CHRON19                  :N3PF.
      CHRON20                  :N3PF.
      CHRON21                  :N3PF.
      CHRON22                  :N3PF.
      CHRON23                  :N3PF.
      CHRON24                  :N3PF.
      CHRON25                  :N3PF.
      CHRONB1                  :N3PF.
      CHRONB2                  :N3PF.
      CHRONB3                  :N3PF.
      CHRONB4                  :N3PF.
      CHRONB5                  :N3PF.
      CHRONB6                  :N3PF.
      CHRONB7                  :N3PF.
      CHRONB8                  :N3PF.
      CHRONB9                  :N3PF.
      CHRONB10                 :N3PF.
      CHRONB11                 :N3PF.
      CHRONB12                 :N3PF.
      CHRONB13                 :N3PF.
      CHRONB14                 :N3PF.
      CHRONB15                 :N3PF.
      CHRONB16                 :N3PF.
      CHRONB17                 :N3PF.
      CHRONB18                 :N3PF.
      CHRONB19                 :N3PF.
      CHRONB20                 :N3PF.
      CHRONB21                 :N3PF.
      CHRONB22                 :N3PF.
      CHRONB23                 :N3PF.
      CHRONB24                 :N3PF.
      CHRONB25                 :N3PF.
      DXMCCS1                  :$CHAR11.
      E_MCCS1                  :$CHAR11.
      HOSP_NRD                 :5.
      KEY_NRD                  :15.
      PCLASS1                  :N3PF.
      PCLASS2                  :N3PF.
      PCLASS3                  :N3PF.
      PCLASS4                  :N3PF.
      PCLASS5                  :N3PF.
      PCLASS6                  :N3PF.
      PCLASS7                  :N3PF.
      PCLASS8                  :N3PF.
      PCLASS9                  :N3PF.
      PCLASS10                 :N3PF.
      PCLASS11                 :N3PF.
      PCLASS12                 :N3PF.
      PCLASS13                 :N3PF.
      PCLASS14                 :N3PF.
      PCLASS15                 :N3PF.
      PRMCCS1                  :$CHAR8.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2010_Hospital.SAS
 * This program will load the 2010 NRD csv Hospital File into SAS.
 *****************************************************************************/

/* Create SAS informats for missing values */
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

/* Data Step to load the file */
DATA NRD_2010_Hospital; 
INFILE "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010_Hospital.csv" dsd dlm=',' LRECL = 66;

/* Define data element attributes */
ATTRIB 
  HOSP_BEDSIZE               LENGTH=3
  LABEL="Bed size of hospital"

  H_CONTRL                   LENGTH=3
  LABEL="Control/ownership of hospital"

  HOSP_NRD                   LENGTH=4
  LABEL="NRD hospital identifier"

  HOSP_URCAT4                LENGTH=3
  LABEL="Hospital urban-rural designation"

  HOSP_UR_TEACH              LENGTH=3
  LABEL="Teaching status of urban hospitals"

  NRD_STRATUM                LENGTH=3
  LABEL="NRD stratum used for weighting"

  N_DISC_U                   LENGTH=5
  LABEL="Number of universe discharges in NRD_STRATUM"

  N_HOSP_U                   LENGTH=3
  LABEL="Number of universe hospitals in NRD_STRATUM"

  S_DISC_U                   LENGTH=4
  LABEL="Number of sample discharges in NRD_STRATUM"

  S_HOSP_U                   LENGTH=4
  LABEL="Number of universe hospitals in NRD_STRATUM"

  TOTAL_DISC                 LENGTH=4
  LABEL="Total hospital discharges"

  YEAR                       LENGTH=3
  LABEL="Calendar year"
  ;

/* Read data elements from the CSV file */
INPUT 
      HOSP_BEDSIZE             :N2PF.
      H_CONTRL                 :N2PF.
      HOSP_NRD                 :5.
      HOSP_URCAT4              :N2PF.
      HOSP_UR_TEACH            :N2PF.
      NRD_STRATUM              :N5PF.
      N_DISC_U                 :N8PF.
      N_HOSP_U                 :N4PF.
      S_DISC_U                 :N8PF.
      S_HOSP_U                 :N6PF.
      TOTAL_DISC               :N6PF.
      YEAR                     :N4PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2010_Hospital_V2.SAS
 * Created on 09/28/2017.
 * This program will load the 2010 NRD csv Hospital_V2 File into SAS.
 *****************************************************************************/

/* Create SAS informats for missing values */
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

/* Data Step to load the file */
DATA NRD_2010_Hospital_V2; 
INFILE "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010_Hospital_V2.csv" dsd dlm=',' LRECL = 66;

/* Define data element attributes */
ATTRIB 
  HOSP_BEDSIZE               LENGTH=3
  LABEL="Bed size of hospital"

  H_CONTRL                   LENGTH=3
  LABEL="Control/ownership of hospital"

  HOSP_NRD                   LENGTH=4
  LABEL="NRD hospital identifier"

  HOSP_URCAT4                LENGTH=3
  LABEL="Hospital urban-rural designation"

  HOSP_UR_TEACH              LENGTH=3
  LABEL="Teaching status of urban hospitals"

  NRD_STRATUM                LENGTH=3
  LABEL="NRD stratum used for weighting"

  N_DISC_U                   LENGTH=5
  LABEL="Number of universe discharges in NRD_STRATUM"

  N_HOSP_U                   LENGTH=3
  LABEL="Number of universe hospitals in NRD_STRATUM"

  S_DISC_U                   LENGTH=4
  LABEL="Number of sample discharges in NRD_STRATUM"

  S_HOSP_U                   LENGTH=4
  LABEL="Number of universe hospitals in NRD_STRATUM"

  TOTAL_DISC                 LENGTH=4
  LABEL="Total hospital discharges"

  YEAR                       LENGTH=3
  LABEL="Calendar year"
  ;

/* Read data elements from the CSV file */
INPUT 
      HOSP_BEDSIZE             :N2PF.
      H_CONTRL                 :N2PF.
      HOSP_NRD                 :5.
      HOSP_URCAT4              :N2PF.
      HOSP_UR_TEACH            :N2PF.
      NRD_STRATUM              :N5PF.
      N_DISC_U                 :N8PF.
      N_HOSP_U                 :N4PF.
      S_DISC_U                 :N8PF.
      S_HOSP_U                 :N6PF.
      TOTAL_DISC               :N6PF.
      YEAR                     :N4PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2010_Severity.SAS
 * This program will load the 2010 NRD csv Severity File into SAS.
 *****************************************************************************/

/* Create SAS informats for missing values */
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

/* Data Step to load the file */
DATA NRD_2010_Severity; 
INFILE "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010_Severity.csv" dsd dlm=',' LRECL = 120;

/* Define data element attributes */
ATTRIB 
  APRDRG                     LENGTH=3
  LABEL="All Patient Refined DRG"

  APRDRG_Risk_Mortality      LENGTH=3
  LABEL="All Patient Refined DRG: Risk of Mortality Subclass"

  APRDRG_Severity            LENGTH=3
  LABEL="All Patient Refined DRG: Severity of Illness Subclass"

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

  HOSP_NRD                   LENGTH=4
  LABEL="NRD hospital identifier"

  KEY_NRD                    LENGTH=8
  LABEL="NRD record identifier"
  ;

/* Read data elements from the CSV file */
INPUT 
      APRDRG                   :N4PF.
      APRDRG_Risk_Mortality    :N2PF.
      APRDRG_Severity          :N2PF.
      CM_AIDS                  :N2PF.
      CM_ALCOHOL               :N2PF.
      CM_ANEMDEF               :N2PF.
      CM_ARTH                  :N2PF.
      CM_BLDLOSS               :N2PF.
      CM_CHF                   :N2PF.
      CM_CHRNLUNG              :N2PF.
      CM_COAG                  :N2PF.
      CM_DEPRESS               :N2PF.
      CM_DM                    :N2PF.
      CM_DMCX                  :N2PF.
      CM_DRUG                  :N2PF.
      CM_HTN_C                 :N2PF.
      CM_HYPOTHY               :N2PF.
      CM_LIVER                 :N2PF.
      CM_LYMPH                 :N2PF.
      CM_LYTES                 :N2PF.
      CM_METS                  :N2PF.
      CM_NEURO                 :N2PF.
      CM_OBESE                 :N2PF.
      CM_PARA                  :N2PF.
      CM_PERIVASC              :N2PF.
      CM_PSYCH                 :N2PF.
      CM_PULMCIRC              :N2PF.
      CM_RENLFAIL              :N2PF.
      CM_TUMOR                 :N2PF.
      CM_ULCER                 :N2PF.
      CM_VALVE                 :N2PF.
      CM_WGHTLOSS              :N2PF.
      HOSP_NRD                 :5.
      KEY_NRD                  :15.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2010_Severity_V2.SAS
 * Created on 09/28/2017.
 * This program will load the 2010 NRD csv Severity_V2 File into SAS.
 *****************************************************************************/

/* Create SAS informats for missing values */
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

/* Data Step to load the file */
DATA NRD_2010_Severity_V2; 
INFILE "%trim(&filepath)NRD/NRD_2010/Data/NRD_2010_Severity_V2.csv" dsd dlm=',' LRECL = 120;

/* Define data element attributes */
ATTRIB 
  APRDRG                     LENGTH=3
  LABEL="All Patient Refined DRG"

  APRDRG_Risk_Mortality      LENGTH=3
  LABEL="All Patient Refined DRG: Risk of Mortality Subclass"

  APRDRG_Severity            LENGTH=3
  LABEL="All Patient Refined DRG: Severity of Illness Subclass"

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

  HOSP_NRD                   LENGTH=4
  LABEL="NRD hospital identifier"

  KEY_NRD                    LENGTH=8
  LABEL="NRD record identifier"
  ;

/* Read data elements from the CSV file */
INPUT 
      APRDRG                   :N4PF.
      APRDRG_Risk_Mortality    :N2PF.
      APRDRG_Severity          :N2PF.
      CM_AIDS                  :N2PF.
      CM_ALCOHOL               :N2PF.
      CM_ANEMDEF               :N2PF.
      CM_ARTH                  :N2PF.
      CM_BLDLOSS               :N2PF.
      CM_CHF                   :N2PF.
      CM_CHRNLUNG              :N2PF.
      CM_COAG                  :N2PF.
      CM_DEPRESS               :N2PF.
      CM_DM                    :N2PF.
      CM_DMCX                  :N2PF.
      CM_DRUG                  :N2PF.
      CM_HTN_C                 :N2PF.
      CM_HYPOTHY               :N2PF.
      CM_LIVER                 :N2PF.
      CM_LYMPH                 :N2PF.
      CM_LYTES                 :N2PF.
      CM_METS                  :N2PF.
      CM_NEURO                 :N2PF.
      CM_OBESE                 :N2PF.
      CM_PARA                  :N2PF.
      CM_PERIVASC              :N2PF.
      CM_PSYCH                 :N2PF.
      CM_PULMCIRC              :N2PF.
      CM_RENLFAIL              :N2PF.
      CM_TUMOR                 :N2PF.
      CM_ULCER                 :N2PF.
      CM_VALVE                 :N2PF.
      CM_WGHTLOSS              :N2PF.
      HOSP_NRD                 :5.
      KEY_NRD                  :15.
      ;
RUN;


proc SQL;
create table isilon.NRD_2010_Core_V2
like work.NRD_2010_Core_V2;

proc SQL;
insert into isilon.NRD_2010_Core_V2
select * from work.NRD_2010_Core_V2;

proc SQL;
create table isilon.NRD_2010_DX_PR_GRPS_V2
like work.NRD_2010_DX_PR_GRPS_V2;

proc SQL;
insert into isilon.NRD_2010_DX_PR_GRPS_V2
select * from work.NRD_2010_DX_PR_GRPS_V2;

proc SQL;
create table isilon.NRD_2010_Hospital_V2
like work.NRD_2010_Hospital_V2;

proc SQL;
insert into isilon.NRD_2010_Hospital_V2
select * from work.NRD_2010_Hospital_V2;

proc SQL;
create table isilon.NRD_2010_Severity_V2
like work.NRD_2010_Severity_V2;

proc SQL;
insert into isilon.NRD_2010_Severity_V2
select * from work.NRD_2010_Severity_V2;




proc delete data= work.NRD_2010_Core_V2; run;
proc delete data= work.NRD_2010_DX_PR_GRPS_V2; run;
proc delete data= work.NRD_2010_Hospital_V2; run;
proc delete data= work.NRD_2010_Severity_V2; run;
proc delete data= work.NRD_2010_Core; run;
proc delete data= work.NRD_2010_DX_PR_GRPS; run;
proc delete data= work.NRD_2010_Hospital; run;
proc delete data= work.NRD_2010_Severity; run;
