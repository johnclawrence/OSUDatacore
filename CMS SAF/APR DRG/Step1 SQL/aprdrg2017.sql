/****** Script for SelectTopNRows command from SSMS  ******/
SELECT cast(a.[DESY_SORT_KEY] as varchar(max))+'^'+cast(a.[CLAIM_NO] as varchar(max)) as case_ID,
	4 as grpr_family,
	380 as grpr_version,
	0 as ice_code_type,
	'' as admit_dx,
	case when icd_dgns_cd1 is null then 0 else 1 end+
	case when icd_dgns_cd2 is null then 0 else 1 end+
	case when icd_dgns_cd3 is null then 0 else 1 end+
	case when icd_dgns_cd4 is null then 0 else 1 end+
	case when icd_dgns_cd5 is null then 0 else 1 end+
	case when icd_dgns_cd6 is null then 0 else 1 end+
	case when icd_dgns_cd7 is null then 0 else 1 end+
	case when icd_dgns_cd8 is null then 0 else 1 end+
	case when icd_dgns_cd9 is null then 0 else 1 end+ 
	case when icd_dgns_cd10 is null then 0 else 1 end+
	case when icd_dgns_cd11 is null then 0 else 1 end+
	case when icd_dgns_cd12 is null then 0 else 1 end+
	case when icd_dgns_cd13 is null then 0 else 1 end+
	case when icd_dgns_cd14 is null then 0 else 1 end+
	case when icd_dgns_cd15 is null then 0 else 1 end+
	case when icd_dgns_cd16 is null then 0 else 1 end+
	case when icd_dgns_cd17 is null then 0 else 1 end+
	case when icd_dgns_cd18 is null then 0 else 1 end+
	case when icd_dgns_cd19 is null then 0 else 1 end+
	case when icd_dgns_cd20 is null then 0 else 1 end+
	case when icd_dgns_cd21 is null then 0 else 1 end+
	case when icd_dgns_cd22 is null then 0 else 1 end+
	case when icd_dgns_cd23 is null then 0 else 1 end+
	case when icd_dgns_cd24 is null then 0 else 1 end+
	case when icd_dgns_cd25 is null then 0 else 1 end
	as num_dx,
	7 as dx_width,
	case when icd_dgns_cd1 is not null then LEFT(icd_dgns_cd1 + space(7), 7) else '' end+
	case when icd_dgns_cd2 is not null then LEFT(icd_dgns_cd2 + space(7), 7) else '' end+
	case when icd_dgns_cd3 is not null then LEFT(icd_dgns_cd3 + space(7), 7) else '' end+
	case when icd_dgns_cd4 is not null then LEFT(icd_dgns_cd4 + space(7), 7) else '' end+
	case when icd_dgns_cd5 is not null then LEFT(icd_dgns_cd5 + space(7), 7) else '' end+
	case when icd_dgns_cd6 is not null then LEFT(icd_dgns_cd6 + space(7), 7) else '' end+
	case when icd_dgns_cd7 is not null then LEFT(icd_dgns_cd7 + space(7), 7) else '' end+
	case when icd_dgns_cd8 is not null then LEFT(icd_dgns_cd8 + space(7), 7) else '' end+
	case when icd_dgns_cd9 is not null then LEFT(icd_dgns_cd9 + space(7), 7) else '' end+
	case when icd_dgns_cd10 is not null then LEFT(icd_dgns_cd10 + space(7), 7) else '' end+
	case when icd_dgns_cd11 is not null then LEFT(icd_dgns_cd11 + space(7), 7) else '' end+
	case when icd_dgns_cd12 is not null then LEFT(icd_dgns_cd12 + space(7), 7) else '' end+
	case when icd_dgns_cd13 is not null then LEFT(icd_dgns_cd13 + space(7), 7) else '' end+
	case when icd_dgns_cd14 is not null then LEFT(icd_dgns_cd14 + space(7), 7) else '' end+
	case when icd_dgns_cd15 is not null then LEFT(icd_dgns_cd15 + space(7), 7) else '' end+
	case when icd_dgns_cd16 is not null then LEFT(icd_dgns_cd16 + space(7), 7) else '' end+
	case when icd_dgns_cd17 is not null then LEFT(icd_dgns_cd17 + space(7), 7) else '' end+
	case when icd_dgns_cd18 is not null then LEFT(icd_dgns_cd18 + space(7), 7) else '' end+
	case when icd_dgns_cd19 is not null then LEFT(icd_dgns_cd19 + space(7), 7) else '' end+
	case when icd_dgns_cd20 is not null then LEFT(icd_dgns_cd20 + space(7), 7) else '' end+
	case when icd_dgns_cd21 is not null then LEFT(icd_dgns_cd21 + space(7), 7) else '' end+
	case when icd_dgns_cd22 is not null then LEFT(icd_dgns_cd22 + space(7), 7) else '' end+
	case when icd_dgns_cd23 is not null then LEFT(icd_dgns_cd23 + space(7), 7) else '' end+
	case when icd_dgns_cd24 is not null then LEFT(icd_dgns_cd24 + space(7), 7) else '' end+
	case when icd_dgns_cd25 is not null then LEFT(icd_dgns_cd25 + space(7), 7) else '' end

	 as diagnosis,
	'' as in_reserved1,
	case when [ICD_PRCDR_CD1] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD2] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD3] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD4] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD5] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD6] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD7] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD8] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD9] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD10] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD11] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD12] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD13] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD14] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD15] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD16] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD17] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD18] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD19] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD20] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD21] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD22] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD23] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD24] is null then 0 else 1 end+
	case when [ICD_PRCDR_CD25] is null then 0 else 1 end
	as num_proc,
	7 as proc_width, 
	case when [ICD_PRCDR_CD1] is not null then LEFT([ICD_PRCDR_CD1] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD2] is not null then LEFT([ICD_PRCDR_CD2] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD3] is not null then LEFT([ICD_PRCDR_CD3] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD4] is not null then LEFT([ICD_PRCDR_CD4] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD5] is not null then LEFT([ICD_PRCDR_CD5] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD6] is not null then LEFT([ICD_PRCDR_CD6] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD7] is not null then LEFT([ICD_PRCDR_CD7] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD8] is not null then LEFT([ICD_PRCDR_CD8] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD9] is not null then LEFT([ICD_PRCDR_CD9] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD10] is not null then LEFT([ICD_PRCDR_CD10] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD11] is not null then LEFT([ICD_PRCDR_CD11] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD12] is not null then LEFT([ICD_PRCDR_CD12] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD13] is not null then LEFT([ICD_PRCDR_CD13] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD14] is not null then LEFT([ICD_PRCDR_CD14] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD15] is not null then LEFT([ICD_PRCDR_CD15] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD16] is not null then LEFT([ICD_PRCDR_CD16] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD17] is not null then LEFT([ICD_PRCDR_CD17] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD18] is not null then LEFT([ICD_PRCDR_CD18] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD19] is not null then LEFT([ICD_PRCDR_CD19] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD20] is not null then LEFT([ICD_PRCDR_CD20] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD21] is not null then LEFT([ICD_PRCDR_CD21] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD22] is not null then LEFT([ICD_PRCDR_CD22] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD23] is not null then LEFT([ICD_PRCDR_CD23] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD24] is not null then LEFT([ICD_PRCDR_CD24] + space(7), 7) else '' end+
	case when [ICD_PRCDR_CD25] is not null then LEFT([ICD_PRCDR_CD25] + space(7), 7) else '' end
	as pro, 
	b.AGE,
	b.SEX_CODE,
	PTNT_DSCHRG_STUS_CD,
	-1 as daysadmit,
	-1 as daysdischarge,
	6 as bw_option,
	-1 as bw,
	-9 as daysonvent,
	2017 as year,
	4 as quarter
	into cms.zzinpclaim2017aprdrgpre
FROM [CAT1].[cms].[inp_claimsk_2017] as a
inner join cat1.cms.mbsf_2017 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
