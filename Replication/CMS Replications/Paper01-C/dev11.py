import pymssql as sql
import pandas as pd
import re
import os

conn = sql.connect(server='sql-ctlst-vp01\\TP', database='CAT1')
cursor = conn.cursor()
cursor.execute("""
with inpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        A.CLAIM_NO as Claim_No
    FROM cms.inp_revenuek_2016 as a
    inner join cms.[mbsf_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
    where (a.rev_cntr like '045%' or a.rev_cntr = 0981) and age >= 65 and HI_COVERAGE=12 and SMI_COVERAGE=12 and HMO_COVERAGE=0
    ),
outpatient as(
    SELECT 
        a.[DESY_SORT_KEY],
        a.CLAIM_NO as Claim_No
    FROM cms.out_revenuek_2016 as a
    inner join cms.[mbsf_2016] as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
    WHERE (a.rev_cntr like '045%' or a.rev_cntr = 0981) and age >= 65 and HI_COVERAGE=12 and SMI_COVERAGE=12 and HMO_COVERAGE=0
    ),
inout as(
    select  [DESY_SORT_KEY],CLAIM_NO from inpatient
    union select  [DESY_SORT_KEY],CLAIM_NO from outpatient
    ),

EMclaims as ( select distinct desy_sort_key, claim_no from inout),
Admvar as (
select a.DESY_SORT_KEY,a.Claim_No
,case when c.DESY_SORT_KEY is not null then c.PRNCPAL_DGNS_CD else d.PRNCPAL_DGNS_CD end as PRNCPAL_DGNS_CD
,case when c.DESY_SORT_KEY is not null then c.CLM_ADMSN_DT else d.CLM_THRU_DT end as Claim_Start
,case when c.DESY_SORT_KEY is not null then c.CLM_THRU_DT else d.CLM_THRU_DT end as CLM_THRU_DT
from EMclaims as a
left outer join cms.inp_claimsk_2016 as c on a.DESY_SORT_KEY=c.DESY_SORT_KEY and a.Claim_No=c.CLAIM_NO
left outer join cms.out_claimsk_2016 as d on a.DESY_SORT_KEY=d.DESY_SORT_KEY and a.Claim_No=d.CLAIM_NO
),
nextadm as(
select a.*,c.PRNCPAL_DGNS_CD as dgns_next,
datediff("D",convert(date,convert(char(8),a.Claim_Start)),min(convert(date,convert(char(8),c.CLM_THRU_DT)))) as daysdiff
from Admvar as a
left outer join Admvar as c on a.DESY_SORT_KEY=c.DESY_SORT_KEY and convert(date,convert(char(8),c.CLM_THRU_DT))>convert(date,convert(char(8),a.Claim_Start))and a.Claim_No!=c.Claim_No
group by a.DESY_SORT_KEY,a.Claim_No,a.PRNCPAL_DGNS_CD,a.Claim_Start,a.CLM_THRU_DT,c.PRNCPAL_DGNS_CD
),

Allvar as(
select
a.DESY_SORT_KEY,a.Claim_No,b.AGE,b.RACE_CODE,b.SEX_CODE,b.STATE_CODE,
case when DUAL_STUS_CD_01='02' or DUAL_STUS_CD_01 = '04' or DUAL_STUS_CD_01 ='06' or
DUAL_STUS_CD_02='02' or DUAL_STUS_CD_02 = '04' or DUAL_STUS_CD_02 ='06' or
DUAL_STUS_CD_03='02' or DUAL_STUS_CD_03 = '04' or DUAL_STUS_CD_03 ='06' or
DUAL_STUS_CD_04='02' or DUAL_STUS_CD_04 = '04' or DUAL_STUS_CD_04 ='06' or
DUAL_STUS_CD_05='02' or DUAL_STUS_CD_05 = '04' or DUAL_STUS_CD_05 ='06' or
DUAL_STUS_CD_06='02' or DUAL_STUS_CD_06 = '04' or DUAL_STUS_CD_06 ='06' or
DUAL_STUS_CD_07='02' or DUAL_STUS_CD_07 = '04' or DUAL_STUS_CD_07 ='06' or
DUAL_STUS_CD_08='02' or DUAL_STUS_CD_08 = '04' or DUAL_STUS_CD_08 ='06' or
DUAL_STUS_CD_09='02' or DUAL_STUS_CD_09 = '04' or DUAL_STUS_CD_09 ='06' or
DUAL_STUS_CD_10='02' or DUAL_STUS_CD_10 = '04' or DUAL_STUS_CD_10 ='06' or
DUAL_STUS_CD_11='02' or DUAL_STUS_CD_11 = '04' or DUAL_STUS_CD_11 ='06' or
DUAL_STUS_CD_12='02' or DUAL_STUS_CD_12 = '04' or DUAL_STUS_CD_12 ='06' then 1 else 0 end as DUAL_STUS_OR
,case when 
(DUAL_STUS_CD_01='02' or DUAL_STUS_CD_01 = '04' or DUAL_STUS_CD_01 ='06') and
(DUAL_STUS_CD_02='02' or DUAL_STUS_CD_02 = '04' or DUAL_STUS_CD_02 ='06') and
(DUAL_STUS_CD_03='02' or DUAL_STUS_CD_03 = '04' or DUAL_STUS_CD_03 ='06') and
(DUAL_STUS_CD_04='02' or DUAL_STUS_CD_04 = '04' or DUAL_STUS_CD_04 ='06') and
(DUAL_STUS_CD_05='02' or DUAL_STUS_CD_05 = '04' or DUAL_STUS_CD_05 ='06') and
(DUAL_STUS_CD_06='02' or DUAL_STUS_CD_06 = '04' or DUAL_STUS_CD_06 ='06') and
(DUAL_STUS_CD_07='02' or DUAL_STUS_CD_07 = '04' or DUAL_STUS_CD_07 ='06') and
(DUAL_STUS_CD_08='02' or DUAL_STUS_CD_08 = '04' or DUAL_STUS_CD_08 ='06') and
(DUAL_STUS_CD_09='02' or DUAL_STUS_CD_09 = '04' or DUAL_STUS_CD_09 ='06') and
(DUAL_STUS_CD_10='02' or DUAL_STUS_CD_10 = '04' or DUAL_STUS_CD_10 ='06') and
(DUAL_STUS_CD_11='02' or DUAL_STUS_CD_11 = '04' or DUAL_STUS_CD_11 ='06') and
(DUAL_STUS_CD_12='02' or DUAL_STUS_CD_12 = '04' or DUAL_STUS_CD_12 ='06') then 1 else 0 end as DUAL_STUS_AND
,case when c.DESY_SORT_KEY is not null then 1 else 0 end as ipAdmission

,case when c.DESY_SORT_KEY is not null then c.CLM_PMT_AMT else d.CLM_PMT_AMT end as clm_pmt_amt
,case when c.DESY_SORT_KEY is not null then c.CLM_TOT_CHRG_AMT else d.CLM_TOT_CHRG_AMT end as CLM_TOT_CHRG_AMT
,case when c.DESY_SORT_KEY is not null then c.NCH_PRMRY_PYR_CLM_PD_AMT else d.NCH_PRMRY_PYR_CLM_PD_AMT end as NCH_PRMRY_PYR_CLM_PD_AMT
,case when e.DESY_SORT_KEY is not null then e.CCI else f.CCI end as CCI

from EMclaims as a
inner join cms.mbsf_2016 as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY
left outer join cms.inp_claimsk_2016 as c on a.DESY_SORT_KEY=c.DESY_SORT_KEY and a.Claim_No=c.CLAIM_NO
left outer join cms.out_claimsk_2016 as d on a.DESY_SORT_KEY=d.DESY_SORT_KEY and a.Claim_No=d.CLAIM_NO
left outer join dbo.[2016out_pqiall] as e on a.DESY_SORT_KEY=e.DESY_SORT_KEY and a.Claim_No=e.CLAIM_NO
left outer join dbo.[2016inp_pqiall] as f on a.DESY_SORT_KEY=f.DESY_SORT_KEY and a.Claim_No=f.CLAIM_NO
)

Select a.*,b.PRNCPAL_DGNS_CD,b.dgns_next,b.daysdiff
from Allvar as a
inner join nextadm as b on a.DESY_SORT_KEY=b.DESY_SORT_KEY and a.Claim_No=b.Claim_No
    """)
