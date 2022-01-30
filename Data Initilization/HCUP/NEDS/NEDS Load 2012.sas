*Developer: John Lawrence*
*Date: 12/24/21*
*This code should load a bunch of NEDS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* INFILE "%trim(&filepath)NEDS/NEDS_2012/Data/NEDS_2012_   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;


/*****************************************************************************
 * SASload_NEDS_2012_IP.SAS
 * This program will load the 2012 NEDS csv IP File into SAS.
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
DATA NEDS_2012_IP; 
INFILE "%trim(&filepath)NEDS/NEDS_2012/Data/NEDS_2012_IP.csv" dsd dlm=',' LRECL = 183;                                                                                                                                                                                                    

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

  DRG_NOPOA                  LENGTH=3
  LABEL="DRG in use on discharge date, calculated without POA"

  LOS_IP                     LENGTH=4
  LABEL="Length of stay (cleaned) from IP"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC_NOPOA                  LENGTH=3
  LABEL="MDC in use on discharge date, calculated without POA"

  NPR_IP                     LENGTH=3
  LABEL="Number of procedures from inpatient discharge record"

  PCLASS_IP1                 LENGTH=3
  LABEL="Principal procedure class for inpatient procedure"

  PCLASS_IP2                 LENGTH=3
  LABEL="Procedure class 2 for inpatient procedure"

  PCLASS_IP3                 LENGTH=3
  LABEL="Procedure class 3 for inpatient procedure"

  PCLASS_IP4                 LENGTH=3
  LABEL="Procedure class 4 for inpatient procedure"

  PCLASS_IP5                 LENGTH=3
  LABEL="Procedure class 5 for inpatient procedure"

  PCLASS_IP6                 LENGTH=3
  LABEL="Procedure class 6 for inpatient procedure"

  PCLASS_IP7                 LENGTH=3
  LABEL="Procedure class 7 for inpatient procedure"

  PCLASS_IP8                 LENGTH=3
  LABEL="Procedure class 8 for inpatient procedure"

  PCLASS_IP9                 LENGTH=3
  LABEL="Procedure class 9 for inpatient procedure"

  PR_IP1                     LENGTH=$4
  LABEL="Principal procedure from inpatient discharge record"

  PR_IP2                     LENGTH=$4
  LABEL="Procedure 2 from inpatient discharge record"

  PR_IP3                     LENGTH=$4
  LABEL="Procedure 3 from inpatient discharge record"

  PR_IP4                     LENGTH=$4
  LABEL="Procedure 4 from inpatient discharge record"

  PR_IP5                     LENGTH=$4
  LABEL="Procedure 5 from inpatient discharge record"

  PR_IP6                     LENGTH=$4
  LABEL="Procedure 6 from inpatient discharge record"

  PR_IP7                     LENGTH=$4
  LABEL="Procedure 7 from inpatient discharge record"

  PR_IP8                     LENGTH=$4
  LABEL="Procedure 8 from inpatient discharge record"

  PR_IP9                     LENGTH=$4
  LABEL="Procedure 9 from inpatient discharge record"

  PRCCS_IP1                  LENGTH=3
  LABEL="CCS: principal procedure from inpatient discharge record"

  PRCCS_IP2                  LENGTH=3
  LABEL="CCS: procedure 2 from inpatient discharge record"

  PRCCS_IP3                  LENGTH=3
  LABEL="CCS: procedure 3 from inpatient discharge record"

  PRCCS_IP4                  LENGTH=3
  LABEL="CCS: procedure 4 from inpatient discharge record"

  PRCCS_IP5                  LENGTH=3
  LABEL="CCS: procedure 5 from inpatient discharge record"

  PRCCS_IP6                  LENGTH=3
  LABEL="CCS: procedure 6 from inpatient discharge record"

  PRCCS_IP7                  LENGTH=3
  LABEL="CCS: procedure 7 from inpatient discharge record"

  PRCCS_IP8                  LENGTH=3
  LABEL="CCS: procedure 8 from inpatient discharge record"

  PRCCS_IP9                  LENGTH=3
  LABEL="CCS: procedure 9 from inpatient discharge record"

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
      DRG_NOPOA                :N3PF.
      LOS_IP                   :N5PF.
      MDC                      :N2PF.
      MDC_NOPOA                :N2PF.
      NPR_IP                   :N3PF.
      PCLASS_IP1               :N3PF.
      PCLASS_IP2               :N3PF.
      PCLASS_IP3               :N3PF.
      PCLASS_IP4               :N3PF.
      PCLASS_IP5               :N3PF.
      PCLASS_IP6               :N3PF.
      PCLASS_IP7               :N3PF.
      PCLASS_IP8               :N3PF.
      PCLASS_IP9               :N3PF.
      PR_IP1                   :$CHAR4.
      PR_IP2                   :$CHAR4.
      PR_IP3                   :$CHAR4.
      PR_IP4                   :$CHAR4.
      PR_IP5                   :$CHAR4.
      PR_IP6                   :$CHAR4.
      PR_IP7                   :$CHAR4.
      PR_IP8                   :$CHAR4.
      PR_IP9                   :$CHAR4.
      PRCCS_IP1                :N3PF.
      PRCCS_IP2                :N3PF.
      PRCCS_IP3                :N3PF.
      PRCCS_IP4                :N3PF.
      PRCCS_IP5                :N3PF.
      PRCCS_IP6                :N3PF.
      PRCCS_IP7                :N3PF.
      PRCCS_IP8                :N3PF.
      PRCCS_IP9                :N3PF.
      TOTCHG_IP                :N12P2F.
      ;
RUN;
/*****************************************************************************
 * SASload_NEDS_2012_Core.SAS
 * This program will load the 2012 NEDS csv Core File into SAS.
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
DATA NEDS_2012_Core; 
INFILE "%trim(&filepath)NEDS/NEDS_2012/Data/NEDS_2012_Core.csv" dsd dlm=',' LRECL = 415;                                                                                                                                                                                                    

/* Define data element attributes */
ATTRIB 
  AGE                        LENGTH=3
  LABEL="Age in years at admission"

  AMONTH                     LENGTH=3
  LABEL="Admission month"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

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

  DIED_VISIT                 LENGTH=3
  LABEL="Died in the ED (1), Died in the hospital (2), did not die (0)"

  DISCWT                     LENGTH=8
  LABEL="Weight to ED Visits in AHA universe"

  DISP_ED                    LENGTH=3
  LABEL="Disposition of patient (uniform) from ED"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

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

  ECODE1                     LENGTH=$5
  LABEL="E code 1"

  ECODE2                     LENGTH=$5
  LABEL="E code 2"

  ECODE3                     LENGTH=$5
  LABEL="E code 3"

  ECODE4                     LENGTH=$5
  LABEL="E code 4"

  EDEVENT                    LENGTH=3
  LABEL="Type of ED Event"

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

  HCUPFILE                   LENGTH=$4
  LABEL="Source of HCUP Record (SID or SEDD)"

  HOSP_ED                    LENGTH=4            FORMAT=Z5.
  LABEL="HCUP ED hospital identifier"

  INJURY                     LENGTH=3
  LABEL="Injury diagnosis reported on record (1:DX1 is an injury; 2:DX2+ is an injury; 0:No injury)"

  INJURY_CUT                 LENGTH=3
  LABEL="Injury by cutting or piercing (by E codes)"

  INJURY_DROWN               LENGTH=3
  LABEL="Injury by drowning or submersion (by E codes)"

  INJURY_FALL                LENGTH=3
  LABEL="Injury by falling (by E codes)"

  INJURY_FIRE                LENGTH=3
  LABEL="Injury by fire, flame or hot object (by E codes)"

  INJURY_FIREARM             LENGTH=3
  LABEL="Injury by firearm (by E codes)"

  INJURY_MACHINERY           LENGTH=3
  LABEL="Injury by machinery (by E codes)"

  INJURY_MVT                 LENGTH=3
  LABEL="Injury involving motor vehicle traffic (by E codes)"

  INJURY_NATURE              LENGTH=3
  LABEL="Injury involving nature or environmental factors (by E codes)"

  INJURY_POISON              LENGTH=3
  LABEL="Injury by poison (by E codes)"

  INJURY_SEVERITY            LENGTH=3            FORMAT=BEST12.
  LABEL="Injury severity score assigned by ICDPIC Stata program"

  INJURY_STRUCK              LENGTH=3
  LABEL="Injury from being struck by or against (by E codes)"

  INJURY_SUFFOCATION         LENGTH=3
  LABEL="Injury by suffocation (by E codes)"

  INTENT_ASSAULT             LENGTH=3
  LABEL="Injury by assault indicated on the record (by E codes)"

  INTENT_SELF_HARM           LENGTH=3
  LABEL="Intentional self harm indicated on the record (by diagnosis and/or E codes)"

  INTENT_UNINTENTIONAL       LENGTH=3
  LABEL="Unintentional injury indicated on the record (by E codes)"

  KEY_ED                     LENGTH=8            FORMAT=Z14.
  LABEL="HCUP NEDS record identifier"

  MULTINJURY                 LENGTH=3
  LABEL="More than one injury diagnosis reported on record"

  NDX                        LENGTH=3
  LABEL="Number of diagnoses on this record"

  NECODE                     LENGTH=3
  LABEL="Number of E codes on this record"

  NEDS_STRATUM               LENGTH=4            FORMAT=5.
  LABEL="Stratum used to sample hospital"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY2                       LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PL_NCHS2006                LENGTH=3
  LABEL="Patient Location: NCHS Urban-Rural Code (V2006)"

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
      DIED_VISIT               :N2PF.
      DISCWT                   :N11P7F.
      DISP_ED                  :N2PF.
      DQTR                     :N2PF.
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
      ECODE1                   :$CHAR5.
      ECODE2                   :$CHAR5.
      ECODE3                   :$CHAR5.
      ECODE4                   :$CHAR5.
      EDEVENT                  :N2PF.
      E_CCS1                   :N4PF.
      E_CCS2                   :N4PF.
      E_CCS3                   :N4PF.
      E_CCS4                   :N4PF.
      FEMALE                   :N2PF.
      HCUPFILE                 :$CHAR4.
      HOSP_ED                  :5.
      INJURY                   :N2PF.
      INJURY_CUT               :N2PF.
      INJURY_DROWN             :N2PF.
      INJURY_FALL              :N2PF.
      INJURY_FIRE              :N2PF.
      INJURY_FIREARM           :N2PF.
      INJURY_MACHINERY         :N2PF.
      INJURY_MVT               :N2PF.
      INJURY_NATURE            :N2PF.
      INJURY_POISON            :N2PF.
      INJURY_SEVERITY          :N2PF.
      INJURY_STRUCK            :N2PF.
      INJURY_SUFFOCATION       :N2PF.
      INTENT_ASSAULT           :N2PF.
      INTENT_SELF_HARM         :N2PF.
      INTENT_UNINTENTIONAL     :N2PF.
      KEY_ED                   :16.
      MULTINJURY               :N2PF.
      NDX                      :N3PF.
      NECODE                   :N3PF.
      NEDS_STRATUM             :N5PF.
      PAY1                     :N2PF.
      PAY2                     :N2PF.
      PL_NCHS2006              :N3PF.
      TOTCHG_ED                :N12P2F.
      YEAR                     :N4PF.
      ZIPINC_QRTL              :N2PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NEDS_2012_ED.SAS
 * This program will load the 2012 NEDS csv ED File into SAS.
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
DATA NEDS_2012_ED; 
INFILE "%trim(&filepath)NEDS/NEDS_2012/Data/NEDS_2012_ED.csv" dsd dlm=',' LRECL = 314;                                                                                                                                                                                                    

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
  LABEL="Number of CPT/HCPCS procedures on this record"

  NPR_ED                     LENGTH=3
  LABEL="Number of procedures from ED"

  PCLASS_ED1                 LENGTH=3
  LABEL="Principal procedure class for ED procedure"

  PCLASS_ED2                 LENGTH=3
  LABEL="Procedure class 2 for ED procedure"

  PCLASS_ED3                 LENGTH=3
  LABEL="Procedure class 3 for ED procedure"

  PCLASS_ED4                 LENGTH=3
  LABEL="Procedure class 4 for ED procedure"

  PCLASS_ED5                 LENGTH=3
  LABEL="Procedure class 5 for ED procedure"

  PCLASS_ED6                 LENGTH=3
  LABEL="Procedure class 6 for ED procedure"

  PCLASS_ED7                 LENGTH=3
  LABEL="Procedure class 7 for ED procedure"

  PCLASS_ED8                 LENGTH=3
  LABEL="Procedure class 8 for ED procedure"

  PCLASS_ED9                 LENGTH=3
  LABEL="Procedure class 9 for ED procedure"

  PR_ED1                     LENGTH=$4
  LABEL="Principal procedure from ED"

  PR_ED2                     LENGTH=$4
  LABEL="Procedure 2 from ED"

  PR_ED3                     LENGTH=$4
  LABEL="Procedure 3 from ED"

  PR_ED4                     LENGTH=$4
  LABEL="Procedure 4 from ED"

  PR_ED5                     LENGTH=$4
  LABEL="Procedure 5 from ED"

  PR_ED6                     LENGTH=$4
  LABEL="Procedure 6 from ED"

  PR_ED7                     LENGTH=$4
  LABEL="Procedure 7 from ED"

  PR_ED8                     LENGTH=$4
  LABEL="Procedure 8 from ED"

  PR_ED9                     LENGTH=$4
  LABEL="Procedure 9 from ED"

  PRCCS_ED1                  LENGTH=3
  LABEL="CCS: principal procedure from ED"

  PRCCS_ED2                  LENGTH=3
  LABEL="CCS: procedure 2 from ED"

  PRCCS_ED3                  LENGTH=3
  LABEL="CCS: procedure 3 from ED"

  PRCCS_ED4                  LENGTH=3
  LABEL="CCS: procedure 4 from ED"

  PRCCS_ED5                  LENGTH=3
  LABEL="CCS: procedure 5 from ED"

  PRCCS_ED6                  LENGTH=3
  LABEL="CCS: procedure 6 from ED"

  PRCCS_ED7                  LENGTH=3
  LABEL="CCS: procedure 7 from ED"

  PRCCS_ED8                  LENGTH=3
  LABEL="CCS: procedure 8 from ED"

  PRCCS_ED9                  LENGTH=3
  LABEL="CCS: procedure 9 from ED"
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
      NPR_ED                   :N3PF.
      PCLASS_ED1               :N3PF.
      PCLASS_ED2               :N3PF.
      PCLASS_ED3               :N3PF.
      PCLASS_ED4               :N3PF.
      PCLASS_ED5               :N3PF.
      PCLASS_ED6               :N3PF.
      PCLASS_ED7               :N3PF.
      PCLASS_ED8               :N3PF.
      PCLASS_ED9               :N3PF.
      PR_ED1                   :$CHAR4.
      PR_ED2                   :$CHAR4.
      PR_ED3                   :$CHAR4.
      PR_ED4                   :$CHAR4.
      PR_ED5                   :$CHAR4.
      PR_ED6                   :$CHAR4.
      PR_ED7                   :$CHAR4.
      PR_ED8                   :$CHAR4.
      PR_ED9                   :$CHAR4.
      PRCCS_ED1                :N3PF.
      PRCCS_ED2                :N3PF.
      PRCCS_ED3                :N3PF.
      PRCCS_ED4                :N3PF.
      PRCCS_ED5                :N3PF.
      PRCCS_ED6                :N3PF.
      PRCCS_ED7                :N3PF.
      PRCCS_ED8                :N3PF.
      PRCCS_ED9                :N3PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NEDS_2012_Hospital.SAS
 * This program will load the 2012 NEDS csv Hospital File into SAS.
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
DATA NEDS_2012_Hospital; 
INFILE "%trim(&filepath)NEDS/NEDS_2012/Data/NEDS_2012_Hospital.csv" dsd dlm=',' LRECL = 95;                                                                                                                                                                                                     

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

  S_HOSP_U                   LENGTH=4
  LABEL="Number of sample hospitals in NEDS_STRATUM"

  TOTAL_EDVISITS             LENGTH=5
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
      S_HOSP_U                 :N6PF.
      TOTAL_EDVISITS           :N8PF.
      YEAR                     :N4PF.
      ;
RUN;



proc SQL;
create table isilon.NEDS_2012_Core
like work.NEDS_2012_Core;

proc SQL;
insert into isilon.NEDS_2012_Core
select * from work.NEDS_2012_Core;

proc SQL;
create table isilon.NEDS_2012_IP
like work.NEDS_2012_IP;

proc SQL;
insert into isilon.NEDS_2012_IP
select * from work.NEDS_2012_IP;

proc SQL;
create table isilon.NEDS_2012_ED
like work.NEDS_2012_ED;

proc SQL;
insert into isilon.NEDS_2012_ED
select * from work.NEDS_2012_ED;

proc SQL;
create table isilon.NEDS_2012_Hospital
like work.NEDS_2012_Hospital;

proc SQL;
insert into isilon.NEDS_2012_Hospital
select * from work.NEDS_2012_Hospital;



proc delete data= work.NEDS_2012_Core; run;
proc delete data= work.NEDS_2012_IP; run;
proc delete data= work.NEDS_2012_ED; run;
proc delete data= work.NEDS_2012_Hospital; run;