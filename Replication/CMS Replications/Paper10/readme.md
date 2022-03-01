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

<<<<<<< HEAD

Next we need to get it narrowed down by diagnosis... So this is going to require some python regex.
It looks like we're parsing like...25,901,427 claims

DX starting with 525 526 527 5022 and 503
soo....."\^+(?:525|526|527|5022|503)" is the regex key.

And after that I get to 55459 claims.  (see dev01.py)

Great! NOw lets compare my results to theirs....
They say n=562 is 2.2% and n=65 = 0.3%
n65 implies 21667 is the population
n562 implies 25545..
so maybe I have some duplicates, and I have some new variables, so back into SQL. 
So when I look at distinct desy sort keys I'm looking at 51485 distinct people, 52318 people-years. 
It begins, the divergence, lol. 

Patients with a preoperative length of stay >1 day (n = 562, 2.2%) and patients who had no information regarding the discharge date (n = 65, 0.3%) were excluded... Okay, so I needed claim number probably. SO lets go back and redo the previous step with claim number. 
So 55559 is where we're at with descrict people,claim,years. NOW, lets go in and do their limitations... Dev02 and 03.

Preoperative los > 1 day, and no discharge date. 
So basically when Day in - day out is greater than 1.
CLM_ADMSN_DT is when they get there
NCH_BENE_DSCHRG_DT is when they leave.

So.... that can't be right because that reduces the number down to 4439, which is too low. 
So they say "preoperative lengnth of stay" So... How do we define preoperative.  It's not a revenue center...
Well, I could see when the operation was by using the revenue file. They probably have a charge, so that'll be any revenue center starting with 036 for operating room services...
So lets add that in Dev04.

Dev04 is going to get us all of the surgery rows I guess... 
Well, Now I'm too low. 17693 if I just look at those claims with some sort of surgical charge....
so I don't know how they did it then. 

Well, lets take a step back now!
Patients who were enrolled in Medicare Part A and Part B, had no additional payments from a health maintenance organization (HMO), and had no record of payment made by a primary payer were selected., I must have missed that. So Lets see how that affects our simplier patient population. 

So, lets break these down 1 at a time. Dev06

Enrolled in A and B
We're looking for HI_Coverage
SMI_Coverage

No additional payments from a HMO
HMO_Coverage = 0

Payment made by a primary payer... well lets see where this gets us just here
Well that gets me to 39533 claims. That's not awful.

And it was at this moment, I realized that the paper is talking about procedure ICD-9 codes and not diagnosis codes. 

So, lets jsut start at the high end and make our way down.

Age Range 25226, well that's a slam dunk in the range, lol. 

A+B Coverage and HMO no coverage.

19974!

And finally with [CLM_THRU_DT]=0 (which I think is rather fake) Lets see how that changes things. 

19709, so that knocks out a few hundred. 

So, next lets remove those where the discharge date is null. 

That takes us down to 19652
si that's 57 vs their 63 so that's fairly close... and their pre-operative length of stay >1 day... I can't figure that out, But that's pretty small so I'm going to move on.


High Cost Patients... 
So they're splitting into 4 hroups as per that table. Easy enough... I'll just add 4 variables. 
And then they look at the spending, Okay I'll add the cost variable. 

Next they're looking at re-hospitalization. age, sex, race/ethnicity, procedure year, CCI, and hospitalization. 

Okay. 
So I am going to figure out the next hospitalization for a patient and then add all those other variables...
I am also going to implement CCI for ICD9 codes. 

So, AGe,cSex, Race, Ethnicity, DX for CCI are all good. I need... [PRVDR_NUM] for hospital...  And last I need time to next hospitalization... Which I did for paper 1 I think, I just need to dig up that code. 

datediff("D",convert(date,convert(char(8),a.[CLM_THRU_DT])),min(convert(date,convert(char(8),c.CLM_ADMSN_DT)))) as daysdiff

and 

left outer join inoutED as c on a.DESY_SORT_KEY=c.DESY_SORT_KEY and convert(date,convert(char(8),c.CLM_ADMSN_DT))>=convert(date,convert(char(8),a.[CLM_THRU_DT]))and a.Claim_No!=c.Claim_No


So, let me start from the top of the paper and make sure I have all the variables now that I'm on the right planet.
I need 
unique person (desy_sort_key)
unique claim (claim_no)
age (Check age)
year (check reference year)
procedure (check, prall)
A, B, HMO, Primary Payer (HI_coverage, SMI_coverage HMO_coverage NCH_PRMRY_PYR_CLM_PD_AMT)
Wage index, obtained from Medicare cost reports, was used to remove the geographic influence in Medicare payment.
    This is done by linking to the WI tables that I just created. 


secondary outcomes of the analysis were perioperative clinical outcomes. Okay. 
Coplicates and stuff  came from diagnosistic and procedure codes (done)
LOS comes from admi / through dates
Date of death comes from date or death
readmission comes from that table 