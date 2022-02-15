
  with cohort2015 as(
    Select
    b.CLAIM_NO,
	b.ORG_NPI_NUM
	from dbo.pivot2015inpAPRDRGv36 as a 
    inner join cms.inp_claimsj_2015 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO) 
    where a.drg='194.0' and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT>20151000 and b.CLM_THRU_DT<20161000) 
,cohort2016 as(
    Select
    b.CLAIM_NO,
	b.ORG_NPI_NUM
	from dbo.pivot2016inpAPRDRGv36 as a 
    inner join cms.inp_claimsk_2016 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO) 
    where a.drg='194.0' and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT>20151000 and b.CLM_THRU_DT<20161000)

,cohort as(
select * from cohort2015
union select * from cohort2016)


Select * 
into cms.zzPaper2_cohort
from cohort

