*Developer: John Lawrence*
*Date: 12/24/21*
*This code should load a bunch of NEDS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* INFILE "%trim(&filepath)NEDS/NEDS_2016/Data/NEDS_2016_   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

/*****************************************************************************
 * SASload_NEDS_2016_IP.SAS
 * This program will load the NEDS 2016 IP csv File into SAS.
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
DATA NEDS_2016_IP; 
INFILE "%trim(&filepath)NEDS/NEDS_2016/Data/NEDS_2016_IP.csv" dsd dlm=',' LRECL = 141;

/* Define data element attributes */
ATTRIB 
  HOSP_ED                    LENGTH=4            FORMAT=Z5.
  LABEL="HCUP ED hospital identifier"

  KEY_ED                     LENGTH=8            FORMAT=Z14.
  LABEL="HCUP NEDS record identifier"

  DISP_IP                    LENGTH=3
  LABEL="Disposition of patient (uniform) from IP"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DRG_NoPOA                  LENGTH=3
  LABEL="DRG in use on discharge date, calculated without POA"

  I10_NPR_IP                 LENGTH=3
  LABEL="Number of ICD-10-PCS procedures from inpatient discharge record"

  I10_PR_IP1                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 1 from inpatient discharge record"

  I10_PR_IP2                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 2 from inpatient discharge record"

  I10_PR_IP3                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 3 from inpatient discharge record"

  I10_PR_IP4                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 4 from inpatient discharge record"

  I10_PR_IP5                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 5 from inpatient discharge record"

  I10_PR_IP6                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 6 from inpatient discharge record"

  I10_PR_IP7                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 7 from inpatient discharge record"

  I10_PR_IP8                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 8 from inpatient discharge record"

  I10_PR_IP9                 LENGTH=$7
  LABEL="ICD-10-PCS Procedure 9 from inpatient discharge record"

  LOS_IP                     LENGTH=4
  LABEL="Length of stay (cleaned) from IP"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC_NoPOA                  LENGTH=3
  LABEL="MDC in use on discharge date, calculated without POA"

  PRVER                      LENGTH=3
  LABEL="Procedure Version"

  TOTCHG_IP                  LENGTH=6
  LABEL="Total charge for ED and inpatient services"
  ;

/* Read data elements from the CSV file */
INPUT 
      HOSP_ED                  :5.
      KEY_ED                   :16.
      DISP_IP                  :N2PF.
      DRG                      :N3PF.
      DRGVER                   :N2PF.
      DRG_NoPOA                :N3PF.
      I10_NPR_IP               :N3PF.
      I10_PR_IP1               :$CHAR7.
      I10_PR_IP2               :$CHAR7.
      I10_PR_IP3               :$CHAR7.
      I10_PR_IP4               :$CHAR7.
      I10_PR_IP5               :$CHAR7.
      I10_PR_IP6               :$CHAR7.
      I10_PR_IP7               :$CHAR7.
      I10_PR_IP8               :$CHAR7.
      I10_PR_IP9               :$CHAR7.
      LOS_IP                   :N5PF.
      MDC                      :N2PF.
      MDC_NoPOA                :N2PF.
      PRVER                    :N2PF.
      TOTCHG_IP                :N12P2F.
      ;
