Paper2 is https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7281913/
This is a paper about a bunch of stuff but the parts of this paper that I care about for the purpose of replication are figures 4 and 5.


Paper 2 Journal:
Table 1 is a list of 5 NQF measures.. however I don't see how these are actually used in the analysis of the paper.
Table 2 shows hospital level coefficients… These looks like they're a definition, not calculated.
Table 3, which is just a list of diagnosis and procedure codes that they're using to define a cohort of encounters.
Table 4 and 5 are things I can actually calculate.

What information do I need tor this study
ICU Admissions by Rec-Center-Code. That's a join on the revenue file where the list of codes is what they suggest.
They're grouping by hospital, so ORG_NPI_NUM
They're using heart failure as their cohort, specifically APR DRG --The explanation / exploration of APRDRG codes is in the ../CMS SAF/APR DRG folder This was more challenging than I realized when writing this.


Inclusion / Exclusion Criteria:
    Claims from October 1, 2015 to September 30, 2016
    Excluded discharge disposition 2
    Excluded hospitals with fewer than 100 ICU cases

So the true "figure 1" is identifying the cohort of heart failures
So they are looking at 1374 hospitals, 430397 cases, and 270616 ICU visits. I assume they're using APRDRG to define heart failure; however it could be elixhauser or CCI so I will be checking
They're using CMS 2017 INP for their findings as well So this should be a simple enough query...

Contuing to Figure 4
Figure 4 is
    Dim 1: SOI level (1-4 From DRG)
    Dim 2: ICU Charge (Boolean from rec-center-code)
    And then for each of these they want...
        Cases               unique Claim_No
        ALOS                They don't call this out specifically and there is no citation, so I am going to assume they mean the average time between admission and discharge.
        %Died               Discharge disposition 20
        %High Intensitive   This is looking to see if they have any procedures / diagnosis from their list


Figure 5 is figure for but grouped by hospital quartile by percentage of reported ICU use for CHF admissions.
So I'm guessing what that means is, of the claims of CHF, what % of them were sent to the ICU.


So the big inconsistency so far is I'm not actually sure what data they're using.
They reference Claims from FY 2016, but reference the 2017 claims dataset. So I'm probably going to end up performing the analysis  on both years to see if either of them generate a simliar cohort. 

I am expecting some variation because they used APRDRG 36.0 and I'm using 38.0, but that is a problem for the me of the future to solve probably. I don't know if it's going to be a huge difference and it's probably something that I'll need to figure out eventually; however, this is probably close enough for now.

2017 data loaded into SQL!
Step 1, we need to identify the cohort as hospitals with more than 100 ICU visits. The paper defines a claim with an ICU visit as having a revenue center code of...
    200	General classification for intensive care unit (ICU)
    201	Surgical ICU
    202	Medical ICU
    203	Pediatric ICU
    204	Psychiatric ICU
    206	Intermediate ICU
    207	Burn care
    208	Trauma care
    209	Other intensive care
    210	General classification cardiac care unit (CCU)
    211	Myocardial infarction care
    212	Pulmonary care
    213	Heart transplant
    214	Intermediate CCU
    219	Other coronary care

So I am going to use this code to identify our hospital cohort

with ICUorg as(
SELECT distinct a.[DESY_SORT_KEY]
      ,a.[CLAIM_NO]
	  ,b.ORG_NPI_NUM
  FROM [cms].[inp_revenuek_2017] as a
  inner join [cms].[inp_claimsk_2017] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
  where a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219)
select org_npi_num, count(claim_no)
from ICUorg
group by ORG_NPI_NUM
having count(claim_no)>=100

This query got me... 3054 hospitals. I expected 1374 hospitals... 

Well maybe they applied their exclusion criteria earlier. So if I add the patient discharge status one I get this sql code.
/****** Script for SelectTopNRows command from SSMS  ******/
with ICUorg as(
SELECT distinct a.[DESY_SORT_KEY]
      ,a.[CLAIM_NO]
	  ,b.ORG_NPI_NUM
  FROM [cms].[inp_revenuek_2017] as a
  inner join [cms].[inp_claimsk_2017] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
  where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219) and PTNT_DSCHRG_STUS_CD!=2
  )