data=cursor.fetchall()
df=pd.DataFrame(data, columns = [desc[0] for desc in cursor.description])

PQI01	=re.compile("\^+(?:E1011|E10641|E1065|E1100|E1101|E11641|E1165)",re.IGNORECASE)
PQI02	=re.compile("\^+(?:K352|K353|K3580|K3589|K37)",re.IGNORECASE)
PQI03	=re.compile("\^+(?:E1022|E1029|E10311|E10319|E10321|E10329|E10331|E10339|E10341|E10349|E10351|E10359|E1036|E1039|E1040|E1041|E1042|E1043|E1044|E1049|E1051|E1052|E1059|E10610|E10618|E10620|E10621|E10622|E10628|E10630|E10638|E1069|E108|E1121|E1122|E1129|E11311|E11319|E11321|E11329|E11331|E11339|E11341|E11349|E11351|E11359|E1136|E1139|E1140|E1141|E1142|E1143|E1144|E1149|E1151|E1152|E1159|E11610|E11618|E11620|E11621|E11622|E11628|E11630|E11638|E1169|E118)",re.IGNORECASE)
PQI05	=re.compile("\^+(?:J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|2016|J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|2016|J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|2016|J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|2016|J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998)",re.IGNORECASE)
PQI07	=re.compile("\^+(?:I10|I119|I129|I1310)",re.IGNORECASE)
PQI08	=re.compile("\^+(?:I0981|I110|I130|I132|I501|I5020|I5021|I5022|I5023|I5030|I5031|I5032|I5033|I5040|I5041|I5042|I5043|I509)",re.IGNORECASE)
PQI09	=re.compile("\^+(?:P0501|P0502|P0503|P0504|P0505|P0506|P0507|P0508|P0511|P0512|P0513|P0514|P0515|P0516|P0517|P0518|P0700|P0701|P0702|P0703|P0710|P0714|P0715|P0716|P0717|P0718)",re.IGNORECASE)
PQI10	=re.compile("\^+(?:E860|E861|E869|E870|A080|A0811|A0819|A082|A0831|A0832|A0839|A084|A088|A09|K5289|K529|N170|N170|N172|N178|N179|N19|N990)",re.IGNORECASE)
PQI11	=re.compile("\^+(?:J13|J14|J15211|J15212|J153|J154|J157|J159|J160|J168|J180|J181|J188|J189)",re.IGNORECASE)
PQI12	=re.compile("\^+(?:N10|N119|N12|N151|N159|N16|N2884|N2885|N2886|N3000|N3001|N3090|N3091|N390)",re.IGNORECASE)
PQI13	=re.compile("\^+(?:E1065|E1165|E10649|E11649)",re.IGNORECASE)
PQI15	=re.compile("\^+(?:J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998)",re.IGNORECASE)

