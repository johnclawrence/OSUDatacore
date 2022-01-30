*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2013/Data/NIS_2013   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;
/*****************************************************************************
* SASload_NIS_2013_Severity.SAS
* This program will load the 2013 NIS ASCII Severity File into SAS.
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
DATA NIS_2013_Severity; 
INFILE "%trim(&filepath)NIS/NIS_2013/Data/NIS_2013_Severity.asc" LRECL = 81;

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
* SASload_NIS_2013_Core.SAS
* This program will load the 2013 NIS ASCII Core File into SAS.
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
DATA NIS_2013_Core; 
INFILE "%trim(&filepath)NIS/NIS_2013/Data/NIS_2013_Core.asc" LRECL = 504;

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
      @163    DXCCS1                   N3PF.
      @166    DXCCS2                   N3PF.
      @169    DXCCS3                   N3PF.
      @172    DXCCS4                   N3PF.
      @175    DXCCS5                   N3PF.
      @178    DXCCS6                   N3PF.
      @181    DXCCS7                   N3PF.
      @184    DXCCS8                   N3PF.
      @187    DXCCS9                   N3PF.
      @190    DXCCS10                  N3PF.
      @193    DXCCS11                  N3PF.
      @196    DXCCS12                  N3PF.
      @199    DXCCS13                  N3PF.
      @202    DXCCS14                  N3PF.
      @205    DXCCS15                  N3PF.
      @208    DXCCS16                  N3PF.
      @211    DXCCS17                  N3PF.
      @214    DXCCS18                  N3PF.
      @217    DXCCS19                  N3PF.
      @220    DXCCS20                  N3PF.
      @223    DXCCS21                  N3PF.
      @226    DXCCS22                  N3PF.
      @229    DXCCS23                  N3PF.
      @232    DXCCS24                  N3PF.
      @235    DXCCS25                  N3PF.
      @238    ECODE1                   $CHAR5.
      @243    ECODE2                   $CHAR5.
      @248    ECODE3                   $CHAR5.
      @253    ECODE4                   $CHAR5.
      @258    ELECTIVE                 N2PF.
      @260    E_CCS1                   N4PF.
      @264    E_CCS2                   N4PF.
      @268    E_CCS3                   N4PF.
      @272    E_CCS4                   N4PF.
      @276    FEMALE                   N2PF.
      @278    HCUP_ED                  N3PF.
      @281    HOSPBRTH                 N2PF.
      @283    HOSP_DIVISION            N2PF.
      @285    HOSP_NIS                 N5PF.
      @290    KEY_NIS                  N10PF.
      @300    LOS                      N5PF.
      @305    MDC                      N2PF.
      @307    MDC24                    N2PF.
      @309    MDC_NoPOA                N2PF.
      @311    NCHRONIC                 N2PF.
      @313    NDX                      N2PF.
      @315    NECODE                   N3PF.
      @318    NEOMAT                   N2PF.
      @320    NIS_STRATUM              N4PF.
      @324    NPR                      N2PF.
      @326    ORPROC                   N2PF.
      @328    PAY1                     N2PF.
      @330    PL_NCHS                  N3PF.
      @333    PR1                      $CHAR4.
      @337    PR2                      $CHAR4.
      @341    PR3                      $CHAR4.
      @345    PR4                      $CHAR4.
      @349    PR5                      $CHAR4.
      @353    PR6                      $CHAR4.
      @357    PR7                      $CHAR4.
      @361    PR8                      $CHAR4.
      @365    PR9                      $CHAR4.
      @369    PR10                     $CHAR4.
      @373    PR11                     $CHAR4.
      @377    PR12                     $CHAR4.
      @381    PR13                     $CHAR4.
      @385    PR14                     $CHAR4.
      @389    PR15                     $CHAR4.
      @393    PRCCS1                   N3PF.
      @396    PRCCS2                   N3PF.
      @399    PRCCS3                   N3PF.
      @402    PRCCS4                   N3PF.
      @405    PRCCS5                   N3PF.
      @408    PRCCS6                   N3PF.
      @411    PRCCS7                   N3PF.
      @414    PRCCS8                   N3PF.
      @417    PRCCS9                   N3PF.
      @420    PRCCS10                  N3PF.
      @423    PRCCS11                  N3PF.
      @426    PRCCS12                  N3PF.
      @429    PRCCS13                  N3PF.
      @432    PRCCS14                  N3PF.
      @435    PRCCS15                  N3PF.
      @438    PRDAY1                   N3PF.
      @441    PRDAY2                   N3PF.
      @444    PRDAY3                   N3PF.
      @447    PRDAY4                   N3PF.
      @450    PRDAY5                   N3PF.
      @453    PRDAY6                   N3PF.
      @456    PRDAY7                   N3PF.
      @459    PRDAY8                   N3PF.
      @462    PRDAY9                   N3PF.
      @465    PRDAY10                  N3PF.
      @468    PRDAY11                  N3PF.
      @471    PRDAY12                  N3PF.
      @474    PRDAY13                  N3PF.
      @477    PRDAY14                  N3PF.
      @480    PRDAY15                  N3PF.
      @483    RACE                     N2PF.
      @485    TOTCHG                   N10PF.
      @495    TRAN_IN                  N2PF.
      @497    TRAN_OUT                 N2PF.
      @499    YEAR                     N4PF.
      @503    ZIPINC_QRTL              N2PF.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2013_DX_PR_GRPS.SAS
* This program will load the 2013 NIS ASCII DX_PR_GRPS File into SAS.
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
DATA NIS_2013_DX_PR_GRPS; 
INFILE "%trim(&filepath)NIS/NIS_2013/Data/NIS_2013_DX_PR_GRPS.asc" LRECL = 240;

*** Define data element attributes ***;
ATTRIB 
  HOSP_NIS                   LENGTH=4            FORMAT=5.
  LABEL="NIS hospital number"

  KEY_NIS                    LENGTH=5            FORMAT=8.
  LABEL="NIS record number"

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
      @16     CHRON1                   N3PF.
      @19     CHRON2                   N3PF.
      @22     CHRON3                   N3PF.
      @25     CHRON4                   N3PF.
      @28     CHRON5                   N3PF.
      @31     CHRON6                   N3PF.
      @34     CHRON7                   N3PF.
      @37     CHRON8                   N3PF.
      @40     CHRON9                   N3PF.
      @43     CHRON10                  N3PF.
      @46     CHRON11                  N3PF.
      @49     CHRON12                  N3PF.
      @52     CHRON13                  N3PF.
      @55     CHRON14                  N3PF.
      @58     CHRON15                  N3PF.
      @61     CHRON16                  N3PF.
      @64     CHRON17                  N3PF.
      @67     CHRON18                  N3PF.
      @70     CHRON19                  N3PF.
      @73     CHRON20                  N3PF.
      @76     CHRON21                  N3PF.
      @79     CHRON22                  N3PF.
      @82     CHRON23                  N3PF.
      @85     CHRON24                  N3PF.
      @88     CHRON25                  N3PF.
      @91     CHRONB1                  N3PF.
      @94     CHRONB2                  N3PF.
      @97     CHRONB3                  N3PF.
      @100    CHRONB4                  N3PF.
      @103    CHRONB5                  N3PF.
      @106    CHRONB6                  N3PF.
      @109    CHRONB7                  N3PF.
      @112    CHRONB8                  N3PF.
      @115    CHRONB9                  N3PF.
      @118    CHRONB10                 N3PF.
      @121    CHRONB11                 N3PF.
      @124    CHRONB12                 N3PF.
      @127    CHRONB13                 N3PF.
      @130    CHRONB14                 N3PF.
      @133    CHRONB15                 N3PF.
      @136    CHRONB16                 N3PF.
      @139    CHRONB17                 N3PF.
      @142    CHRONB18                 N3PF.
      @145    CHRONB19                 N3PF.
      @148    CHRONB20                 N3PF.
      @151    CHRONB21                 N3PF.
      @154    CHRONB22                 N3PF.
      @157    CHRONB23                 N3PF.
      @160    CHRONB24                 N3PF.
      @163    CHRONB25                 N3PF.
      @166    DXMCCS1                  $CHAR11.
      @177    E_MCCS1                  $CHAR11.
      @188    PCLASS1                  N3PF.
      @191    PCLASS2                  N3PF.
      @194    PCLASS3                  N3PF.
      @197    PCLASS4                  N3PF.
      @200    PCLASS5                  N3PF.
      @203    PCLASS6                  N3PF.
      @206    PCLASS7                  N3PF.
      @209    PCLASS8                  N3PF.
      @212    PCLASS9                  N3PF.
      @215    PCLASS10                 N3PF.
      @218    PCLASS11                 N3PF.
      @221    PCLASS12                 N3PF.
      @224    PCLASS13                 N3PF.
      @227    PCLASS14                 N3PF.
      @230    PCLASS15                 N3PF.
      @233    PRMCCS1                  $CHAR8.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2013_Hospital.SAS
* This program will load the 2013 NIS ASCII Hospital File into SAS.
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
DATA NIS_2013_Hospital; 
INFILE "%trim(&filepath)NIS/NIS_2013/Data/NIS_2013_Hospital.asc" LRECL = 64;

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
create table isilon.NIS_2013_HOSPITAL
like work.NIS_2013_HOSPITAL;

proc SQL;
insert into isilon.NIS_2013_HOSPITAL
select * from work.NIS_2013_HOSPITAL;

proc SQL;
create table isilon.NIS_2013_CORE
like work.NIS_2013_CORE;

proc SQL;
insert into isilon.NIS_2013_CORE
select * from work.NIS_2013_CORE;

proc SQL;
create table isilon.NIS_2013_Dx_Pr_Grps
like work.NIS_2013_Dx_Pr_Grps;

proc SQL;
insert into isilon.NIS_2013_Dx_Pr_Grps
select * from work.NIS_2013_Dx_Pr_Grps;

proc SQL;
create table isilon.NIS_2013_SEVERITY
like work.NIS_2013_SEVERITY;

proc SQL;
insert into isilon.NIS_2013_SEVERITY
select * from work.NIS_2013_SEVERITY;



proc delete data= work.NIS_2013_HOSPITAL; run;
proc delete data= work.NIS_2013_CORE; run;
proc delete data= work.NIS_2013_Dx_Pr_Grps; run;
proc delete data= work.NIS_2013_SEVERITY; run;