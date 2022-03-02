
with uni2013 as(
SELECT DESY_SORT_KEY  
  FROM [CAT1].[cms].[dnmntr_saf_lds_2013]
    group by  [DESY_SORT_KEY]
  having count([DESY_SORT_KEY])=1
),

uni2014 as(
SELECT DESY_SORT_KEY  
  FROM [CAT1].[cms].[dnmntr_saf_lds_2014]
    group by  [DESY_SORT_KEY]
  having count([DESY_SORT_KEY])=1
),
uni2015 as(
SELECT DESY_SORT_KEY  
  FROM [CAT1].[cms].[dnmntr_saf_lds_2015]
    group by  [DESY_SORT_KEY]
  having count([DESY_SORT_KEY])=1
),
uni2016 as(
SELECT DESY_SORT_KEY  
  FROM [CAT1].[cms].mbsf_2016
    group by  [DESY_SORT_KEY]
  having count([DESY_SORT_KEY])=1
),
uni2017 as(
SELECT DESY_SORT_KEY  
  FROM [CAT1].[cms].mbsf_2017
    group by  [DESY_SORT_KEY]
  having count([DESY_SORT_KEY])=1
),
uniall as(
select * from uni2013
union select * from uni2014
union select * from uni2015
union select * from uni2016
union select * from uni2017),

benilist as (select distinct DESY_SORT_KEY
from uniall)

select top 10 a.DESY_SORT_KEY 
,case when b.DESY_SORT_KEY is null then 0 else b.[HI_COVERAGE] end as HI2013
,case when b.DESY_SORT_KEY is null then 0 else b.[SMI_COVERAGE] end as SMI2013
,case when b.DESY_SORT_KEY is null then 0 else b.[HMO_COVERAGE] end as HMO2013
,case when c.DESY_SORT_KEY is null then 0 else c.[HI_COVERAGE] end as HI2014
,case when c.DESY_SORT_KEY is null then 0 else c.[SMI_COVERAGE] end as SMI2014
,case when c.DESY_SORT_KEY is null then 0 else c.[HMO_COVERAGE] end as HMO2014
,case when d.DESY_SORT_KEY is null then 0 else d.[HI_COVERAGE] end as HI2015
,case when d.DESY_SORT_KEY is null then 0 else d.[SMI_COVERAGE] end as SMI2015
,case when d.DESY_SORT_KEY is null then 0 else d.[HMO_COVERAGE] end as HMO2015
,case when e.DESY_SORT_KEY is null then 0 else e.[HI_COVERAGE] end as HI2016
,case when e.DESY_SORT_KEY is null then 0 else e.[SMI_COVERAGE] end as SMI2016
,case when e.DESY_SORT_KEY is null then 0 else e.[HMO_COVERAGE] end as HMO2016
,case when f.DESY_SORT_KEY is null then 0 else f.[HI_COVERAGE] end as HI2017
,case when f.DESY_SORT_KEY is null then 0 else f.[SMI_COVERAGE] end as SMI2017
,case when f.DESY_SORT_KEY is null then 0 else f.[HMO_COVERAGE] end as HMO2017
,case when b.DESY_SORT_KEY is not null and b.[HI_COVERAGE] >0 then 2013
	when c.DESY_SORT_KEY is not null and c.[HI_COVERAGE] >0 then 2014
	when d.DESY_SORT_KEY is not null and d.[HI_COVERAGE] >0 then 2015
	when e.DESY_SORT_KEY is not null and e.[HI_COVERAGE] >0 then 2016
	when f.DESY_SORT_KEY is not null and f.[HI_COVERAGE] >0 then 2017
	end as HI_start_year
, case when b.DESY_SORT_KEY is not null and b.[HI_COVERAGE] >0 then 13-b.[HI_COVERAGE]
	when c.DESY_SORT_KEY is not null and c.[HI_COVERAGE] >0 then 13-c.[HI_COVERAGE]
	when d.DESY_SORT_KEY is not null and d.[HI_COVERAGE] >0 then 13-d.[HI_COVERAGE]
	when e.DESY_SORT_KEY is not null and e.[HI_COVERAGE] >0 then 13-e.[HI_COVERAGE]
	when f.DESY_SORT_KEY is not null and f.[HI_COVERAGE] >0 then 13-f.[HI_COVERAGE] 
	end as HI_start_month
,case when f.DESY_SORT_KEY is not null and f.[HI_COVERAGE] >0 then 2017
	when e.DESY_SORT_KEY is not null and e.[HI_COVERAGE] >0 then 2016
	when d.DESY_SORT_KEY is not null and d.[HI_COVERAGE] >0 then 2015
	when c.DESY_SORT_KEY is not null and c.[HI_COVERAGE] >0 then 2014
	when b.DESY_SORT_KEY is not null and b.[HI_COVERAGE] >0 then 2013
	end as HI_end_year
, case when f.DESY_SORT_KEY is not null and f.[SMI_COVERAGE] >0 then f.[SMI_COVERAGE]
	when e.DESY_SORT_KEY is not null and e.[SMI_COVERAGE] >0 then e.[SMI_COVERAGE]
	when d.DESY_SORT_KEY is not null and d.[SMI_COVERAGE] >0 then d.[SMI_COVERAGE]
	when c.DESY_SORT_KEY is not null and c.[SMI_COVERAGE] >0 then c.[SMI_COVERAGE]
	when b.DESY_SORT_KEY is not null and b.[SMI_COVERAGE] >0 then b.[SMI_COVERAGE] 
	end as HI_end_month
