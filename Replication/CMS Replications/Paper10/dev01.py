import pymssql as sql
import pandas as pd
import re

conn = sql.connect(server='sql-ctlst-vp01\\TP', database='CAT1')
cursor = conn.cursor()
cursor.execute("""with denom1 as(
SELECT a.[DESY_SORT_KEY],claim_no,age,[REFERENCE_YEAR],'^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2013] as a inner join cms.inp_claimsj_2013 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
union SELECT a.[DESY_SORT_KEY],claim_no,age,[REFERENCE_YEAR],'^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2014] as a inner join cms.inp_claimsj_2014 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
union SELECT a.[DESY_SORT_KEY],claim_no,age,[REFERENCE_YEAR],'^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall FROM [CAT1].[cms].[dnmntr_saf_lds_2015] as a inner join cms.inp_claimsj_2015 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY)
Select * from denom1
where age >64 and age<101""")
data=cursor.fetchall()
df=pd.DataFrame(data, columns = [desc[0] for desc in cursor.description])
dxTar=re.compile("\^+(?:525|526|527|5022|503)",re.IGNORECASE)
df['dxSurg']=df['dxall'].str.contains(dxTar, regex=True)
dfSurg=df[df['dxSurg']==True]
dfSurg.to_csv("L:\Research\datacore\TARSS\Paper10\dev01v2.csv")
print (dfSurg)
