*Developer: John Lawrence*
*Date: 12/16/21*
*This code should load a bunch of NIS data into SQL*;

%let filepath = X:\HCUP\; * <-- Place Input File Path Here *;
* "%trim(&filepath)NIS/NIS_2005/Data/NIS_2005   *;  

LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = hcup;

                                                                           
                                                                                

                                                                                

proc SQL;
create table isilon.NIS_2005_HOSPITAL
like work.NIS_2005_HOSPITAL;

proc SQL;
insert into isilon.NIS_2005_HOSPITAL
select * from work.NIS_2005_HOSPITAL;

proc SQL;
create table isilon.NIS_2005_CORE
like work.NIS_2005_CORE;

proc SQL;
insert into isilon.NIS_2005_CORE
select * from work.NIS_2005_CORE;

proc SQL;
create table isilon.NIS_2005_Dx_Pr_Grps
like work.NIS_2005_Dx_Pr_Grps;

proc SQL;
insert into isilon.NIS_2005_Dx_Pr_Grps
select * from work.NIS_2005_Dx_Pr_Grps;

proc SQL;
create table isilon.NIS_2005_SEVERITY
like work.NIS_2005_SEVERITY;

proc SQL;
insert into isilon.NIS_2005_SEVERITY
select * from work.NIS_2005_SEVERITY;



proc delete data= work.NIS_2005_HOSPITAL; run;
proc delete data= work.NIS_2005_CORE; run;
proc delete data= work.NIS_2005_Dx_Pr_Grps; run;
proc delete data= work.NIS_2005_SEVERITY; run;