RUN;
/*****************************************************************************
 * SASload_NEDS_2016_Core.SAS
 * This program will load the NEDS 2016 Core csv File into SAS.
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
DATA NEDS_2016_Core; 
INFILE "%trim(&filepath)NEDS/NEDS_2016/Data/NEDS_2016_Core.csv" dsd dlm=',' LRECL = 385;

/* Define data element attributes */
ATTRIB 
  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AMONTH                     LENGTH=3
  LABEL="Admission month"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED_VISIT                 LENGTH=3
  LABEL="Died in the ED (1), Died in the hospital (2), did not die (0)"

  DISCWT                     LENGTH=8
  LABEL="Weight to ED Visits in AHA universe"

  DISP_ED                    LENGTH=3
  LABEL="Disposition of patient (uniform) from ED"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DXVER                      LENGTH=3
  LABEL="Diagnosis Version"

  EDEVENT                    LENGTH=3
  LABEL="Type of ED Event"

  FEMALE                     LENGTH=3
  LABEL="Indicator of sex"

  HCUPFILE                   LENGTH=$4
  LABEL="Source of HCUP Record (SID or SEDD)"

  HOSP_ED                    LENGTH=4            FORMAT=Z5.
  LABEL="HCUP ED hospital identifier"

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
  LABEL="ICD-10-CM E Cause 1"

  I10_ECAUSE2                LENGTH=$7
  LABEL="ICD-10-CM E Cause 2"

  I10_ECAUSE3                LENGTH=$7
  LABEL="ICD-10-CM E Cause 3"

  I10_ECAUSE4                LENGTH=$7
  LABEL="ICD-10-CM E Cause 4"

  I10_NDX                    LENGTH=3
  LABEL="ICD-10-CM Number of diagnoses on this record"

  I10_NECAUSE                LENGTH=3
  LABEL="ICD-10-CM Number of E Causes on this record"

  KEY_ED                     LENGTH=8            FORMAT=Z14.
  LABEL="HCUP NEDS record identifier"

  NEDS_STRATUM               LENGTH=4            FORMAT=5.
  LABEL="Stratum used to sample hospital"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY2                       LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PL_NCHS                    LENGTH=3
  LABEL="Patient Location: NCHS Urban-Rural Code"

  TOTCHG_ED                  LENGTH=6
  LABEL="Total charge for ED services"

  YEAR                       LENGTH=3
  LABEL="Calendar year"

  ZIPINC_QRTL                LENGTH=3
  LABEL="Median household income national quartile for patient ZIP Code"
  ;

/* Read data elements from the CSV file */
INPUT 
      AGE                      :N3PF.
      AMONTH                   :N2PF.
      AWEEKEND                 :N2PF.
      DIED_VISIT               :N2PF.
      DISCWT                   :N11P7F.
      DISP_ED                  :N2PF.
      DQTR                     :N2PF.
      DXVER                    :N2PF.
      EDEVENT                  :N2PF.
      FEMALE                   :N2PF.
      HCUPFILE                 :$CHAR4.
      HOSP_ED                  :5.
      I10_DX1                  :$CHAR7.
      I10_DX2                  :$CHAR7.
      I10_DX3                  :$CHAR7.
      I10_DX4                  :$CHAR7.
      I10_DX5                  :$CHAR7.
      I10_DX6                  :$CHAR7.
      I10_DX7                  :$CHAR7.
      I10_DX8                  :$CHAR7.
      I10_DX9                  :$CHAR7.
      I10_DX10                 :$CHAR7.
      I10_DX11                 :$CHAR7.
      I10_DX12                 :$CHAR7.
      I10_DX13                 :$CHAR7.
      I10_DX14                 :$CHAR7.
      I10_DX15                 :$CHAR7.
      I10_DX16                 :$CHAR7.
      I10_DX17                 :$CHAR7.
      I10_DX18                 :$CHAR7.
      I10_DX19                 :$CHAR7.
      I10_DX20                 :$CHAR7.
      I10_DX21                 :$CHAR7.
      I10_DX22                 :$CHAR7.
      I10_DX23                 :$CHAR7.
      I10_DX24                 :$CHAR7.
      I10_DX25                 :$CHAR7.
      I10_DX26                 :$CHAR7.
      I10_DX27                 :$CHAR7.
      I10_DX28                 :$CHAR7.
      I10_DX29                 :$CHAR7.
      I10_DX30                 :$CHAR7.
      I10_ECAUSE1              :$CHAR7.
      I10_ECAUSE2              :$CHAR7.
      I10_ECAUSE3              :$CHAR7.
      I10_ECAUSE4              :$CHAR7.
      I10_NDX                  :N3PF.
      I10_NECAUSE              :N3PF.
      KEY_ED                   :16.
      NEDS_STRATUM             :N5PF.
      PAY1                     :N2PF.
      PAY2                     :N2PF.
      PL_NCHS                  :N3PF.
      TOTCHG_ED                :N12P2F.
      YEAR                     :N4PF.
      ZIPINC_QRTL              :N2PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NEDS_2016_ED.SAS
 * This program will load the NEDS 2016 ED csv File into SAS.
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
DATA NEDS_2016_ED; 
INFILE "%trim(&filepath)NEDS/NEDS_2016/Data/NEDS_2016_ED.csv" dsd dlm=',' LRECL = 193;

