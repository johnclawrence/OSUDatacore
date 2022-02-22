import pymssql as sql
import pandas as pd
conn = sql.connect(server='sql-ctlst-vp01\\TP', database='CAT1')
cursor = conn.cursor()
cursor.execute(""" Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.mbsf_2016
	union select * from cms.mbsf_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
  where ssa = 'True'""")
data=cursor.fetchall()
df=pd.DataFrame(data, columns = cursor.description)
df.to_csv("L:\Research\datacore\TARSS\Sarah\mbsf.csv")

cursor.execute(""" Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.out_claimsk_2016
	union select * from cms.out_claimsk_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
 where ssa = 'True'
""")
data=cursor.fetchall()
df=pd.DataFrame(data, columns = cursor.description)
df.to_csv("L:\Research\datacore\TARSS\Sarah\outClaim.csv")

cursor.execute(""" Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.inp_claimsk_2016
	union select * from cms.inp_claimsk_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
 where ssa = 'True'
""")
data=cursor.fetchall()
df=pd.DataFrame(data, columns = cursor.description)
df.to_csv("L:\Research\datacore\TARSS\Sarah\inpClaim.csv")
cursor.execute(""" Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.out_revenuek_2016
	union select * from cms.out_revenuek_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
 where ssa = 'True'
""")
data=cursor.fetchall()
df=pd.DataFrame(data, columns = cursor.description)
df.to_csv("L:\Research\datacore\TARSS\Sarah\outRev.csv")
cursor.execute(""" Select b.*
 from  [CAT1].[cms].[zzsarahch2v1] as a
 inner join (
	Select * from cms.inp_revenuek_2016
	union select * from cms.inp_revenuek_2017
) as b on a.desy_sort_key=b.DESY_SORT_KEY
 where ssa = 'True'
""")
data=cursor.fetchall()
df=pd.DataFrame(data, columns = cursor.description)
df.to_csv("L:\Research\datacore\TARSS\Sarah\inpRev.csv")
