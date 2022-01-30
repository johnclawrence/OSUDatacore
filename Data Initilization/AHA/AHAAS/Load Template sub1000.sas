/*
Programmer: John Lawrence
Date: 12/10/2021
Description: This code loads AHAAS data from the flatfile into SQL.
It starts by loading the dataset into 2, sub 1024 column chunks, 
It then loads that data into SQL
It then created a new, unified, sparse table
And it then unions the 2 primary tables into the single sparse table.
*/

*Take the infiles from AHA doccumentation and split it into 2 chunks, adding the ID as duplicate to use as the PK later;
DATA ANNUAL2003;

INfile 'X:\AHA\AHAAS Raw Data\FY2003 ASDB\FLAT\pubas03' lrecl=2701 recfm=f;				

INPUT

;
;	
RUN;	
proc contents data=annual2003;run;				


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.annual2003
like work.annual2003;

proc SQL;
insert into isilon.annual2003
select * from work.annual2003;
