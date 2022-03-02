DRG / APR-DRG
This folder details a process to generate APR-DRG codes for an inpatient claim of the CMS SAF.
DRG’s are Diagnosis Related Groupers. As the name suggests, DRGs represents patients with similar disease states. A difference between DRG and say PQI is all claims about heart failure will be classified under PQI08 but only cases that are predominantly about heart failure will have a heart failure DRG as a given claim only has one DRG code assigned to it. DRG codes are useful because they are a quick way to determine if a particular claim is about a disease state. 

Something else that differentiates DRGs from PQI or CCI is that PQI/CCI are based primarily on diagnoses codes with some minor use of procedure codes. DRG codes are also based on diagnosis codes, procedure codes, as well as other patient demographics such as age or ventilator days. 

In addition to the predominate condition of a claim, DRG codes also talk about the degree of severity.

There are several flavors of DRG codes. The two that I will be discussing here are MS-DRG and APR-DRG.

MS-DRG is CMS’s version of the DRG system and they are included by default in the SAF. The defining characteristic of MS-DRG is they break a given DRG into three levels
The DRG without complications
The DRG with minor complications
The DRG with major complications
The specifics of these codes are outlines here: https://www.cms.gov/Medicare/Medicare-Fee-for-Service-Payment/AcuteInpatientPPS/MS-DRG-Classifications-and-Software

The most commonly used version of DRG codes are known as APR-DRG codes because they are used broadly by insurers to talk about how much a hospital visit should cost. APR-DRG is a codeset built by 3M. The documentation of how APR-DRG works is sparse and arcane. AHRQ / 3M have a description of the algorithm but it isn’t nearly enough to reproduce it. How APR-DRG codes are normally defined is by using software licensed by 3m. AHRQ has a public use version of this algorithm for some DRGs related to their metrics and that was what I used.

The APR-DRG code has 3 components
1: The diagnosis part of the DRG code (heart failure, for example)
2: A Severity of Illness (SOI) code. SOI is a scale from 1-4 that describes the severity of a particular illness. For example, an SOI of 4 for a broken arm is not equivalent to having a SOI of 4 for a stroke
3: A Risk of Mortality (ROM) code is on a scale from 1-4 what is the risk of mortality. I don’t totally understand this stuff yet, so I’ll come back to this later. 

The AHRQ public license for APR DRG can be found here: https://qualityindicators.ahrq.gov/Software/SAS.aspx . There are many versions of it, I will be coding a particular year of data with the APR-DRG version that was new when the dataset was released. 

The process of generating APR-DRG codes for the CMS SAF is: 

Step 1: Create a SQL query to build a table with the inputs required by the APR-DRG coding program.
Step 2: Export the dataset to flat files
Step 3: Run the test.exe script contained in the public file and write the results to a flat file.
Step 4: Parse the results of that test script in python to define DRG, SOI, and ROM for each claim.
Step 5: Upload the parsed results into SQL

Step 1 is detailed in the Step 1 folder.
Step 2 is a SQL export
Step 3 is described below.
Step 4 is in the Step 4 folder.
Step 5 is a SQL import. 

Here is how you do step 3. 

Step 1, unzip the file provided by AHRQ.
Step 2, move the file exported in step to that folder. 
Step 3, open the command line in that folder
Step 4, Execute the following code with the relative path to the following files (for example here is my code)
testapr.exe aprlim.dll ..\gapr_v380.ctl ..\umap.ctl ..\testdata2.txt 0 > type somepath/filename.txt | ThatSamesomepath/filename.txt

This code has two components, split by a “>” before the > executes the code, after the > saves the output. 

Step 3 example code
testapr.exe aprlim.dll ..\gapr_v380.ctl ..\umap.ctl ..\pre2015inpAPRDRGicd10.txt 0 > C:\Users\lsa-lawr47\Desktop\Paper2\APRDRG_LIMITED_GROUPER_2021\out2015inpAPRDRG.txt | type C:\Users\lsa-lawr47\Desktop\Paper2\APRDRG_LIMITED_GROUPER_2021\out2015inpAPRDRG.txt


