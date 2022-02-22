Paper 10! Hot spotting surgical patients undergoing hepatopancreatic procedures.
    https://pubmed.ncbi.nlm.nih.gov/30497897/
    https://linkinghub.elsevier.com/retrieve/pii/S1365-182X(18)34508-8

    Methods!   
        This is an OSU paper! Okay! They said they used medpar but they did not.
        I can probably just stop here because I get to cheat on this paper because i can literally use the code they wrote because i know the author. 
        
    There is no cheating. They do not have the code... Dissapointing. 


    Well, lets start at the top.

    The Medicare Provider Analysis and Review (MEDPAR) Inpatient Files linked with the Denominator File were used to identify Medicare patients aged 65–100 years who underwent elective surgical procedures of the liver and pancreas. 
        They didn't use medpar, they used the INP and the MBSF.
        65-100 is easy. 
        electrive surgical procedures of the liver and pancreas... I need to figure out what that means.
    
    Patients undergoing surgery between the years 2013 and 2015 were included. 
        Okay, 2013-2015 files, EZPZ, and all ICD9
    Patients with the International Classification of Diseases, 9th Revision (ICD-9) procedure codes for proximal pancreatectomy (5251), distal pancreatectomy (5252), radical subtotal pancreatectomy (5253), other partial pancreatectomy (5259), total pancreatectomy (526), radical pancreatoduodenectomy (527), partial hepatectomy (5022), and hepatic lobectomy (503) were included.
        Yay! A list of ICD codes.

    14 Patients who were enrolled in Medicare Part A and Part B, had no additional payments from a health maintenance organization (HMO), and had no record of payment made by a primary payer were selected.
        Wat. How? But, why?  
        Enrolled in A/B, EZ
        No HMO, EZ
        No record of payment made by a primary payer... uhhhh, I'm sure that's something in the MBSF? Or something that's called out on the claim level... but why 14? Were there only 14?
        SO I AM GOING TO ASSUME THIS IS A TYPO. I think they ment excluded due to the context of this sentence. 

    Patients with a preoperative length of stay >1 day (n = 562, 2.2%) and patients who had no information regarding the discharge date (n = 65, 0.3%) were excluded. Wage index, obtained from Medicare cost reports, was used to remove the geographic influence in Medicare payment.
        Okay, That's easy enough... I can do that... That's fine. 

     The study was approved by the Institutional Review Board of The Ohio State University Wexner Medical Center.
        No it wasn't, lol. 


Identifying high-cost patients (“hot spotting”)
Total patients were divided into four groups based on procedure types and complexity: 1) non-complex pancreatic procedures; 2) complex pancreatic procedures; 3) non-complex liver procedures; and 4) complex liver procedures (Supplemental Table 1).
    Well, lets look at supplemental figure to be sure I have some way to, uh.... FIGURE this out. 
    The figure kind of explains it, explains it close enough for me to get the rest of the way, that's fine...

 Unadjusted standardized Medicare payments for each group were used to identify the highest and lowest quintiles of payments. Patients within the highest and lowest quintiles of spending for each of the procedure groups were identified. The most expensive 20% of patients were defined as the super-utilizers.
    Kay. Claim file, that's straight forward enough.

 The primary outcome of the analysis was Medicare payment for index hospitalization and readmissions, identified using the MEDPAR inpatient database.
    Okay, rehospitalization, EZPZ. 

  Payments were standardized to exclude indirect medical education and disproportionate share costs, as well as removing geographic influence.15,  16 
    Magic, but I assume those citations explain how they did that. 
  The secondary outcomes of the analysis were perioperative clinical outcomes. Complications, ascertained from all ICD-9-CM diagnostic and procedure codes from the index hospitalization, were defined as the occurrence of a complication during the index hospitalization. 
    uhhh
  Codes were selected based on data from previous studies in order to achieve high specificity and sensitivity in identifying complications among patients undergoing surgery.
    uhhhhhhh
   Length of stay (LOS) was defined as the number of days between admission and discharge. Readmissions were defined as the admission to any hospital within 30 days after discharge.
    Okay, sure that's fine.
   Thirty-day, 60-day and 90-day mortality were defined as death within 30-, 60-, or 90-days of the index operation. 
    Okay, fine.
   Information regarding patient death was found in the MEDPAR denominator file. 
    Sure.
   Rates of clinical outcomes were risk-adjusted for age, sex, race/ethnicity, procedure year, and 17 Charlson comorbidity index for each procedure group. 
    Sure, you started with Madison's generic all the stuff data file. That's fine. 
   Overall surgical volume was defined as the number of procedures performed over 3 years at any given institution.   
    Interesting. Okay, So and now here at the end we're grouping by "Institution" 

    Well Time to start slapping this togeather in dev 1
    -----
Medicare patients aged 65–100 years who underwent elective surgical procedures of the liver and pancreas. Patients undergoing surgery between the years 2013 and 2015 were included. Patients with the International Classification of Diseases, 9th Revision (ICD-9) procedure codes for proximal pancreatectomy (5251), distal pancreatectomy (5252), radical subtotal pancreatectomy (5253), other partial pancreatectomy (5259), total pancreatectomy (526), radical pancreatoduodenectomy (527), partial hepatectomy (5022), and hepatic lobectomy (503) were included.

So Lets break it down by year
We're looking for ICD-9 codes 5252 5259 5251 5253 526 527 5022 503 

So ICD9 codes that start with 52 are pancreas operations.

525 are all partial pancreatemocy (there is only 5251 5252 5253 5259)
526 is Total
527 is pseudo

50- are all about the liver

5022 and 503 are partial and total.
So I'm not here to question why they did what they did. But I odn't totally understand why the picked some of these codes and not others
But okay! Lets break it down by year... well before I do that I need to figure out what dataset they used... OH just SAF INP, Great. 

Pop	        Year
55,084,335	13
56,642,555	14
58,169,388	15


So the number of patients in our patient population of the right ages is....
Pop         Year
42,840,573	13
44,270,400	14
45,724,204	15

Next we need to get it narrowed down by diagnosis... So this is going to require some python regex.