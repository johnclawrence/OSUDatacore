Step 1
with mbsf as (
SELECT DESY_SORT_KEY,count(desy_sort_key) FROM [cms].[dnmntr_saf_lds_2013] as a
group by desy_sort_key
having count(DESY_SORT_KEY)=1)

Step 2

with mbsf2013 as (
SELECT DESY_SORT_KEY,count(desy_sort_key) count FROM [cms].[dnmntr_saf_lds_2013] as a
group by desy_sort_key
having count(DESY_SORT_KEY)=1),
mbsf2014 as (
SELECT DESY_SORT_KEY,count(desy_sort_key) count FROM [cms].[dnmntr_saf_lds_2013] as a
group by desy_sort_key
having count(DESY_SORT_KEY)=1)


select count(mbsf2013.desy_sort_key) from mbsf2013 
inner join mbsf2014 on mbsf2013.DESY_SORT_KEY=mbsf2014.DESY_SORT_KEY

Step 3

with mbsf2013 as (
SELECT DESY_SORT_KEY,count(desy_sort_key) count FROM [cms].[dnmntr_saf_lds_2013] as a
where HMO_COVERAGE=0
group by desy_sort_key
having count(DESY_SORT_KEY)=1),
mbsf2014 as (
SELECT DESY_SORT_KEY,count(desy_sort_key) count FROM [cms].[dnmntr_saf_lds_2014] as a
where HMO_COVERAGE=0
group by desy_sort_key
having count(DESY_SORT_KEY)=1)


select count(mbsf2013.desy_sort_key) from mbsf2013 
inner join mbsf2014 on mbsf2013.DESY_SORT_KEY=mbsf2014.DESY_SORT_KEY

Step 4


with mbsf2013 as (
SELECT DESY_SORT_KEY,count(desy_sort_key) count FROM [cms].[dnmntr_saf_lds_2013] as a
where HMO_COVERAGE=0 and
      [ENTITLEMENT_BUY_IN_IND1] ='3' and
      [ENTITLEMENT_BUY_IN_IND2] ='3' and
      [ENTITLEMENT_BUY_IN_IND3] ='3' and
      [ENTITLEMENT_BUY_IN_IND4] ='3' and
      [ENTITLEMENT_BUY_IN_IND5] ='3' and
      [ENTITLEMENT_BUY_IN_IND6] ='3' and
      [ENTITLEMENT_BUY_IN_IND7] ='3' and
      [ENTITLEMENT_BUY_IN_IND8] ='3' and
      [ENTITLEMENT_BUY_IN_IND9] ='3' and
      [ENTITLEMENT_BUY_IN_IND10] ='3' and
      [ENTITLEMENT_BUY_IN_IND11] ='3' and
      [ENTITLEMENT_BUY_IN_IND12] ='3' 
group by desy_sort_key
having count(DESY_SORT_KEY)=1),
mbsf2014 as (
SELECT DESY_SORT_KEY,count(desy_sort_key) count FROM [cms].[dnmntr_saf_lds_2014] as a
where HMO_COVERAGE=0 and (
      [ENTITLEMENT_BUY_IN_IND1] ='3' or
      [ENTITLEMENT_BUY_IN_IND2] ='3' or
      [ENTITLEMENT_BUY_IN_IND3] ='3' or
      [ENTITLEMENT_BUY_IN_IND4] ='3' or
      [ENTITLEMENT_BUY_IN_IND5] ='3' or
      [ENTITLEMENT_BUY_IN_IND6] ='3' or
      [ENTITLEMENT_BUY_IN_IND7] ='3' or
      [ENTITLEMENT_BUY_IN_IND8] ='3' or
      [ENTITLEMENT_BUY_IN_IND9] ='3' or
      [ENTITLEMENT_BUY_IN_IND10] ='3' or
      [ENTITLEMENT_BUY_IN_IND11] ='3' or
      [ENTITLEMENT_BUY_IN_IND12] ='3'
	  )
group by desy_sort_key
having count(DESY_SORT_KEY)=1)


select count(mbsf2013.desy_sort_key) from mbsf2013 
inner join mbsf2014 on mbsf2013.DESY_SORT_KEY=mbsf2014.DESY_SORT_KEY
