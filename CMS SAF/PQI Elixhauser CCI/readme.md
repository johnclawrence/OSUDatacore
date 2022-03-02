This document details information on calculating PQI, CCI and Elixhauser for a claim in the CMS SAF. 

What are CCI, Elixhauser and PQIs?

CCI (Charlson Co-morbidity Index) is a score that talks about the degree that a person’s co- morbidity are impacting their health outcomes. Typically, this is measured in groups below 5 and 5+ (So either 0,1,2,3,4,5+, or 0-2,2-4,5+). CCI is a scoring system where having a diagnosis in a certain group awards points, for example myocardial infarction would award one point, Diabetes with chronic complications would award 2 points, and metastatic solid tumor cancer would award 6. I commonly see this as a quick way to control for patient “health”.

Elixhauser and PQI are both category assignment indicators. In bothcases diagnosis (and sometimes procedure) is used to determine if someone falls into a particular category. Elixhauser outlines 31 commonly referenced co-morbidities, and PQI defined ambulatory care sensitive conditions (ACSCs). 

PQI is defined by AHRQ and changes annually. For this dataset, all ICD 9 codes (claims before October 1st 2015) were assigned base on the final ICD-9 PQI mapping. ICD-10 mappings were defined by the PQI for the year that they were released. PQIs and ACSCs are commonly used to talk about preventable conditions that can get out of control. 
https://qualityindicators.ahrq.gov/modules/pqi_resources.aspx#techspecs
https://qualityindicators.ahrq.gov/Archive/

Elixhauser and CCI were all defined by the mappings in Quan https://pubmed.ncbi.nlm.nih.gov/16224307/
This is because this version is by far the most referenced version of CCI and elixhauser and when people refer to CCI and elixhauser they basically always are referring to this paper.  

PQI, CCI, and Elixhauser are all calculated at the same time because they all use the same variables so calculating PQI is most of the way to calculating a CCI as well. These variables are calculated by python code that does the following:
 
Step 1 Get the primary key, diagnosis codes and procedure code for all claims in a SQL table.
Step 2 Download the file to the local disk.
Step 3 For each claim execute regular expressions to determine what categories the claim fits into.
Step 4 export this updated file to flat file.
Step 5 upload the flat file to SQL. 

A few notes:
1, this code writes to disk because the files get quite large and cannot be held in memory.
2, this process is performed in parallel
3, the pre 2012-2015 years run use ICD-9 and 10 codes because there is some variable coding. 
