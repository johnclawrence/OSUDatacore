
--Full population
SELECT [DESY_SORT_KEY],[REFERENCE_YEAR] FROM [CAT1].[cms].[dnmntr_saf_lds_2013]
union SELECT [DESY_SORT_KEY],[REFERENCE_YEAR] FROM [CAT1].[cms].[dnmntr_saf_lds_2014]
union SELECT [DESY_SORT_KEY],[REFERENCE_YEAR] FROM [CAT1].[cms].[dnmntr_saf_lds_2015])

Select * from denom1

--Age by Year
with denom1 as(
SELECT [DESY_SORT_KEY],age,[REFERENCE_YEAR] FROM [CAT1].[cms].[dnmntr_saf_lds_2013]
union SELECT [DESY_SORT_KEY],age,[REFERENCE_YEAR] FROM [CAT1].[cms].[dnmntr_saf_lds_2014]
union SELECT [DESY_SORT_KEY],age,[REFERENCE_YEAR] FROM [CAT1].[cms].[dnmntr_saf_lds_2015])

Select count(desy_sort_key),REFERENCE_YEAR from denom1
where age >64 and age<101
group by reference_year

--Get DX for all inp claims for those beneies
with denom1 as(
SELECT a.[DESY_SORT_KEY],age,[REFERENCE_YEAR],'^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2013] as a inner join cms.inp_claimsj_2013 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
union SELECT a.[DESY_SORT_KEY],age,[REFERENCE_YEAR],'^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2014] as a inner join cms.inp_claimsj_2014 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
union SELECT a.[DESY_SORT_KEY],age,[REFERENCE_YEAR],'^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2015] as a inner join cms.inp_claimsj_2015 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY)

Select * from denom1
where age >64 and age<101