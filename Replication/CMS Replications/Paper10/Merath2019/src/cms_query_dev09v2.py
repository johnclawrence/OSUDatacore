import pymssql as sql
import pandas as pd
import re

conn = sql.connect(server='sql-ctlst-vp01\\TP', database='CAT1')
cursor = conn.cursor()
cursor.execute("""with denom1 as(
SELECT a.[DESY_SORT_KEY],b.claim_no,age,CCI,[CLM_THRU_DT],CLM_ADMSN_DT,[readmission],PQI05,PQI08,CCI13,[occ mix adjusted wage index] as WI,a.[REFERENCE_YEAR],HI_COVERAGE,SMI_COVERAGE,HMO_COVERAGE,[DATE_OF_DEATH],b.[CLM_PMT_AMT],NCH_PRMRY_PYR_CLM_PD_AMT,[SEX_CODE],[RACE_CODE],[PRVDR_NUM],'^'+isnull([ICD_PRCDR_CD1],'')+'^'+isnull([ICD_PRCDR_CD2],'')+'^'+isnull([ICD_PRCDR_CD3],'')+'^'+isnull([ICD_PRCDR_CD4],'')+'^'+isnull([ICD_PRCDR_CD5],'')+'^'+isnull([ICD_PRCDR_CD6],'')+'^'+isnull([ICD_PRCDR_CD7],'')+'^'+isnull([ICD_PRCDR_CD8],'')+'^'+isnull([ICD_PRCDR_CD9],'')+'^'+isnull([ICD_PRCDR_CD10],'')+'^'+isnull([ICD_PRCDR_CD11],'')+'^'+isnull([ICD_PRCDR_CD12],'')+'^'+isnull([ICD_PRCDR_CD13],'')+'^'+isnull([ICD_PRCDR_CD14],'')+'^'+isnull([ICD_PRCDR_CD15],'')+'^'+isnull([ICD_PRCDR_CD16],'')+'^'+isnull([ICD_PRCDR_CD17],'')+'^'+isnull([ICD_PRCDR_CD18],'')+'^'+isnull([ICD_PRCDR_CD19],'')+'^'+isnull([ICD_PRCDR_CD20],'')+'^'+isnull([ICD_PRCDR_CD21],'')+'^'+isnull([ICD_PRCDR_CD22],'')+'^'+isnull([ICD_PRCDR_CD23],'')+'^'+isnull([ICD_PRCDR_CD24],'')+'^'+isnull([ICD_PRCDR_CD25],'') as prall, '^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall
FROM [CAT1].[cms].[dnmntr_saf_lds_2013] as a 
inner join cms.inp_claimsj_2013 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
left outer join [CAT1].dbo.[2013inp_readmission] as d on a.DESY_SORT_KEY=d.DESY_SORT_KEY and b.claim_no=d.claim_no
left outer join [CAT1].dbo.[2013WI] as e on b.[PRVDR_NUM]=e.[PROV]
left outer join [CAT1].dbo.[2013inp_pqiall] as f on a.DESY_SORT_KEY=f.DESY_SORT_KEY and b.claim_no=f.claim_no

union 
SELECT a.[DESY_SORT_KEY],b.claim_no,age,CCI,[CLM_THRU_DT],CLM_ADMSN_DT,[readmission],PQI05,PQI08,CCI13,[occmix wage index] as WI,a.[REFERENCE_YEAR],HI_COVERAGE,SMI_COVERAGE,HMO_COVERAGE,[DATE_OF_DEATH],b.[CLM_PMT_AMT],NCH_PRMRY_PYR_CLM_PD_AMT,[SEX_CODE],[RACE_CODE],[PRVDR_NUM],'^'+isnull([ICD_PRCDR_CD1],'')+'^'+isnull([ICD_PRCDR_CD2],'')+'^'+isnull([ICD_PRCDR_CD3],'')+'^'+isnull([ICD_PRCDR_CD4],'')+'^'+isnull([ICD_PRCDR_CD5],'')+'^'+isnull([ICD_PRCDR_CD6],'')+'^'+isnull([ICD_PRCDR_CD7],'')+'^'+isnull([ICD_PRCDR_CD8],'')+'^'+isnull([ICD_PRCDR_CD9],'')+'^'+isnull([ICD_PRCDR_CD10],'')+'^'+isnull([ICD_PRCDR_CD11],'')+'^'+isnull([ICD_PRCDR_CD12],'')+'^'+isnull([ICD_PRCDR_CD13],'')+'^'+isnull([ICD_PRCDR_CD14],'')+'^'+isnull([ICD_PRCDR_CD15],'')+'^'+isnull([ICD_PRCDR_CD16],'')+'^'+isnull([ICD_PRCDR_CD17],'')+'^'+isnull([ICD_PRCDR_CD18],'')+'^'+isnull([ICD_PRCDR_CD19],'')+'^'+isnull([ICD_PRCDR_CD20],'')+'^'+isnull([ICD_PRCDR_CD21],'')+'^'+isnull([ICD_PRCDR_CD22],'')+'^'+isnull([ICD_PRCDR_CD23],'')+'^'+isnull([ICD_PRCDR_CD24],'')+'^'+isnull([ICD_PRCDR_CD25],'') as prall, '^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall
FROM [CAT1].[cms].[dnmntr_saf_lds_2014] as a 
inner join cms.inp_claimsj_2014 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
left outer join [CAT1].dbo.[2014inp_readmission] as d on a.DESY_SORT_KEY=d.DESY_SORT_KEY and b.claim_no=d.claim_no
left outer join [CAT1].dbo.[2014WI] as e on b.[PRVDR_NUM]=e.[PROV]
left outer join [CAT1].dbo.[2014inp_pqiall] as f on a.DESY_SORT_KEY=f.DESY_SORT_KEY and b.claim_no=f.claim_no

union 
SELECT a.[DESY_SORT_KEY],b.claim_no,age,CCI,[CLM_THRU_DT],CLM_ADMSN_DT,[readmission],PQI05,PQI08,CCI13,[cbsa_new occmix wage index] as WI,a.[REFERENCE_YEAR],HI_COVERAGE,SMI_COVERAGE,HMO_COVERAGE,[DATE_OF_DEATH],b.[CLM_PMT_AMT],NCH_PRMRY_PYR_CLM_PD_AMT,[SEX_CODE],[RACE_CODE],[PRVDR_NUM],'^'+isnull([ICD_PRCDR_CD1],'')+'^'+isnull([ICD_PRCDR_CD2],'')+'^'+isnull([ICD_PRCDR_CD3],'')+'^'+isnull([ICD_PRCDR_CD4],'')+'^'+isnull([ICD_PRCDR_CD5],'')+'^'+isnull([ICD_PRCDR_CD6],'')+'^'+isnull([ICD_PRCDR_CD7],'')+'^'+isnull([ICD_PRCDR_CD8],'')+'^'+isnull([ICD_PRCDR_CD9],'')+'^'+isnull([ICD_PRCDR_CD10],'')+'^'+isnull([ICD_PRCDR_CD11],'')+'^'+isnull([ICD_PRCDR_CD12],'')+'^'+isnull([ICD_PRCDR_CD13],'')+'^'+isnull([ICD_PRCDR_CD14],'')+'^'+isnull([ICD_PRCDR_CD15],'')+'^'+isnull([ICD_PRCDR_CD16],'')+'^'+isnull([ICD_PRCDR_CD17],'')+'^'+isnull([ICD_PRCDR_CD18],'')+'^'+isnull([ICD_PRCDR_CD19],'')+'^'+isnull([ICD_PRCDR_CD20],'')+'^'+isnull([ICD_PRCDR_CD21],'')+'^'+isnull([ICD_PRCDR_CD22],'')+'^'+isnull([ICD_PRCDR_CD23],'')+'^'+isnull([ICD_PRCDR_CD24],'')+'^'+isnull([ICD_PRCDR_CD25],'') as prall, '^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall
FROM [CAT1].[cms].[dnmntr_saf_lds_2015] as a 
inner join cms.inp_claimsj_2015 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
left outer join [CAT1].dbo.[2015inp_readmission] as d on a.DESY_SORT_KEY=d.DESY_SORT_KEY and b.claim_no=d.claim_no
left outer join [CAT1].dbo.[2015WI] as e on b.[PRVDR_NUM]=e.[PROV]
left outer join [CAT1].dbo.[2015inp_pqiall] as f on a.DESY_SORT_KEY=f.DESY_SORT_KEY and b.claim_no=f.claim_no

)
Select a.* 
from denom1 as a
where a.age >64 and a.age<101
    and a.HI_COVERAGE=12
    and a.SMI_COVERAGE=12
    and a.HMO_COVERAGE=0
    and a.NCH_PRMRY_PYR_CLM_PD_AMT=0
    and a.CLM_ADMSN_DT is not null
    and a.CLM_THRU_DT is not null
    and (prall like '%^525%'
    or prall like '%^526%'
    or prall like '%^527%'
    or prall like '%^5022%'
    or prall like '%^503%')
    """)
data=cursor.fetchall()
df=pd.DataFrame(data, columns = [desc[0] for desc in cursor.description])
prTar=re.compile("\^+(?:525|526|527|5022|503)",re.IGNORECASE)
prNCP=re.compile("\^+(?:5252|5259)",re.IGNORECASE)
prCP=re.compile("\^+(?:5251|5253|526|527)",re.IGNORECASE)
prNCL=re.compile("\^+(?:5022)",re.IGNORECASE)
prCL=re.compile("\^+(?:503)",re.IGNORECASE)
prMIS=re.compile("\^+(?:541)",re.IGNORECASE)
df['prSurg']=df['prall'].str.contains(prTar, regex=True)
df['prNCP']=df['prall'].str.contains(prNCP, regex=True)
df['prCP']=df['prall'].str.contains(prCP, regex=True)
df['prNCL']=df['prall'].str.contains(prNCL, regex=True)
df['prCL']=df['prall'].str.contains(prCL, regex=True)
df['prMIS']=df['prall'].str.contains(prMIS, regex=True)
dfSurg=df[df['prSurg']==True]

dfSurgPath = "dat/tmp/dev09v2.csv"
dfSurg.to_csv(dfSurgPath)
sys.stdout.write(dfSurgPath)
