import os
import pandas as pd
import re
import os
dirname = os.path.dirname(__file__)
dataset = os.path.join(dirname,'zzsarahch1c2.csv')
df = pd.read_csv(dataset)
dxlist=re.compile("\^+(?:28241|28242|28260|28261|28262|28263|28264|28269|D5740|D57419|D571|D5700|D5720|D57219|D5780|D57819)",re.IGNORECASE)
df['ssa']=df['dxall'].str.contains(dxlist, regex=True)
df.drop(['dxall','claimcount'],axis=1,inplace=True)
df.to_csv(dirname+'/zzsarahch2v1.csv',chunksize=20000,mode='w')
print("done")