/* Define data element attributes */
ATTRIB 
  HOSP_ED                    LENGTH=4            FORMAT=Z5.
  LABEL="HCUP ED hospital identifier"

  KEY_ED                     LENGTH=8            FORMAT=Z14.
  LABEL="HCUP NEDS record identifier"

  CPT1                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 1"

  CPT2                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 2"

  CPT3                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 3"

  CPT4                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 4"

  CPT5                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 5"

  CPT6                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 6"

  CPT7                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 7"

  CPT8                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 8"

  CPT9                       LENGTH=$5
  LABEL="CPT/HCPCS procedure code 9"

  CPT10                      LENGTH=$5
  LABEL="CPT/HCPCS procedure code 10"

  CPT11                      LENGTH=$5
  LABEL="CPT/HCPCS procedure code 11"

  CPT12                      LENGTH=$5
  LABEL="CPT/HCPCS procedure code 12"

  CPT13                      LENGTH=$5
  LABEL="CPT/HCPCS procedure code 13"

  CPT14                      LENGTH=$5
  LABEL="CPT/HCPCS procedure code 14"

  CPT15                      LENGTH=$5
  LABEL="CPT/HCPCS procedure code 15"

  CPTCCS1                    LENGTH=4
  LABEL="CCS: CPT 1"

  CPTCCS2                    LENGTH=4
  LABEL="CCS: CPT 2"

  CPTCCS3                    LENGTH=4
  LABEL="CCS: CPT 3"

  CPTCCS4                    LENGTH=4
  LABEL="CCS: CPT 4"

  CPTCCS5                    LENGTH=4
  LABEL="CCS: CPT 5"

  CPTCCS6                    LENGTH=4
  LABEL="CCS: CPT 6"

  CPTCCS7                    LENGTH=4
  LABEL="CCS: CPT 7"

  CPTCCS8                    LENGTH=4
  LABEL="CCS: CPT 8"

  CPTCCS9                    LENGTH=4
  LABEL="CCS: CPT 9"

  CPTCCS10                   LENGTH=4
  LABEL="CCS: CPT 10"

  CPTCCS11                   LENGTH=4
  LABEL="CCS: CPT 11"

  CPTCCS12                   LENGTH=4
  LABEL="CCS: CPT 12"

  CPTCCS13                   LENGTH=4
  LABEL="CCS: CPT 13"

  CPTCCS14                   LENGTH=4
  LABEL="CCS: CPT 14"

  CPTCCS15                   LENGTH=4
  LABEL="CCS: CPT 15"

  NCPT                       LENGTH=3
  LABEL="Number of CPT/HCPCS procedures for this visit"
  ;

/* Read data elements from the CSV file */
INPUT 
      HOSP_ED                  :5.
      KEY_ED                   :16.
      CPT1                     :$CHAR5.
      CPT2                     :$CHAR5.
      CPT3                     :$CHAR5.
      CPT4                     :$CHAR5.
      CPT5                     :$CHAR5.
      CPT6                     :$CHAR5.
      CPT7                     :$CHAR5.
      CPT8                     :$CHAR5.
      CPT9                     :$CHAR5.
      CPT10                    :$CHAR5.
      CPT11                    :$CHAR5.
      CPT12                    :$CHAR5.
      CPT13                    :$CHAR5.
      CPT14                    :$CHAR5.
      CPT15                    :$CHAR5.
      CPTCCS1                  :N4PF.
      CPTCCS2                  :N4PF.
      CPTCCS3                  :N4PF.
      CPTCCS4                  :N4PF.
      CPTCCS5                  :N4PF.
      CPTCCS6                  :N4PF.
      CPTCCS7                  :N4PF.
      CPTCCS8                  :N4PF.
      CPTCCS9                  :N4PF.
      CPTCCS10                 :N4PF.
      CPTCCS11                 :N4PF.
      CPTCCS12                 :N4PF.
      CPTCCS13                 :N4PF.
      CPTCCS14                 :N4PF.
      CPTCCS15                 :N4PF.
      NCPT                     :N4PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NEDS_2016_Hospital.SAS
 * This program will load the NEDS 2016 Hospital csv File into SAS.
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
DATA NEDS_2016_Hospital; 
INFILE "%trim(&filepath)NEDS/NEDS_2016/Data/NEDS_2016_Hospital.csv" dsd dlm=',' LRECL = 93;

