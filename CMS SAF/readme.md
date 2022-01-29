This folder contains all of the code that is used to initialize the Center for Medicaid and Medicare (CMS) Standard Analytical Files (SAF) of the Limited Data Set (LDS) For:
SAF-5C  5% - CARRIER LDS                        2012-2020
MBSFL   MASTER BENEFICIARY SUMMARY FILE LSD     2016-2020
DENOM1  DENOMINATOR 100% LSD                    2012-2015
SAFHHP  HOME HEALTH AGENCY LSD                  2012-2020
SAFHSP  HOSPICE LSD                             2012-2020
SAFIPP  INPATIENT LSD                           2012-2020
SAFOPP  OUTPATIENT LSD                          2012-2020
SAFSNP  SKILLED NURSING FACILITY LSD            2012-2020

This repository does not contain -any- CMS Data, only the structures of those datasets, the code required to load those datasets into SQL, and then the code that uses that SQL database to perform operations common in claims research. This repository is made in the spirit of trying to share my solutions to various problems so that no one else needs to struggle through them again.

What are the folders in this repository about

CMS Init: This folder contains the process and code that was used to convert the files as they were received from CMS into a SQL database. 

PQI-Elixhauser-CCI: This folder is how to build a supporting table tells us, for a given claim, what AHRQ Prevention Quality Indicators (PQI) are (For ACSC research, which is what I do =) ) as well as elixhauser and charlston co-morbidities. 

APR-DRG: THis folder contains the process I went through to assign 3M-All Patients Refined Diagnosis Related Groups (APR-DRG) DRG, Risk of Mortality (ROM) and Severity of Illness (SOI), under the AHRQ 3M Limited License APR-DRG Grouper License.