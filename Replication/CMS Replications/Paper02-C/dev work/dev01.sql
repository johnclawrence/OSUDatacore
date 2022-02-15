with ICUorg2016 as(
SELECT distinct a.[DESY_SORT_KEY]
      ,a.[CLAIM_NO]
	  ,b.ORG_NPI_NUM
  FROM [cms].[inp_revenuek_2016] as a
  inner join [cms].[inp_claimsk_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
  where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219) and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT<20161000
  ),
  ICUorg2015 as(
SELECT distinct a.[DESY_SORT_KEY]
      ,a.[CLAIM_NO]
	  ,b.ORG_NPI_NUM
  FROM [cms].[inp_revenuej_2015] as a
  inner join [cms].[inp_claimsj_2015] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
  where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219) and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT>20151000
  ),
  ICUordall as
  (select * from ICUorg2015
  union select * from ICUorg2016)
--Get the list of hospitals with 100 ICU visits or more

select org_npi_num
from ICUordall
group by ORG_NPI_NUM
having count(claim_no)>=100