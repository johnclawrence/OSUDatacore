import pandas as pd
import re
import os
dirname = os.path.dirname(__file__)
dataset= os.path.join(dirname, 'paper2fromSQLfy2016.csv')
df = pd.read_csv(dataset)
dxHighU=re.compile("\^+(?:A4101|A4102|A4151|A419|I462|I469|J95821|J9600|J9601|J9602|J9602|J9620|J9621|J9622|J9690|J9691|J9692|K7200|K767|R4020|R570|R571|R578|R579|R6520|R6521)",re.IGNORECASE)
prHighU=re.compile("\^+(?:5A1955Z|5A1945Z|4A133B1|03HY32Z|0BH18EZ|0BH17EZ|3E033XZ|5A09557|5A09457)",re.IGNORECASE)
df['highdx']=df['dxall'].str.contains(dxHighU, regex=True)
df['highpr']=df['prall'].str.contains(prHighU, regex=True)
df['highUtil']=(df['highpr']|df['highdx'])
df.drop(['dxall','prall','highdx','highpr'], axis=1, inplace=True)
print (df)