select org_npi_num, count(claim_no)
from ICUorg
group by ORG_NPI_NUM
having count(claim_no)>=100

and I get 2979. So Claim dates is probably the big one....
So the criteria they say is:
The research team obtained financial year 2016 (FY2016) Medicare fee-for-service claims spanning October 1, 2015, through September 30, 2016. So this implies the 2016 dataset.

The team retained claims for hospitals paid under the IPPS and grouped claims under Version 36 of the All-Patient Refined Diagnosis-Related Group (APR-DRG) classification system. 
How is this defined. Well... huh, I don't actually see any way to do this. I suspect it's just an excentricity of their dataset. I am using the SAF and they are using IPPS, however the INP file of the CMS SAF and IPPS should be similar. It could be that IPPS contains some information about hospitals using APR-DRG where as I just calculated APR-DRG myself. So even though my cohort is larger I should get the same result with the same year of data, or atleast something quite similar. So this is the moment that I am giving up on an "exact" replication for paper2, I am just aiming for a statistical replication now- can I do the same process on the same general dataset and get the same results (Since I no longer believe I am using the same dataset)


So given that... I have identified my hospital cohort, now I need to get my claim cohort

I still want to start with this query because it's my initial cohort.

--Get the claims with an icu visit
with ICUorg as(
SELECT distinct a.[DESY_SORT_KEY]
      ,a.[CLAIM_NO]
	  ,b.ORG_NPI_NUM
  FROM [cms].[inp_revenuek_2016] as a
  inner join [cms].[inp_claimsk_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
  where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219) and PTNT_DSCHRG_STUS_CD!=2
  ),

--Get the list of hospitals with 100 ICU visits or more
  HospList as(
select org_npi_num
from ICUorg
group by ORG_NPI_NUM
having count(claim_no)>=100),

