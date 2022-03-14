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
