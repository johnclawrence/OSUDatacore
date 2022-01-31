--Get the claims with an icu visit
with ICUorg2016 as(
SELECT distinct a.[DESY_SORT_KEY]
      ,a.[CLAIM_NO]
	  ,2016 as year
	  ,b.ORG_NPI_NUM
  FROM [cms].[inp_revenuek_2016] as a
  inner join [cms].[inp_claimsk_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
  where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219) and b.CLM_THRU_DT<20161000
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
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219) and b.CLM_THRU_DT>20151000
  ),

--Get the list of hospitals with 100 ICU visits or more
ICUOrgAll as(
select * from ICUorg2015
union select * from ICUorg2016),

icuorgnum as
(select org_npi_num
from ICUOrgAll
group by ORG_NPI_NUM
having count(claim_no)>=100),
--Get the claims with the correct DRG that belong to one of the hospitals
data2016 as (
    Select
    b.DESY_SORT_KEY,
    b.CLAIM_NO,
	b.ORG_NPI_NUM,
	b.clm_PPS_IND_cd,
    case when PTNT_DSCHRG_STUS_CD=20 then '1' else '0' end as Death,
    case when d.claim_no is null then 0 else 1 end as ICUClaim
    from dbo.pivot2016inpAPRDRGv36 as a
    inner join cms.inp_claimsk_2016 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO)
	inner join icuorgnum as c on b.ORG_NPI_NUM=c.ORG_NPI_NUM
    left outer join ICUorg2016 as d on b.DESY_SORT_KEY=d.DESY_SORT_KEY and b.CLAIM_NO=d.CLAIM_NO
    where a.drg='194.0' and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT<20161000),

	data2015 as (
    Select
    b.DESY_SORT_KEY,
    b.CLAIM_NO,
	b.ORG_NPI_NUM,
	b.clm_PPS_IND_cd,
    case when PTNT_DSCHRG_STUS_CD=20 then '1' else '0' end as Death,
    case when d.claim_no is null then 0 else 1 end as ICUClaim
    from dbo.pivot2015inpAPRDRGv36 as a --DRG194
    inner join cms.inp_claimsj_2015 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO) --getting claims level data
	inner join icuorgnum as c on b.ORG_NPI_NUM=c.ORG_NPI_NUM --is it in an org
    left outer join ICUorg2015 as d on b.DESY_SORT_KEY=d.DESY_SORT_KEY and b.CLAIM_NO=d.CLAIM_NO --was it an ICU encounter
    where a.drg='194.0' and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT>20151000) --starting in october of 2015...

	,dataout as(
	select * from data2016
	union select * from data2015)

	select *
	into cms.zzpaper2_temp3_icu100v36
	from dataout