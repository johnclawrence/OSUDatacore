*Developer: John Lawrence*
*Date: 12/24/21*
*This code should load a bunch of NEDS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* INFILE "%trim(&filepath)NEDS/NEDS_2007/Data/NEDS_2007_   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;





proc SQL;
create table isilon.NEDS_2007_Core
like work.NEDS_2007_Core;

proc SQL;
insert into isilon.NEDS_2007_Core
select * from work.NEDS_2007_Core;

proc SQL;
create table isilon.NEDS_2007_IP
like work.NEDS_2007_IP;

proc SQL;
insert into isilon.NEDS_2007_IP
select * from work.NEDS_2007_IP;

proc SQL;
create table isilon.NEDS_2007_ED
like work.NEDS_2007_ED;

proc SQL;
insert into isilon.NEDS_2007_ED
select * from work.NEDS_2007_ED;

proc SQL;
create table isilon.NEDS_2007_Hospital
like work.NEDS_2007_Hospital;

proc SQL;
insert into isilon.NEDS_2007_Hospital
select * from work.NEDS_2007_Hospital;



proc delete data= work.NEDS_2007_Core; run;
proc delete data= work.NEDS_2007_IP; run;
proc delete data= work.NEDS_2007_ED; run;
proc delete data= work.NEDS_2007_Hospital; run;