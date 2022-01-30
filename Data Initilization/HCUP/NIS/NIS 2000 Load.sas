*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2000/Data/NIS_2000   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;
/*******************************************************************            
*   SASload_NIS_2000_10PCT_SAMPLE_A.SAS:                                        
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
DATA NIS_2000_10PCT_SAMPLE_A;                                                   
INFILE "%trim(&filepath)NIS/NIS_2000/Data/NIS_2000_10PCT_SAMPLE_A.ASC" LRECL = 493;                               
                                                                                
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
  LABEL=                                                                        
                                                                                
"10% subsample weight to discharges in AHA universe for estimates other than tot
al charges"                                                                     
                                                                                
  DISCWTcharge10     LENGTH=8                                                   
  LABEL=                                                                        
                                                                                
"10% subsample weight to discharges in AHA universe for total charge estimates" 
                                                                                
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
                                                                                
  MDID_S             LENGTH=$16                                                 
  LABEL="Attending physician number (synthetic)"                                
                                                                                
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
                                                                                
  SURGID_S           LENGTH=$16                                                 
  LABEL="Primary surgeon number (synthetic)"                                    
                                                                                
  TOTCHG             LENGTH=6                                                   
  LABEL="Total charges (cleaned)"                                               
                                                                                
  TOTCHG_X           LENGTH=7                                                   
  LABEL="Total charges (as received from source)"                               
                                                                                
  YEAR               LENGTH=3                                                   
  LABEL="Calendar year"                                                         
                                                                                
  ZIPINC             LENGTH=3                                                   
  LABEL="Median household income category for patient's zip code"               
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
      @44     DISCWTcharge10      N10P4F.                                       
      @54     DISPUB92            N2PF.                                         
      @56     DISPUNIFORM         N2PF.                                         
      @58     DQTR                N2PF.                                         
      @60     DRG                 N3PF.                                         
      @63     DRG18               N3PF.                                         
      @66     DRGVER              N2PF.                                         
      @68     DSHOSPID            $CHAR13.                                      
      @81     DX1                 $CHAR5.                                       
      @86     DX2                 $CHAR5.                                       
      @91     DX3                 $CHAR5.                                       
      @96     DX4                 $CHAR5.                                       
      @101    DX5                 $CHAR5.                                       
      @106    DX6                 $CHAR5.                                       
      @111    DX7                 $CHAR5.                                       
      @116    DX8                 $CHAR5.                                       
      @121    DX9                 $CHAR5.                                       
      @126    DX10                $CHAR5.                                       
      @131    DX11                $CHAR5.                                       
      @136    DX12                $CHAR5.                                       
      @141    DX13                $CHAR5.                                       
      @146    DX14                $CHAR5.                                       
      @151    DX15                $CHAR5.                                       
      @156    DXCCS1              N4PF.                                         
      @160    DXCCS2              N4PF.                                         
      @164    DXCCS3              N4PF.                                         
      @168    DXCCS4              N4PF.                                         
      @172    DXCCS5              N4PF.                                         
      @176    DXCCS6              N4PF.                                         
      @180    DXCCS7              N4PF.                                         
      @184    DXCCS8              N4PF.                                         
      @188    DXCCS9              N4PF.                                         
      @192    DXCCS10             N4PF.                                         
      @196    DXCCS11             N4PF.                                         
      @200    DXCCS12             N4PF.                                         
      @204    DXCCS13             N4PF.                                         
      @208    DXCCS14             N4PF.                                         
      @212    DXCCS15             N4PF.                                         
      @216    FEMALE              N2PF.                                         
      @218    HOSPID              5.                                            
      @223    HOSPST              $CHAR2.                                       
      @225    HOSPSTCO            N5PF.                                         
      @230    LOS                 N5PF.                                         
      @235    LOS_X               N6PF.                                         
      @241    MDC                 N2PF.                                         
      @243    MDC18               N2PF.                                         
      @245    MDID_S              $CHAR16.                                      
      @261    NDX                 N2PF.                                         
      @263    NEOMAT              N2PF.                                         
      @265    NIS_STRATUM         N4PF.                                         
      @269    NPR                 N2PF.                                         
      @271    PAY1                N2PF.                                         
      @273    PAY1_X              $CHAR10.                                      
      @283    PAY2                N2PF.                                         
      @285    PAY2_X              $CHAR10.                                      
      @295    PR1                 $CHAR4.                                       
      @299    PR2                 $CHAR4.                                       
      @303    PR3                 $CHAR4.                                       
      @307    PR4                 $CHAR4.                                       
      @311    PR5                 $CHAR4.                                       
      @315    PR6                 $CHAR4.                                       
      @319    PR7                 $CHAR4.                                       
      @323    PR8                 $CHAR4.                                       
      @327    PR9                 $CHAR4.                                       
      @331    PR10                $CHAR4.                                       
      @335    PR11                $CHAR4.                                       
      @339    PR12                $CHAR4.                                       
      @343    PR13                $CHAR4.                                       
      @347    PR14                $CHAR4.                                       
      @351    PR15                $CHAR4.                                       
      @355    PRCCS1              N3PF.                                         
      @358    PRCCS2              N3PF.                                         
      @361    PRCCS3              N3PF.                                         
      @364    PRCCS4              N3PF.                                         
      @367    PRCCS5              N3PF.                                         
      @370    PRCCS6              N3PF.                                         
      @373    PRCCS7              N3PF.                                         
      @376    PRCCS8              N3PF.                                         
      @379    PRCCS9              N3PF.                                         
      @382    PRCCS10             N3PF.                                         
      @385    PRCCS11             N3PF.                                         
      @388    PRCCS12             N3PF.                                         
      @391    PRCCS13             N3PF.                                         
      @394    PRCCS14             N3PF.                                         
      @397    PRCCS15             N3PF.                                         
      @400    PRDAY1              N3PF.                                         
      @403    PRDAY2              N3PF.                                         
      @406    PRDAY3              N3PF.                                         
      @409    PRDAY4              N3PF.                                         
      @412    PRDAY5              N3PF.                                         
      @415    PRDAY6              N3PF.                                         
      @418    PRDAY7              N3PF.                                         
      @421    PRDAY8              N3PF.                                         
      @424    PRDAY9              N3PF.                                         
      @427    PRDAY10             N3PF.                                         
      @430    PRDAY11             N3PF.                                         
      @433    PRDAY12             N3PF.                                         
      @436    PRDAY13             N3PF.                                         
      @439    PRDAY14             N3PF.                                         
      @442    PRDAY15             N3PF.                                         
      @445    RACE                N2PF.                                         
      @447    SURGID_S            $CHAR16.                                      
      @463    TOTCHG              N10PF.                                        
      @473    TOTCHG_X            N15P2F.                                       
      @488    YEAR                N4PF.                                         
      @492    ZIPINC              N2PF.                                         
      ;                                                                         
                                                                                
                                                                                
RUN;
/*******************************************************************            
*   SASload_NIS_2000_10PCT_SAMPLE_B.SAS:                                        
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
DATA NIS_2000_10PCT_SAMPLE_B;                                                   
INFILE "%trim(&filepath)NIS/NIS_2000/Data/NIS_2000_10PCT_SAMPLE_B.ASC" LRECL = 493;                               
                                                                                
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
  LABEL=                                                                        
                                                                                
"10% subsample weight to discharges in AHA universe for estimates other than tot
al charges"                                                                     
                                                                                
  DISCWTcharge10     LENGTH=8                                                   
  LABEL=                                                                        
                                                                                
"10% subsample weight to discharges in AHA universe for total charge estimates" 
                                                                                
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
                                                                                
  MDID_S             LENGTH=$16                                                 
  LABEL="Attending physician number (synthetic)"                                
                                                                                
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
                                                                                
  SURGID_S           LENGTH=$16                                                 
  LABEL="Primary surgeon number (synthetic)"                                    
                                                                                
  TOTCHG             LENGTH=6                                                   
  LABEL="Total charges (cleaned)"                                               
                                                                                
  TOTCHG_X           LENGTH=7                                                   
  LABEL="Total charges (as received from source)"                               
                                                                                
  YEAR               LENGTH=3                                                   
  LABEL="Calendar year"                                                         
                                                                                
  ZIPINC             LENGTH=3                                                   
  LABEL="Median household income category for patient's zip code"               
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
      @44     DISCWTcharge10      N10P4F.                                       
      @54     DISPUB92            N2PF.                                         
      @56     DISPUNIFORM         N2PF.                                         
      @58     DQTR                N2PF.                                         
      @60     DRG                 N3PF.                                         
      @63     DRG18               N3PF.                                         
      @66     DRGVER              N2PF.                                         
      @68     DSHOSPID            $CHAR13.                                      
      @81     DX1                 $CHAR5.                                       
      @86     DX2                 $CHAR5.                                       
      @91     DX3                 $CHAR5.                                       
      @96     DX4                 $CHAR5.                                       
      @101    DX5                 $CHAR5.                                       
      @106    DX6                 $CHAR5.                                       
      @111    DX7                 $CHAR5.                                       
      @116    DX8                 $CHAR5.                                       
      @121    DX9                 $CHAR5.                                       
      @126    DX10                $CHAR5.                                       
      @131    DX11                $CHAR5.                                       
      @136    DX12                $CHAR5.                                       
      @141    DX13                $CHAR5.                                       
      @146    DX14                $CHAR5.                                       
      @151    DX15                $CHAR5.                                       
      @156    DXCCS1              N4PF.                                         
      @160    DXCCS2              N4PF.                                         
      @164    DXCCS3              N4PF.                                         
      @168    DXCCS4              N4PF.                                         
      @172    DXCCS5              N4PF.                                         
      @176    DXCCS6              N4PF.                                         
      @180    DXCCS7              N4PF.                                         
      @184    DXCCS8              N4PF.                                         
      @188    DXCCS9              N4PF.                                         
      @192    DXCCS10             N4PF.                                         
      @196    DXCCS11             N4PF.                                         
      @200    DXCCS12             N4PF.                                         
      @204    DXCCS13             N4PF.                                         
      @208    DXCCS14             N4PF.                                         
      @212    DXCCS15             N4PF.                                         
      @216    FEMALE              N2PF.                                         
      @218    HOSPID              5.                                            
      @223    HOSPST              $CHAR2.                                       
      @225    HOSPSTCO            N5PF.                                         
      @230    LOS                 N5PF.                                         
      @235    LOS_X               N6PF.                                         
      @241    MDC                 N2PF.                                         
      @243    MDC18               N2PF.                                         
      @245    MDID_S              $CHAR16.                                      
      @261    NDX                 N2PF.                                         
      @263    NEOMAT              N2PF.                                         
      @265    NIS_STRATUM         N4PF.                                         
      @269    NPR                 N2PF.                                         
      @271    PAY1                N2PF.                                         
      @273    PAY1_X              $CHAR10.                                      
      @283    PAY2                N2PF.                                         
      @285    PAY2_X              $CHAR10.                                      
      @295    PR1                 $CHAR4.                                       
      @299    PR2                 $CHAR4.                                       
      @303    PR3                 $CHAR4.                                       
      @307    PR4                 $CHAR4.                                       
      @311    PR5                 $CHAR4.                                       
      @315    PR6                 $CHAR4.                                       
      @319    PR7                 $CHAR4.                                       
      @323    PR8                 $CHAR4.                                       
      @327    PR9                 $CHAR4.                                       
      @331    PR10                $CHAR4.                                       
      @335    PR11                $CHAR4.                                       
      @339    PR12                $CHAR4.                                       
      @343    PR13                $CHAR4.                                       
      @347    PR14                $CHAR4.                                       
      @351    PR15                $CHAR4.                                       
      @355    PRCCS1              N3PF.                                         
      @358    PRCCS2              N3PF.                                         
      @361    PRCCS3              N3PF.                                         
      @364    PRCCS4              N3PF.                                         
      @367    PRCCS5              N3PF.                                         
      @370    PRCCS6              N3PF.                                         
      @373    PRCCS7              N3PF.                                         
      @376    PRCCS8              N3PF.                                         
      @379    PRCCS9              N3PF.                                         
      @382    PRCCS10             N3PF.                                         
      @385    PRCCS11             N3PF.                                         
      @388    PRCCS12             N3PF.                                         
      @391    PRCCS13             N3PF.                                         
      @394    PRCCS14             N3PF.                                         
      @397    PRCCS15             N3PF.                                         
      @400    PRDAY1              N3PF.                                         
      @403    PRDAY2              N3PF.                                         
      @406    PRDAY3              N3PF.                                         
      @409    PRDAY4              N3PF.                                         
      @412    PRDAY5              N3PF.                                         
      @415    PRDAY6              N3PF.                                         
      @418    PRDAY7              N3PF.                                         
      @421    PRDAY8              N3PF.                                         
      @424    PRDAY9              N3PF.                                         
      @427    PRDAY10             N3PF.                                         
      @430    PRDAY11             N3PF.                                         
      @433    PRDAY12             N3PF.                                         
      @436    PRDAY13             N3PF.                                         
      @439    PRDAY14             N3PF.                                         
      @442    PRDAY15             N3PF.                                         
      @445    RACE                N2PF.                                         
      @447    SURGID_S            $CHAR16.                                      
      @463    TOTCHG              N10PF.                                        
      @473    TOTCHG_X            N15P2F.                                       
      @488    YEAR                N4PF.                                         
      @492    ZIPINC              N2PF.                                         
      ;                                                                         
                                                                                
                                                                                
RUN;
/*******************************************************************            
*   SASload_NIS_2000_CORE.SAS:                                                  
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
DATA NIS_2000_CORE;                                                             
INFILE "%trim(&filepath)NIS/NIS_2000/Data/NIS_2000_CORE.ASC" LRECL = 493;                                         
                                                                                
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
  LABEL=                                                                        
  "Weight to discharges in AHA universe for estimates other than total charges" 
                                                                                
  DISCWTcharge       LENGTH=8                                                   
  LABEL="Weight to discharges in AHA universe for total charge estimates"       
                                                                                
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
                                                                                
  MDID_S             LENGTH=$16                                                 
  LABEL="Attending physician number (synthetic)"                                
                                                                                
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
                                                                                
  SURGID_S           LENGTH=$16                                                 
  LABEL="Primary surgeon number (synthetic)"                                    
                                                                                
  TOTCHG             LENGTH=6                                                   
  LABEL="Total charges (cleaned)"                                               
                                                                                
  TOTCHG_X           LENGTH=7                                                   
  LABEL="Total charges (as received from source)"                               
                                                                                
  YEAR               LENGTH=3                                                   
  LABEL="Calendar year"                                                         
                                                                                
  ZIPINC             LENGTH=3                                                   
  LABEL="Median household income category for patient's zip code"               
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
      @44     DISCWTcharge        N10P4F.                                       
      @54     DISPUB92            N2PF.                                         
      @56     DISPUNIFORM         N2PF.                                         
      @58     DQTR                N2PF.                                         
      @60     DRG                 N3PF.                                         
      @63     DRG18               N3PF.                                         
      @66     DRGVER              N2PF.                                         
      @68     DSHOSPID            $CHAR13.                                      
      @81     DX1                 $CHAR5.                                       
      @86     DX2                 $CHAR5.                                       
      @91     DX3                 $CHAR5.                                       
      @96     DX4                 $CHAR5.                                       
      @101    DX5                 $CHAR5.                                       
      @106    DX6                 $CHAR5.                                       
      @111    DX7                 $CHAR5.                                       
      @116    DX8                 $CHAR5.                                       
      @121    DX9                 $CHAR5.                                       
      @126    DX10                $CHAR5.                                       
      @131    DX11                $CHAR5.                                       
      @136    DX12                $CHAR5.                                       
      @141    DX13                $CHAR5.                                       
      @146    DX14                $CHAR5.                                       
      @151    DX15                $CHAR5.                                       
      @156    DXCCS1              N4PF.                                         
      @160    DXCCS2              N4PF.                                         
      @164    DXCCS3              N4PF.                                         
      @168    DXCCS4              N4PF.                                         
      @172    DXCCS5              N4PF.                                         
      @176    DXCCS6              N4PF.                                         
      @180    DXCCS7              N4PF.                                         
      @184    DXCCS8              N4PF.                                         
      @188    DXCCS9              N4PF.                                         
      @192    DXCCS10             N4PF.                                         
      @196    DXCCS11             N4PF.                                         
      @200    DXCCS12             N4PF.                                         
      @204    DXCCS13             N4PF.                                         
      @208    DXCCS14             N4PF.                                         
      @212    DXCCS15             N4PF.                                         
      @216    FEMALE              N2PF.                                         
      @218    HOSPID              5.                                            
      @223    HOSPST              $CHAR2.                                       
      @225    HOSPSTCO            N5PF.                                         
      @230    LOS                 N5PF.                                         
      @235    LOS_X               N6PF.                                         
      @241    MDC                 N2PF.                                         
      @243    MDC18               N2PF.                                         
      @245    MDID_S              $CHAR16.                                      
      @261    NDX                 N2PF.                                         
      @263    NEOMAT              N2PF.                                         
      @265    NIS_STRATUM         N4PF.                                         
      @269    NPR                 N2PF.                                         
      @271    PAY1                N2PF.                                         
      @273    PAY1_X              $CHAR10.                                      
      @283    PAY2                N2PF.                                         
      @285    PAY2_X              $CHAR10.                                      
      @295    PR1                 $CHAR4.                                       
      @299    PR2                 $CHAR4.                                       
      @303    PR3                 $CHAR4.                                       
      @307    PR4                 $CHAR4.                                       
      @311    PR5                 $CHAR4.                                       
      @315    PR6                 $CHAR4.                                       
      @319    PR7                 $CHAR4.                                       
      @323    PR8                 $CHAR4.                                       
      @327    PR9                 $CHAR4.                                       
      @331    PR10                $CHAR4.                                       
      @335    PR11                $CHAR4.                                       
      @339    PR12                $CHAR4.                                       
      @343    PR13                $CHAR4.                                       
      @347    PR14                $CHAR4.                                       
      @351    PR15                $CHAR4.                                       
      @355    PRCCS1              N3PF.                                         
      @358    PRCCS2              N3PF.                                         
      @361    PRCCS3              N3PF.                                         
      @364    PRCCS4              N3PF.                                         
      @367    PRCCS5              N3PF.                                         
      @370    PRCCS6              N3PF.                                         
      @373    PRCCS7              N3PF.                                         
      @376    PRCCS8              N3PF.                                         
      @379    PRCCS9              N3PF.                                         
      @382    PRCCS10             N3PF.                                         
      @385    PRCCS11             N3PF.                                         
      @388    PRCCS12             N3PF.                                         
      @391    PRCCS13             N3PF.                                         
      @394    PRCCS14             N3PF.                                         
      @397    PRCCS15             N3PF.                                         
      @400    PRDAY1              N3PF.                                         
      @403    PRDAY2              N3PF.                                         
      @406    PRDAY3              N3PF.                                         
      @409    PRDAY4              N3PF.                                         
      @412    PRDAY5              N3PF.                                         
      @415    PRDAY6              N3PF.                                         
      @418    PRDAY7              N3PF.                                         
      @421    PRDAY8              N3PF.                                         
      @424    PRDAY9              N3PF.                                         
      @427    PRDAY10             N3PF.                                         
      @430    PRDAY11             N3PF.                                         
      @433    PRDAY12             N3PF.                                         
      @436    PRDAY13             N3PF.                                         
      @439    PRDAY14             N3PF.                                         
      @442    PRDAY15             N3PF.                                         
      @445    RACE                N2PF.                                         
      @447    SURGID_S            $CHAR16.                                      
      @463    TOTCHG              N10PF.                                        
      @473    TOTCHG_X            N15P2F.                                       
      @488    YEAR                N4PF.                                         
      @492    ZIPINC              N2PF.                                         
      ;                                                                         
                                                                                
                                                                                
RUN;
/*******************************************************************            
*   SASload_NIS_2000_HOSPITAL.SAS:                                              
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
DATA NIS_2000_HOSPITAL;                                                         
INFILE "%trim(&filepath)NIS/NIS_2000/Data/NIS_2000_HOSPITAL.ASC" LRECL = 183;                                     
                                                                                
*** Variable attribute ***;                                                     
ATTRIB                                                                          
  AHAID              LENGTH=$7                                                  
  LABEL="AHA hospital identifier with the leading 6"                            
                                                                                
  DISCWT             LENGTH=8                                                   
  LABEL=                                                                        
  "Weight to discharges in AHA universe for estimates other than total charges" 
                                                                                
  DISCWTcharge       LENGTH=8                                                   
  LABEL="Weight to discharges in AHA universe for total charge estimates"       
                                                                                
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
      @18     DISCWTcharge        N10P4F.                                       
      @28     HOSPADDR            $CHAR30.                                      
      @58     HOSPCITY            $CHAR20.                                      
      @78     HOSPID              5.                                            
      @83     HOSPNAME            $CHAR30.                                      
      @113    HOSPST              $CHAR2.                                       
      @115    HOSPWT              N10P4F.                                       
      @125    HOSPZIP             $CHAR5.                                       
      @130    HOSP_BEDSIZE        N2PF.                                         
      @132    HOSP_CONTROL        N2PF.                                         
      @134    HOSP_LOCATION       N2PF.                                         
      @136    HOSP_LOCTEACH       N2PF.                                         
      @138    HOSP_REGION         N2PF.                                         
      @140    HOSP_TEACH          N2PF.                                         
      @142    IDNUMBER            $CHAR6.                                       
      @148    NIS_STRATUM         N4PF.                                         
      @152    N_DISC_U            N8PF.                                         
      @160    N_HOSP_U            N4PF.                                         
      @164    S_DISC_U            N6PF.                                         
      @170    S_HOSP_U            N4PF.                                         
      @174    TOTAL_DISC          N6PF.                                         
      @180    YEAR                N4PF.                                         
      ;                                                                         
                                                                                
                                                                                
RUN;
/*******************************************************************
*   SASload_NIS_2000_SC_ECODES.SAS:                                
*      THE SAS CODE SHOWN BELOW WILL LOAD THE ASCII NIS             
*      INPATIENT STAY SC_ECODES FILE INTO SAS                          
*******************************************************************/


