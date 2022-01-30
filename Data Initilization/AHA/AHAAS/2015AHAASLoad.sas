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
DATA ANNUAL2015;

INfile 'X:\AHA\AHAAS Raw Data\FY2015 ASDB\FLAT\pubas15.asc' lrecl=4606 recfm=f;				

INPUT
@0001	ID		$7.	
@0002	REG		$1.	
@0002	STCD		$2.	
@0004	HOSPN		$4.	
@0008	DTBEG		$10.	
@0008   DBEGM		$2. 
@0011	DBEGD		$2.	
@0014	DBEGY		4.	
@0018	DTEND		$10.	
@0018	DENDM		$2.	
@0021	DENDD		$2.	
@0024	DENDY		$4.	
@0028	DCOV		3.	
@0031	FYR		1.	
@0032	FISYR		$10.	
@0032	FISM		$2.	
@0035	FISD		$2.	
@0038	FISY		$4.	
CNTRL          $        42-43
SERV          $         44-45
SERVOTH          $      46-145
RADMCHI          $      146-146
HSACODE                 147-151
HSANAME          $      152-181
HRRCODE                 182-184
HRRNAME          $      185-214
MTYPE          $        215-216
LOS          $          217-217
MNAME          $        218-317
MADMIN          $       318-467
MLOCADDR          $     468-527
MLOCCITY          $     528-557
MLOCSTCD          $     558-559
MLOCZIP          $      560-569
MSTATE          $       570-571
AREA          $         572-574
TELNO          $        575-581
RESP          $         582-582
CHC          $          583-583
BSC          $          584-584
MHSMEMB          $      585-585
SUBS          $         586-586
MNGT          $         587-587
MNGTNAME          $     588-687
MNGTCITY          $     688-717
MNGTSTCD          $     718-719
NETWRK          $       720-720
NETNAME          $      721-820
NETCT          $        821-850
NETSC          $        851-852
NETPHONE          $     853-862
GROUP          $        863-863
GPONAME          $      864-963
GPOCITY          $      964-993
GPOST          $        994-995
SUPLY          $        996-996
SUPNM          $        997-1096
PHYGP          $        1097-1097
LTCHF          $        1098-1098
LTCHC          $        1099-1099
LTNM          $         1100-1199
LTCT          $         1200-1229
LTST          $         1230-1231
NPINUM                  1232-1241
CLUSTER                 1242-1242
SYSID          $        1243-1246
SYSNAME          $      1247-1346
SYSADDR          $      1347-1406
SYSCITY          $      1407-1436
SYSST          $        1437-1438
SYSZIP          $       1439-1448
SYSAREA          $      1449-1451
SYSTELN          $      1452-1459
SYSTEM_PRIMARY_CONTACT $ 1460-1489
SYSTITLE          $     1490-1589
COMMTY          $       1590-1590
MCRNUM          $       1591-1596
LAT                     1597-1606
LONG                    1607-1616
CNTYNAME          $     1617-1676
CBSANAME          $     1677-1736
CBSATYPE          $     1737-1744
CBSACODE              $ 1745-1749
DIVNAME          $      1750-1809
DIVCODE          $      1810-1814
CSANAME          $      1815-1874
CSACODE          $      1875-1877
MCNTYCD          $      1878-1880
FCOUNTY          $      1881-1885
FSTCD          $        1886-1887
FCNTYCD          $      1888-1890
CITYRK          $       1891-1893
MAPP1                   1894-1894
MAPP2                   1895-1895
MAPP3                   1896-1896
MAPP5                   1897-1897
MAPP7                   1898-1898
MAPP8                   1899-1899
MAPP10                  1900-1900
MAPP11                  1901-1901
MAPP12                  1902-1902
MAPP13                  1903-1903
MAPP16                  1904-1904
MAPP18                  1905-1905
MAPP19                  1906-1906
MAPP20                  1907-1907
MAPP21                  1908-1908
MAPP22                  1909-1909
AHAMBR          $       1910-1910
SNT          $          1911-1911
SUNITS          $       1912-1912
IPAHOS          $       1913-1913
IPASYS          $       1914-1914
IPANET          $       1915-1915
GPWWHOS          $      1916-1916
GPWWSYS          $      1917-1917
GPWWNET          $      1918-1918
OPHOHOS          $      1919-1919
OPHOSYS          $      1920-1920
OPHONET          $      1921-1921
CPHOHOS          $      1922-1922
CPHOSYS          $      1923-1923
CPHONET          $      1924-1924
MSOHOS          $       1925-1925
MSOSYS          $       1926-1926
MSONET          $       1927-1927
ISMHOS          $       1928-1928
ISMSYS          $       1929-1929
ISMNET          $       1930-1930
EQMODHOS          $     1931-1931
EQMODSYS          $     1932-1932
EQMODNET          $     1933-1933
FOUNDHOS          $     1934-1934
FOUNDSYS          $     1935-1935
FOUNDNET          $     1936-1936
PHYOTH          $       1937-2036
PHYHOS          $       2037-2037
PHYSYS          $       2038-2038
PHYNET          $       2039-2039
IPHMOHOS          $     2040-2040
IPHMOSYS          $     2041-2041
IPHMONET          $     2042-2042
IPHMOVEN          $     2043-2043
IPPPOHOS          $     2044-2044
IPPPOSYS          $     2045-2045
IPPPONET          $     2046-2046
IPPPOVEN          $     2047-2047
IPFEEHOS          $     2048-2048
IPFEESYS          $     2049-2049
IPFEENET          $     2050-2050
IPFEEVEN          $     2051-2051
HMO86          $        2052-2052
HMOCON                  2053-2056
PPO86          $        2057-2057
PPOCON                  2058-2061
CAPCON94          $     2062-2062
CAPCOV                  2063-2070
IPAP                    2071-2078
GPWP                    2079-2086
OPHP                    2087-2094
CPHP                    2095-2102
MSOP                    2103-2110
ISMP                    2111-2118
EQMP                    2119-2126
FNDP                    2127-2134
PHYP                    2135-2142
FTMT                    2143-2150
JNTPH          $        2151-2151
JNLS          $         2152-2152
JNTAMB          $       2153-2153
JNTCTR          $       2154-2154
JNTOTH          $       2155-2155
LSHTXT          $       2156-2255
JNTLSC          $       2256-2256
JNTLSO          $       2257-2257
JNTLSS          $       2258-2258
JNTLST          $       2259-2259
JNTTXT          $       2260-2359
JNTMD          $        2360-2360
MEDHME          $       2361-2361
BNDPAY          $       2362-2362
EHLTH          $        2362-2362
GENBD                   2363-2366
PEDBD                   2367-2370
OBLEV          $        2371-2371
OBBD                    2372-2375
MSICBD                  2376-2379
CICBD                   2380-2383
NICBD                   2384-2387
NINTBD                  2388-2391
PEDICBD                 2392-2395
BRNBD                   2396-2399
SPCICBD                 2400-2403
OSPOTH          $       2404-2503
OTHICBD                 2504-2507
OTHIC          $        2508-2607
REHABBD                 2608-2611
ALCHBD                  2612-2615
PSYBD                   2616-2619
SNBD88                  2620-2623
ICFBD88                 2624-2627
ACULTBD                 2628-2631
OTHLBD94                2632-2635
OTHBD94                 2636-2639
OTHOTH          $       2640-2739
HOSPBD                  2740-2743
GENHOS          $       2744-2744
GENSYS          $       2745-2745
GENVEN          $       2746-2746
PEDHOS          $       2747-2747
PEDSYS          $       2748-2748
PEDVEN          $       2749-2749
OBHOS          $        2750-2750
OBSYS          $        2751-2751
OBVEN          $        2752-2752
MSICHOS          $      2753-2753
MSICSYS          $      2754-2754
MSICVEN          $      2755-2755
CICHOS          $       2756-2756
CICSYS          $       2757-2757
CICVEN          $       2758-2758
NICHOS          $       2759-2759
NICSYS          $       2760-2760
NICVEN          $       2761-2761
NINTHOS          $      2762-2762
NINTSYS          $      2763-2763
NINTVEN          $      2764-2764
PEDICHOS          $     2765-2765
PEDICSYS          $     2766-2766
PEDICVEN          $     2767-2767
BRNHOS          $       2768-2768
BRNSYS          $       2769-2769
BRNVEN          $       2770-2770
SPCICHOS          $     2771-2771
SPCICSYS          $     2772-2772
SPCICVEN          $     2773-2773
OTHIHOS          $      2774-2774
OTHISYS          $      2775-2775
OTHIVEN          $      2776-2776
REHABHOS          $     2777-2777
REHABSYS          $     2778-2778
REHABVEN          $     2779-2779
ALCHHOS          $      2780-2780
ALCHSYS          $      2781-2781
ALCHVEN          $      2782-2782
PSYHOS          $       2783-2783
PSYSYS          $       2784-2784
PSYVEN          $       2785-2785
SNHOS          $        2786-2786
SNSYS          $        2787-2787
SNVEN          $        2788-2788
ICFHOS          $       2789-2789
ICFSYS          $       2790-2790
ICFVEN          $       2791-2791
ACUHOS          $       2792-2792
ACUSYS          $       2793-2793
ACUVEN          $       2794-2794
OTHLTHOS          $     2795-2795
OTHLTSYS          $     2796-2796
OTHLTVEN          $     2797-2797
OTHCRHOS          $     2798-2798
OTHCRSYS          $     2799-2799
OTHCRVEN          $     2800-2800
ADULTHOS          $     2801-2801
ADULTSYS          $     2802-2802
ADULTVEN          $     2803-2803
AIRBHOS          $      2804-2804
AIRBSYS          $      2805-2805
AIRBVEN          $      2806-2806
AIRBROOM                2807-2810
ALCOPHOS          $     2811-2811
ALCOPSYS          $     2812-2812
ALCOPVEN          $     2813-2813
ALZHOS            $     2814-2814
ALZSYS          $       2815-2815
ALZVEN          $       2816-2816
AMBHOS          $       2817-2817
AMBSYS          $       2818-2818
AMBVEN          $       2819-2819
AMBSHOS          $      2820-2820
AMBSSYS          $      2821-2821
AMBSVEN          $      2822-2822
ARTHCHOS          $     2823-2823
ARTHCSYS          $     2824-2824
ARTHCVEN          $     2825-2825
ASSTLHOS          $     2826-2826
ASSTLSYS          $     2827-2827
ASSTLVEN          $     2828-2828
AUXHOS          $       2829-2829
AUXSYS          $       2830-2830
AUXVEN          $       2831-2831
BWHTHOS          $      2832-2832
BWHTSYS          $      2833-2833
BWHTVEN          $      2834-2834
BROOMHOS          $     2835-2835
BROOMSYS          $     2836-2836
BROOMVEN          $     2837-2837
BLDOHOS          $      2838-2838
BLDOSYS          $      2839-2839
BLDOVEN          $      2840-2840
MAMMSHOS          $     2841-2841
MAMMSSYS          $     2842-2842
MAMMSVEN          $     2843-2843
ACARDHOS          $     2844-2844
ACARDSYS          $     2845-2845
ACARDVEN          $     2846-2846
PCARDHOS          $     2847-2847
PCARDSYS          $     2848-2848
PCARDVEN          $     2849-2849
ACLABHOS          $     2850-2850
ACLABSYS          $     2851-2851
ACLABVEN          $     2852-2852
PCLABHOS          $     2853-2853
PCLABSYS          $     2854-2854
PCLABVEN          $     2855-2855
ICLABHOS          $     2856-2856
ICLABSYS          $     2857-2857
ICLABVEN          $     2858-2858
PELABHOS          $     2859-2859
PELABSYS          $     2860-2860
PELABVEN          $     2861-2861
ADTCHOS          $      2862-2862
ADTCSYS          $      2863-2863
ADTCVEN          $      2864-2864
PEDCSHOS          $     2865-2865
PEDCSSYS          $     2866-2866
PEDCSVEN          $     2867-2867
ADTEHOS          $      2868-2868
ADTESYS          $      2869-2869
ADTEVEN          $      2870-2870
PEDEHOS          $      2871-2871
PEDESYS          $      2872-2872
PEDEVEN          $      2873-2873
CHABHOS          $      2874-2874
CHABSYS          $      2875-2875
CHABVEN          $      2876-2876
CMNGTHOS          $     2877-2877
CMNGTSYS          $     2878-2878
CMNGTVEN          $     2879-2879
CHAPHOS          $      2880-2880
CHAPSYS          $      2881-2881
CHAPVEN          $      2882-2882
CHTHHOS           $     2883-2883
CHTHSYS           $     2884-2884
CHTHVEN           $     2885-2885
CWELLHOS          $     2886-2886
CWELLSYS          $     2887-2887
CWELLVEN          $     2888-2888
CHIHOS          $       2889-2889
CHISYS          $       2890-2890
CHIVEN          $       2891-2891
COUTRHOS          $     2892-2892
COUTRSYS          $     2893-2893
COUTRVEN          $     2894-2894
COMPHOS          $      2895-2895
COMPSYS          $      2896-2896
COMPVEN          $      2897-2897
CAOSHOS          $      2898-2898
CAOSSYS          $      2899-2899
CAOSVEN          $      2900-2900
CPREVHOS          $     2901-2901
CPREVSYS          $     2902-2902
CPREVVEN          $     2903-2903
DENTSHOS          $     2904-2904
DENTSSYS          $     2905-2905
DENTSVEN          $     2906-2906
EMDEPHOS          $     2907-2907
EMDEPSYS          $     2908-2908
EMDEPVEN          $     2909-2909
PEMERHOS          $     2910-2910
PEMERSYS          $     2911-2911
PEMERVEN          $     2912-2912
FSERHOS          $      2913-2913
FSERSYS          $      2914-2914
FSERVEN          $      2915-2915
FSERYN          $       2916-2916
TRAUMHOS          $     2917-2917
TRAUMSYS          $     2918-2918
TRAUMVEN          $     2919-2919
TRAUML90          $     2920-2920
ENBHOS          $       2921-2921
ENBSYS          $       2922-2922
ENBVEN          $       2923-2923
ENDOCHOS          $     2924-2924
ENDOCSYS          $     2925-2925
ENDOCVEN          $     2926-2926
ENDOUHOS          $     2927-2927
ENDOUSYS          $     2928-2928
ENDOUVEN          $     2929-2929
ENDOAHOS          $     2930-2930
ENDOASYS          $     2931-2931
ENDOAVEN          $     2932-2932
ENDOEHOS          $     2933-2933
ENDOESYS          $     2934-2934
ENDOEVEN          $     2935-2935
ENDORHOS          $     2936-2936
ENDORSYS          $     2937-2937
ENDORVEN          $     2938-2938
ENRHOS          $       2939-2939
ENRSYS          $       2940-2940
ENRVEN          $       2941-2941
ESWLHOS          $      2942-2942
ESWLSYS          $      2943-2943
ESWLVEN          $      2944-2944
FRTCHOS           $     2945-2945
FRTCSYS           $     2946-2946
FRTCVEN           $     2947-2947
FITCHOS          $      2948-2948
FITCSYS          $      2949-2949
FITCVEN          $      2950-2950
OPCENHOS          $     2951-2951
OPCENSYS          $     2952-2952
OPCENVEN          $     2953-2953
GERSVHOS          $     2954-2954
GERSVSYS          $     2955-2955
GERSVVEN          $     2956-2956
HLTHFHOS          $     2957-2957
HLTHFSYS          $     2958-2958
HLTHFVEN          $     2959-2959
HLTHCHOS          $     2960-2960
HLTHCSYS          $     2961-2961
HLTHCVEN          $     2962-2962
GNTCHOS           $     2963-2963
GNTCSYS           $     2964-2964
GNTCVEN           $     2965-2965
HLTHSHOS          $     2966-2966
HLTHSSYS          $     2967-2967
HLTHSVEN          $     2968-2968
HLTRHOS          $      2969-2969
HLTRSYS          $      2970-2970
HLTRVEN          $      2971-2971
HEMOHOS          $      2972-2972
HEMOSYS          $      2973-2973
HEMOVEN          $      2974-2974
AIDSSHOS          $     2975-2975
AIDSSSYS          $     2976-2976
AIDSSVEN          $     2977-2977
HOMEHHOS          $     2978-2978
HOMEHSYS          $     2979-2979
HOMEHVEN          $     2980-2980
HOSPCHOS          $     2981-2981
HOSPCSYS          $     2982-2982
HOSPCVEN          $     2983-2983
OPHOSHOS          $     2984-2984
OPHOSSYS          $     2985-2985
OPHOSVEN          $     2986-2986
IMPRHOS          $      2987-2987
IMPRSYS          $      2988-2988
IMPRVEN          $      2989-2989
ICARHOS          $      2990-2990
ICARSYS          $      2991-2991
ICARVEN          $      2992-2992
LINGHOS          $      2993-2993
LINGSYS          $      2994-2994
LINGVEN          $      2995-2995
MEALSHOS          $     2996-2996
MEALSSYS          $     2997-2997
MEALSVEN          $     2998-2998
MOHSHOS          $      2999-2999
MOHSSYS          $      3000-3000
MOHSVEN          $      3001-3001
NEROHOS          $      3002-3002
NEROSYS          $      3003-3003
NEROVEN          $      3004-3004
NUTRPHOS          $     3005-3005
NUTRPSYS          $     3006-3006
NUTRPVEN          $     3007-3007
OCCHSHOS          $     3008-3008
OCCHSSYS          $     3009-3009
OCCHSVEN          $     3010-3010
ONCOLHOS          $     3011-3011
ONCOLSYS          $     3012-3012
ONCOLVEN          $     3013-3013
ORTOHOS          $      3014-3014
ORTOSYS          $      3015-3015
ORTOVEN          $      3016-3016
OPSRGHOS          $     3017-3017
OPSRGSYS          $     3018-3018
OPSRGVEN          $     3019-3019
PAINHOS          $      3020-3020
PAINSYS          $      3021-3021
PAINVEN          $      3022-3022
PALHOS          $       3023-3023
PALSYS          $       3024-3024
PALVEN          $       3025-3025
IPALHOS          $      3026-3026
IPALSYS          $      3027-3027
IPALVEN          $      3028-3028
PCAHOS          $       3029-3029
PCASYS          $       3030-3030
PCAVEN          $       3031-3031
PATEDHOS          $     3032-3032
PATEDSYS          $     3033-3033
PATEDVEN          $     3034-3034
PATRPHOS          $     3035-3035
PATRPSYS          $     3036-3036
PATRPVEN          $     3037-3037
RASTHOS          $      3038-3038
RASTSYS          $      3039-3039
RASTVEN          $      3040-3040
REDSHOS          $      3041-3041
REDSSYS          $      3042-3042
REDSVEN          $      3043-3043
RHBOPHOS          $     3044-3044
RHBOPSYS          $     3045-3045
RHBOPVEN          $     3046-3046
RPRSHOS          $      3047-3047
RPRSSYS          $      3048-3048
RPRSVEN          $      3049-3049
RBOTHOS          $      3050-3050
RBOTSYS          $      3051-3051
RBOTVEN          $      3052-3052
RSIMHOS          $      3053-3053
RSIMSYS          $      3054-3054
RSIMVEN          $      3055-3055
PCDEPHOS          $     3056-3056
PCDEPSYS          $     3057-3057
PCDEPVEN          $     3058-3058
PSYCAHOS          $     3059-3059
PSYCASYS          $     3060-3060
PSYCAVEN          $     3061-3061
PSYLSHOS          $     3062-3062
PSYLSSYS          $     3063-3063
PSYLSVEN          $     3064-3064
PSYEDHOS          $     3065-3065
PSYEDSYS          $     3066-3066
PSYEDVEN          $     3067-3067
PSYEMHOS          $     3068-3068
PSYEMSYS          $     3069-3069
PSYEMVEN          $     3070-3070
PSYGRHOS          $     3071-3071
PSYGRSYS          $     3072-3072
PSYGRVEN          $     3073-3073
PSYOPHOS          $     3074-3074
PSYOPSYS          $     3075-3075
PSYOPVEN          $     3076-3076
PSYPHHOS          $     3077-3077
PSYPHSYS          $     3078-3078
PSYPHVEN          $     3079-3079
PSTRTHOS          $     3080-3080
PSTRTSYS          $     3081-3081
PSTRTVEN          $     3082-3082
CTSCNHOS          $     3083-3083
CTSCNSYS          $     3084-3084
CTSCNVEN          $     3085-3085
DRADFHOS          $     3086-3086
DRADFSYS          $     3087-3087
DRADFVEN          $     3088-3088
EBCTHOS           $     3089-3089
EBCTSYS           $     3090-3090
EBCTVEN           $     3091-3091
FFDMHOS          $      3092-3092
FFDMSYS          $      3093-3093
FFDMVEN          $      3094-3094
MRIHOS          $       3095-3095
MRISYS          $       3096-3096
MRIVEN          $       3097-3097
IMRIHOS          $      3098-3098
IMRISYS          $      3099-3099
IMRIVEN          $      3100-3100
MEGHOS          $       3101-3101
MEGSYS          $       3102-3102
MEGVEN          $       3103-3103
MSCTHOS           $     3104-3104
MSCTSYS           $     3105-3105
MSCTVEN           $     3106-3106
MSCTGHOS          $     3107-3107
MSCTGSYS          $     3108-3108
MSCTGVEN          $     3109-3109
PETHOS          $       3110-3110
PETSYS          $       3111-3111
PETVEN          $       3112-3112
PETCTHOS          $     3113-3113
PETCTSYS          $     3114-3114
PETCTVEN          $     3115-3115
SPECTHOS          $     3116-3116
SPECTSYS          $     3117-3117
SPECTVEN          $     3118-3118
ULTSNHOS          $     3119-3119
ULTSNSYS          $     3120-3120
ULTSNVEN          $     3121-3121
IGRTHOS          $      3122-3122
IGRTSYS          $      3123-3123
IGRTVEN          $      3124-3124
IMRTHOS           $     3125-3125
IMRTSYS           $     3126-3126
IMRTVEN           $     3127-3127
PTONHOS          $      3128-3128
PTONSYS          $      3129-3129
PTONVEN          $      3130-3130
BEAMHOS          $      3131-3131
BEAMSYS          $      3132-3132
BEAMVEN          $      3133-3133
SRADHOS          $      3134-3134
SRADSYS          $      3135-3135
SRADVEN          $      3136-3136
RETIRHOS          $     3137-3137
RETIRSYS          $     3138-3138
RETIRVEN          $     3139-3139
ROBOHOS          $      3140-3140
ROBOSYS          $      3141-3141
ROBOVEN          $      3142-3142
RURLHOS          $      3143-3143
RURLSYS          $      3144-3144
RURLVEN          $      3145-3145
SLEPHOS          $      3146-3146
SLEPSYS          $      3147-3147
SLEPVEN          $      3148-3148
SOCWKHOS          $     3149-3149
SOCWKSYS          $     3150-3150
SOCWKVEN          $     3151-3151
SPORTHOS          $     3152-3152
SPORTSYS          $     3153-3153
SPORTVEN          $     3154-3154
SUPPGHOS          $     3155-3155
SUPPGSYS          $     3156-3156
SUPPGVEN          $     3157-3157
SWBDHOS          $      3158-3158
SWBDSYS          $          3159-3159
SWBDVEN          $          3160-3160
TEENSHOS          $          3161-3161
TEENSSYS          $          3162-3162
TEENSVEN          $          3163-3163
TOBHOS          $          3164-3164
TOBSYS          $          3165-3165
TOBVEN          $          3166-3166
OTBONHOS          $          3167-3167
OTBONSYS          $          3168-3168
OTBONVEN          $          3169-3169
HARTHOS          $          3170-3170
HARTSYS          $          3171-3171
HARTVEN          $          3172-3172
KDNYHOS          $          3173-3173
KDNYSYS          $          3174-3174
KDNYVEN          $          3175-3175
LIVRHOS          $          3176-3176
LIVRSYS          $          3177-3177
LIVRVEN          $          3178-3178
LUNGHOS          $          3179-3179
LUNGSYS          $          3180-3180
LUNGVEN          $          3181-3181
TISUHOS          $          3182-3182
TISUSYS          $          3183-3183
TISUVEN          $          3184-3184
OTOTHHOS          $          3185-3185
OTOTHSYS          $          3186-3186
OTOTHVEN          $          3187-3187
TPORTHOS          $          3188-3188
TPORTSYS          $          3189-3189
TPORTVEN          $          3190-3190
URGCCHOS          $          3191-3191
URGCCSYS          $          3192-3192
URGCCVEN          $          3193-3193
VRCSHOS          $          3194-3194
VRCSSYS          $          3195-3195
VRCSVEN          $          3196-3196
VOLSVHOS          $          3197-3197
VOLSVSYS          $          3198-3198
VOLSVVEN          $          3199-3199
WOMHCHOS          $          3200-3200
WOMHCSYS          $          3201-3201
WOMHCVEN          $          3202-3202
WMGTHOS          $          3203-3203
WMGTSYS          $          3204-3204
WMGTVEN          $          3205-3205
EXPTOT                    3206-3220
EXPTHA                    3221-3235
EXPTLA                    3236-3250
CPPCT                    3251-3254
CAPRSK                    3255-3258
DPEXA                    3259-3268
INTEXA                    3269-3278
SUPEXA                    3279-3288
OTHEXPA                    3289-3298
NPAYBEN                    3299-3308
PAYTOT                    3309-3318
PAYTOTH                    3319-3328
NPAYBENH                    3329-3338
PAYTOTLT                    3339-3348
NPAYBENL                    3349-3358
LBEDSA                    3359-3364
BDTOT                    3365-3368
ADMTOT                    3369-3374
IPDTOT                    3375-3382
BDH                    3383-3386
ADMH                    3387-3392
IPDH                    3393-3400
LBEDLA                    3401-3406
BDLT                    3407-3410
ADMLT                    3411-3416
IPDLT                    3417-3424
MCRDC                    3425-3430
MCRIPD                    3431-3438
MCDDC                    3439-3444
MCDIPD                    3445-3452
MCRDCH                    3453-3458
MCRIPDH                    3459-3466
MCDDCH                    3467-3472
MCDIPDH                    3473-3480
MCRDCLT                    3481-3486
MCRIPDLT                    3487-3494
MCDDCLT                    3495-3500
MCDIPDLT                    3501-3508
BASSIN                    3509-3512
BIRTHS                    3513-3518
SUROPIP                    3519-3524
SUROPOP                    3525-3530
SUROPTOT                    3531-3536
VEM                    3537-3544
VOTH                    3545-3552
VTOT                    3553-3560

