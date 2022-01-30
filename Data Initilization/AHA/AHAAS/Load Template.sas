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
DATA ANNUAL2017_1;

INfile 'X:\AHA\AHAAS Raw Data\FY2017 ASDB\FLAT\pubas17.asc' lrecl=5039 recfm=f;				

INPUT

;
;	
RUN;	
proc contents data=annual2017_1;run;				

DATA ANNUAL2017_2;

INfile 'X:\AHA\AHAAS Raw Data\FY2017 ASDB\FLAT\pubas17.asc' lrecl=5039 recfm=f;				

INPUT

;
;	
RUN;			
proc contents data=annual2017_2;run;


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.annual2017_1 
like work.annual2017_1;

proc SQL;
insert into isilon.annual2017_1
select * from work.annual2017_1;

proc SQL;
create table isilon.annual2017_2 
like work.annual2017_2;

proc SQL;
insert into isilon.annual2017_2
select * from work.annual2017_2;

*Create the all table by combining all the columns from table 1 and 2.;
*because of SQL limitations, make the variables after the 1000 variable sparse (other than the last one);
PROC SQL;
CONNECT using isilon;
EXECUTE(
CREATE TABLE [AHA].[annual2017](

	DetailSet XML COLUMN_SET FOR ALL_SPARSE_COLUMNS)
) BY isilon;
quit;
*The final query inserts into all of the explicit columns of the general table;
*And then select a.* and the explicit columns from table _1;
PROC SQL;
CONNECT using isilon;
EXECUTE(
	insert into AHA.annual2017(
	select  
  	FROM [Isilon].[AHA].[annual2017_1] as a
  	inner join isilon.aha.annual2017_2 as b on a.id=b.id
) BY isilon;
quit;