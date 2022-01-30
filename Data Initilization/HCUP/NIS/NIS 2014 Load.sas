*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2014/Data/NIS_2014   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

/*****************************************************************************
* SASload_NIS_2014_Severity.SAS
* This program will load the 2014 NIS ASCII Severity File into SAS.
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
DATA NIS_2014_Severity; 
INFILE "%trim(&filepath)NIS/NIS_2014/Data/NIS_2014_Severity.asc" LRECL = 81;

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
  ;

*** Read data elements from the ASCII file ***;
INPUT 
      @1      HOSP_NIS                 N5PF.
      @6      KEY_NIS                  N10PF.
      @16     APRDRG                   N4PF.
      @20     APRDRG_Risk_Mortality    N2PF.
      @22     APRDRG_Severity          N2PF.
      @24     CM_AIDS                  N2PF.
      @26     CM_ALCOHOL               N2PF.
      @28     CM_ANEMDEF               N2PF.
      @30     CM_ARTH                  N2PF.
      @32     CM_BLDLOSS               N2PF.
      @34     CM_CHF                   N2PF.
      @36     CM_CHRNLUNG              N2PF.
      @38     CM_COAG                  N2PF.
      @40     CM_DEPRESS               N2PF.
      @42     CM_DM                    N2PF.
      @44     CM_DMCX                  N2PF.
      @46     CM_DRUG                  N2PF.
      @48     CM_HTN_C                 N2PF.
      @50     CM_HYPOTHY               N2PF.
      @52     CM_LIVER                 N2PF.
      @54     CM_LYMPH                 N2PF.
      @56     CM_LYTES                 N2PF.
      @58     CM_METS                  N2PF.
      @60     CM_NEURO                 N2PF.
      @62     CM_OBESE                 N2PF.
      @64     CM_PARA                  N2PF.
      @66     CM_PERIVASC              N2PF.
      @68     CM_PSYCH                 N2PF.
      @70     CM_PULMCIRC              N2PF.
      @72     CM_RENLFAIL              N2PF.
      @74     CM_TUMOR                 N2PF.
      @76     CM_ULCER                 N2PF.
      @78     CM_VALVE                 N2PF.
      @80     CM_WGHTLOSS              N2PF.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2014_Core.SAS
* This program will load the 2014 NIS ASCII Core File into SAS.
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
DATA NIS_2014_Core; 
INFILE "%trim(&filepath)NIS/NIS_2014/Data/NIS_2014_Core.asc" LRECL = 547;

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

  DRG24                      LENGTH=3
  LABEL="DRG, version 24"

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

  DX26                       LENGTH=$5
  LABEL="Diagnosis 26"

  DX27                       LENGTH=$5
  LABEL="Diagnosis 27"

  DX28                       LENGTH=$5
  LABEL="Diagnosis 28"

  DX29                       LENGTH=$5
  LABEL="Diagnosis 29"

  DX30                       LENGTH=$5
  LABEL="Diagnosis 30"

  DXCCS1                     LENGTH=3
  LABEL="CCS: diagnosis 1"

  DXCCS2                     LENGTH=3
  LABEL="CCS: diagnosis 2"

  DXCCS3                     LENGTH=3
  LABEL="CCS: diagnosis 3"

  DXCCS4                     LENGTH=3
  LABEL="CCS: diagnosis 4"

  DXCCS5                     LENGTH=3
  LABEL="CCS: diagnosis 5"

  DXCCS6                     LENGTH=3
  LABEL="CCS: diagnosis 6"

  DXCCS7                     LENGTH=3
  LABEL="CCS: diagnosis 7"

  DXCCS8                     LENGTH=3
  LABEL="CCS: diagnosis 8"

  DXCCS9                     LENGTH=3
  LABEL="CCS: diagnosis 9"

  DXCCS10                    LENGTH=3
  LABEL="CCS: diagnosis 10"

  DXCCS11                    LENGTH=3
  LABEL="CCS: diagnosis 11"

  DXCCS12                    LENGTH=3
  LABEL="CCS: diagnosis 12"

  DXCCS13                    LENGTH=3
  LABEL="CCS: diagnosis 13"

  DXCCS14                    LENGTH=3
  LABEL="CCS: diagnosis 14"

  DXCCS15                    LENGTH=3
  LABEL="CCS: diagnosis 15"

  DXCCS16                    LENGTH=3
  LABEL="CCS: diagnosis 16"

  DXCCS17                    LENGTH=3
  LABEL="CCS: diagnosis 17"

  DXCCS18                    LENGTH=3
  LABEL="CCS: diagnosis 18"

  DXCCS19                    LENGTH=3
  LABEL="CCS: diagnosis 19"

  DXCCS20                    LENGTH=3
  LABEL="CCS: diagnosis 20"

  DXCCS21                    LENGTH=3
  LABEL="CCS: diagnosis 21"

  DXCCS22                    LENGTH=3
  LABEL="CCS: diagnosis 22"

  DXCCS23                    LENGTH=3
  LABEL="CCS: diagnosis 23"

  DXCCS24                    LENGTH=3
  LABEL="CCS: diagnosis 24"

  DXCCS25                    LENGTH=3
  LABEL="CCS: diagnosis 25"

  DXCCS26                    LENGTH=3
  LABEL="CCS: diagnosis 26"

  DXCCS27                    LENGTH=3
  LABEL="CCS: diagnosis 27"

  DXCCS28                    LENGTH=3
  LABEL="CCS: diagnosis 28"

  DXCCS29                    LENGTH=3
  LABEL="CCS: diagnosis 29"

  DXCCS30                    LENGTH=3
  LABEL="CCS: diagnosis 30"

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

  HOSPBRTH                   LENGTH=3
  LABEL="Indicator of birth in this hospital"

  HOSP_DIVISION              LENGTH=3            FORMAT=2.
  LABEL="Census Division of hospital"

  HOSP_NIS                   LENGTH=4            FORMAT=5.
  LABEL="NIS hospital number"

  KEY_NIS                    LENGTH=5            FORMAT=8.
  LABEL="NIS record number"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  MDC                        LENGTH=3
  LABEL="MDC in effect on discharge date"

  MDC24                      LENGTH=3
  LABEL="MDC, version 24"

  MDC_NoPOA                  LENGTH=3
  LABEL="MDC in use on discharge date, calculated without POA"

  NCHRONIC                   LENGTH=3
  LABEL="Number of chronic conditions"

  NDX                        LENGTH=3
  LABEL="Number of diagnoses on this record"

  NECODE                     LENGTH=3
  LABEL="Number of E codes on this record"

  NEOMAT                     LENGTH=3
  LABEL="Neonatal and/or maternal DX and/or PR"

  NIS_STRATUM                LENGTH=4            FORMAT=4.
  LABEL="NIS hospital stratum"

  NPR                        LENGTH=3
  LABEL="Number of procedures on this record"

  ORPROC                     LENGTH=3
  LABEL="Major operating room procedure indicator"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PL_NCHS                    LENGTH=3
  LABEL="Patient Location: NCHS Urban-Rural Code"

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

  SERVICELINE                LENGTH=3
  LABEL="Hospital Service Line"

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
      @30     DRG24                    N3PF.
      @33     DRGVER                   N2PF.
      @35     DRG_NoPOA                N3PF.
      @38     DX1                      $CHAR5.
      @43     DX2                      $CHAR5.
      @48     DX3                      $CHAR5.
      @53     DX4                      $CHAR5.
      @58     DX5                      $CHAR5.
      @63     DX6                      $CHAR5.
      @68     DX7                      $CHAR5.
      @73     DX8                      $CHAR5.
      @78     DX9                      $CHAR5.
      @83     DX10                     $CHAR5.
      @88     DX11                     $CHAR5.
      @93     DX12                     $CHAR5.
      @98     DX13                     $CHAR5.
      @103    DX14                     $CHAR5.
      @108    DX15                     $CHAR5.
      @113    DX16                     $CHAR5.
      @118    DX17                     $CHAR5.
      @123    DX18                     $CHAR5.
      @128    DX19                     $CHAR5.
      @133    DX20                     $CHAR5.
      @138    DX21                     $CHAR5.
      @143    DX22                     $CHAR5.
      @148    DX23                     $CHAR5.
      @153    DX24                     $CHAR5.
      @158    DX25                     $CHAR5.
      @163    DX26                     $CHAR5.
      @168    DX27                     $CHAR5.
      @173    DX28                     $CHAR5.
      @178    DX29                     $CHAR5.
      @183    DX30                     $CHAR5.
      @188    DXCCS1                   N3PF.
      @191    DXCCS2                   N3PF.
      @194    DXCCS3                   N3PF.
      @197    DXCCS4                   N3PF.
      @200    DXCCS5                   N3PF.
      @203    DXCCS6                   N3PF.
      @206    DXCCS7                   N3PF.
      @209    DXCCS8                   N3PF.
      @212    DXCCS9                   N3PF.
      @215    DXCCS10                  N3PF.
      @218    DXCCS11                  N3PF.
      @221    DXCCS12                  N3PF.
      @224    DXCCS13                  N3PF.
      @227    DXCCS14                  N3PF.
      @230    DXCCS15                  N3PF.
      @233    DXCCS16                  N3PF.
      @236    DXCCS17                  N3PF.
      @239    DXCCS18                  N3PF.
      @242    DXCCS19                  N3PF.
      @245    DXCCS20                  N3PF.
      @248    DXCCS21                  N3PF.
      @251    DXCCS22                  N3PF.
      @254    DXCCS23                  N3PF.
      @257    DXCCS24                  N3PF.
      @260    DXCCS25                  N3PF.
      @263    DXCCS26                  N3PF.
      @266    DXCCS27                  N3PF.
      @269    DXCCS28                  N3PF.
      @272    DXCCS29                  N3PF.
      @275    DXCCS30                  N3PF.
      @278    ECODE1                   $CHAR5.
      @283    ECODE2                   $CHAR5.
      @288    ECODE3                   $CHAR5.
      @293    ECODE4                   $CHAR5.
      @298    ELECTIVE                 N2PF.
      @300    E_CCS1                   N4PF.
      @304    E_CCS2                   N4PF.
      @308    E_CCS3                   N4PF.
      @312    E_CCS4                   N4PF.
      @316    FEMALE                   N2PF.
      @318    HCUP_ED                  N3PF.
      @321    HOSPBRTH                 N2PF.
      @323    HOSP_DIVISION            N2PF.
      @325    HOSP_NIS                 N5PF.
      @330    KEY_NIS                  N10PF.
      @340    LOS                      N5PF.
      @345    MDC                      N2PF.
      @347    MDC24                    N2PF.
      @349    MDC_NoPOA                N2PF.
      @351    NCHRONIC                 N2PF.
      @353    NDX                      N2PF.
      @355    NECODE                   N3PF.
      @358    NEOMAT                   N2PF.
      @360    NIS_STRATUM              N4PF.
      @364    NPR                      N2PF.
      @366    ORPROC                   N2PF.
      @368    PAY1                     N2PF.
      @370    PL_NCHS                  N3PF.
      @373    PR1                      $CHAR4.
      @377    PR2                      $CHAR4.
      @381    PR3                      $CHAR4.
      @385    PR4                      $CHAR4.
      @389    PR5                      $CHAR4.
      @393    PR6                      $CHAR4.
      @397    PR7                      $CHAR4.
      @401    PR8                      $CHAR4.
      @405    PR9                      $CHAR4.
      @409    PR10                     $CHAR4.
      @413    PR11                     $CHAR4.
      @417    PR12                     $CHAR4.
      @421    PR13                     $CHAR4.
      @425    PR14                     $CHAR4.
      @429    PR15                     $CHAR4.
      @433    PRCCS1                   N3PF.
      @436    PRCCS2                   N3PF.
      @439    PRCCS3                   N3PF.
      @442    PRCCS4                   N3PF.
      @445    PRCCS5                   N3PF.
      @448    PRCCS6                   N3PF.
      @451    PRCCS7                   N3PF.
      @454    PRCCS8                   N3PF.
      @457    PRCCS9                   N3PF.
      @460    PRCCS10                  N3PF.
      @463    PRCCS11                  N3PF.
      @466    PRCCS12                  N3PF.
      @469    PRCCS13                  N3PF.
      @472    PRCCS14                  N3PF.
      @475    PRCCS15                  N3PF.
      @478    PRDAY1                   N3PF.
      @481    PRDAY2                   N3PF.
      @484    PRDAY3                   N3PF.
      @487    PRDAY4                   N3PF.
      @490    PRDAY5                   N3PF.
      @493    PRDAY6                   N3PF.
      @496    PRDAY7                   N3PF.
      @499    PRDAY8                   N3PF.
      @502    PRDAY9                   N3PF.
      @505    PRDAY10                  N3PF.
      @508    PRDAY11                  N3PF.
      @511    PRDAY12                  N3PF.
      @514    PRDAY13                  N3PF.
      @517    PRDAY14                  N3PF.
      @520    PRDAY15                  N3PF.
      @523    RACE                     N2PF.
      @525    SERVICELINE              N3PF.
      @528    TOTCHG                   N10PF.
      @538    TRAN_IN                  N2PF.
      @540    TRAN_OUT                 N2PF.
      @542    YEAR                     N4PF.
      @546    ZIPINC_QRTL              N2PF.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2014_DX_PR_GRPS.SAS
* This program will load the 2014 NIS ASCII DX_PR_GRPS File into SAS.
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
DATA NIS_2014_DX_PR_GRPS; 
INFILE "%trim(&filepath)NIS/NIS_2014/Data/NIS_2014_DX_PR_GRPS.asc" LRECL = 270;

*** Define data element attributes ***;
ATTRIB 
  HOSP_NIS                   LENGTH=4            FORMAT=5.
  LABEL="NIS hospital number"

  KEY_NIS                    LENGTH=5            FORMAT=8.
  LABEL="NIS record number"

  BODYSYSTEM1                LENGTH=3
  LABEL="Body system 1"

  BODYSYSTEM2                LENGTH=3
  LABEL="Body system 2"

  BODYSYSTEM3                LENGTH=3
  LABEL="Body system 3"

  BODYSYSTEM4                LENGTH=3
  LABEL="Body system 4"

  BODYSYSTEM5                LENGTH=3
  LABEL="Body system 5"

  BODYSYSTEM6                LENGTH=3
  LABEL="Body system 6"

  BODYSYSTEM7                LENGTH=3
  LABEL="Body system 7"

  BODYSYSTEM8                LENGTH=3
  LABEL="Body system 8"

  BODYSYSTEM9                LENGTH=3
  LABEL="Body system 9"

  BODYSYSTEM10               LENGTH=3
  LABEL="Body system 10"

  BODYSYSTEM11               LENGTH=3
  LABEL="Body system 11"

  BODYSYSTEM12               LENGTH=3
  LABEL="Body system 12"

  BODYSYSTEM13               LENGTH=3
  LABEL="Body system 13"

  BODYSYSTEM14               LENGTH=3
  LABEL="Body system 14"

  BODYSYSTEM15               LENGTH=3
  LABEL="Body system 15"

  BODYSYSTEM16               LENGTH=3
  LABEL="Body system 16"

  BODYSYSTEM17               LENGTH=3
  LABEL="Body system 17"

  BODYSYSTEM18               LENGTH=3
  LABEL="Body system 18"

  BODYSYSTEM19               LENGTH=3
  LABEL="Body system 19"

  BODYSYSTEM20               LENGTH=3
  LABEL="Body system 20"

  BODYSYSTEM21               LENGTH=3
  LABEL="Body system 21"

  BODYSYSTEM22               LENGTH=3
  LABEL="Body system 22"

  BODYSYSTEM23               LENGTH=3
  LABEL="Body system 23"

  BODYSYSTEM24               LENGTH=3
  LABEL="Body system 24"

  BODYSYSTEM25               LENGTH=3
  LABEL="Body system 25"

  BODYSYSTEM26               LENGTH=3
  LABEL="Body system 26"

  BODYSYSTEM27               LENGTH=3
  LABEL="Body system 27"

  BODYSYSTEM28               LENGTH=3
  LABEL="Body system 28"

  BODYSYSTEM29               LENGTH=3
  LABEL="Body system 29"

  BODYSYSTEM30               LENGTH=3
  LABEL="Body system 30"

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

  CHRON26                    LENGTH=3
  LABEL="Chronic condition indicator 26"

  CHRON27                    LENGTH=3
  LABEL="Chronic condition indicator 27"

  CHRON28                    LENGTH=3
  LABEL="Chronic condition indicator 28"

  CHRON29                    LENGTH=3
  LABEL="Chronic condition indicator 29"

  CHRON30                    LENGTH=3
  LABEL="Chronic condition indicator 30"

  DXMCCS1                    LENGTH=$11
  LABEL="Multi-Level CCS:  Diagnosis 1"

  E_MCCS1                    LENGTH=$11
  LABEL="Multi-Level CCS:  E Code 1"

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

*** Read data elements from the ASCII file ***;
INPUT 
      @1      HOSP_NIS                 N5PF.
      @6      KEY_NIS                  N10PF.
      @16     BODYSYSTEM1              N3PF.
      @19     BODYSYSTEM2              N3PF.
      @22     BODYSYSTEM3              N3PF.
      @25     BODYSYSTEM4              N3PF.
      @28     BODYSYSTEM5              N3PF.
      @31     BODYSYSTEM6              N3PF.
      @34     BODYSYSTEM7              N3PF.
      @37     BODYSYSTEM8              N3PF.
      @40     BODYSYSTEM9              N3PF.
      @43     BODYSYSTEM10             N3PF.
      @46     BODYSYSTEM11             N3PF.
      @49     BODYSYSTEM12             N3PF.
      @52     BODYSYSTEM13             N3PF.
      @55     BODYSYSTEM14             N3PF.
      @58     BODYSYSTEM15             N3PF.
      @61     BODYSYSTEM16             N3PF.
      @64     BODYSYSTEM17             N3PF.
      @67     BODYSYSTEM18             N3PF.
      @70     BODYSYSTEM19             N3PF.
      @73     BODYSYSTEM20             N3PF.
      @76     BODYSYSTEM21             N3PF.
      @79     BODYSYSTEM22             N3PF.
      @82     BODYSYSTEM23             N3PF.
      @85     BODYSYSTEM24             N3PF.
      @88     BODYSYSTEM25             N3PF.
      @91     BODYSYSTEM26             N3PF.
      @94     BODYSYSTEM27             N3PF.
      @97     BODYSYSTEM28             N3PF.
      @100    BODYSYSTEM29             N3PF.
      @103    BODYSYSTEM30             N3PF.
      @106    CHRON1                   N3PF.
      @109    CHRON2                   N3PF.
      @112    CHRON3                   N3PF.
      @115    CHRON4                   N3PF.
      @118    CHRON5                   N3PF.
      @121    CHRON6                   N3PF.
      @124    CHRON7                   N3PF.
      @127    CHRON8                   N3PF.
      @130    CHRON9                   N3PF.
      @133    CHRON10                  N3PF.
      @136    CHRON11                  N3PF.
      @139    CHRON12                  N3PF.
      @142    CHRON13                  N3PF.
      @145    CHRON14                  N3PF.
      @148    CHRON15                  N3PF.
      @151    CHRON16                  N3PF.
      @154    CHRON17                  N3PF.
      @157    CHRON18                  N3PF.
      @160    CHRON19                  N3PF.
      @163    CHRON20                  N3PF.
      @166    CHRON21                  N3PF.
      @169    CHRON22                  N3PF.
      @172    CHRON23                  N3PF.
      @175    CHRON24                  N3PF.
      @178    CHRON25                  N3PF.
      @181    CHRON26                  N3PF.
      @184    CHRON27                  N3PF.
      @187    CHRON28                  N3PF.
      @190    CHRON29                  N3PF.
      @193    CHRON30                  N3PF.
      @196    DXMCCS1                  $CHAR11.
      @207    E_MCCS1                  $CHAR11.
      @218    PCLASS1                  N3PF.
      @221    PCLASS2                  N3PF.
      @224    PCLASS3                  N3PF.
      @227    PCLASS4                  N3PF.
      @230    PCLASS5                  N3PF.
      @233    PCLASS6                  N3PF.
      @236    PCLASS7                  N3PF.
      @239    PCLASS8                  N3PF.
      @242    PCLASS9                  N3PF.
      @245    PCLASS10                 N3PF.
      @248    PCLASS11                 N3PF.
      @251    PCLASS12                 N3PF.
      @254    PCLASS13                 N3PF.
      @257    PCLASS14                 N3PF.
      @260    PCLASS15                 N3PF.
      @263    PRMCCS1                  $CHAR8.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2014_Hospital.SAS
* This program will load the 2014 NIS ASCII Hospital File into SAS.
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
DATA NIS_2014_Hospital; 
INFILE "%trim(&filepath)NIS/NIS_2014/Data/NIS_2014_Hospital.asc" LRECL = 64;

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
                                                                           
                                                                                

                                                                                

proc SQL;
create table isilon.NIS_2014_HOSPITAL
like work.NIS_2014_HOSPITAL;

proc SQL;
insert into isilon.NIS_2014_HOSPITAL
select * from work.NIS_2014_HOSPITAL;

proc SQL;
create table isilon.NIS_2014_CORE
like work.NIS_2014_CORE;

proc SQL;
insert into isilon.NIS_2014_CORE
select * from work.NIS_2014_CORE;

proc SQL;
create table isilon.NIS_2014_Dx_Pr_Grps
like work.NIS_2014_Dx_Pr_Grps;

proc SQL;
insert into isilon.NIS_2014_Dx_Pr_Grps
select * from work.NIS_2014_Dx_Pr_Grps;

proc SQL;
create table isilon.NIS_2014_SEVERITY
like work.NIS_2014_SEVERITY;

proc SQL;
insert into isilon.NIS_2014_SEVERITY
select * from work.NIS_2014_SEVERITY;



proc delete data= work.NIS_2014_HOSPITAL; run;
proc delete data= work.NIS_2014_CORE; run;
proc delete data= work.NIS_2014_Dx_Pr_Grps; run;
proc delete data= work.NIS_2014_SEVERITY; run;