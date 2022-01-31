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


--Get the claims with the correct DRG that belong to one of the hospitals
data2016 as (
    Select
        --param 1 Count
    b.DESY_SORT_KEY,
    b.CLAIM_NO,
	b.ORG_NPI_NUM,
        --Param 4 Death
    case when PTNT_DSCHRG_STUS_CD=20 then '1' else '0' end as Death,
        --IV 1 SoI
    a.[SOI ] as SOI,
        --Param 2 LOS
    datediff("D",convert(date,convert(char(8),b.CLM_ADMSN_DT)),convert(date,convert(char(8),b.NCH_BENE_DSCHRG_DT))) as LOS,
	convert(date,convert(char(8),b.CLM_ADMSN_DT)) as admission,
	convert(date,convert(char(8),b.NCH_BENE_DSCHRG_DT)) as discharge,
        --IV2 ICU
    case when d.claim_no is null then 0 else 1 end as ICUClaim,
        --Param 3 isn't one I'm going to do in SQL. SQL's regex is weak, So, to do this, I need diagnosis and procedures, so that's what I'll be getting here. 
    '^'+isnull([ICD_DGNS_CD1],'')+'^'+
      isnull([ICD_DGNS_CD2],'')+'^'+
      isnull([ICD_DGNS_CD3],'')+'^'+
      isnull([ICD_DGNS_CD4],'')+'^'+
      isnull([ICD_DGNS_CD5],'')+'^'+
      isnull([ICD_DGNS_CD6],'')+'^'+
      isnull([ICD_DGNS_CD7],'')+'^'+
      isnull([ICD_DGNS_CD8],'')+'^'+
      isnull([ICD_DGNS_CD9],'')+'^'+
      isnull([ICD_DGNS_CD10],'')+'^'+
      isnull([ICD_DGNS_CD11],'')+'^'+
      isnull([ICD_DGNS_CD12],'')+'^'+
      isnull([ICD_DGNS_CD13],'')+'^'+
      isnull([ICD_DGNS_CD14],'')+'^'+
      isnull([ICD_DGNS_CD15],'')+'^'+
      isnull([ICD_DGNS_CD16],'')+'^'+
      isnull([ICD_DGNS_CD17],'')+'^'+
      isnull([ICD_DGNS_CD18],'')+'^'+
      isnull([ICD_DGNS_CD19],'')+'^'+
      isnull([ICD_DGNS_CD20],'')+'^'+
      isnull([ICD_DGNS_CD21],'')+'^'+
      isnull([ICD_DGNS_CD22],'')+'^'+
      isnull([ICD_DGNS_CD23],'')+'^'+
      isnull([ICD_DGNS_CD24],'')+'^'+
      isnull([ICD_DGNS_CD25],'') as dxall,
    '^'+isnull([ICD_PRCDR_CD1],'')+'^'+
      isnull([ICD_PRCDR_CD2],'')+'^'+
      isnull([ICD_PRCDR_CD3],'')+'^'+
      isnull([ICD_PRCDR_CD4],'')+'^'+
      isnull([ICD_PRCDR_CD5],'')+'^'+
      isnull([ICD_PRCDR_CD6],'')+'^'+
      isnull([ICD_PRCDR_CD7],'')+'^'+
      isnull([ICD_PRCDR_CD8],'')+'^'+
      isnull([ICD_PRCDR_CD9],'')+'^'+
      isnull([ICD_PRCDR_CD10],'')+'^'+
      isnull([ICD_PRCDR_CD11],'')+'^'+
      isnull([ICD_PRCDR_CD12],'')+'^'+
      isnull([ICD_PRCDR_CD13],'')+'^'+
      isnull([ICD_PRCDR_CD14],'')+'^'+
      isnull([ICD_PRCDR_CD15],'')+'^'+
      isnull([ICD_PRCDR_CD16],'')+'^'+
      isnull([ICD_PRCDR_CD17],'')+'^'+
      isnull([ICD_PRCDR_CD18],'')+'^'+
      isnull([ICD_PRCDR_CD19],'')+'^'+
      isnull([ICD_PRCDR_CD20],'')+'^'+
      isnull([ICD_PRCDR_CD21],'')+'^'+
      isnull([ICD_PRCDR_CD22],'')+'^'+
      isnull([ICD_PRCDR_CD23],'')+'^'+
      isnull([ICD_PRCDR_CD24],'')+'^'+
      isnull([ICD_PRCDR_CD25],'') as prall
    from dbo.pivot2016inpAPRDRGv2 as a
    inner join cms.inp_claimsk_2016 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO)
    left outer join ICUorg2016 as d on b.DESY_SORT_KEY=d.DESY_SORT_KEY and b.CLAIM_NO=d.CLAIM_NO
    where a.drg='194.0' and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT<20161000),

	data2015 as (
    Select
        --param 1 Count
    b.DESY_SORT_KEY,
    b.CLAIM_NO,
	b.ORG_NPI_NUM,
        --Param 4 Death
    case when PTNT_DSCHRG_STUS_CD=20 then '1' else '0' end as Death,
        --IV 1 SoI
    a.[SOI ] as SOI,
        --Param 2 LOS
    datediff("D",convert(date,convert(char(8),b.CLM_ADMSN_DT)),convert(date,convert(char(8),b.NCH_BENE_DSCHRG_DT))) as LOS,
	convert(date,convert(char(8),b.CLM_ADMSN_DT)) as admission,
	convert(date,convert(char(8),b.NCH_BENE_DSCHRG_DT)) as discharge,
        --IV2 ICU
    case when d.claim_no is null then 0 else 1 end as ICUClaim,
        --Param 3 isn't one I'm going to do in SQL. SQL's regex is weak, So, to do this, I need diagnosis and procedures, so that's what I'll be getting here. 
    '^'+isnull([ICD_DGNS_CD1],'')+'^'+
      isnull([ICD_DGNS_CD2],'')+'^'+
      isnull([ICD_DGNS_CD3],'')+'^'+
      isnull([ICD_DGNS_CD4],'')+'^'+
      isnull([ICD_DGNS_CD5],'')+'^'+
      isnull([ICD_DGNS_CD6],'')+'^'+
      isnull([ICD_DGNS_CD7],'')+'^'+
      isnull([ICD_DGNS_CD8],'')+'^'+
      isnull([ICD_DGNS_CD9],'')+'^'+
      isnull([ICD_DGNS_CD10],'')+'^'+
      isnull([ICD_DGNS_CD11],'')+'^'+
      isnull([ICD_DGNS_CD12],'')+'^'+
      isnull([ICD_DGNS_CD13],'')+'^'+
      isnull([ICD_DGNS_CD14],'')+'^'+
      isnull([ICD_DGNS_CD15],'')+'^'+
      isnull([ICD_DGNS_CD16],'')+'^'+
      isnull([ICD_DGNS_CD17],'')+'^'+
      isnull([ICD_DGNS_CD18],'')+'^'+
      isnull([ICD_DGNS_CD19],'')+'^'+
      isnull([ICD_DGNS_CD20],'')+'^'+
      isnull([ICD_DGNS_CD21],'')+'^'+
      isnull([ICD_DGNS_CD22],'')+'^'+
      isnull([ICD_DGNS_CD23],'')+'^'+
      isnull([ICD_DGNS_CD24],'')+'^'+
      isnull([ICD_DGNS_CD25],'') as dxall,
    '^'+isnull([ICD_PRCDR_CD1],'')+'^'+
      isnull([ICD_PRCDR_CD2],'')+'^'+
      isnull([ICD_PRCDR_CD3],'')+'^'+
      isnull([ICD_PRCDR_CD4],'')+'^'+
      isnull([ICD_PRCDR_CD5],'')+'^'+
      isnull([ICD_PRCDR_CD6],'')+'^'+
      isnull([ICD_PRCDR_CD7],'')+'^'+
      isnull([ICD_PRCDR_CD8],'')+'^'+
      isnull([ICD_PRCDR_CD9],'')+'^'+
      isnull([ICD_PRCDR_CD10],'')+'^'+
      isnull([ICD_PRCDR_CD11],'')+'^'+
      isnull([ICD_PRCDR_CD12],'')+'^'+
      isnull([ICD_PRCDR_CD13],'')+'^'+
      isnull([ICD_PRCDR_CD14],'')+'^'+
      isnull([ICD_PRCDR_CD15],'')+'^'+
      isnull([ICD_PRCDR_CD16],'')+'^'+
      isnull([ICD_PRCDR_CD17],'')+'^'+
      isnull([ICD_PRCDR_CD18],'')+'^'+
      isnull([ICD_PRCDR_CD19],'')+'^'+
      isnull([ICD_PRCDR_CD20],'')+'^'+
      isnull([ICD_PRCDR_CD21],'')+'^'+
      isnull([ICD_PRCDR_CD22],'')+'^'+
      isnull([ICD_PRCDR_CD23],'')+'^'+
      isnull([ICD_PRCDR_CD24],'')+'^'+
      isnull([ICD_PRCDR_CD25],'') as prall
    from dbo.pivot2015inpAPRDRGicd10 as a
    inner join cms.inp_claimsj_2015 as b on a.id=CONCAT(b.DESY_SORT_KEY,'^',b.CLAIM_NO)
    left outer join ICUorg2015 as d on b.DESY_SORT_KEY=d.DESY_SORT_KEY and b.CLAIM_NO=d.CLAIM_NO
    where a.drg='194.0' and PTNT_DSCHRG_STUS_CD!=2 and b.CLM_THRU_DT>20151000)

	,dataout as(
	select * from data2016
	union select * from data2015)

	select *
	into cms.zzpaper2_temp3
	from dataout