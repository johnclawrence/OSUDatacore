SELECT [DESY_SORT_KEY]
      ,[CLAIM_NO]
     	,isnull([ICD_DGNS_CD1],'')+'^'+
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
      isnull([ICD_DGNS_CD25],'') as dxall
	  into cms.z_out_2017_dx
  FROM [CAT1].[cms].[out_claimsk_2017]