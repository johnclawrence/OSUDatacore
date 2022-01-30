*Developer: John Lawrence*
*Date: 1/18/22*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NRD/NRD_2013/Data/NRD_2013   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;


proc SQL;
create table isilon.NRD_2013_Core
like work.NRD_2013_Core;

proc SQL;
insert into isilon.NRD_2013_Core
select * from work.NRD_2013_Core;

proc SQL;
create table isilon.NRD_2013_DX_PR_GRPS
like work.NRD_2013_DX_PR_GRPS;

proc SQL;
insert into isilon.NRD_2013_DX_PR_GRPS
select * from work.NRD_2013_DX_PR_GRPS;

proc SQL;
create table isilon.NRD_2013_Hospital
like work.NRD_2013_Hospital;

proc SQL;
insert into isilon.NRD_2013_Hospital
select * from work.NRD_2013_Hospital;

proc SQL;
create table isilon.NRD_2013_Severity
like work.NRD_2013_Severity;

proc SQL;
insert into isilon.NRD_2013_Severity
select * from work.NRD_2013_Severity;




proc delete data= work.NRD_2013_Core; run;
proc delete data= work.NRD_2013_DX_PR_GRPS; run;
proc delete data= work.NRD_2013_Hospital; run;
proc delete data= work.NRD_2013_Severity; run;