--Get the claims with the correct DRG that belong to one of the hospitals
DRGHosp as(
    Select 
        --param 1 Count
    b.DESY_SORT_KEY,
    b.CLAIM_NO,
        --hospital ID
    b.ORG_NPI_NUM,
        --Param 4 Death
    case when PTNT_DSCHRG_STUS_CD=20 then '1' else '0' end as Death,
        --IV 1 SoI
    a.[SOI ] as SOI,
        --Param 2 LOS
    datediff("D",convert(date,convert(char(8),b.CLM_ADMSN_DT)),convert(date,convert(char(8),b.NCH_BENE_DSCHRG_DT))) as LOS,
        --IV2 ICU
    case when d.claim_no is null then 0 else 1 end as ICUClaim,
        --Param 3 isn't one I'm going to do in SQL. SQL's regex is weak, So, to do this, I need diagnosis and procedures, so that's what I'll be getting here. 
    '^'+isnull([ICD_DGNS_CD1],'')+'^'+
      isnull([ICD_DGNS_CD2],'')+'^'+
      isnull([ICD_DGNS_CD3],'')+'^'+
      isnull([ICD_DGNS_CD4],'')+'^'+
      isnull([ICD_DGNS_CD5],'')+'^'+
      isnull([ICD_DGNS_CD6],'')+'^'+
      isnull([ICD_DGNS_CD7],'')+'^'+
      isnull([ICD_DGNS_CD8],'')+'^'+
      isnull([ICD_DGNS_CD9],'')+'^'+
      isnull([ICD_DGNS_CD10],'')+'^'+
      isnull([ICD_DGNS_CD11],'')+'^'+
      isnull([ICD_DGNS_CD12],'')+'^'+
      isnull([ICD_DGNS_CD13],'')+'^'+
      isnull([ICD_DGNS_CD14],'')+'^'+
      isnull([ICD_DGNS_CD15],'')+'^'+
      isnull([ICD_DGNS_CD16],'')+'^'+
      isnull([ICD_DGNS_CD17],'')+'^'+
      isnull([ICD_DGNS_CD18],'')+'^'+
      isnull([ICD_DGNS_CD19],'')+'^'+
      isnull([ICD_DGNS_CD20],'')+'^'+
      isnull([ICD_DGNS_CD21],'')+'^'+
      isnull([ICD_DGNS_CD22],'')+'^'+
      isnull([ICD_DGNS_CD23],'')+'^'+
      isnull([ICD_DGNS_CD24],'')+'^'+
      isnull([ICD_DGNS_CD25],'') as dxall,
    '^'+isnull([ICD_PRCDR_CD1],'')+'^'+
      isnull([ICD_PRCDR_CD2],'')+'^'+
      isnull([ICD_PRCDR_CD3],'')+'^'+
      isnull([ICD_PRCDR_CD4],'')+'^'+
      isnull([ICD_PRCDR_CD5],'')+'^'+
      isnull([ICD_PRCDR_CD6],'')+'^'+
      isnull([ICD_PRCDR_CD7],'')+'^'+
      isnull([ICD_PRCDR_CD8],'')+'^'+
      isnull([ICD_PRCDR_CD9],'')+'^'+
      isnull([ICD_PRCDR_CD10],'')+'^'+
      isnull([ICD_PRCDR_CD11],'')+'^'+
      isnull([ICD_PRCDR_CD12],'')+'^'+
      isnull([ICD_PRCDR_CD13],'')+'^'+
      isnull([ICD_PRCDR_CD14],'')+'^'+
      isnull([ICD_PRCDR_CD15],'')+'^'+
      isnull([ICD_PRCDR_CD16],'')+'^'+
      isnull([ICD_PRCDR_CD17],'')+'^'+
      isnull([ICD_PRCDR_CD18],'')+'^'+
      isnull([ICD_PRCDR_CD19],'')+'^'+
      isnull([ICD_PRCDR_CD20],'')+'^'+
      isnull([ICD_PRCDR_CD21],'')+'^'+
      isnull([ICD_PRCDR_CD22],'')+'^'+
      isnull([ICD_PRCDR_CD23],'')+'^'+
      isnull([ICD_PRCDR_CD24],'')+'^'+
      isnull([ICD_PRCDR_CD25],'') as prall

    from dbo.pivot2016inpAPRDRG as a
    inner join cms.inp_claimsk_2016 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO)
    inner join HospList as c on b.ORG_NPI_NUM=c.ORG_NPI_NUM
    left outer join ICUorg as d on b.DESY_SORT_KEY=d.DESY_SORT_KEY and b.CLAIM_NO=d.CLAIM_NO
    where a.drg='194.0'
)

So this query was 360188 rows. Again, the target 1374 hospitals, 430397 cases, and 270616 ICU visits. Well, that's not too far off...
I wonder when they said 100 ICU visits if they meant 100 ICU Heart Failure visits. I need to edit the query above because I didn't include hospital ID

So we're looking at 2976 hospitals total. 
if I just look at hospitals with more than 100 claims... We're looking at 1368 huh... So, that's what they did then, Casual 0.6% off, so that means I need to go adjust my query in order to perform the ICU filter step later... I don't think it will change anything but computers / sql / all this stuff is magic. My logical brain tells me nothing will change; however, I just want to validate. 

Actually, when I went and looked what I tested I tested this query 
SELECT count([CLAIM_NO])
      ,[ORG_NPI_NUM]
   FROM [CAT1].[cms].[zzpaper2_temp]
  group by org_npi_num
  having count([CLAIM_NO]) >100

  So I wasn't even looking at ICU claims, I was looking at Heart Failure claims... Did I misread the paper? 
  " The analysis was further restricted to hospitals having at least 100 ICU cases within the claims data."
  Nope, I did not. I need to explore what's going on here further.

  I altered the query by no longer inner joining on HospList 
This increased the number of hospitals to 1369.. So basically no difference. Okay.  I wonder how different the cases are in each case. 

Paper
    430397 cases
    270616 ICU visits
    1374 Hospitals
100 HF  2016
    1369
    285604
100ICU --> 100 HF   2016
    360188 cases -->285482
    2976 -->  1368
    
So, this so with the 2016 data... I wonder if they really did the 2017 data. 
In 2017 data I'm getting 1778 is orgs, either way I calculate it. So that's a totally different animal. 

