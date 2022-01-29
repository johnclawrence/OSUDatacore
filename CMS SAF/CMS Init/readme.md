This readme is a temporary one until I can write something more final when I do this process again for reals

So, when CMS sends you the data they send it to you a bunch of password protected auto-zipped.exe files.
When you unlock those files you get a 2 .sas files (one for v6 one for v8) that can be used to open the main file
And you get a .dat file that contains the data.

CMS LDS is split up by claim time (in patient, outpatient, ETC)
And then you get a file that contains claim level data, a file that contains revnue level data, and 3 files I've never used.
You also get the MBSF file that contains benificiary level data, so broadly...

MBSF links to the claim file through the desy_sort_key (unique identifier across years for a benificiary)
and the claim files link to the revenue file through Claim_NO (an identifer by year)

So those are the 3 keys we care about
Desy_sort_key (unique beneficiary id)
claim_no and Year (unique claim id)

So, how I got the data into SQL was that 
1:  I used the sas files load the files into sas, (because this changes the data in various ways)
2: I used the sas files to create SQL tables that looked correct
3: I used sas to convert the .dats into .tsv files
4: I used BCP to move the .tsv files to SQL (Because I used MS-SQL and the files are big)

My data structure is
Schema = cms
table = DataSetAbbreviation_DatasetName_Year
So For example...
the 2017 outpatient claims table is
cms.out_claimsk_2017
'out' is the dataset abberviation
'claimsk' is the datasetname (claims being the type, k being the format)
'2017' is the year

