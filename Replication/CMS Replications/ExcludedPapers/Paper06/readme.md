Paper-06#377    The cost impact to Medicare of shifting treatment of worsening heart failure from inpatient to outpatient management settings.
                    It has the 5% vs 100% sample issue but like, it should still be possible to replicate

Data Source
    We used the 2013–2014 Medicare 5% sample (limited data set) which contains all Medicare FFS Part A and Part B paid claims (no Part D data) from a statistically balanced 5% sample of the total Medicare population.
    Again, that 5% issue that means... atleast at this point, I've got data
    DRG, I'll need to dig in if they mean MS-DRG or APR-DRG but I believe probably MS-DRG because they're in triplets. 

    Yeah I can do sthis all most likely. Now, onyo the modeling...

Modeling
    Yeah I don't totally understand what's going on here but it doesn't look impossible? That said from my first read I would be lying if I said I understood it. But it looks fine enough. 

    2/7/22, the goal of today is to build the cohort for this papers. 
5% sample (I will be using 100%) 2013-2014, Part A and B (inp, out)

Lets start with the initial cohort. Queries in Dev01

Step 1, lets exclude duplicate rows.
    55078879 Bene
Step 2, in 2013 and 2014
    52887386
Step 3, No HMO Enrollment (HMO_COVERAGE=0 in 2013 and 2014)
    35610028
Step 4, Part A and B for all months of 2013, and 1 month of 2014
        Where [ENTITLEMENT_BUY_IN_IND1-12] = 3 in 2013, and atleast 1 of them =3 in 2014
    23214452
Step 5, Heart Failure
Step 5a, one or more acute inpatient (INP), non-acute inpatient (SNF), OP, Observation, or ED claim with a HF ICD code.
    So, we need to start be defining, inpatient, non-acute inpatient, outpatient, observation, or ED claim. 
    Inpatient
    Non-Acute Inpatient
    Outpatient
    Observation
    ED claim

    And before I got any further, it was at this moment I realized that they're using an internal dataset... wow, How did I not realize it before this moment that they're using not one but TWO internal databases it's like, the last 2 sentences of the last secton of the methods... 
    