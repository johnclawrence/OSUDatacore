Tim asked me to recreate this query. 

Can you please create an excel file for Hospitals in Ohio with name, full address, and the organizational characteristcs from this paper:
https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3329212/
Hospital Characteristics Related to the Intention to Apply for Meaningful Use Incentive Payments
The Health Information Technology for Economic and Clinical Health (HITECH) Act of 2009 provides incentives for hospitals to fully adopt and use electronic health records (EHRs). We used data from ...

So, Hospital Characteristics are....

Besdize, BSC

TAx Status, CNTRL

Rurality, 

CNTYNAME
CBSANAME
CBSATYPE


Teching hospital status
MAPP3,5,8

Address
MLOCADDR
MLOCCITY
MLOCSTCD
MLOCZIP
HOSPNO
MSANAME

/****** Script for SelectTopNRows command from SSMS  ******/

with ahads as(SELECT ID, bsc,cntrl,cntyname,cbsaname,cbsatype,mapp3,mapp5,mapp8,mlocaddr,mloccity,mlocstcd,mloczip,mname, 2020 as year FROM [Isilon].[AHA].[annual2020]
union SELECT ID, bsc,cntrl,cntyname,cbsaname,cbsatype,mapp3,mapp5,mapp8,mlocaddr,mloccity,mlocstcd,mloczip,mname, 2019 as year FROM [Isilon].[AHA].[annual2019]
union SELECT ID, bsc,cntrl,cntyname,cbsaname,cbsatype,mapp3,mapp5,mapp8,mlocaddr,mloccity,mlocstcd,mloczip,mname, 2018 as year FROM [Isilon].[AHA].[annual2018])

select id as AHAID,
bsc as bedSize,
cntrl as CNTRL,
cntyName as county,
cbsaName as cbsa,
cbsaType as cbsaType,
mapp3 as ResTraining,
mapp5 as schoolAMA,
mapp8 as COTH,
mlocaddr as address,
mloccity as City,
mlocZip as Zip,
mname as name,
year
from ahads 
  where mlocstcd = 41