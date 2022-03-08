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
inout as(
    select  [DESY_SORT_KEY],CLAIM_NO from inpatient
    union select  [DESY_SORT_KEY],CLAIM_NO from outpatient
    ),

EMclaims as ( select distinct desy_sort_key, claim_no from inout),
Admvar as (
select a.DESY_SORT_KEY,a.Claim_No
,case when c.DESY_SORT_KEY is not null then c.PRNCPAL_DGNS_CD else d.PRNCPAL_DGNS_CD end as PRNCPAL_DGNS_CD
,case when c.DESY_SORT_KEY is not null then c.CLM_ADMSN_DT else d.CLM_THRU_DT end as Claim_Start
,case when c.DESY_SORT_KEY is not null then c.CLM_THRU_DT else d.CLM_THRU_DT end as CLM_THRU_DT
from EMclaims as a
left outer join cms.inp_claimsk_2016 as c on a.DESY_SORT_KEY=c.DESY_SORT_KEY and a.Claim_No=c.CLAIM_NO
left outer join cms.out_claimsk_2016 as d on a.DESY_SORT_KEY=d.DESY_SORT_KEY and a.Claim_No=d.CLAIM_NO
),
nextadm as(
select a.*,c.PRNCPAL_DGNS_CD as dgns_next,
datediff("D",convert(date,convert(char(8),a.Claim_Start)),min(convert(date,convert(char(8),c.CLM_THRU_DT)))) as daysdiff
from Admvar as a
left outer join Admvar as c on a.DESY_SORT_KEY=c.DESY_SORT_KEY and convert(date,convert(char(8),c.CLM_THRU_DT))>convert(date,convert(char(8),a.Claim_Start))and a.Claim_No!=c.Claim_No
group by a.DESY_SORT_KEY,a.Claim_No,a.PRNCPAL_DGNS_CD,a.Claim_Start,a.CLM_THRU_DT,c.PRNCPAL_DGNS_CD
),

Allvar as(
select
a.DESY_SORT_KEY,a.Claim_No,b.AGE,b.RACE_CODE,b.SEX_CODE,b.STATE_CODE
,DUAL_STUS_CD_01,DUAL_STUS_CD_02,DUAL_STUS_CD_03,DUAL_STUS_CD_04
,DUAL_STUS_CD_05,DUAL_STUS_CD_06,DUAL_STUS_CD_07,DUAL_STUS_CD_08
,DUAL_STUS_CD_09,DUAL_STUS_CD_10,DUAL_STUS_CD_11,DUAL_STUS_CD_12
,case when c.DESY_SORT_KEY is not null then 1 else 0 end as ipAdmission

,case when c.DESY_SORT_KEY is not null then c.CLM_PMT_AMT else d.CLM_PMT_AMT end as clm_pmt_amt
,case when c.DESY_SORT_KEY is not null then c.CLM_TOT_CHRG_AMT else d.CLM_TOT_CHRG_AMT end as CLM_TOT_CHRG_AMT
,case when c.DESY_SORT_KEY is not null then c.NCH_PRMRY_PYR_CLM_PD_AMT else d.NCH_PRMRY_PYR_CLM_PD_AMT end as NCH_PRMRY_PYR_CLM_PD_AMT
,case when e.DESY_SORT_KEY is not null then e.CCI else f.CCI end as CCI

from EMclaims as a
inner join cms.mbsf_2016 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
left outer join cms.inp_claimsk_2016 as c on a.DESY_SORT_KEY=c.DESY_SORT_KEY and a.Claim_No=c.CLAIM_NO
left outer join cms.out_claimsk_2016 as d on a.DESY_SORT_KEY=d.DESY_SORT_KEY and a.Claim_No=d.CLAIM_NO
left outer join dbo.[2016out_pqiall] as e on a.DESY_SORT_KEY=e.DESY_SORT_KEY and a.Claim_No=e.CLAIM_NO
left outer join dbo.[2016inp_pqiall] as f on a.DESY_SORT_KEY=f.DESY_SORT_KEY and a.Claim_No=f.CLAIM_NO
)

Select a.*,b.dgns_next,b.daysdiff
from Allvar as a
inner join nextadm as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.Claim_No=b.Claim_No
