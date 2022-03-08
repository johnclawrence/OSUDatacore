    with DS1 as(
    select
    DESY_SORT_KEY,
    case when 
    (DUAL_STUS_CD_01='02' or DUAL_STUS_CD_01 = '04' or DUAL_STUS_CD_01 ='06') and
    (DUAL_STUS_CD_02='02' or DUAL_STUS_CD_02 = '04' or DUAL_STUS_CD_02 ='06') and
    (DUAL_STUS_CD_03='02' or DUAL_STUS_CD_03 = '04' or DUAL_STUS_CD_03 ='06') and
    (DUAL_STUS_CD_04='02' or DUAL_STUS_CD_04 = '04' or DUAL_STUS_CD_04 ='06') and
    (DUAL_STUS_CD_05='02' or DUAL_STUS_CD_05 = '04' or DUAL_STUS_CD_05 ='06') and
    (DUAL_STUS_CD_06='02' or DUAL_STUS_CD_06 = '04' or DUAL_STUS_CD_06 ='06') and
    (DUAL_STUS_CD_07='02' or DUAL_STUS_CD_07 = '04' or DUAL_STUS_CD_07 ='06') and
    (DUAL_STUS_CD_08='02' or DUAL_STUS_CD_08 = '04' or DUAL_STUS_CD_08 ='06') and
    (DUAL_STUS_CD_09='02' or DUAL_STUS_CD_09 = '04' or DUAL_STUS_CD_09 ='06') and
    (DUAL_STUS_CD_10='02' or DUAL_STUS_CD_10 = '04' or DUAL_STUS_CD_10 ='06') and
    (DUAL_STUS_CD_11='02' or DUAL_STUS_CD_11 = '04' or DUAL_STUS_CD_11 ='06') and
    (DUAL_STUS_CD_12='02' or DUAL_STUS_CD_12 = '04' or DUAL_STUS_CD_12 ='06') then 1 else 0 end as DUAL_STUS
    from cms.mbsf_2016)

    Select count(DESY_SORT_KEY),DUAL_STUS
    from DS1
    group by DUAL_STUS