I keep comming back to the dates. It's weird that they specify a dataset, and specify a range. MAybe I just don't really understand that data included in the CMS dataset and that's my failing. So the claims included in a dataset are claims that are submitted in 2016 for the 2016 dataset... they say the obtained "claims spanning October 1, 2015, through September 30, 2016. " and I get why they picked october 1st 2015 because it's when ICD10 started... The issue is that all the claims in the 2015 claims dataset are ICD9, and all the claims in the 2016 claims dataset are ICD10, which, in my dataset, literally never happens. So I wonder if my dataset is flawed. So, to test that I will go back to the very start . I suspect my approach was flawed. I was looking for ICD_DGNS_VRSN equal to 10, where as in reality I needed to find them equal to 0. So This whole time, more or less, i've been using the wrong dataset, lol. Well lets start again, this time using the correct dataset. 

Well all of that was a waste I suspect. As it turns out I was referencing the 2017 MBSF with the 2016 data. So now I need to redo that.

Updated the 2016 code to now reference the right table, and I executed the 2015 code to get that dataset using claimsj and DNMNTR files. 

Well it also turns out I was able to find some files from AHRQ in the archive that contain v36 of APR-DRG, so I can implement that now too, or implement both v36 and v38 to see if theres a difference. So this should get me much closer to the final version. 