*******************************;
*  Data Step                  *;
*******************************;
DATA NIS_2000_SC_ECODES; 
INFILE "%trim(&filepath)NIS/NIS_2000/Data/NIS_2000_SC_ECODES.ASC" LRECL = 24;                                                                                                                                                                                                     

*** Variable attribute ***;
ATTRIB 
  KEY                LENGTH=8          FORMAT=Z14.
  LABEL="HCUP record identifier"

  DX11               LENGTH=$5
  LABEL="Diagnosis 11"

  DX12               LENGTH=$5
  LABEL="Diagnosis 12"
  ;


*** Input the variables from the ASCII file ***;
INPUT 
      @1      KEY                 14.
      @15     DX11                $CHAR5.
      @20     DX12                $CHAR5.
      ;


RUN;

                                                                           
                                                                                

proc SQL;
create table isilon.NIS_2000_CORE
like work.NIS_2000_CORE;

proc SQL;
insert into isilon.NIS_2000_CORE
select * from work.NIS_2000_CORE;

proc SQL;
create table isilon.NIS_2000_10PCT_SAMPLE_A
like work.NIS_2000_10PCT_SAMPLE_A;

proc SQL;
insert into isilon.NIS_2000_10PCT_SAMPLE_A
select * from work.NIS_2000_10PCT_SAMPLE_A;

proc SQL;
create table isilon.NIS_2000_10PCT_SAMPLE_B
like work.NIS_2000_10PCT_SAMPLE_B;

proc SQL;
insert into isilon.NIS_2000_10PCT_SAMPLE_B
select * from work.NIS_2000_10PCT_SAMPLE_B;

proc SQL;
create table isilon.NIS_2000_HOSPITAL
like work.NIS_2000_HOSPITAL;

proc SQL;
insert into isilon.NIS_2000_HOSPITAL
select * from work.NIS_2000_HOSPITAL;

proc SQL;
create table isilon.NIS_2000_SC_ECODES
like work.NIS_2000_SC_ECODES;

proc SQL;
insert into isilon.NIS_2000_SC_ECODES
select * from work.NIS_2000_SC_ECODES;

proc delete data= work.NIS_2000_CORE; run;
proc delete data= work.NIS_2000_CORE10A; run;
proc delete data= work.NIS_2000_CORE10B; run;
proc delete data= work.NIS_2000_HOSPITAL; run;
proc delete data= work.NIS_2000_SC_ECODES; run;
