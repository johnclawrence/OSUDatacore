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
	DATAFILE = "X:\AHA\AHAIT Raw Data\2009_AHAIT\2009_AHAIT_Database - Load JL.xlsx"
	OUT= AHAIT2009
	DBMS=xlsx
	Replace;
	Sheet="Sheet1";
	GETNAMES = YES;
Run;


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.AHAIT2009
like work.AHAIT2009;

proc SQL;
insert into isilon.AHAIT2009
select * from work.AHAIT2009;