So lets start by looking at ICU visits in the time period... [dev01.sql]
So... we're looking at 3025 hospitals... Which, is still quite a bit higher than i would expect, so I still don't think they looked at ICU visits but heart failure (Because this wouldn't chance v36 vs v38)
that said... I havn't filtered icd 9v10 yet and v36 as far as I can tell, requires icd-10 so if there is a filtering step it hasn't happened yet. 

Pandas told me there was an issue with my 2015 APRDRG (duplicate data) so i'm going to investigate what's going on with that...
11265668 rows, oh that means I certainly made a mistake... that's as many as there are rows in the dataset so I didn't filter the dataset based on ICD9/10 code... which is why so many GRC11's (invalid)
Yep I didn't add a filter in my whereclause. Oh well, that's soemthing that isn't the end of the world. So, how many APRDRG194s did I get... None. Actually Zero. that's unexpected... equally unexpected was how I confidently believed 149 was 194... 

Well okay 129878 in 2015... and the same with distinct, so no duplicates with this DRG, so that's great. Now to beind everything togeather. my first stab at that is dev02

So again, the target is...
Paper    430397 cases    270616 ICU visits    1374 Hospitals
Initially I have 523097 rows...
when I filter this to those with more than 100 CHF I get 1708 hospitals
When I look at hospitals with more than 100 ICU + CHF I get 872 hospitals
When I look at hospitals with more than 100 ICU visits I get 492207 visits initially. Again 1702 hospitals.

So before I go and do the v36 vs v38 stuff...

So let me break down exactly what their inclusion criteria were...
October 1, 2015, through September 30, 2016 (Check)
claims for hospitals paid under the I (Check)
    PPS hmmmm Not check. I wonder if they're filtering by pps_ind if pps_ind
grouped claims under Version 36 of the All-Patient Refined Diagnosis-Related Group (APR-DRG) classification system (Check)
 Cases identified as transfers (discharge disposition = 2) were excluded for subsequent analysis (Check)
 and flagged cases in which patients died (discharge disposition = 20) were excluded for subsequent analysis. Ambuous... I'll try filtering out deaths I guess...
The analysis was further restricted to hospitals having at least 100 ICU cases within the claims data. (Check, though, again, it's ambiguous if they mean ICU cases or ICU+CHF cases)

So 2 things to change, 1, I am going to be using v36 rather than v38 from here on out.
2, I am going to experiment with looking at pps_ind

I am also going to be looking at simplier code to figure out the cohort rather than trying to get all ther variables I need for everything.  dev04 is my first stab at that
So 492203 cases is where I'm starting...
there are 17837 not in PPS
there are 14782 deaths
there are 3057 orgs
there are 1702 orgs with more than 100 Heart failure visits and more than 100 ICU visits.
there are 872 orgs with more than 100 heart failure ICU visits. 
of my claims, 252892 are ICU claims 239315 are not.
So my count of ICU claims is lower than their count, and my count of non-icu claimns is like... double. 

So they describe their restriction as... "To review variation in patterns of ICU designation across hospitals, the analysis was restricted to a single base DRG—APR-DRG 194 CHF—that has a known high level of ICU utilization. The analysis was further restricted to hospitals having at least 100 ICU cases within the claims data. "
To me this implies they first restricted by DRG, and then restricted by ICU cases in that dataset... 
So Step 1 Exclusion Criteria
    1   Claims from October 1 2015 to September 30 2016 (where CLM_THRU_DT>20151000 and CLM_THRU_DT<20161000)
    2   Discharge Disposition = 2 discarded (PTNT_DSCHRG_STUS_CD!=2)
    3   DRG=194   ( drg='194.0')
So... this is dev05. Where I try to do it as simple as I can possibably do it. 

523090 is the number of cases. now I need to restrict it to hospitals with atleast 100 ICU visits.  (dev06)
same number of cases, so that's good. 
523090 cases, 878 hospitals, 254690 ICU cases. 
and if I just look at 100+ HF it's 1708 hospitals. 

So... what if they didn't do what they said they did. The closest I've been to their numbers is using the 2016 dataset... what does this look like if I use the 2016 dataset (but correctly), GaWd why couldn't they have actually included a figure on how they built their cohort. 

So I no longer believe what they did was "correct" or if it was correct i don't understand it. 

So lets look at the 2016 FY date range, using the 2016 Dataset, this is a pretty hilarous way to be wrong but hey, maybe that's what they did. Maybe they used the 2016 dataset incorrectly- they believed it was the fiscal year rather than it being the calendar year. 

Looks promising initially 393216 claims 1395 hospitals filtering on heart failures...  this is so dissapointing. GaWd, is this what they actually did...  Like there some other minor filters I can add... is the ratio close? No. The ratio isn't close at all. 191451... 

I must be tired... I realize I've been targeting the wrong number this whole time... 430397 is the true number. 
That's still a bit on the high side? But that's a lot more believeable.  So... Lets take another stab... dev07 
492019 is where I'm starting. 

Maybe I'm getting ahead of myself. Maybe what I really need to be focused on initially is that hospital number. So, before I do everything else... I should be able to get the hospital number from -just- ICU data. 
1374 hospitals... So I've been using ORG_NPI_NUM to define hospital... but maybe that's not correct. 
huh... Maybe they're filtering on CLM_FAC_TYPE_CD=1... 

So lets start extremely slow. dev08
How many ICU encounters do we have in 2015-2016. 


803289
    3994528 in 2015
        984584 Oct-Dec
    4037761 in 2016
        3025857 Jan-Sep
    4010441 in FY 2016

    4155 orgs in FY 2016
    Orgs >100 ICU FY 2016
    3082 orgs in FY2016

    Excluding Non Hospital
    3082 orgs in FY2016

    Exclusing deaths and transfers
    2949 orgs in FY2016
    
    So either something very flawed has happened with data selection -or- they did the APR-DRG filter before this step. 
    if I look at the most likely -flawed- case it comes out to like 1857 hospitals...  Like, the issue is als that in their figures they say "a Source: Medicare Financial Year 2017 claims data." and "aSource: Medicare FY2017 claims data. FY2016; 1374 IPPS hospitals; 430 397 CHF admissions; 270 616 (62.9%) ICU admissions."

    Maybe there is some definition of IPPS hospital that I can't figure out. I think you could define IPPS with the CLP_PPS_IND_CD variable as hospitals that don't participat in PPS would have tha blank. 

    So, I do not believe there is any possible way they're looking at the number of hospitals before looking at heart failure. 
    So, lets look at our heart failure cohort for 2015-2017
    drg 194
        2015 = 259762
            Oct-Dec also 259762 i can accept that. 
        2016 = 532981
            jan-Sep 293216
        552978 cases in FY16 with no filters...

        4912 orgs in 2015
        5592 in 2016
        5590 in FY 2016
        HF > 100 is 1708 FY2016
        HF > 100 is 858 2015
        HF > 100 is 1733 2016
        HF > 100 is 1395 2016 jan-sep (294248 cases)

So I'm at the end of 1/30/22 right before I commit. I am doing the APR-DRG Transformation of 2017 to v36
Start of 1/31/22

So what do I want to figure out...
    HF 2017             569150 cases
    HF >100 2017        1785 hospitals
    HF FY 2017          564832 cases
    HF >100 FY 2017     1799 hospitals
        2017 jan-sept   1483 hospitals
        2016 oct-dec    276 hospitals
    ICU >100 2017       3051 hospitals
    ICU >100 FY2017     3055 hospitals
        2017 jan-sept   2862 hospitals
        2016 oct-dec    2003 hospitals
    HFICU>100 2017      930 hospitals
    HFICU>100 FY2017    926 hospitals
100ICU and 100HF
    2017                1779 hospitals  477183 cases
    2017FY              1774 hospitals  472773
        2017 jan-sept   1479 hospitals  330269 cases
        2016 oct-dec    276 hospitals   
    2016                1715 hospitals  
        2016 jan-sept   1385 hospitals  292870 cases
        2015 oct-dec    
    2016FY              1702 hospitals  426408 cases

So, here is more or less where I'm at, 
    I know I'm not looking at clm_Fac_type_cd, PTNT_DSCHRG_STUS!=2 or CLM_PPS_IND_CD.. I've come this far, I might as well. 
    FY2017              1703 Hospitals  444285 cases 229473 icu cases
    FY2016              1638 Hospitals  399297 cases
What I believe is that they seem to have some different way of determining hospitals than I do and that is likely causing everything else to cascade OR they did something wrong. The initial way that they describe their dataset still bothers me because they reference the medicare dataset by FY, which is not how the medicare datasets are organized. They retain hospitals that paid under IPPS, ignored patients with discharge 2 and 20, and looked only at hospitals, which are the 4 extra variables I filtered on. And they only looked at hospitals with... atleast 100ICU cases within the claims data... which the defined earlier as only containing heart failure visits. Which to me implies the HFICU case (the most restrictive case) So lets explore that most restrictive case again. Hospitals with 100 heartfailure ICU claims per year.

 HFICU>100 and CLM_FAC_TYPE_CD=1 and PTNT_DSCHRG_STUS_CD!=2 and PTNT_DSCHRG_STUS_CD!=20 and CLM_PPS_IND_CD !=''
    2016 FY         829 hospitals   172910 icu visits
    2016            840 hospitals   177963 icu visits
    2017 FY         883 hospitals   193759 icu visits
    2017            903 hospitals   196710 icu visits
    2017+2016q4     1053 hospitals  260002 icu visits

So, what does this tell me... What I believe is the most likely thing if they have some other way of figuring out what hospital the charge was in. I'm able to get close to their ICU count, I'm able to get close to their claim count, I'm just not able to get close to their hospital count unless I do things that I believe would be incorrect. Yeah, that's really all I can figure out. Their methods are extremely clear, they call out almost everything... except for how they determine what a hospital is, and maybe my assumption of ORG_NPI is incorrect... it just feels like the only "hospital identifier" that I get. 
So my org NPIs are certanly linking to corperations. Not hospitals. what npis do I get...
I get the organization, attending, operating, other, and rendering...
what are each of these things
    Organizational  these are health systems it seems like 
    attending       these are individuals
    operating       these are individuals
    other           these are individuals
    rendering       these are individuals
provider number... for some random sample I have 4208 orgnpis and 4240 provider numbers...
400104
Positions 1-2 are a GEO-SSA Code
Positions 3-4 are category indicators
Positions 4+ are serial numbers...
Further more there are hospitals with a letter in position 3 that aren't in PPS
So 12 are where
34 are what
and 56 are which...
So I dont' use 12or56 to filter on hospital
just 34... so I need to understand 34 but before I get into that, lets just turn off the brain for a moment and see how it looks when we use provnum rather than orgnpi


Honestly it doesn't change much 
    2017 HFICU case...      903-->898
    2017 HF100 case...      1799-->1704
    2017 ICU 100 / HF 100   -->1697 hospitals, 451317 cases... So honestly it's getting closer?
    if I look at the fiscal years for icu100/hf100
    FY 2017 1686 hosp 446210 cases
    FY 2016 1491 hosp 341481 cases

So, my number of cases is closer, forsure. but the average size of my hospital is just too large...
and the HFICU 2017 cases reduced the number of hospitals, it didn't increase it... 

So lets dig into the numbers again...
Well, like, this certainly splits off stuff but it still doesn't break it down further. 
OSU has atleast 3 hospitals, but they all seem to be the same provider number and npi...
So NPI is too large
To provider number smaller but is too large

provider_npi is in appropiate...
So maybe the identifier is in the revnue center file. 
So I know rev_cntr is -which- revenue center in a hospital, but like... that does me no help as that's just a category list... Yep Nope. 
I sent out a message to CCW to ask but I suspect that they're going to tell me there isn't any other way to break it down.
So. Here is my plan then... I plan to just do my best and to try and get a statistical replication, now that I no longer believe that I can actually recreate their cohort after days of trying.

So, lets start from the top
Dev 09
Step 1: The research team obtained financial year 2016 (FY2016) Medicare fee-for-service claims spanning October 1, 2015, through September 30, 2016. 
    year	claim
    2015	2757860
    2016	8473922
            11231782 

Step 2: The team retained claims for hospitals paid under the IPPS and grouped claims under Version 36 of the All-Patient Refined Diagnosis-Related Group (APR-DRG) classification system.	
    year	claim
    2015	121415
    2016	368349
            489764 
    
Step 3: Cases identified as transfers (discharge disposition = 2) and flagged cases in which patients died (discharge disposition = 20) were excluded for subsequent analysis.
    year	claim
    2015	117671
    2016	357231
            474902 
step 4: To identify patient admissions reported as receiving days in ICUs, the research team flagged a claim as ICU if any claim charges were made for a revenue center code listed in Supplementary Appendix 2.
    year	icu	claim
    2015	0	58790
    2016	0	178569
    2015	1	58881
    2016	1	178662
    2015    x   117671
    2016    x   357231
            1   237543
            0   237359
    That is bizzarly close to a 50-50 split. This is also the first piece of evidence that we have deviated with the paper, as even before we perform the 100 ICU filter we have fewer ICU cases than they do. 
Step 5: To review variation in patterns of ICU designation across hospitals, the analysis was restricted to a single base DRG—APR-DRG 194 CHF(This was done in step 2) however because everything until this point is transitive it doesn't matter.

Step 6: The analysis was further restricted to hospitals having at least 100 ICU cases within the claims data.
    So THIS is the first decision point. I believe that they are refering to 100 icu cases within the claims data in this state. Not the initial dataset but the current dataset.
    this restriction is by hospital (provider number according to CCW) and ICU cases (sumICU=1>=100 group by provider_number)
    4143 providers total of which 834 providers have 100 or more HF ICU visuts per year with all previous criteria
    year	icu	claim
    2015	0	13951
    2016	0	43413
    2015	1	43186
    2016	1	131790
    icu     0   57364
    icu     1   174976
    2015        57137
    2016        175203
    total cases:232340    
    So the final break down is...
    Paper     430397 cases    270616 ICU visits    1374 Hospitals
    My Cohort 232340 cases    174976 ICU visits    834  Hospitals
    their % ICU is 62.9, my % ICU was 75.3

So, On to figure 4. Figure 4 says 2017 claims data, but their cohort said 2016, so I'm going to just continue with my existing dataset as the numbers in their cohort are the same. 

So for this figure I need
    This figure also suggests that deaths were not excluded (as the text above did suggest) So I will be adding them back in now. This increases my number of hospitals by 1 (865 now)
    year	icu	(No column name)
    2015	0	15519
    2015	1	45419
    2016	0	48303
    2016	1	138670
    ended up being the final figure.

    So for figure 4 I need 
    Case Count (claimno,year)
    LoS (los)
    % died (death)
    % high intensitive (dxall, prall)
    And I need SOI (SOI)
    and I need ICU (ICU) 
    and I need hospital identifier for Figure 5 (PRVDR_NUM)
Dev 11 has the final python code needed to build the dataset
now all that's left is building the tables  in R. 