/* Define data element attributes */
ATTRIB 
  DISCWT                     LENGTH=8
  LABEL="Weight to ED Visits in AHA universe"

  HOSPWT                     LENGTH=8
  LABEL="Weight to hospitals in AHA universe"

  HOSP_CONTROL               LENGTH=3            FORMAT=1.
  LABEL="Control/ownership of hospital"

  HOSP_ED                    LENGTH=4            FORMAT=Z5.
  LABEL="HCUP ED hospital identifier"

  HOSP_REGION                LENGTH=3            FORMAT=1.
  LABEL="Region of hospital"

  HOSP_TRAUMA                LENGTH=3
  LABEL="Trauma level designation"

  HOSP_URCAT4                LENGTH=3
  LABEL="Hospital urban-rural designation"

  HOSP_UR_TEACH              LENGTH=3            FORMAT=1.
  LABEL="Teaching status of hospital"

  NEDS_STRATUM               LENGTH=4            FORMAT=5.
  LABEL="Stratum used to sample hospital"

  N_DISC_U                   LENGTH=5
  LABEL="Number of AHA universe ED visits in NEDS_STRATUM"

  N_HOSP_U                   LENGTH=3
  LABEL="Number of AHA universe hospitals in NEDS_STRATUM"

  S_DISC_U                   LENGTH=5
  LABEL="Number of sample discharges in NEDS_STRATUM"

  S_HOSP_U                   LENGTH=3
  LABEL="Number of sample hospitals in NEDS_STRATUM"

  TOTAL_EDVisits             LENGTH=5
  LABEL="Total number of ED visits from this hospital in the NEDS"

  YEAR                       LENGTH=3
  LABEL="Calendar Year"
  ;

/* Read data elements from the CSV file */
INPUT 
      DISCWT                   :N11P7F.
      HOSPWT                   :N11P7F.
      HOSP_CONTROL             :N2PF.
      HOSP_ED                  :5.
      HOSP_REGION              :N2PF.
      HOSP_TRAUMA              :N2PF.
      HOSP_URCAT4              :N2PF.
      HOSP_UR_TEACH            :N2PF.
      NEDS_STRATUM             :N5PF.
      N_DISC_U                 :N8PF.
      N_HOSP_U                 :N4PF.
      S_DISC_U                 :N8PF.
      S_HOSP_U                 :N4PF.
      TOTAL_EDVisits           :N8PF.
      YEAR                     :N4PF.
      ;
RUN;




proc SQL;
create table isilon.NEDS_2016_Core
like work.NEDS_2016_Core;

proc SQL;
insert into isilon.NEDS_2016_Core
select * from work.NEDS_2016_Core;

proc SQL;
create table isilon.NEDS_2016_IP
like work.NEDS_2016_IP;

proc SQL;
insert into isilon.NEDS_2016_IP
select * from work.NEDS_2016_IP;

proc SQL;
create table isilon.NEDS_2016_ED
like work.NEDS_2016_ED;

proc SQL;
insert into isilon.NEDS_2016_ED
select * from work.NEDS_2016_ED;

proc SQL;
create table isilon.NEDS_2016_Hospital
like work.NEDS_2016_Hospital;

proc SQL;
insert into isilon.NEDS_2016_Hospital
select * from work.NEDS_2016_Hospital;



proc delete data= work.NEDS_2016_Core; run;
proc delete data= work.NEDS_2016_IP; run;
proc delete data= work.NEDS_2016_ED; run;
proc delete data= work.NEDS_2016_Hospital; run;