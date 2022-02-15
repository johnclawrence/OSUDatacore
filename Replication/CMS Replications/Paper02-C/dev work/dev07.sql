with ICUorg2016 as(
SELECT distinct a.[DESY_SORT_KEY]
      ,a.[CLAIM_NO]
	  ,2016 as year
	  ,b.ORG_NPI_NUM
  FROM [cms].[inp_revenuek_2016] as a
  inner join [cms].[inp_claimsk_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
  where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219) 
  ),
  ICUorg2015 as(
SELECT distinct a.[DESY_SORT_KEY]
      ,a.[CLAIM_NO]
	  ,2015 as year
	  ,b.ORG_NPI_NUM
  FROM [cms].[inp_revenuej_2015] as a
  inner join [cms].[inp_claimsj_2015] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
  where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219) 
  icuorgAll as (
  select * from ICUorg2016
  union select * from ICUorg2015),

  orgICU as(
  select org_npi_num
  from icuorgAll
  group by ORG_NPI_NUM
  having count(claim_no)>100),

  cohort2015 as(
    Select
    b.CLAIM_NO,
	b.ORG_NPI_NUM,
	case when c.claim_no is not null then 1 else 0 end as icu
	from dbo.pivot2015inpAPRDRGv36 as a 
    inner join cms.inp_claimsj_2015 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO) 
	left outer join ICUorg2015 as c on b.CLAIM_NO=c.CLAIM_NO
	inner join orgICU as d on b.ORG_NPI_NUM=d.ORG_NPI_NUM
    where a.drg='194.0' and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT>20151000 and b.CLM_THRU_DT<20161000) 
,cohort2016 as(
    Select
    b.CLAIM_NO,
	b.ORG_NPI_NUM
	,case when c.claim_no is not null then 1 else 0 end as icu
	from dbo.pivot2016inpAPRDRGv36 as a 
    inner join cms.inp_claimsk_2016 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO) 
	left outer join ICUorg2015 as c on b.CLAIM_NO=c.CLAIM_NO
	inner join orgICU as d on b.ORG_NPI_NUM=d.ORG_NPI_NUM
    where a.drg='194.0' and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT>20151000 and b.CLM_THRU_DT<20161000)

,cohort as(
select * from cohort2015
union select * from cohort2016)


Select * 
into cms.zzPaper2_cohort_icu100v2
from cohort