df['PQI01dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI01dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI02dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI02dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI03dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI03dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI05dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI05dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI07dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI07dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI08dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI08dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI09dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI09dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI10dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI10dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI11dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI11dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI12dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI12dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI13dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI13dxN']=df['dgns_next'].str.contains(PQI01, regex=True)
df['PQI15dxP']=df['PRNCPAL_DGNS_CD'].str.contains(PQI01, regex=True)
df['PQI15dxN']=df['dgns_next'].str.contains(PQI01, regex=True)

if (df['PQI01dxP']): df['pqiP']='01'
if (df['PQI02dxP']): df['pqiP']='02'
if (df['PQI03dxP']): df['pqiP']='03'
if (df['PQI05dxP']): df['pqiP']='05'
if (df['PQI07dxP']): df['pqiP']='07'
if (df['PQI08dxP']): df['pqiP']='08'
if (df['PQI09dxP']): df['pqiP']='09'
if (df['PQI10dxP']): df['pqiP']='10'
if (df['PQI11dxP']): df['pqiP']='11'
if (df['PQI12dxP']): df['pqiP']='12'
if (df['PQI13dxP']): df['pqiP']='13'
if (df['PQI15dxP']): df['pqiP']='15'

if (df['PQI01dxN']): df['pqiN']='01'
if (df['PQI02dxN']): df['pqIN']='02'
if (df['PQI03dxN']): df['pqiN']='03'
if (df['PQI05dxN']): df['pqiN']='05'
if (df['PQI07dxN']): df['pqiN']='07'
if (df['PQI08dxN']): df['pqiN']='08'
if (df['PQI09dxN']): df['pqiN']='09'
if (df['PQI10dxN']): df['pqiN']='10'
if (df['PQI11dxN']): df['pqiN']='11'
if (df['PQI12dxN']): df['pqiN']='12'
if (df['PQI13dxN']): df['pqiN']='13'
if (df['PQI15dxN']): df['pqiN']='15'

df.drop(['PQI01dxN','PQI02dxN','PQI03dxN','PQI05dxN','PQI07dxN','PQI08dxN','PQI09dxN','PQI10dxN','PQI11dxN','PQI12dxN','PQI13dxN','PQI15dxN'], axis=1, inplace=True)
df.drop(['PQI01dxP','PQI02dxP','PQI03dxP','PQI05dxP','PQI07dxP','PQI08dxP','PQI09dxP','PQI10dxP','PQI11dxP','PQI12dxP','PQI13dxP','PQI15dxP'], axis=1, inplace=True)
dirname = os.path.dirname(__file__)
filepath = os.path.join(dirname, 'paper01dev06.csv')
df.to_csv(filepath)
