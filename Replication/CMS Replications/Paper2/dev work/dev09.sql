--Step 1: The research team obtained financial year 2016 (FY2016) Medicare fee-for-service claims spanning October 1, 2015, through September 30, 2016. 
  with 
    claim2016 as(
    select a.claim_no ,2016 as year
    from cms.inp_claimsk_2016 as a
	where a.CLM_THRU_DT < 20161000
    )

    ,claim2015 as (
    select a.claim_no ,2015 as year
    from cms.inp_claimsj_2015 as a
	 where a.CLM_THRU_DT > 20151000
    )

    ,claimall as(
    select * from claim2015
    union
	select * from claim2016
	)

    select year, count(claim_no) from claimall
	group by year



--Step 2: The team retained claims for hospitals paid under the IPPS and grouped claims under Version 36 of the All-Patient Refined Diagnosis-Related Group (APR-DRG) classification system.
  with 
    claim2016 as(
    select a.claim_no ,2016 as year
    from cms.inp_claimsk_2016 as a
	inner join dbo.[pivot2016inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
    where a.CLM_THRU_DT < 20161000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !=''
    )

    ,claim2015 as (
    select a.claim_no ,2015 as year
    from cms.inp_claimsj_2015 as a
	inner join dbo.[pivot2015inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
    where a.CLM_THRU_DT > 20151000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !=''
    )

    ,claimall as(
    select * from claim2015
    union
	select * from claim2016
	)

    select year, count(claim_no) from claimall
	group by year



--Step 3: Cases identified as transfers (discharge disposition = 2) and flagged cases in which patients died (discharge disposition = 20) were excluded for subsequent analysis.

  with 
    claim2016 as(
    select a.claim_no ,2016 as year
	,case when  PTNT_DSCHRG_STUS_CD=20 then 1 else 0 end as Death
    from cms.inp_claimsk_2016 as a
	inner join dbo.[pivot2016inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
    where a.CLM_THRU_DT < 20161000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !='' and CLM_PPS_IND_CD !='' and PTNT_DSCHRG_STUS_CD!=2
    )

    ,claim2015 as (
    select a.claim_no ,2015 as year
	,case when  PTNT_DSCHRG_STUS_CD=20 then 1 else 0 end as Death
    from cms.inp_claimsj_2015 as a
	inner join dbo.[pivot2015inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
    where a.CLM_THRU_DT > 20151000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !='' and CLM_PPS_IND_CD !='' and PTNT_DSCHRG_STUS_CD!=2
    )

    ,claimall as(
    select * from claim2015
    union
	select * from claim2016
	)

    select year, count(claim_no) from claimall
	where Death=0
	group by year


--step 4: To identify patient admissions reported as receiving days in ICUs, the research team flagged a claim as ICU if any claim charges were made for a revenue center code listed in Supplementary Appendix 2.
      with 
  ICUorg2016 as(
    SELECT distinct 
        a.[CLAIM_NO]
    FROM [cms].[inp_revenuek_2016] as a
    inner join [cms].[inp_claimsk_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
    where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
    or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
    or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219)
    ),
    ICUorg2015 as(
    SELECT distinct
        a.[CLAIM_NO]
    FROM [cms].[inp_revenuej_2015] as a
    inner join [cms].[inp_claimsj_2015] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
    where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
    or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
    or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219)
    ),
    claim2016 as(
    select a.claim_no ,2016 as year
	,case when  PTNT_DSCHRG_STUS_CD=20 then 1 else 0 end as Death
	,case when c.claim_no is not null then 1 else 0 end as ICU
    from cms.inp_claimsk_2016 as a
	inner join dbo.[pivot2016inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
	left outer join ICUorg2016 as c on a.CLAIM_NO=c.CLAIM_NO
    where a.CLM_THRU_DT < 20161000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !='' and CLM_PPS_IND_CD !='' and PTNT_DSCHRG_STUS_CD!=2
    )

    ,claim2015 as (
    select a.claim_no ,2015 as year
	,case when  PTNT_DSCHRG_STUS_CD=20 then 1 else 0 end as Death
	,case when c.claim_no is not null then 1 else 0 end as ICU
    from cms.inp_claimsj_2015 as a
	inner join dbo.[pivot2015inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
	left outer join ICUorg2015 as c on a.CLAIM_NO=c.CLAIM_NO
    where a.CLM_THRU_DT > 20151000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !='' and CLM_PPS_IND_CD !='' and PTNT_DSCHRG_STUS_CD!=2
    )

    ,claimall as(
    select * from claim2015
    union
	select * from claim2016
	)

    select year, icu,count(claim_no) 
	from claimall
	where Death=0
	group by year,icu


--Step 6 The analysis was further restricted to hospitals having at least 100 ICU cases within the claims data.
   with 
  ICUorg2016 as(
    SELECT distinct 
        a.[CLAIM_NO]
    FROM [cms].[inp_revenuek_2016] as a
    inner join [cms].[inp_claimsk_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
    where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
    or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
    or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219)
    ),
    ICUorg2015 as(
    SELECT distinct
        a.[CLAIM_NO]
    FROM [cms].[inp_revenuej_2015] as a
    inner join [cms].[inp_claimsj_2015] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
    where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
    or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
    or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219)
    ),
    claim2016 as(
    select a.claim_no ,2016 as year
	,case when  PTNT_DSCHRG_STUS_CD=20 then 1 else 0 end as Death
	,case when c.claim_no is not null then 1 else 0 end as ICU
	,PRVDR_NUM
    from cms.inp_claimsk_2016 as a
	inner join dbo.[pivot2016inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
	left outer join ICUorg2016 as c on a.CLAIM_NO=c.CLAIM_NO
    where a.CLM_THRU_DT < 20161000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !='' and CLM_PPS_IND_CD !='' and PTNT_DSCHRG_STUS_CD!=2
    )

    ,claim2015 as (
    select a.claim_no ,2015 as year
	,case when  PTNT_DSCHRG_STUS_CD=20 then 1 else 0 end as Death
	,case when c.claim_no is not null then 1 else 0 end as ICU
	,PRVDR_NUM
    from cms.inp_claimsj_2015 as a
	inner join dbo.[pivot2015inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
	left outer join ICUorg2015 as c on a.CLAIM_NO=c.CLAIM_NO
    where a.CLM_THRU_DT > 20151000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !='' and CLM_PPS_IND_CD !='' and PTNT_DSCHRG_STUS_CD!=2
    )

    ,claimall as(
    select * from claim2015
    union
	select * from claim2016
	)

    select PRVDR_NUM
	into cms.zzpaper2_prvlistFY2016
	from claimall
	group by PRVDR_NUM
	having sum(icu)>=100


--Also Step 6
  with 
  ICUorg2016 as(
    SELECT distinct 
        a.[CLAIM_NO]
    FROM [cms].[inp_revenuek_2016] as a
    inner join [cms].[inp_claimsk_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
    where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
    or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
    or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219)
    ),
    ICUorg2015 as(
    SELECT distinct
        a.[CLAIM_NO]
    FROM [cms].[inp_revenuej_2015] as a
    inner join [cms].[inp_claimsj_2015] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.CLAIM_NO=b.CLAIM_NO
    where (a.REV_CNTR=200 or REV_CNTR=201 or REV_CNTR=202 or REV_CNTR=203 or REV_CNTR=204 or REV_CNTR=206
    or REV_CNTR=207 or REV_CNTR=208 or REV_CNTR=209 or REV_CNTR=210 or REV_CNTR=211 or REV_CNTR=212 
    or REV_CNTR=213 or REV_CNTR=214 or REV_CNTR=219)
    ),
    claim2016 as(
    select a.claim_no ,2016 as year
	,case when  PTNT_DSCHRG_STUS_CD=20 then 1 else 0 end as Death
	,case when c.claim_no is not null then 1 else 0 end as ICU
	,a.PRVDR_NUM
    from cms.inp_claimsk_2016 as a
	inner join dbo.[pivot2016inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
	left outer join ICUorg2016 as c on a.CLAIM_NO=c.CLAIM_NO
	inner join cms.zzpaper2_prvlistFY2016 as d on a.PRVDR_NUM=d.PRVDR_NUM
    where a.CLM_THRU_DT < 20161000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !='' and CLM_PPS_IND_CD !='' and PTNT_DSCHRG_STUS_CD!=2
    )

    ,claim2015 as (
    select a.claim_no ,2015 as year
	,case when  PTNT_DSCHRG_STUS_CD=20 then 1 else 0 end as Death
	,case when c.claim_no is not null then 1 else 0 end as ICU
	,a.PRVDR_NUM
    from cms.inp_claimsj_2015 as a
	inner join dbo.[pivot2015inpAPRDRGv36] as b on [id]=CONCAT(a.DESY_SORT_KEY,'^',a.CLAIM_NO) and [DRG ] = '194.0'
	left outer join ICUorg2015 as c on a.CLAIM_NO=c.CLAIM_NO
	inner join cms.zzpaper2_prvlistFY2016 as d on a.PRVDR_NUM=d.PRVDR_NUM
    where a.CLM_THRU_DT > 20151000 and CLM_FAC_TYPE_CD=1 and CLM_PPS_IND_CD !='' and CLM_PPS_IND_CD !='' and PTNT_DSCHRG_STUS_CD!=2
    )

    ,claimall as(
    select * from claim2015
    union
	select * from claim2016
	)

    select year, icu,count(claim_no) 
	from claimall
	group by year,icu

