/*
Programmer: John Lawrence
Date: 12/13/2021
Description: 
This Code loads a MODIFIED version of the AHAIT dataset from the Excel Sheets.
It's modified because Row 2 is deleted. Row 2 contains survey names of data
but not database names. So Q1_2 is different between years but CSOFT is forever.
Unless it's not. BEcause AHA sometimes changes category values between years....
But that's a problem for future John Lawrence.

*/


PROC Import
	DATAFILE = "X:\AHA\AHAIT Raw Data\2017_AHAIT\2017_AHAIT_Database - Load JL.xlsx"
	OUT= AHAIT2017
	DBMS=xlsx
	Replace;
	Sheet="Sheet1";
	GETNAMES = YES;
Run;


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.AHAIT2017
like work.AHAIT2017;

proc SQL;
insert into isilon.AHAIT2017
select * from work.AHAIT2017;
