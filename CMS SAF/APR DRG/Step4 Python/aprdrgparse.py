import pandas as pd
import os
dirname = os.path.dirname(__file__)
df=pd.read_csv(dirname+'\out.txt', delim_whitespace=True
               ,names=['id','date','type','g1','g2','val','g3'])
df.drop(['date','g1','g2','g3'], axis=1, inplace=True)
pdf=df.pivot(index='id',columns='type',values='val')
pdf.to_csv(dirname+'\pivotout.csv',chunksize=20000,mode='w')
