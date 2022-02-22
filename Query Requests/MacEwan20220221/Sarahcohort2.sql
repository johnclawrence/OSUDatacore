
--Query 1 is for just MBSF

 Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.mbsf_2016
	union select * from cms.mbsf_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
  where ssa = 'True'

 --Query 2 is just inp claims
 Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.inp_claimsk_2016
	union select * from cms.inp_claimsk_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
 where ssa = 'True'
 --Query 3 is just out claims

 Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.out_claimsk_2016
	union select * from cms.out_claimsk_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
 where ssa = 'True'

 --Really the hard part of this process was filtering by diagnosis in a way that isn't awful, which is why I used regular expressions in python... I wish MS-SQL had stronger regular expression functionality.

 --Sarah asked for revenue files too

 Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.out_revenuek_2016
	union select * from cms.out_revenuek_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
 where ssa = 'True'

 Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.inp_revenuek_2016
	union select * from cms.inp_revenuek_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
 where ssa = 'True'
