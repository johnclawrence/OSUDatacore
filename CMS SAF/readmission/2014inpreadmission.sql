with inpnextYear as(
select desy_sort_key, CLM_ADMSN_DT,CLAIM_NO from cms.[inp_claimsj_2014]
union select desy_sort_key, CLM_ADMSN_DT,CLAIM_NO from cms.[inp_claimsj_2015])

SELECT a.DESY_SORT_KEY,a.CLAIM_NO,
datediff("D",convert(date,convert(char(8),a.[CLM_THRU_DT])),min(convert(date,convert(char(8),c.CLM_ADMSN_DT)))) as readmission
	into dbo.[2014inp_readmission]
  FROM [CAT1].[cms].[inp_claimsj_2014] as a
  left outer join inpnextYear as c on a.DESY_SORT_KEY=c.DESY_SORT_KEY and convert(date,convert(char(8),c.CLM_ADMSN_DT))>convert(date,convert(char(8),a.[CLM_THRU_DT]))and a.Claim_No!=c.Claim_No
  group by a.DESY_SORT_KEY,a.CLAIM_NO,a.CLM_THRU_DT
  having datediff("D",convert(date,convert(char(8),a.[CLM_THRU_DT])),min(convert(date,convert(char(8),c.CLM_ADMSN_DT))))<366