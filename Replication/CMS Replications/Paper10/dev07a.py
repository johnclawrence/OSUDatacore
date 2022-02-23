import pymssql as sql
import pandas as pd
import re

conn = sql.connect(server='sql-ctlst-vp01\\TP', database='CAT1')
cursor = conn.cursor()
cursor.execute("""with denom1 as(
SELECT a.[DESY_SORT_KEY],b.claim_no,age,c.[CLM_THRU_DT],[REFERENCE_YEAR],CLM_ADMSN_DT,NCH_BENE_DSCHRG_DT,HI_COVERAGE,SMI_COVERAGE,HMO_COVERAGE,NCH_PRMRY_PYR_CLM_PD_AMT,'^'+isnull([ICD_PRCDR_CD1],'')+'^'+isnull([ICD_PRCDR_CD2],'')+'^'+isnull([ICD_PRCDR_CD3],'')+'^'+isnull([ICD_PRCDR_CD4],'')+'^'+isnull([ICD_PRCDR_CD5],'')+'^'+isnull([ICD_PRCDR_CD6],'')+'^'+isnull([ICD_PRCDR_CD7],'')+'^'+isnull([ICD_PRCDR_CD8],'')+'^'+isnull([ICD_PRCDR_CD9],'')+'^'+isnull([ICD_PRCDR_CD10],'')+'^'+isnull([ICD_PRCDR_CD11],'')+'^'+isnull([ICD_PRCDR_CD12],'')+'^'+isnull([ICD_PRCDR_CD13],'')+'^'+isnull([ICD_PRCDR_CD14],'')+'^'+isnull([ICD_PRCDR_CD15],'')+'^'+isnull([ICD_PRCDR_CD16],'')+'^'+isnull([ICD_PRCDR_CD17],'')+'^'+isnull([ICD_PRCDR_CD18],'')+'^'+isnull([ICD_PRCDR_CD19],'')+'^'+isnull([ICD_PRCDR_CD20],'')+'^'+isnull([ICD_PRCDR_CD21],'')+'^'+isnull([ICD_PRCDR_CD22],'')+'^'+isnull([ICD_PRCDR_CD23],'')+'^'+isnull([ICD_PRCDR_CD24],'')+'^'+isnull([ICD_PRCDR_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2013] as a inner join cms.inp_claimsj_2013 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY  inner join cms.inp_revenuej_2013 as c on b.DESY_SORT_KEY=c.DESY_SORT_KEY and b.claim_no=c.claim_no and c.REV_CNTR like'036%'
union SELECT a.[DESY_SORT_KEY],b.claim_no,age,c.[CLM_THRU_DT],[REFERENCE_YEAR],CLM_ADMSN_DT,NCH_BENE_DSCHRG_DT,HI_COVERAGE,SMI_COVERAGE,HMO_COVERAGE,NCH_PRMRY_PYR_CLM_PD_AMT,'^'+isnull([ICD_PRCDR_CD1],'')+'^'+isnull([ICD_PRCDR_CD2],'')+'^'+isnull([ICD_PRCDR_CD3],'')+'^'+isnull([ICD_PRCDR_CD4],'')+'^'+isnull([ICD_PRCDR_CD5],'')+'^'+isnull([ICD_PRCDR_CD6],'')+'^'+isnull([ICD_PRCDR_CD7],'')+'^'+isnull([ICD_PRCDR_CD8],'')+'^'+isnull([ICD_PRCDR_CD9],'')+'^'+isnull([ICD_PRCDR_CD10],'')+'^'+isnull([ICD_PRCDR_CD11],'')+'^'+isnull([ICD_PRCDR_CD12],'')+'^'+isnull([ICD_PRCDR_CD13],'')+'^'+isnull([ICD_PRCDR_CD14],'')+'^'+isnull([ICD_PRCDR_CD15],'')+'^'+isnull([ICD_PRCDR_CD16],'')+'^'+isnull([ICD_PRCDR_CD17],'')+'^'+isnull([ICD_PRCDR_CD18],'')+'^'+isnull([ICD_PRCDR_CD19],'')+'^'+isnull([ICD_PRCDR_CD20],'')+'^'+isnull([ICD_PRCDR_CD21],'')+'^'+isnull([ICD_PRCDR_CD22],'')+'^'+isnull([ICD_PRCDR_CD23],'')+'^'+isnull([ICD_PRCDR_CD24],'')+'^'+isnull([ICD_PRCDR_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2014] as a inner join cms.inp_claimsj_2014 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY  inner join cms.inp_revenuej_2014 as c on b.DESY_SORT_KEY=c.DESY_SORT_KEY and b.claim_no=c.claim_no and c.REV_CNTR like'036%'
union SELECT a.[DESY_SORT_KEY],b.claim_no,age,c.[CLM_THRU_DT],[REFERENCE_YEAR],CLM_ADMSN_DT,NCH_BENE_DSCHRG_DT,HI_COVERAGE,SMI_COVERAGE,HMO_COVERAGE,NCH_PRMRY_PYR_CLM_PD_AMT,'^'+isnull([ICD_PRCDR_CD1],'')+'^'+isnull([ICD_PRCDR_CD2],'')+'^'+isnull([ICD_PRCDR_CD3],'')+'^'+isnull([ICD_PRCDR_CD4],'')+'^'+isnull([ICD_PRCDR_CD5],'')+'^'+isnull([ICD_PRCDR_CD6],'')+'^'+isnull([ICD_PRCDR_CD7],'')+'^'+isnull([ICD_PRCDR_CD8],'')+'^'+isnull([ICD_PRCDR_CD9],'')+'^'+isnull([ICD_PRCDR_CD10],'')+'^'+isnull([ICD_PRCDR_CD11],'')+'^'+isnull([ICD_PRCDR_CD12],'')+'^'+isnull([ICD_PRCDR_CD13],'')+'^'+isnull([ICD_PRCDR_CD14],'')+'^'+isnull([ICD_PRCDR_CD15],'')+'^'+isnull([ICD_PRCDR_CD16],'')+'^'+isnull([ICD_PRCDR_CD17],'')+'^'+isnull([ICD_PRCDR_CD18],'')+'^'+isnull([ICD_PRCDR_CD19],'')+'^'+isnull([ICD_PRCDR_CD20],'')+'^'+isnull([ICD_PRCDR_CD21],'')+'^'+isnull([ICD_PRCDR_CD22],'')+'^'+isnull([ICD_PRCDR_CD23],'')+'^'+isnull([ICD_PRCDR_CD24],'')+'^'+isnull([ICD_PRCDR_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2015] as a inner join cms.inp_claimsj_2015 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY  inner join cms.inp_revenuej_2015 as c on b.DESY_SORT_KEY=c.DESY_SORT_KEY and b.claim_no=c.claim_no and c.REV_CNTR like'036%')
Select * from denom1
where age >64 and age<101
    and HI_COVERAGE=12
    and SMI_COVERAGE=12
    and HMO_COVERAGE=0
    and NCH_PRMRY_PYR_CLM_PD_AMT=0
    """)
data=cursor.fetchall()
df=pd.DataFrame(data, columns = [desc[0] for desc in cursor.description])
dxTar=re.compile("\^+(?:525|526|527|5022|503)",re.IGNORECASE)
df['dxSurg']=df['dxall'].str.contains(dxTar, regex=True)
dfSurg=df[df['dxSurg']==True]
dfSurg.to_csv("L:\Research\datacore\TARSS\Paper10\dev07v1.csv")
print (dfSurg)