FTMDTF                    3561-3565
FTRES                    3566-3570
FTTRAN84                    3571-3575
FTRNTF                    3576-3580
FTLPNTF                    3581-3585
FTAST                    3586-3590
FTRAD                    3591-3595
FTLAB                    3596-3600
FTPHR                    3601-3605
FTPHT                    3606-3610
FTRESP                    3611-3615
FTOTHTF                    3616-3620
FTTOT                    3621-3625
PTMDTF                    3626-3630
PTRES                    3631-3635
PTTRAN84                    3636-3640
PTRNTF                    3641-3645
PTLPNTF                    3646-3650
PTAST                    3651-3655
PTRAD                    3656-3660
PTLAB                    3661-3665
PTPHR                    3666-3670
PTPHT                    3671-3675
PTRESP                    3676-3680
PTOTHTF                    3681-3685
PTTOT                    3686-3690
FTTOTH                    3691-3695
PTTOTH                    3696-3700
FTTOTLT                    3701-3705
PTTOTLT                    3706-3710
FTED                        3711-3718
FTER                        3719-3726
FTET                        3727-3734
FTEN                        3735-3742
FTEP                        3743-3750
FTEAP                       3751-3758
FTERAD                    3759-3766
FTELAB                    3767-3774
FTEPH                    3775-3782
FTEPHT                    3783-3790
FTERESP                    3791-3798
FTEO                        3799-3806
FTETF                       3807-3814
FTERNLT                    3815-3822
FTEU                        3823-3830
VMD                    3831-3838
VRES                    3839-3846
VTTRN                    3847-3854
VRN                    3855-3862
VLPN                    3863-3870
VAST                    3871-3878
VRAD                    3879-3886
VLAB                    3887-3894
VPHR                    3895-3902
VPHT                    3903-3910
VRSP                    3911-3918
VOTHL                    3919-3926
VTOTL                    3927-3934
VRNH                    3935-3942
VTNH                    3943-3950
ERNFTE                    3951-3958
ADC                    3959-3966
ADJADM                    3967-3974
ADJPD                    3975-3982
ADJADC                    3983-3990
FTEMD                    3991-3998
FTERN                    3999-4006
FTELPN                    4007-4014
FTERES                    4015-4022
FTETRAN                    4023-4030
FTETTRN                    4031-4038
FTEOTH94                    4039-4046
FTEH                    4047-4054
FTENH                    4055-4062
FTE                    4063-4070
OPRA                    4071-4074
EADMTOT          $          4075-4075
EIPDTOT          $          4076-4076
EADMH          $          4077-4077
EIPDH          $          4078-4078
EADMLT          $          4079-4079
EIPDLT          $          4080-4080
EMCRDC          $          4081-4081
EMCRIPD          $          4082-4082
EMCDDC          $          4083-4083
EMCDIPD          $          4084-4084
EMCRDCH          $          4085-4085
EMCRIPDH          $          4086-4086
EMCDDCH          $          4087-4087
EMCDIPDH          $          4088-4088
EMCRDCLT          $          4089-4089
EMCRPDLT          $          4090-4090
EMCDDCLT          $          4091-4091
EMCDPDLT          $          4092-4092
EBIRTHS          $          4093-4093
ESUROPIP          $          4094-4094
ESUROPOP          $          4095-4095
ESUROPTO          $          4096-4096
EVEM          $          4097-4097
EVOTH          $          4098-4098
EVTOT          $          4099-4099
EPAYTOT          $          4100-4100
ENPAYBEN          $          4101-4101
EPAYTOTH          $          4102-4102
ENPYBENH          $          4103-4103
EPYTOTLT          $          4104-4104
ENPBENLT          $          4105-4105
EFTMDTF          $          4106-4106
EFTRES          $          4107-4107
EFTTRN84          $          4108-4108
EFTRNTF          $          4109-4109
EFTLPNTF          $          4110-4110
EFTAST          $          4111-4111
EFTRAD          $          4112-4112
EFTLAB          $          4113-4113
EFTPHR          $          4114-4114
EFTPHT          $          4115-4115
EFTRESP          $          4116-4116
EFTOTHTF          $          4117-4117
EFTTOT          $          4118-4118
EPTMDTF          $          4119-4119
EPTRES          $          4120-4120
EPTTRN84          $          4121-4121
EPTRNTF          $          4122-4122
EPTLPNTF          $          4123-4123
EPTAST          $          4124-4124
EPTRAD          $          4125-4125
EPTLAB          $          4126-4126
EPTPHR          $          4127-4127
EPTPHT          $          4128-4128
EPTRESP          $          4129-4129
EPTOTHTF          $          4130-4130
EPTTOT          $          4131-4131
EFTTOTH          $          4132-4132
EPTTOTH          $          4133-4133
EFTTOTLT          $          4134-4134
EPTTOTLT          $          4135-4135
EEXPTOT          $          4136-4136
EXPTHB          $          4137-4137
EXPTLB          $          4138-4138
TECAR                    4139-4146
TEMER                    4147-4154
TEHSP                    4155-4162
TEINT                    4163-4170
TEGST                    4171-4178
TEOTH                    4179-4186
TETOT                    4187-4194
TCCAR                    4195-4202
TCMER                    4203-4210
TCHSP                    4211-4218
TCINT                    4219-4226
TCGST                    4227-4234
TCOTH                    4235-4242
TCTOT                    4243-4250
TGCAR                    4251-4258
TGMER                    4259-4266
TGHSP                    4267-4274
TGINT                    4275-4282
TGGST                    4283-4290
TGOTH                    4291-4298
TGTOT                    4299-4306
NECAR                    4307-4314
NEMER                    4315-4322
NEHSP                    4323-4330
NEINT                    4331-4338
NEGST                    4339-4346
NEOTH                    4347-4354
NETOT                    4355-4362
TPCAR                    4363-4370
TPMER                    4371-4378
TPHSP                    4379-4386
TPINT                    4387-4394
TPGST                    4395-4402
TPOTH                    4403-4410
TPRTOT                    4411-4418
HSPTL              $          4419-4419
FTEHSP                    4420-4427
INTCAR          $          4428-4428
FTEMSI                    4429-4436
FTECIC                    4437-4444
FTENIC                    4445-4452
FTEPIC                    4453-4460
FTEOIC                    4461-4468
FTEINT                    4469-4476
CLSMSI          $          4477-4477
CLSCIC          $          4478-4478
CLSNIC          $          4479-4479
CLSPIC          $          4480-4480
CLSOIC          $          4481-4481
APRN          $          4482-4482
FTAPRN                    4483-4490
PTAPRN                    4491-4498
FTEAPN                    4499-4506
FTPHRN                    4507-4514
PTPHRN                    4515-4522
FTEPHRN                    4523-4530
APCAR          $          4531-4531
APANES          $          4532-4532
APEMER          $          4533-4533
APSPC          $          4534-4534
APED          $          4535-4535
APCASE          $          4536-4536
APOTH          $          4537-4537
FORNRSA          $          4538-4538
AFRICA          $          4539-4539
KOREA          $          4540-4540
CANADA          $          4541-4541
PH          $          4542-4542
CHINA          $          4543-4543
INDIA          $          4544-4544
OFRNRS          $          4545-4545
RNSCH                    4546-4555
PLNTA                    4556-4565
ADEPRA                    4566-4575
ASSNET                    4576-4585
GFEET                    4586-4595
CEAMT                    4596-4605
ENDMARK           $          4606-4606

;
;	
RUN;	
proc contents data=annual2015;run;				


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.annual2015
like work.annual2015;

proc SQL;
insert into isilon.annual2015
select * from work.annual2015;
