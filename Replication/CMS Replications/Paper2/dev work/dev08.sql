/****** Script for SelectTopNRows command from SSMS  ******/
with icu16 as(
SELECT distinct
	a.DESY_SORT_KEY,
      a.[CLAIM_NO],
	  2016 as year
     
 FROM [CAT1].[cms].[inp_claimsk_2016] as a
  inner join cms.mbsf_2016 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
  inner join cms.inp_revenuek_2016 as c on a.claim_no=c.claim_no
  where REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219
  ),
  icu15 as(
SELECT distinct
	a.DESY_SORT_KEY,
      a.[CLAIM_NO],
	  2015 as year
     
 FROM [CAT1].[cms].[inp_claimsj_2015] as a
  inner join cms.dnmntr_saf_lds_2015 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
  inner join cms.inp_revenuej_2015 as c on a.claim_no=c.claim_no
  where REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
  or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
  or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219
  ),
icu1516 as(  select * from icu15
  union select * from icu16)
  


  select * into cms.zzpaper2_icu1516 from icu1516
