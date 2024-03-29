with inpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        A.CLAIM_NO as Claim_No
    FROM cms.inp_revenuek_2016 as a
    inner join cms.[mbsf_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
    where (a.rev_cntr like '045%' or a.rev_cntr = 0981) and age >= 65 and HI_COVERAGE=12 and SMI_COVERAGE=12 and HMO_COVERAGE=0
    ),
outpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No
    FROM cms.out_revenuek_2016 as a
    inner join cms.[mbsf_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
    WHERE (a.rev_cntr like '045%' or a.rev_cntr = 0981) and age >= 65 and HI_COVERAGE=12 and SMI_COVERAGE=12 and HMO_COVERAGE=0
    ),
HHA as(
    SELECT 
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No
    FROM cms.HHA_revenuek_2016 as a
    inner join cms.[mbsf_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
    WHERE (a.rev_cntr like '045%' or a.rev_cntr = 0981) and age >= 65 and HI_COVERAGE=12 and SMI_COVERAGE=12 and HMO_COVERAGE=0
    ),
SNF as(
    SELECT 
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No
    FROM cms.SNF_revenuek_2016 as a
    inner join cms.[mbsf_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
    WHERE (a.rev_cntr like '045%' or a.rev_cntr = 0981) and age >= 65 and HI_COVERAGE=12 and SMI_COVERAGE=12 and HMO_COVERAGE=0
    ),
HOSP as(
    SELECT 
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No
    FROM cms.hosp_revenuek_2016 as a
    inner join cms.[mbsf_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
    WHERE (a.rev_cntr like '045%' or a.rev_cntr = 0981) and age >= 65 and HI_COVERAGE=12 and SMI_COVERAGE=12 and HMO_COVERAGE=0
    ),





inout as(
    select  [DESY_SORT_KEY],CLAIM_NO from inpatient
    union select  [DESY_SORT_KEY],CLAIM_NO from outpatient
    union select  [DESY_SORT_KEY],CLAIM_NO from HOSP
    union select  [DESY_SORT_KEY],CLAIM_NO from SNF
    union select  [DESY_SORT_KEY],CLAIM_NO from HHA

    )

    select count([DESY_SORT_KEY]) from inout 