,case when b.DESY_SORT_KEY is not null and b.[SMI_COVERAGE] >0 then 2013
	when c.DESY_SORT_KEY is not null and c.[SMI_COVERAGE] >0 then 2014
	when d.DESY_SORT_KEY is not null and d.[SMI_COVERAGE] >0 then 2015
	when e.DESY_SORT_KEY is not null and e.[SMI_COVERAGE] >0 then 2016
	when f.DESY_SORT_KEY is not null and f.[SMI_COVERAGE] >0 then 2017
	end as SMI_start_year
, case when b.DESY_SORT_KEY is not null and b.[SMI_COVERAGE] >0 then 13-b.[SMI_COVERAGE]
	when c.DESY_SORT_KEY is not null and c.[SMI_COVERAGE] >0 then 13-c.[SMI_COVERAGE]
	when d.DESY_SORT_KEY is not null and d.[SMI_COVERAGE] >0 then 13-d.[SMI_COVERAGE]
	when e.DESY_SORT_KEY is not null and e.[SMI_COVERAGE] >0 then 13-e.[SMI_COVERAGE]
	when f.DESY_SORT_KEY is not null and f.[SMI_COVERAGE] >0 then 13-f.[SMI_COVERAGE] 
	end as SMI_start_month
,case when f.DESY_SORT_KEY is not null and f.[SMI_COVERAGE] >0 then 2017
	when e.DESY_SORT_KEY is not null and e.[SMI_COVERAGE] >0 then 2016
	when d.DESY_SORT_KEY is not null and d.[SMI_COVERAGE] >0 then 2015
	when c.DESY_SORT_KEY is not null and c.[SMI_COVERAGE] >0 then 2014
	when b.DESY_SORT_KEY is not null and b.[SMI_COVERAGE] >0 then 2013
	end as SMI_end_year
, case when f.DESY_SORT_KEY is not null and f.[SMI_COVERAGE] >0 then f.[SMI_COVERAGE]
	when e.DESY_SORT_KEY is not null and e.[SMI_COVERAGE] >0 then e.[SMI_COVERAGE]
	when d.DESY_SORT_KEY is not null and d.[SMI_COVERAGE] >0 then d.[SMI_COVERAGE]
	when c.DESY_SORT_KEY is not null and c.[SMI_COVERAGE] >0 then c.[SMI_COVERAGE]
	when b.DESY_SORT_KEY is not null and b.[SMI_COVERAGE] >0 then b.[SMI_COVERAGE] 
	end as SMI_end_month
,case when b.DESY_SORT_KEY is not null and b.[HMO_COVERAGE] >0 then 2013
	when c.DESY_SORT_KEY is not null and c.[HMO_COVERAGE] >0 then 2014
	when d.DESY_SORT_KEY is not null and d.[HMO_COVERAGE] >0 then 2015
	when e.DESY_SORT_KEY is not null and e.[HMO_COVERAGE] >0 then 2016
	when f.DESY_SORT_KEY is not null and f.[HMO_COVERAGE] >0 then 2017
	end as HMO_start_year
, case when b.DESY_SORT_KEY is not null and b.[HMO_COVERAGE] >0 then 13-b.[HMO_COVERAGE]
	when c.DESY_SORT_KEY is not null and c.[HMO_COVERAGE] >0 then 13-c.[HMO_COVERAGE]
	when d.DESY_SORT_KEY is not null and d.[HMO_COVERAGE] >0 then 13-d.[HMO_COVERAGE]
	when e.DESY_SORT_KEY is not null and e.[HMO_COVERAGE] >0 then 13-e.[HMO_COVERAGE]
	when f.DESY_SORT_KEY is not null and f.[HMO_COVERAGE] >0 then 13-f.[HMO_COVERAGE] 
	end as HMO_start_month
,case when f.DESY_SORT_KEY is not null and f.[HMO_COVERAGE] >0 then 2017
	when e.DESY_SORT_KEY is not null and e.[HMO_COVERAGE] >0 then 2016
	when d.DESY_SORT_KEY is not null and d.[HMO_COVERAGE] >0 then 2015
	when c.DESY_SORT_KEY is not null and c.[HMO_COVERAGE] >0 then 2014
	when b.DESY_SORT_KEY is not null and b.[HMO_COVERAGE] >0 then 2013
	end as HMO_end_year
, case when f.DESY_SORT_KEY is not null and f.[HMO_COVERAGE] >0 then f.[HMO_COVERAGE]
	when e.DESY_SORT_KEY is not null and e.[HMO_COVERAGE] >0 then e.[HMO_COVERAGE]
	when d.DESY_SORT_KEY is not null and d.[HMO_COVERAGE] >0 then d.[HMO_COVERAGE]
	when c.DESY_SORT_KEY is not null and c.[HMO_COVERAGE] >0 then c.[HMO_COVERAGE]
	when b.DESY_SORT_KEY is not null and b.[HMO_COVERAGE] >0 then b.[HMO_COVERAGE] 
	end as HMO_end_month

from benilist as a
left outer join cms.[dnmntr_saf_lds_2013] as b on b.DESY_SORT_KEY=a.DESY_SORT_KEY
left outer join cms.[dnmntr_saf_lds_2014] as c on c.DESY_SORT_KEY=a.DESY_SORT_KEY
left outer join cms.[dnmntr_saf_lds_2015] as d on d.DESY_SORT_KEY=a.DESY_SORT_KEY
left outer join cms.mbsf_2016 as e on e.DESY_SORT_KEY=a.DESY_SORT_KEY
left outer join cms.mbsf_2017 as f on f.DESY_SORT_KEY=a.DESY_SORT_KEY