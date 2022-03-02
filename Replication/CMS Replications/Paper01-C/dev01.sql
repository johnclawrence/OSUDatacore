with inpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        A.CLAIM_NO as Claim_No
    FROM cms.inp_revenuek_2016 as a
    where a.rev_cntr like '045%' or a.rev_cntr = 0981
  )
 ,outpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No
    FROM cms.out_revenuek_2016 as a
    WHERE a.rev_cntr like '045%' or a.rev_cntr = 0981
    )
  select [DESY_SORT_KEY],CLAIM_NO from inpatient
  union select [DESY_SORT_KEY],CLAIM_NO from outpatient
Well, that ran out of memory.

with inpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        A.CLAIM_NO as Claim_No
    FROM cms.inp_revenuek_2016 as a
    where a.rev_cntr like '045%' or a.rev_cntr = 0981
    ),
outpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No
    FROM cms.out_revenuek_2016 as a
    WHERE a.rev_cntr like '045%' or a.rev_cntr = 0981
    ),
inout as(
    select [DESY_SORT_KEY],CLAIM_NO from inpatient
    union select [DESY_SORT_KEY],CLAIM_NO from outpatient
    )

select count([DESY_SORT_KEY]) from inout
