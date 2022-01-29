This folder is all about how to figure out the PQI, Elixhauser, and CCI score for your dataset.
Initially I ran this process when I needed it, but these numbers are referenced so often that I decided to just generate it once and just use this table forever more. 

So first a little about each of these

Elixhauser / CCI
https://pubmed.ncbi.nlm.nih.gov/16224307/
Coding algorithms for defining comorbidities in ICD-9-CM and ICD-10 administrative data by Quan is just how this is done.
Yes, there are newer ways to do these things and lots of different flavours of these things... But...
When people reference CCI and Elixhauser in the literature, THIS is how they talk about generateding them

At a very high level CCI (Charlson Co-morbidity Index) is a score that talks about how awful someones co-morbidities are, generally this is mesasured as 0 to 5+, meaning if you're at 0 you don't have any major co-morbidities, and if you're at 5+ you have, you're in bad shape.

Elixhauser just breaks down what each of the co-morbidities is and states if someone has one (of which there are 31)

PQI
https://qualityindicators.ahrq.gov/modules/pqi_resources.aspx#techspecs
PQIs are just ways of talking about ambulatory care sensitive conditions (ACSC) which is the broad list conditions that become bad but were probably preventable. 

These change every year-ish, so for a given year, when people talk about PQIs, I use the PQI dataset that came out that year because that's how that particulear PQI was defined at that time.
https://qualityindicators.ahrq.gov/Archive/

However, here is the big inconsistency. For ALL ICD-9 codes, I use Version 6.0 PQI. The reason I do this is because it's the "end" of how icd-9 PQIs were defined so it's possible to have an apples to apples comparison of PQIs historically because it's unchanging now.  When I think about why I did this, I didn't want to go back and update this variable for all datasets every year because I wanted it to remain static going forward, hence I change ICD-10 every year but keep ICD-9 static. 

Here is how I do this process 
Step 1 Execute the SQL code. This generates a SQL table that is used by the transformation
Step 2 Export the SQL code to a .csv file.
Step 3 Execute the python code for that year on that csv file.
Step 4 import the output file of that python code back to sql. 
I'll explain broadly what's going on in Step 1 and 3 in those steps subfolders.