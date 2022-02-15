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
	,a.PRVDR_NUM,
	    b.[SOI ] as SOI,
   
    datediff("D",convert(date,convert(char(8),a.CLM_ADMSN_DT)),convert(date,convert(char(8),a.NCH_BENE_DSCHRG_DT))) as LOS,
   
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
	,    b.[SOI ] as SOI,
   
    datediff("D",convert(date,convert(char(8),a.CLM_ADMSN_DT)),convert(date,convert(char(8),a.NCH_BENE_DSCHRG_DT))) as LOS,
   
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

    select top 100 *
	from claimall

