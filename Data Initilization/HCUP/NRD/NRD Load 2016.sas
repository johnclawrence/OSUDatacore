*Developer: John Lawrence*
*Date: 1/18/22*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NRD/NRD_2016/Data/NRD_2016   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;
/*****************************************************************************
 * SASload_NRD_2016_Core.SAS
 * Created on 07/20/2018.
 * This program will load the NRD_2016_Core CSV File into SAS.
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
DATA NRD_2016_Core; 
INFILE "%trim(&filepath)NRD/NRD_2016/Data/NRD_2016_Core.csv" dsd dlm=',' LRECL = 655;

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

  I10_DX31                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 31"

  I10_DX32                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 32"

  I10_DX33                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 33"

  I10_DX34                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 34"

  I10_DX35                   LENGTH=$7
  LABEL="ICD-10-CM Diagnosis 35"

  I10_ECAUSE1                LENGTH=$7
  LABEL="ICD-10-CM External cause 1"

  I10_ECAUSE2                LENGTH=$7
  LABEL="ICD-10-CM External cause 2"

  I10_ECAUSE3                LENGTH=$7
  LABEL="ICD-10-CM External cause 3"

  I10_ECAUSE4                LENGTH=$7
  LABEL="ICD-10-CM External cause 4"

  ELECTIVE                   LENGTH=3
  LABEL="Elective versus non-elective admission"

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

  I10_NDX                    LENGTH=3
  LABEL="ICD-10-CM Number of diagnoses on this record"

  I10_NECAUSE                LENGTH=3
  LABEL="ICD-10-CM Number of External cause codes on this record"

  I10_NPR                    LENGTH=3
  LABEL="ICD-10-PCS Number of procedures on this record"

  NRD_DaysToEvent            LENGTH=8
  LABEL="Timing variable used to identify days between admissions"

  NRD_STRATUM                LENGTH=3
  LABEL="NRD stratum used for weighting"

  NRD_VisitLink              LENGTH=$7
  LABEL="NRD visitlink"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PL_NCHS                    LENGTH=3
  LABEL="Patient Location: NCHS Urban-Rural Code"

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

  DXVER                      LENGTH=3
  LABEL="Diagnosis Version"

  PRVER                      LENGTH=3
  LABEL="Procedure Version"
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
      I10_DX31                 :$CHAR7.
      I10_DX32                 :$CHAR7.
      I10_DX33                 :$CHAR7.
      I10_DX34                 :$CHAR7.
      I10_DX35                 :$CHAR7.
      I10_ECAUSE1              :$CHAR7.
      I10_ECAUSE2              :$CHAR7.
      I10_ECAUSE3              :$CHAR7.
      I10_ECAUSE4              :$CHAR7.
      ELECTIVE                 :N2PF.
      FEMALE                   :N2PF.
      HCUP_ED                  :N2PF.
      HOSP_NRD                 :5.
      KEY_NRD                  :15.
      LOS                      :N5PF.
      MDC                      :N2PF.
      MDC_NoPOA                :N2PF.
      I10_NDX                  :N3PF.
      I10_NECAUSE              :N3PF.
      I10_NPR                  :N3PF.
      NRD_DaysToEvent          :N10PF.
      NRD_STRATUM              :N5PF.
      NRD_VisitLink            :$CHAR7.
      PAY1                     :N2PF.
      PL_NCHS                  :N3PF.
      I10_PR1                  :$CHAR7.
      I10_PR2                  :$CHAR7.
      I10_PR3                  :$CHAR7.
      I10_PR4                  :$CHAR7.
      I10_PR5                  :$CHAR7.
      I10_PR6                  :$CHAR7.
      I10_PR7                  :$CHAR7.
      I10_PR8                  :$CHAR7.
      I10_PR9                  :$CHAR7.
      I10_PR10                 :$CHAR7.
      I10_PR11                 :$CHAR7.
      I10_PR12                 :$CHAR7.
      I10_PR13                 :$CHAR7.
      I10_PR14                 :$CHAR7.
      I10_PR15                 :$CHAR7.
      PRDAY1                   :N3PF.
      PRDAY2                   :N3PF.
      PRDAY3                   :N3PF.
      PRDAY4                   :N3PF.
      PRDAY5                   :N3PF.
      PRDAY6                   :N3PF.
      PRDAY7                   :N3PF.
      PRDAY8                   :N3PF.
      PRDAY9                   :N3PF.
      PRDAY10                  :N3PF.
      PRDAY11                  :N3PF.
      PRDAY12                  :N3PF.
      PRDAY13                  :N3PF.
      PRDAY14                  :N3PF.
      PRDAY15                  :N3PF.
      REHABTRANSFER            :N2PF.
      RESIDENT                 :N2PF.
      SAMEDAYEVENT             :$CHAR2.
      TOTCHG                   :N10PF.
      YEAR                     :N4PF.
      ZIPINC_QRTL              :N2PF.
      DXVER                    :N2PF.
      PRVER                    :N2PF.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2016_Severity.SAS
 * Created on 07/20/2018.
 * This program will load the NRD_2016_Severity CSV File into SAS.
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
DATA NRD_2016_Severity; 
INFILE "%trim(&filepath)NRD/NRD_2016/Data/NRD_2016_Severity.csv" dsd dlm=',' LRECL = 33;

/* Define data element attributes */
ATTRIB 
  APRDRG                     LENGTH=3
  LABEL="All Patient Refined DRG"

  APRDRG_Risk_Mortality      LENGTH=3
  LABEL="All Patient Refined DRG: Risk of Mortality Subclass"

  APRDRG_Severity            LENGTH=3
  LABEL="All Patient Refined DRG: Severity of Illness Subclass"

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
      HOSP_NRD                 :5.
      KEY_NRD                  :15.
      ;
RUN;
/*****************************************************************************
 * SASload_NRD_2016_Hospital.SAS
 * Created on 07/20/2018.
 * This program will load the NRD_2016_Hospital CSV File into SAS.
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
DATA NRD_2016_Hospital; 
INFILE "%trim(&filepath)NRD/NRD_2016/Data/NRD_2016_Hospital.csv" dsd dlm=',' LRECL = 66;

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


proc SQL;
create table isilon.NRD_2016_Core
like work.NRD_2016_Core;

proc SQL;
insert into isilon.NRD_2016_Core
select * from work.NRD_2016_Core;


proc SQL;
create table isilon.NRD_2016_Hospital
like work.NRD_2016_Hospital;

proc SQL;
insert into isilon.NRD_2016_Hospital
select * from work.NRD_2016_Hospital;

proc SQL;
create table isilon.NRD_2016_Severity
like work.NRD_2016_Severity;

proc SQL;
insert into isilon.NRD_2016_Severity
select * from work.NRD_2016_Severity;




proc delete data= work.NRD_2016_Core; run;
proc delete data= work.NRD_2016_Hospital; run;
proc delete data= work.NRD_2016_Severity; run;
