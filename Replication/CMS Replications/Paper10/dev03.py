import pymssql as sql
import pandas as pd
import re



df = pd.read_csv('L:\Research\datacore\TARSS\Paper10\dev01v2.csv')
df['dat'] = df['NCH_BENE_DSCHRG_DT']-df['CLM_ADMSN_DT']
dfFil=df[df['dat']<=1]
print(dfFil)