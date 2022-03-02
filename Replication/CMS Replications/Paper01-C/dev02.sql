24,952,921 is the count, which obviously is much higher than I want, and we surely have duplicate claims. So lets try this

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
    select distinct [DESY_SORT_KEY],CLAIM_NO from inpatient
    union select distinct [DESY_SORT_KEY],CLAIM_NO from outpatient
    )

select count([DESY_SORT_KEY]) from inout

This gives me the distinct from each dataset.
24,952,921

Lets validate we’re getting all the rev centers

with inpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        A.CLAIM_NO as Claim_No,
        rev_cntr
    FROM cms.inp_revenuek_2016 as a
    where a.rev_cntr like '045%' or a.rev_cntr = 0981
    ),
outpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No,
        rev_cntr
    FROM cms.out_revenuek_2016 as a
    WHERE a.rev_cntr like '045%' or a.rev_cntr = 0981
    ),
inout as(
    select  [DESY_SORT_KEY],CLAIM_NO,rev_cntr from inpatient
    union select  [DESY_SORT_KEY],CLAIM_NO,rev_cntr from outpatient
    )

select count(rev_cntr),rev_cntr from inout group by rev_cntr

(No column name)    rev_cntr
24279723    0450
429033    0452
184033    0456
5    0458
929656    0981
448841    0451
35067    0459

So I am getting all of my rev centers, so that’s good. 

Now lets look at distinct claims.

with inpatient as(
    SELECT distinct
        a.[DESY_SORT_KEY],
        A.CLAIM_NO as Claim_No
    FROM cms.inp_revenuek_2016 as a
    where a.rev_cntr like '045%' or a.rev_cntr = 0981
    ),
outpatient as(
    SELECT distinct
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No
    FROM cms.out_revenuek_2016 as a
    WHERE a.rev_cntr like '045%' or a.rev_cntr = 0981
    ),
inout as(
    select  [DESY_SORT_KEY],CLAIM_NO from inpatient
    union select  [DESY_SORT_KEY],CLAIM_NO from outpatient
    )

select count([DESY_SORT_KEY]) from inout

24952921
So that implies there are no duplicates.
