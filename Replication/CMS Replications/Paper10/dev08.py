import pymssql as sql
import pandas as pd
import re



df = pd.read_csv('L:\Research\datacore\TARSS\Paper10\dev07v1.csv')
df['dat'] = df['CLM_THRU_DT']-df['CLM_ADMSN_DT']

print(df)