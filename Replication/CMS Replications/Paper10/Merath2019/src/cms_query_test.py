import pymssql as sql
import pandas as pd
import re
import sys

dat = {'name':["aparna", "pankaj", "sudhir", "Geeku"],
        'degree': ["MBA", "BCA", "M.Tech", "MBA"],
        'score':[90, 40, 80, 98]}
 
df = pd.DataFrame(dat)

file_path = "dat/tmp/test1.csv"

df.to_csv(file_path)

sys.stdout.write(file_path)

# print(file_path)
