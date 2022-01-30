*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2010/Data/NIS_2010   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

/*****************************************************************************
* SASload_NIS_2010_Hospital.SAS
* This program will load the 2010 NIS ASCII Hospital File into SAS.
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
DATA NIS_2010_Hospital; 
INFILE "%trim(&filepath)NIS/NIS_2010/Data/NIS_2010_Hospital.asc" LRECL = 299;                                                                                                                                                                                                    

*** Define data element attributes ***;
ATTRIB 
  HOSPST                     LENGTH=$2           FORMAT=$8.
  LABEL="Hospital state postal code"

  AHAID                      LENGTH=$7
  LABEL="AHA hospital identifier with the leading 6"

  DISCWT                     LENGTH=8
  LABEL="Weight to discharges in AHA universe"

  HFIPSSTCO                  LENGTH=4
  LABEL="Hospital FIPS state/county code"

  H_CONTRL                   LENGTH=3
  LABEL="Control/ownership of hospital"

  HOSPADDR                   LENGTH=$60
  LABEL="Hospital address from AHA Survey (Z011)"

  HOSPCITY                   LENGTH=$20
  LABEL="Hospital city from AHA Survey (Z012)"

  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPNAME                   LENGTH=$90
  LABEL="Hospital name from AHA Survey (Z000)"

  HOSPSTCO                   LENGTH=4            FORMAT=Z5.
  LABEL="Hospital modified FIPS state/county code"

  HOSPWT                     LENGTH=8
  LABEL="Weight to hospitals in AHA universe"

  HOSPZIP                    LENGTH=$5
  LABEL="Hospital ZIP Code from AHA Survey (Z014)"

  HOSP_BEDSIZE               LENGTH=3            FORMAT=1.
  LABEL="Bed size of hospital (STRATA)"

  HOSP_CONTROL               LENGTH=3            FORMAT=1.
  LABEL="Control/ownership of hospital (STRATA)"

  HOSP_LOCATION              LENGTH=3            FORMAT=1.
  LABEL="Location (urban/rural) of hospital"

  HOSP_LOCTEACH              LENGTH=3            FORMAT=1.
  LABEL="Location/teaching status of hospital (STRATA)"

  HOSP_REGION                LENGTH=3            FORMAT=1.
  LABEL="Region of hospital (STRATA)"

  HOSP_TEACH                 LENGTH=3            FORMAT=1.
  LABEL="Teaching status of hospital"

  IDNUMBER                   LENGTH=$6
  LABEL="AHA hospital identifier without the leading 6"

  NIS_STRATUM                LENGTH=3            FORMAT=4.
  LABEL="Stratum used to sample hospital"

  N_DISC_U                   LENGTH=5
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

  HOSP_RNPCT                 LENGTH=3
  LABEL="Percentage of RN among licensed nurses-H"

  HOSP_RNFTEAPD              LENGTH=4            FORMAT=5.1
  LABEL="RN FTEs per 1000 adjusted patient days-H"

  HOSP_LPNFTEAPD             LENGTH=4            FORMAT=5.1
  LABEL="LPN FTEs per 1000 adjusted patient days-H"

  HOSP_NAFTEAPD              LENGTH=4            FORMAT=5.1
  LABEL="Nurse aides per 1000 adjusted patient days-H"

  HOSP_OPSURGPCT             LENGTH=3
  LABEL="Percentage of all surgeries performed in outpatient setting-H"

  HOSP_MHSMEMBER             LENGTH=3
  LABEL="Hospital is part of multiple hospital system-H"

  HOSP_MHSCLUSTER            LENGTH=3
  LABEL="AHA multiple hospital system cluster code-H"
  ;

*** Read data elements from the ASCII file ***;
INPUT 
      @1      HOSPST                   $CHAR2.
      @3      AHAID                    $CHAR7.
      @10     DISCWT                   N11P7F.
      @21     HFIPSSTCO                N5PF.
      @26     H_CONTRL                 N2PF.
      @28     HOSPADDR                 $CHAR60.
      @88     HOSPCITY                 $CHAR20.
      @108    HOSPID                   5.
      @113    HOSPNAME                 $CHAR90.
      @203    HOSPSTCO                 N5PF.
      @208    HOSPWT                   N11P7F.
      @219    HOSPZIP                  $CHAR5.
      @224    HOSP_BEDSIZE             N2PF.
      @226    HOSP_CONTROL             N2PF.
      @228    HOSP_LOCATION            N2PF.
      @230    HOSP_LOCTEACH            N2PF.
      @232    HOSP_REGION              N2PF.
      @234    HOSP_TEACH               N2PF.
      @236    IDNUMBER                 $CHAR6.
      @242    NIS_STRATUM              N4PF.
      @246    N_DISC_U                 N8PF.
      @254    N_HOSP_U                 N4PF.
      @258    S_DISC_U                 N6PF.
      @264    S_HOSP_U                 N4PF.
      @268    TOTAL_DISC               N6PF.
      @274    YEAR                     N4PF.
      @278    HOSP_RNPCT               N3PF.
      @281    HOSP_RNFTEAPD            N4P1F.
      @285    HOSP_LPNFTEAPD           N4P1F.
      @289    HOSP_NAFTEAPD            N4P1F.
      @293    HOSP_OPSURGPCT           N3PF.
      @296    HOSP_MHSMEMBER           N2PF.
      @298    HOSP_MHSCLUSTER          N2PF.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2010_DX_PR_GRPS.SAS
* This program will load the 2010 NIS ASCII DX_PR_GRPS File into SAS.
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
DATA NIS_2010_DX_PR_GRPS; 
INFILE "%trim(&filepath)NIS/NIS_2010/Data/NIS_2010_DX_PR_GRPS.asc" LRECL = 244;                                                                                                                                                                                                    

*** Define data element attributes ***;
ATTRIB 
  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  KEY                        LENGTH=8            FORMAT=Z18.
  LABEL="HCUP record identifier"

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
      @1      HOSPID                   5.
      @6      KEY                      14.
      @20     CHRON1                   N3PF.
      @23     CHRON2                   N3PF.
      @26     CHRON3                   N3PF.
      @29     CHRON4                   N3PF.
      @32     CHRON5                   N3PF.
      @35     CHRON6                   N3PF.
      @38     CHRON7                   N3PF.
      @41     CHRON8                   N3PF.
      @44     CHRON9                   N3PF.
      @47     CHRON10                  N3PF.
      @50     CHRON11                  N3PF.
      @53     CHRON12                  N3PF.
      @56     CHRON13                  N3PF.
      @59     CHRON14                  N3PF.
      @62     CHRON15                  N3PF.
      @65     CHRON16                  N3PF.
      @68     CHRON17                  N3PF.
      @71     CHRON18                  N3PF.
      @74     CHRON19                  N3PF.
      @77     CHRON20                  N3PF.
      @80     CHRON21                  N3PF.
      @83     CHRON22                  N3PF.
      @86     CHRON23                  N3PF.
      @89     CHRON24                  N3PF.
      @92     CHRON25                  N3PF.
      @95     CHRONB1                  N3PF.
      @98     CHRONB2                  N3PF.
      @101    CHRONB3                  N3PF.
      @104    CHRONB4                  N3PF.
      @107    CHRONB5                  N3PF.
      @110    CHRONB6                  N3PF.
      @113    CHRONB7                  N3PF.
      @116    CHRONB8                  N3PF.
      @119    CHRONB9                  N3PF.
      @122    CHRONB10                 N3PF.
      @125    CHRONB11                 N3PF.
      @128    CHRONB12                 N3PF.
      @131    CHRONB13                 N3PF.
      @134    CHRONB14                 N3PF.
      @137    CHRONB15                 N3PF.
      @140    CHRONB16                 N3PF.
      @143    CHRONB17                 N3PF.
      @146    CHRONB18                 N3PF.
      @149    CHRONB19                 N3PF.
      @152    CHRONB20                 N3PF.
      @155    CHRONB21                 N3PF.
      @158    CHRONB22                 N3PF.
      @161    CHRONB23                 N3PF.
      @164    CHRONB24                 N3PF.
      @167    CHRONB25                 N3PF.
      @170    DXMCCS1                  $CHAR11.
      @181    E_MCCS1                  $CHAR11.
      @192    PCLASS1                  N3PF.
      @195    PCLASS2                  N3PF.
      @198    PCLASS3                  N3PF.
      @201    PCLASS4                  N3PF.
      @204    PCLASS5                  N3PF.
      @207    PCLASS6                  N3PF.
      @210    PCLASS7                  N3PF.
      @213    PCLASS8                  N3PF.
      @216    PCLASS9                  N3PF.
      @219    PCLASS10                 N3PF.
      @222    PCLASS11                 N3PF.
      @225    PCLASS12                 N3PF.
      @228    PCLASS13                 N3PF.
      @231    PCLASS14                 N3PF.
      @234    PCLASS15                 N3PF.
      @237    PRMCCS1                  $CHAR8.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2010_Core.SAS
* This program will load the 2010 NIS ASCII Core File into SAS.
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
DATA NIS_2010_Core; 
INFILE "%trim(&filepath)NIS/NIS_2010/Data/NIS_2010_Core.asc" LRECL = 591;                                                                                                                                                                                                    

*** Define data element attributes ***;
ATTRIB 
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

  ASOURCE_X                  LENGTH=$4
  LABEL="Admission source (as received from source)"

  ATYPE                      LENGTH=3
  LABEL="Admission type"

  AWEEKEND                   LENGTH=3
  LABEL="Admission day is a weekend"

  DIED                       LENGTH=3
  LABEL="Died during hospitalization"

  DISCWT                     LENGTH=8
  LABEL="Weight to discharges in AHA universe"

  DISPUB04                   LENGTH=3
  LABEL="Disposition of patient (UB-04 standard coding)"

  DISPUNIFORM                LENGTH=3
  LABEL="Disposition of patient (uniform)"

  DQTR                       LENGTH=3
  LABEL="Discharge quarter"

  DQTR_X                     LENGTH=3
  LABEL="Discharge quarter (as received from source)"

  DRG                        LENGTH=3
  LABEL="DRG in effect on discharge date"

  DRG24                      LENGTH=3
  LABEL="DRG, version 24"

  DRGVER                     LENGTH=3
  LABEL="DRG grouper version used on discharge date"

  DRG_NoPOA                  LENGTH=3
  LABEL="DRG in use on discharge date, calculated without POA"

  DSHOSPID                   LENGTH=$17
  LABEL="Data source hospital identifier"

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

  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  HOSPST                     LENGTH=$2           FORMAT=$8.
  LABEL="Hospital state postal code"

  KEY                        LENGTH=8            FORMAT=Z18.
  LABEL="HCUP record identifier"

  LOS                        LENGTH=4
  LABEL="Length of stay (cleaned)"

  LOS_X                      LENGTH=4
  LABEL="Length of stay (as received from source)"

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

  NIS_STRATUM                LENGTH=3            FORMAT=4.
  LABEL="Stratum used to sample hospital"

  NPR                        LENGTH=3
  LABEL="Number of procedures on this record"

  ORPROC                     LENGTH=3
  LABEL="Major operating room procedure indicator"

  PAY1                       LENGTH=3
  LABEL="Primary expected payer (uniform)"

  PAY1_X                     LENGTH=$10
  LABEL="Primary expected payer (as received from source)"

  PAY2                       LENGTH=3
  LABEL="Secondary expected payer (uniform)"

  PAY2_X                     LENGTH=$10
  LABEL="Secondary expected payer (as received from source)"

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

  PointOfOriginUB04          LENGTH=$1
  LABEL="Point of origin for admission or visit, UB-04 standard coding"

  PointOfOrigin_X            LENGTH=$8
  LABEL="Point of origin for admission or visit, as received from source"

  RACE                       LENGTH=3
  LABEL="Race (uniform)"

  TOTCHG                     LENGTH=6
  LABEL="Total charges (cleaned)"

  TOTCHG_X                   LENGTH=7
  LABEL="Total charges (as received from source)"

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
      @4      AGEDAY                   N3PF.
      @7      AMONTH                   N2PF.
      @9      ASOURCE                  N2PF.
      @11     ASOURCEUB92              $CHAR1.
      @12     ASOURCE_X                $CHAR4.
      @16     ATYPE                    N2PF.
      @18     AWEEKEND                 N2PF.
      @20     DIED                     N2PF.
      @22     DISCWT                   N11P7F.
      @33     DISPUB04                 N2PF.
      @35     DISPUNIFORM              N2PF.
      @37     DQTR                     N2PF.
      @39     DQTR_X                   N2PF.
      @41     DRG                      N3PF.
      @44     DRG24                    N3PF.
      @47     DRGVER                   N2PF.
      @49     DRG_NoPOA                N3PF.
      @52     DSHOSPID                 $CHAR17.
      @69     DX1                      $CHAR5.
      @74     DX2                      $CHAR5.
      @79     DX3                      $CHAR5.
      @84     DX4                      $CHAR5.
      @89     DX5                      $CHAR5.
      @94     DX6                      $CHAR5.
      @99     DX7                      $CHAR5.
      @104    DX8                      $CHAR5.
      @109    DX9                      $CHAR5.
      @114    DX10                     $CHAR5.
      @119    DX11                     $CHAR5.
      @124    DX12                     $CHAR5.
      @129    DX13                     $CHAR5.
      @134    DX14                     $CHAR5.
      @139    DX15                     $CHAR5.
      @144    DX16                     $CHAR5.
      @149    DX17                     $CHAR5.
      @154    DX18                     $CHAR5.
      @159    DX19                     $CHAR5.
      @164    DX20                     $CHAR5.
      @169    DX21                     $CHAR5.
      @174    DX22                     $CHAR5.
      @179    DX23                     $CHAR5.
      @184    DX24                     $CHAR5.
      @189    DX25                     $CHAR5.
      @194    DXCCS1                   N3PF.
      @197    DXCCS2                   N3PF.
      @200    DXCCS3                   N3PF.
      @203    DXCCS4                   N3PF.
      @206    DXCCS5                   N3PF.
      @209    DXCCS6                   N3PF.
      @212    DXCCS7                   N3PF.
      @215    DXCCS8                   N3PF.
      @218    DXCCS9                   N3PF.
      @221    DXCCS10                  N3PF.
      @224    DXCCS11                  N3PF.
      @227    DXCCS12                  N3PF.
      @230    DXCCS13                  N3PF.
      @233    DXCCS14                  N3PF.
      @236    DXCCS15                  N3PF.
      @239    DXCCS16                  N3PF.
      @242    DXCCS17                  N3PF.
      @245    DXCCS18                  N3PF.
      @248    DXCCS19                  N3PF.
      @251    DXCCS20                  N3PF.
      @254    DXCCS21                  N3PF.
      @257    DXCCS22                  N3PF.
      @260    DXCCS23                  N3PF.
      @263    DXCCS24                  N3PF.
      @266    DXCCS25                  N3PF.
      @269    ECODE1                   $CHAR5.
      @274    ECODE2                   $CHAR5.
      @279    ECODE3                   $CHAR5.
      @284    ECODE4                   $CHAR5.
      @289    ELECTIVE                 N2PF.
      @291    E_CCS1                   N4PF.
      @295    E_CCS2                   N4PF.
      @299    E_CCS3                   N4PF.
      @303    E_CCS4                   N4PF.
      @307    FEMALE                   N2PF.
      @309    HCUP_ED                  N3PF.
      @312    HOSPBRTH                 N2PF.
      @314    HOSPID                   5.
      @319    HOSPST                   $CHAR2.
      @321    KEY                      14.
      @335    LOS                      N5PF.
      @340    LOS_X                    N6PF.
      @346    MDC                      N2PF.
      @348    MDC24                    N2PF.
      @350    MDC_NoPOA                N2PF.
      @352    NCHRONIC                 N2PF.
      @354    NDX                      N2PF.
      @356    NECODE                   N3PF.
      @359    NEOMAT                   N2PF.
      @361    NIS_STRATUM              N4PF.
      @365    NPR                      N2PF.
      @367    ORPROC                   N2PF.
      @369    PAY1                     N2PF.
      @371    PAY1_X                   $CHAR10.
      @381    PAY2                     N2PF.
      @383    PAY2_X                   $CHAR10.
      @393    PL_NCHS2006              N3PF.
      @396    PR1                      $CHAR4.
      @400    PR2                      $CHAR4.
      @404    PR3                      $CHAR4.
      @408    PR4                      $CHAR4.
      @412    PR5                      $CHAR4.
      @416    PR6                      $CHAR4.
      @420    PR7                      $CHAR4.
      @424    PR8                      $CHAR4.
      @428    PR9                      $CHAR4.
      @432    PR10                     $CHAR4.
      @436    PR11                     $CHAR4.
      @440    PR12                     $CHAR4.
      @444    PR13                     $CHAR4.
      @448    PR14                     $CHAR4.
      @452    PR15                     $CHAR4.
      @456    PRCCS1                   N3PF.
      @459    PRCCS2                   N3PF.
      @462    PRCCS3                   N3PF.
      @465    PRCCS4                   N3PF.
      @468    PRCCS5                   N3PF.
      @471    PRCCS6                   N3PF.
      @474    PRCCS7                   N3PF.
      @477    PRCCS8                   N3PF.
      @480    PRCCS9                   N3PF.
      @483    PRCCS10                  N3PF.
      @486    PRCCS11                  N3PF.
      @489    PRCCS12                  N3PF.
      @492    PRCCS13                  N3PF.
      @495    PRCCS14                  N3PF.
      @498    PRCCS15                  N3PF.
      @501    PRDAY1                   N3PF.
      @504    PRDAY2                   N3PF.
      @507    PRDAY3                   N3PF.
      @510    PRDAY4                   N3PF.
      @513    PRDAY5                   N3PF.
      @516    PRDAY6                   N3PF.
      @519    PRDAY7                   N3PF.
      @522    PRDAY8                   N3PF.
      @525    PRDAY9                   N3PF.
      @528    PRDAY10                  N3PF.
      @531    PRDAY11                  N3PF.
      @534    PRDAY12                  N3PF.
      @537    PRDAY13                  N3PF.
      @540    PRDAY14                  N3PF.
      @543    PRDAY15                  N3PF.
      @546    PointOfOriginUB04        $CHAR1.
      @547    PointOfOrigin_X          $CHAR8.
      @555    RACE                     N2PF.
      @557    TOTCHG                   N10PF.
      @567    TOTCHG_X                 N15P2F.
      @582    TRAN_IN                  N2PF.
      @584    TRAN_OUT                 N2PF.
      @586    YEAR                     N4PF.
      @590    ZIPINC_QRTL              N2PF.
      ;
RUN;
/*****************************************************************************
* SASload_NIS_2010_Severity.SAS
* This program will load the 2010 NIS ASCII Severity File into SAS.
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
DATA NIS_2010_Severity; 
INFILE "%trim(&filepath)NIS/NIS_2010/Data/NIS_2010_Severity.asc" LRECL = 95;                                                                                                                                                                                                     

*** Define data element attributes ***;
ATTRIB 
  HOSPID                     LENGTH=4            FORMAT=Z5.
  LABEL="HCUP hospital identification number"

  KEY                        LENGTH=8            FORMAT=Z18.
  LABEL="HCUP record identifier"

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

  DS_DX_Category1            LENGTH=$5
  LABEL="Disease Staging: Principal Disease Category"

  DS_Stage1                  LENGTH=5            FORMAT=4.2
  LABEL="Disease Staging: Principal Stage"
  ;

*** Read data elements from the ASCII file ***;
INPUT 
      @1      HOSPID                   5.
      @6      KEY                      14.
      @20     APRDRG                   N4PF.
      @24     APRDRG_Risk_Mortality    N2PF.
      @26     APRDRG_Severity          N2PF.
      @28     CM_AIDS                  N2PF.
      @30     CM_ALCOHOL               N2PF.
      @32     CM_ANEMDEF               N2PF.
      @34     CM_ARTH                  N2PF.
      @36     CM_BLDLOSS               N2PF.
      @38     CM_CHF                   N2PF.
      @40     CM_CHRNLUNG              N2PF.
      @42     CM_COAG                  N2PF.
      @44     CM_DEPRESS               N2PF.
      @46     CM_DM                    N2PF.
      @48     CM_DMCX                  N2PF.
      @50     CM_DRUG                  N2PF.
      @52     CM_HTN_C                 N2PF.
      @54     CM_HYPOTHY               N2PF.
      @56     CM_LIVER                 N2PF.
      @58     CM_LYMPH                 N2PF.
      @60     CM_LYTES                 N2PF.
      @62     CM_METS                  N2PF.
      @64     CM_NEURO                 N2PF.
      @66     CM_OBESE                 N2PF.
      @68     CM_PARA                  N2PF.
      @70     CM_PERIVASC              N2PF.
      @72     CM_PSYCH                 N2PF.
      @74     CM_PULMCIRC              N2PF.
      @76     CM_RENLFAIL              N2PF.
      @78     CM_TUMOR                 N2PF.
      @80     CM_ULCER                 N2PF.
      @82     CM_VALVE                 N2PF.
      @84     CM_WGHTLOSS              N2PF.
      @86     DS_DX_Category1          $CHAR5.
      @91     DS_Stage1                N5P2F.
      ;
RUN;
                                                                           
                                                                                

                                                                                

proc SQL;
create table isilon.NIS_2010_HOSPITAL
like work.NIS_2010_HOSPITAL;

proc SQL;
insert into isilon.NIS_2010_HOSPITAL
select * from work.NIS_2010_HOSPITAL;

proc SQL;
create table isilon.NIS_2010_CORE
like work.NIS_2010_CORE;

proc SQL;
insert into isilon.NIS_2010_CORE
select * from work.NIS_2010_CORE;

proc SQL;
create table isilon.NIS_2010_Dx_Pr_Grps
like work.NIS_2010_Dx_Pr_Grps;

proc SQL;
insert into isilon.NIS_2010_Dx_Pr_Grps
select * from work.NIS_2010_Dx_Pr_Grps;

proc SQL;
create table isilon.NIS_2010_SEVERITY
like work.NIS_2010_SEVERITY;

proc SQL;
insert into isilon.NIS_2010_SEVERITY
select * from work.NIS_2010_SEVERITY;



proc delete data= work.NIS_2010_HOSPITAL; run;
proc delete data= work.NIS_2010_CORE; run;
proc delete data= work.NIS_2010_Dx_Pr_Grps; run;
proc delete data= work.NIS_2010_SEVERITY; run;