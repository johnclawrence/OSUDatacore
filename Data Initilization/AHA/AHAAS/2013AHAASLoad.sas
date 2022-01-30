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
DATA ANNUAL2013;

INfile 'X:\AHA\AHAAS Raw Data\FY2013 ASDB\FLAT\pubas13.asc' lrecl=4447 recfm=f;				

INPUT
@0001   ID             $7.
@0002   REG            $1.
@0002   STCD           $2.
@0004   HOSPN          $4.
@0008   DTBEG          $10.
@0008   DBEGM          $2.
@0011   DBEGD          $2.
@0014   DBEGY          $4.
@0018   DTEND          $10.
@0018   DENDM          $2.
@0021   DENDD          $2.
@0024   DENDY          $4.
@0028   DCOV            3.
@0031   FYR             1.
@0032   FISYR          $10.
@0032   FISM           $2.
@0035   FISD           $2.
@0038   FISY           $4.



CNTRL            $        42   -  43
SERV             $        44   -  45
SERVOTH          $        46   -  145
RADMCHI          $        146  -  146
HSACODE          $        147  -  151
HSANAME          $        152  -  181
HRRCODE          $        182  -  184
HRRNAME          $        185  -  214
MTYPE            $        215  -  216
LOS              $        217  -  217
MNAME            $        218  -  317
MADMIN           $        318  -  467
MLOCADDR         $        468  -  527
MLOCCITY         $        528  -  557
MLOCSTCD         $        558  -  559
MLOCZIP          $        560  -  569
MSTATE           $        570  -  571
AREA             $        572  -  574
TELNO            $        575  -  581
RESP             $        582  -  582
CHC              $        583  -  583
BSC              $        584  -  584
MHSMEMB          $        585  -  585
SUBS             $        586  -  586
MNGT             $        587  -  587
MNGTNAME         $        588  -  687
MNGTCITY         $        688  -  717
MNGTSTCD         $        718  -  719
NETWRK           $        720  -  720
NETNAME          $        721  -  820
NETCT            $        821  -  850
NETSC            $        851  -  852
NETPHONE         $        853  -  862
GROUP            $        863  -  863
GPONAME          $        864  -  963
GPOCITY          $        964  -  993
GPOST            $        994  -  995
SUPLY            $        996  -  996
SUPNM            $        997  -  1096
PHYGP            $        1097 -  1097
LTCHF            $        1098 -  1098
LTCHC            $        1099 -  1099
LTNM             $        1100 -  1199
LTCT             $        1200 -  1229
LTST             $        1230 -  1231
NPINUM                    1232 -  1241
CLUSTER          $        1242 -  1242
SYSID            $        1243 -  1246
SYSNAME          $        1247 -  1346
SYSADDR          $        1347 -  1406
SYSCITY          $        1407 -  1436
SYSST            $        1437 -  1438
SYSZIP           $        1439 -  1448
SYSAREA          $        1449 -  1451
SYSTELN          $        1452 -  1459
SYSTEM_PRIMARY_CONTACT $        1460 -  1489
SYSTITLE         $        1490 -  1589
COMMTY           $        1590 -  1590
MCRNUM           $        1591 -  1596

LAT                       1597 -  1606
LONG                      1607 -  1616

CNTYNAME         $        1617 -  1676
CBSANAME         $        1677 -  1736
CBSATYPE         $        1737 -  1744
CBSACODE         $        1745 -  1749
MCNTYCD          $        1750 -  1752
FCOUNTY          $        1753 -  1757
FSTCD            $        1758 -  1759
FCNTYCD          $        1760 -  1762
CITYRK           $        1763 -  1765
MAPP1            $        1766 -  1766
MAPP2            $        1767 -  1767
MAPP3            $        1768 -  1768
MAPP5            $        1769 -  1769
MAPP6            $        1770 -  1770
MAPP7            $        1771 -  1771
MAPP8            $        1772 -  1772
MAPP9            $        1773 -  1773
MAPP10           $        1774 -  1774
MAPP11           $        1775 -  1775
MAPP12           $        1776 -  1776
MAPP13           $        1777 -  1777
MAPP16           $        1778 -  1778
MAPP18           $        1779 -  1779
MAPP19           $        1780 -  1780
MAPP20           $        1781 -  1781
MAPP21           $        1782 -  1782
AHAMBR           $        1783 -  1783
SNT              $        1784 -  1784
SUNITS           $        1785 -  1785
IPAHOS           $        1786 -  1786
IPASYS           $        1787 -  1787
IPANET           $        1788 -  1788
GPWWHOS          $        1789 -  1789
GPWWSYS          $        1790 -  1790
GPWWNET          $        1791 -  1791
OPHOHOS          $        1792 -  1792
OPHOSYS          $        1793 -  1793
OPHONET          $        1794 -  1794
CPHOHOS          $        1795 -  1795
CPHOSYS          $        1796 -  1796
CPHONET          $        1797 -  1797
MSOHOS           $        1798 -  1798
MSOSYS           $        1799 -  1799
MSONET           $        1800 -  1800
ISMHOS           $        1801 -  1801
ISMSYS           $        1802 -  1802
ISMNET           $        1803 -  1803
EQMODHOS         $        1804 -  1804
EQMODSYS         $        1805 -  1805
EQMODNET         $        1806 -  1806
FOUNDHOS         $        1807 -  1807
FOUNDSYS         $        1808 -  1808
FOUNDNET         $        1809 -  1809
PHYOTH           $        1810 -  1909
PHYHOS           $        1910 -  1910
PHYSYS           $        1911 -  1911
PHYNET           $        1912 -  1912
IPHMOHOS         $        1913 -  1913
IPHMOSYS         $        1914 -  1914
IPHMONET         $        1915 -  1915
IPHMOVEN         $        1916 -  1916
IPPPOHOS         $        1917 -  1917
IPPPOSYS         $        1918 -  1918
IPPPONET         $        1919 -  1919
IPPPOVEN         $        1920 -  1920
IPFEEHOS         $        1921 -  1921
IPFEESYS         $        1922 -  1922
IPFEENET         $        1923 -  1923
IPFEEVEN         $        1924 -  1924
HMO86            $        1925 -  1925
HMOCON                    1926 -  1929
PPO86            $        1930 -  1930
PPOCON                    1931 -  1934
CAPCON94         $        1935 -  1935
CAPCOV                    1936 -  1943
IPAP                      1944 -  1951
GPWP                      1952 -  1959
OPHP                      1960 -  1967
CPHP                      1968 -  1975
MSOP                      1976 -  1983
ISMP                      1984 -  1991
EQMP                      1992 -  1999
FNDP                      2000 -  2007
PHYP                      2008 -  2015
FTMT                      2016 -  2023
JNTPH            $        2024 -  2024
JNLS             $        2025 -  2025
JNTAMB           $        2026 -  2026
JNTCTR           $        2027 -  2027
JNTOTH           $        2028 -  2028
LSHTXT           $        2029 -  2128
JNTLSC           $        2129 -  2129
JNTLSO           $        2130 -  2130
JNTLSS           $        2131 -  2131
JNTLST           $        2132 -  2132
JNTTXT           $        2133 -  2232
JNTMD            $        2233 -  2233
MEDHME           $        2234 -  2234
EHLTH            $        2235 -  2235
GENBD                     2236 -  2239
PEDBD                     2240 -  2243
OBLEV            $        2244 -  2244
OBBD                      2245 -  2248
MSICBD                    2249 -  2252
CICBD                     2253 -  2256
NICBD                     2257 -  2260
NINTBD                    2261 -  2264
PEDICBD                   2265 -  2268
BRNBD                     2269 -  2272
SPCICBD                   2273 -  2276
OSPOTH           $        2277 -  2376
OTHICBD                   2377 -  2380
OTHIC            $        2381 -  2480
REHABBD                   2481 -  2484
ALCHBD                    2485 -  2488
PSYBD                     2489 -  2492
SNBD88                    2493 -  2496
ICFBD88                   2497 -  2500
ACULTBD                   2501 -  2504
OTHLBD94                  2505 -  2508
OTHBD94                   2509 -  2512
OTHOTH           $        2513 -  2612
HOSPBD                    2613 -  2616
GENHOS           $        2617 -  2617
GENSYS           $        2618 -  2618
GENVEN           $        2619 -  2619
PEDHOS           $        2620 -  2620
PEDSYS           $        2621 -  2621
PEDVEN           $        2622 -  2622
OBHOS            $        2623 -  2623
OBSYS            $        2624 -  2624
OBVEN            $        2625 -  2625
MSICHOS          $        2626 -  2626
MSICSYS          $        2627 -  2627
MSICVEN          $        2628 -  2628
CICHOS           $        2629 -  2629
CICSYS           $        2630 -  2630
CICVEN           $        2631 -  2631
NICHOS           $        2632 -  2632
NICSYS           $        2633 -  2633
NICVEN           $        2634 -  2634
NINTHOS          $        2635 -  2635
NINTSYS          $        2636 -  2636
NINTVEN          $        2637 -  2637
PEDICHOS         $        2638 -  2638
PEDICSYS         $        2639 -  2639
PEDICVEN         $        2640 -  2640
BRNHOS           $        2641 -  2641
BRNSYS           $        2642 -  2642
BRNVEN           $        2643 -  2643
SPCICHOS         $        2644 -  2644
SPCICSYS         $        2645 -  2645
SPCICVEN         $        2646 -  2646
OTHIHOS          $        2647 -  2647
OTHISYS          $        2648 -  2648
OTHIVEN          $        2649 -  2649
REHABHOS         $        2650 -  2650
REHABSYS         $        2651 -  2651
REHABVEN         $        2652 -  2652
ALCHHOS          $        2653 -  2653
ALCHSYS          $        2654 -  2654
ALCHVEN          $        2655 -  2655
PSYHOS           $        2656 -  2656
PSYSYS           $        2657 -  2657
PSYVEN           $        2658 -  2658
SNHOS            $        2659 -  2659
SNSYS            $        2660 -  2660
SNVEN            $        2661 -  2661
ICFHOS           $        2662 -  2662
ICFSYS           $        2663 -  2663
ICFVEN           $        2664 -  2664
ACUHOS           $        2665 -  2665
ACUSYS           $        2666 -  2666
ACUVEN           $        2667 -  2667
OTHLTHOS         $        2668 -  2668
OTHLTSYS         $        2669 -  2669
OTHLTVEN         $        2670 -  2670
OTHCRHOS         $        2671 -  2671
OTHCRSYS         $        2672 -  2672
OTHCRVEN         $        2673 -  2673
ADULTHOS         $        2674 -  2674
ADULTSYS         $        2675 -  2675
ADULTVEN         $        2676 -  2676
AIRBHOS          $        2677 -  2677
AIRBSYS          $        2678 -  2678
AIRBVEN          $        2679 -  2679
AIRBROOM                  2680 -  2683
ALCOPHOS         $        2684 -  2684
ALCOPSYS         $        2685 -  2685
ALCOPVEN         $        2686 -  2686
ALZHOS           $        2687 -  2687
ALZSYS           $        2688 -  2688
ALZVEN           $        2689 -  2689
AMBHOS           $        2690 -  2690
AMBSYS           $        2691 -  2691
AMBVEN           $        2692 -  2692
AMBSHOS          $        2693 -  2693
AMBSSYS          $        2694 -  2694
AMBSVEN          $        2695 -  2695
ARTHCHOS         $        2696 -  2696
ARTHCSYS         $        2697 -  2697
ARTHCVEN         $        2698 -  2698
ASSTLHOS         $        2699 -  2699
ASSTLSYS         $        2700 -  2700
ASSTLVEN         $        2701 -  2701
AUXHOS           $        2702 -  2702
AUXSYS           $        2703 -  2703
AUXVEN           $        2704 -  2704
BWHTHOS          $        2705 -  2705
BWHTSYS          $        2706 -  2706
BWHTVEN          $        2707 -  2707
BROOMHOS         $        2708 -  2708
BROOMSYS         $        2709 -  2709
BROOMVEN         $        2710 -  2710
BLDOHOS          $        2711 -  2711
BLDOSYS          $        2712 -  2712
BLDOVEN          $        2713 -  2713
MAMMSHOS         $        2714 -  2714
MAMMSSYS         $        2715 -  2715
MAMMSVEN         $        2716 -  2716
ACARDHOS         $        2717 -  2717
ACARDSYS         $        2718 -  2718
ACARDVEN         $        2719 -  2719
PCARDHOS         $        2720 -  2720
PCARDSYS         $        2721 -  2721
PCARDVEN         $        2722 -  2722
ACLABHOS         $        2723 -  2723
ACLABSYS         $        2724 -  2724
ACLABVEN         $        2725 -  2725
PCLABHOS         $        2726 -  2726
PCLABSYS         $        2727 -  2727
PCLABVEN         $        2728 -  2728
ICLABHOS         $        2729 -  2729
ICLABSYS         $        2730 -  2730
ICLABVEN         $        2731 -  2731
PELABHOS         $        2732 -  2732
PELABSYS         $        2733 -  2733
PELABVEN         $        2734 -  2734
ADTCHOS          $        2735 -  2735
ADTCSYS          $        2736 -  2736
ADTCVEN          $        2737 -  2737
PEDCSHOS         $        2738 -  2738
PEDCSSYS         $        2739 -  2739
PEDCSVEN         $        2740 -  2740
ADTEHOS          $        2741 -  2741
ADTESYS          $        2742 -  2742
ADTEVEN          $        2743 -  2743
PEDEHOS          $        2744 -  2744
PEDESYS          $        2745 -  2745
PEDEVEN          $        2746 -  2746
CHABHOS          $        2747 -  2747
CHABSYS          $        2748 -  2748
CHABVEN          $        2749 -  2749
CMNGTHOS         $        2750 -  2750
CMNGTSYS         $        2751 -  2751
CMNGTVEN         $        2752 -  2752
CHAPHOS          $        2753 -  2753
CHAPSYS          $        2754 -  2754
CHAPVEN          $        2755 -  2755
CHTHHOS          $        2756 -  2756
CHTHSYS          $        2757 -  2757
CHTHVEN          $        2758 -  2758
CWELLHOS         $        2759 -  2759
CWELLSYS         $        2760 -  2760
CWELLVEN         $        2761 -  2761
CHIHOS           $        2762 -  2762
CHISYS           $        2763 -  2763
CHIVEN           $        2764 -  2764
COUTRHOS         $        2765 -  2765
COUTRSYS         $        2766 -  2766
COUTRVEN         $        2767 -  2767
COMPHOS          $        2768 -  2768
COMPSYS          $        2769 -  2769
COMPVEN          $        2770 -  2770
CAOSHOS          $        2771 -  2771
CAOSSYS          $        2772 -  2772
CAOSVEN          $        2773 -  2773
CPREVHOS         $        2774 -  2774
CPREVSYS         $        2775 -  2775
CPREVVEN         $        2776 -  2776
DENTSHOS         $        2777 -  2777
DENTSSYS         $        2778 -  2778
DENTSVEN         $        2779 -  2779
EMDEPHOS         $        2780 -  2780
EMDEPSYS         $        2781 -  2781
EMDEPVEN         $        2782 -  2782
PEMERHOS         $        2783 -  2783
PEMERSYS         $        2784 -  2784
PEMERVEN         $        2785 -  2785
FSERHOS          $        2786 -  2786
FSERSYS          $        2787 -  2787
FSERVEN          $        2788 -  2788
FSERYN           $        2789 -  2789
TRAUMHOS         $        2790 -  2790
TRAUMSYS         $        2791 -  2791
TRAUMVEN         $        2792 -  2792
TRAUML90         $        2793 -  2793
ENBHOS           $        2794 -  2794
ENBSYS           $        2795 -  2795
ENBVEN           $        2796 -  2796
ENDOCHOS         $        2797 -  2797
ENDOCSYS         $        2798 -  2798
ENDOCVEN         $        2799 -  2799
ENDOUHOS         $        2800 -  2800
ENDOUSYS         $        2801 -  2801
ENDOUVEN         $        2802 -  2802
ENDOAHOS         $        2803 -  2803
ENDOASYS         $        2804 -  2804
ENDOAVEN         $        2805 -  2805
ENDOEHOS         $        2806 -  2806
ENDOESYS         $        2807 -  2807
ENDOEVEN         $        2808 -  2808
ENDORHOS         $        2809 -  2809
ENDORSYS         $        2810 -  2810
ENDORVEN         $        2811 -  2811
ENRHOS           $        2812 -  2812
ENRSYS           $        2813 -  2813
ENRVEN           $        2814 -  2814
ESWLHOS          $        2815 -  2815
ESWLSYS          $        2816 -  2816
ESWLVEN          $        2817 -  2817
FRTCHOS          $        2818 -  2818
FRTCSYS          $        2819 -  2819
FRTCVEN          $        2820 -  2820
FITCHOS          $        2821 -  2821
FITCSYS          $        2822 -  2822
FITCVEN          $        2823 -  2823
OPCENHOS         $        2824 -  2824
OPCENSYS         $        2825 -  2825
OPCENVEN         $        2826 -  2826
GERSVHOS         $        2827 -  2827
GERSVSYS         $        2828 -  2828
GERSVVEN         $        2829 -  2829
HLTHFHOS         $        2830 -  2830
HLTHFSYS         $        2831 -  2831
HLTHFVEN         $        2832 -  2832
HLTHCHOS         $        2833 -  2833
HLTHCSYS         $        2834 -  2834
HLTHCVEN         $        2835 -  2835
GNTCHOS          $        2836 -  2836
GNTCSYS          $        2837 -  2837
GNTCVEN          $        2838 -  2838
HLTHSHOS         $        2839 -  2839
HLTHSSYS         $        2840 -  2840
HLTHSVEN         $        2841 -  2841
HLTRHOS          $        2842 -  2842
HLTRSYS          $        2843 -  2843
HLTRVEN          $        2844 -  2844
HEMOHOS          $        2845 -  2845
HEMOSYS          $        2846 -  2846
HEMOVEN          $        2847 -  2847
AIDSSHOS         $        2848 -  2848
AIDSSSYS         $        2849 -  2849
AIDSSVEN         $        2850 -  2850
HOMEHHOS         $        2851 -  2851
HOMEHSYS         $        2852 -  2852
HOMEHVEN         $        2853 -  2853
HOSPCHOS         $        2854 -  2854
HOSPCSYS         $        2855 -  2855
HOSPCVEN         $        2856 -  2856
OPHOSHOS         $        2857 -  2857
OPHOSSYS         $        2858 -  2858
OPHOSVEN         $        2859 -  2859
IMPRHOS          $        2860 -  2860
IMPRSYS          $        2861 -  2861
IMPRVEN          $        2862 -  2862
ICARHOS          $        2863 -  2863
ICARSYS          $        2864 -  2864
ICARVEN          $        2865 -  2865
LINGHOS          $        2866 -  2866
LINGSYS          $        2867 -  2867
LINGVEN          $        2868 -  2868
MEALSHOS         $        2869 -  2869
MEALSSYS         $        2870 -  2870
MEALSVEN         $        2871 -  2871
MOHSHOS          $        2872 -  2872
MOHSSYS          $        2873 -  2873
MOHSVEN          $        2874 -  2874
NEROHOS          $        2875 -  2875
NEROSYS          $        2876 -  2876
NEROVEN          $        2877 -  2877
NUTRPHOS         $        2878 -  2878
NUTRPSYS         $        2879 -  2879
NUTRPVEN         $        2880 -  2880
OCCHSHOS         $        2881 -  2881
OCCHSSYS         $        2882 -  2882
OCCHSVEN         $        2883 -  2883
ONCOLHOS         $        2884 -  2884
ONCOLSYS         $        2885 -  2885
ONCOLVEN         $        2886 -  2886
ORTOHOS          $        2887 -  2887
ORTOSYS          $        2888 -  2888
ORTOVEN          $        2889 -  2889
OPSRGHOS         $        2890 -  2890
OPSRGSYS         $        2891 -  2891
OPSRGVEN         $        2892 -  2892
PAINHOS          $        2893 -  2893
PAINSYS          $        2894 -  2894
PAINVEN          $        2895 -  2895
PALHOS           $        2896 -  2896
PALSYS           $        2897 -  2897
PALVEN           $        2898 -  2898
IPALHOS          $        2899 -  2899
IPALSYS          $        2900 -  2900
IPALVEN          $        2901 -  2901
PCAHOS           $        2902 -  2902
PCASYS           $        2903 -  2903
PCAVEN           $        2904 -  2904
PATEDHOS         $        2905 -  2905
PATEDSYS         $        2906 -  2906
PATEDVEN         $        2907 -  2907
PATRPHOS         $        2908 -  2908
PATRPSYS         $        2909 -  2909
PATRPVEN         $        2910 -  2910
RASTHOS          $        2911 -  2911
RASTSYS          $        2912 -  2912
RASTVEN          $        2913 -  2913
REDSHOS          $        2914 -  2914
REDSSYS          $        2915 -  2915
REDSVEN          $        2916 -  2916
RHBOPHOS         $        2917 -  2917
RHBOPSYS         $        2918 -  2918
RHBOPVEN         $        2919 -  2919
RPRSHOS          $        2920 -  2920
RPRSSYS          $        2921 -  2921
RPRSVEN          $        2922 -  2922
RBOTHOS          $        2923 -  2923
RBOTSYS          $        2924 -  2924
RBOTVEN          $        2925 -  2925
RSIMHOS          $        2926 -  2926
RSIMSYS          $        2927 -  2927
RSIMVEN          $        2928 -  2928
PCDEPHOS         $        2929 -  2929
PCDEPSYS         $        2930 -  2930
PCDEPVEN         $        2931 -  2931
PSYCAHOS         $        2932 -  2932
PSYCASYS         $        2933 -  2933
PSYCAVEN         $        2934 -  2934
PSYLSHOS         $        2935 -  2935
PSYLSSYS         $        2936 -  2936
PSYLSVEN         $        2937 -  2937
PSYEDHOS         $        2938 -  2938
PSYEDSYS         $        2939 -  2939
PSYEDVEN         $        2940 -  2940
PSYEMHOS         $        2941 -  2941
PSYEMSYS         $        2942 -  2942
PSYEMVEN         $        2943 -  2943
PSYGRHOS         $        2944 -  2944
PSYGRSYS         $        2945 -  2945
PSYGRVEN         $        2946 -  2946
PSYOPHOS         $        2947 -  2947
PSYOPSYS         $        2948 -  2948
PSYOPVEN         $        2949 -  2949
PSYPHHOS         $        2950 -  2950
PSYPHSYS         $        2951 -  2951
PSYPHVEN         $        2952 -  2952
PSTRTHOS         $        2953 -  2953
PSTRTSYS         $        2954 -  2954
PSTRTVEN         $        2955 -  2955
CTSCNHOS         $        2956 -  2956
CTSCNSYS         $        2957 -  2957
CTSCNVEN         $        2958 -  2958
DRADFHOS         $        2959 -  2959
DRADFSYS         $        2960 -  2960
DRADFVEN         $        2961 -  2961
EBCTHOS          $        2962 -  2962
EBCTSYS          $        2963 -  2963
EBCTVEN          $        2964 -  2964
FFDMHOS          $        2965 -  2965
FFDMSYS          $        2966 -  2966
FFDMVEN          $        2967 -  2967
MRIHOS           $        2968 -  2968
MRISYS           $        2969 -  2969
MRIVEN           $        2970 -  2970
IMRIHOS          $        2971 -  2971
IMRISYS          $        2972 -  2972
IMRIVEN          $        2973 -  2973
MEGHOS           $        2974 -  2974
MEGSYS           $        2975 -  2975
MEGVEN           $        2976 -  2976
MSCTHOS          $        2977 -  2977
MSCTSYS          $        2978 -  2978
MSCTVEN          $        2979 -  2979
MSCTGHOS         $        2980 -  2980
MSCTGSYS         $        2981 -  2981
MSCTGVEN         $        2982 -  2982
PETHOS           $        2983 -  2983
PETSYS           $        2984 -  2984
PETVEN           $        2985 -  2985
PETCTHOS         $        2986 -  2986
PETCTSYS         $        2987 -  2987
PETCTVEN         $        2988 -  2988
SPECTHOS         $        2989 -  2989
SPECTSYS         $        2990 -  2990
SPECTVEN         $        2991 -  2991
ULTSNHOS         $        2992 -  2992
ULTSNSYS         $        2993 -  2993
ULTSNVEN         $        2994 -  2994
IGRTHOS          $        2995 -  2995
IGRTSYS          $        2996 -  2996
IGRTVEN          $        2997 -  2997
IMRTHOS          $        2998 -  2998
IMRTSYS          $        2999 -  2999
IMRTVEN          $        3000 -  3000
PTONHOS          $        3001 -  3001
PTONSYS          $        3002 -  3002
PTONVEN          $        3003 -  3003
BEAMHOS          $        3004 -  3004
BEAMSYS          $        3005 -  3005
BEAMVEN          $        3006 -  3006
SRADHOS          $        3007 -  3007
SRADSYS          $        3008 -  3008
SRADVEN          $        3009 -  3009
RETIRHOS         $        3010 -  3010
RETIRSYS         $        3011 -  3011
RETIRVEN         $        3012 -  3012
ROBOHOS          $        3013 -  3013
ROBOSYS          $        3014 -  3014
ROBOVEN          $        3015 -  3015
RURLHOS          $        3016 -  3016
RURLSYS          $        3017 -  3017
RURLVEN          $        3018 -  3018
SLEPHOS          $        3019 -  3019
SLEPSYS          $        3020 -  3020
SLEPVEN          $        3021 -  3021
SOCWKHOS         $        3022 -  3022
SOCWKSYS         $        3023 -  3023
SOCWKVEN         $        3024 -  3024
SPORTHOS         $        3025 -  3025
SPORTSYS         $        3026 -  3026
SPORTVEN         $        3027 -  3027
SUPPGHOS         $        3028 -  3028
SUPPGSYS         $        3029 -  3029
SUPPGVEN         $        3030 -  3030
SWBDHOS          $        3031 -  3031
SWBDSYS          $        3032 -  3032
SWBDVEN          $        3033 -  3033
TEENSHOS         $        3034 -  3034
TEENSSYS         $        3035 -  3035
TEENSVEN         $        3036 -  3036
TOBHOS           $        3037 -  3037
TOBSYS           $        3038 -  3038
TOBVEN           $        3039 -  3039
OTBONHOS         $        3040 -  3040
OTBONSYS         $        3041 -  3041
OTBONVEN         $        3042 -  3042
HARTHOS          $        3043 -  3043
HARTSYS          $        3044 -  3044
HARTVEN          $        3045 -  3045
KDNYHOS          $        3046 -  3046
KDNYSYS          $        3047 -  3047
KDNYVEN          $        3048 -  3048
LIVRHOS          $        3049 -  3049
LIVRSYS          $        3050 -  3050
LIVRVEN          $        3051 -  3051
LUNGHOS          $        3052 -  3052
LUNGSYS          $        3053 -  3053
LUNGVEN          $        3054 -  3054
TISUHOS          $        3055 -  3055
TISUSYS          $        3056 -  3056
TISUVEN          $        3057 -  3057
OTOTHHOS         $        3058 -  3058
OTOTHSYS         $        3059 -  3059
OTOTHVEN         $        3060 -  3060
TPORTHOS         $        3061 -  3061
TPORTSYS         $        3062 -  3062
TPORTVEN         $        3063 -  3063
URGCCHOS         $        3064 -  3064
URGCCSYS         $        3065 -  3065
URGCCVEN         $        3066 -  3066
VRCSHOS          $        3067 -  3067
VRCSSYS          $        3068 -  3068
VRCSVEN          $        3069 -  3069
VOLSVHOS         $        3070 -  3070
VOLSVSYS         $        3071 -  3071
VOLSVVEN         $        3072 -  3072
WOMHCHOS         $        3073 -  3073
WOMHCSYS         $        3074 -  3074
WOMHCVEN         $        3075 -  3075
WMGTHOS          $        3076 -  3076
WMGTSYS          $        3077 -  3077
WMGTVEN          $        3078 -  3078
EXPTOT                    3079 -  3093
EXPTHA                    3094 -  3108
EXPTLA                    3109 -  3123
CPPCT                     3124 -  3127
CAPRSK                    3128 -  3131
DPEXA                     3132 -  3141
INTEXA                    3142 -  3151
SUPEXA                    3152 -  3161
OTHEXPA                   3162 -  3171
NPAYBEN                   3172 -  3181
PAYTOT                    3182 -  3191
PAYTOTH                   3192 -  3201
NPAYBENH                  3202 -  3211
PAYTOTLT                  3212 -  3221
NPAYBENL                  3222 -  3231
LBEDSA                    3232 -  3237
BDTOT                     3238 -  3241
ADMTOT                    3242 -  3247
IPDTOT                    3248 -  3255
BDH                       3256 -  3259
ADMH                      3260 -  3265
IPDH                      3266 -  3273
LBEDLA                    3274 -  3279
BDLT                      3280 -  3283
ADMLT                     3284 -  3289
IPDLT                     3290 -  3297
MCRDC                     3298 -  3303
MCRIPD                    3304 -  3311
MCDDC                     3312 -  3317
MCDIPD                    3318 -  3325
MCRDCH                    3326 -  3331
MCRIPDH                   3332 -  3339
MCDDCH                    3340 -  3345
MCDIPDH                   3346 -  3353
MCRDCLT                   3354 -  3359
MCRIPDLT                  3360 -  3367
MCDDCLT                   3368 -  3373
MCDIPDLT                  3374 -  3381
BASSIN                    3382 -  3385
BIRTHS                    3386 -  3391
SUROPIP                   3392 -  3397
SUROPOP                   3398 -  3403
SUROPTOT                  3404 -  3409
VEM                       3410 -  3417
VOTH                      3418 -  3425
VTOT                      3426 -  3433
FTMDTF                    3434 -  3438
FTRES                     3439 -  3443
FTTRAN84                  3444 -  3448
FTRNTF                    3449 -  3453
FTLPNTF                   3454 -  3458
FTAST                     3459 -  3463
FTRAD                     3464 -  3468
FTLAB                     3469 -  3473
FTPHR                     3474 -  3478
FTPHT                     3479 -  3483
FTRESP                    3484 -  3488
FTOTHTF                   3489 -  3493
FTTOT                     3494 -  3498
PTMDTF                    3499 -  3503
PTRES                     3504 -  3508
PTTRAN84                  3509 -  3513
PTRNTF                    3514 -  3518
PTLPNTF                   3519 -  3523
PTAST                     3524 -  3528
PTRAD                     3529 -  3533
PTLAB                     3534 -  3538
PTPHR                     3539 -  3543
PTPHT                     3544 -  3548
PTRESP                    3549 -  3553
PTOTHTF                   3554 -  3558
PTTOT                     3559 -  3563
FTTOTH                    3564 -  3568
PTTOTH                    3569 -  3573
FTTOTLT                   3574 -  3578
PTTOTLT                   3579 -  3583
FTED                      3584 -  3591
FTER                      3592 -  3599
FTET                      3600 -  3607
FTEN                      3608 -  3615
FTEP                      3616 -  3623
FTEAP                     3624 -  3631
FTERAD                    3632 -  3639
FTELAB                    3640 -  3647
FTEPH                     3648 -  3655
FTEPHT                    3656 -  3663
FTERESP                   3664 -  3671
FTEO                      3672 -  3679
FTETF                     3680 -  3687
FTERNLT                   3688 -  3695
FTEU                      3696 -  3703
VMD                       3704 -  3711
VRES                      3712 -  3719
VTTRN                     3720 -  3727
VRN                       3728 -  3735
VLPN                      3736 -  3743
VAST                      3744 -  3751
VRAD                      3752 -  3759
VLAB                      3760 -  3767
VPHR                      3768 -  3775
VPHT                      3776 -  3783
VRSP                      3784 -  3791
VOTHL                     3792 -  3799
VTOTL                     3800 -  3807
VRNH                      3808 -  3815
VTNH                      3816 -  3823
ADC                       3824 -  3831
ADJADM                    3832 -  3839
ADJPD                     3840 -  3847
ADJADC                    3848 -  3855
FTEMD                     3856 -  3863
FTERN                     3864 -  3871
FTELPN                    3872 -  3879
FTERES                    3880 -  3887
FTETRAN                   3888 -  3895
FTETTRN                   3896 -  3903
FTEOTH94                  3904 -  3911
FTEH                      3912 -  3919
FTENH                     3920 -  3927
FTE                       3928 -  3935
OPRA                      3936 -  3939
EADMTOT          $        3940 -  3940
EIPDTOT          $        3941 -  3941
EADMH            $        3942 -  3942
EIPDH            $        3943 -  3943
EADMLT           $        3944 -  3944
EIPDLT           $        3945 -  3945
EMCRDC           $        3946 -  3946
EMCRIPD          $        3947 -  3947
EMCDDC           $        3948 -  3948
EMCDIPD          $        3949 -  3949
EMCRDCH          $        3950 -  3950
EMCRIPDH         $        3951 -  3951
EMCDDCH          $        3952 -  3952
EMCDIPDH         $        3953 -  3953
EMCRDCLT         $        3954 -  3954
EMCRPDLT         $        3955 -  3955
EMCDDCLT         $        3956 -  3956
EMCDPDLT         $        3957 -  3957
EBIRTHS          $        3958 -  3958
ESUROPIP         $        3959 -  3959
ESUROPOP         $        3960 -  3960
ESUROPTO         $        3961 -  3961
EVEM             $        3962 -  3962
EVOTH            $        3963 -  3963
EVTOT            $        3964 -  3964
EPAYTOT          $        3965 -  3965
ENPAYBEN         $        3966 -  3966
EPAYTOTH         $        3967 -  3967
ENPYBENH         $        3968 -  3968
EPYTOTLT         $        3969 -  3969
ENPBENLT         $        3970 -  3970
EFTMDTF          $        3971 -  3971
EFTRES           $        3972 -  3972
EFTTRN84         $        3973 -  3973
EFTRNTF          $        3974 -  3974
EFTLPNTF         $        3975 -  3975
EFTAST           $        3976 -  3976
EFTRAD           $        3977 -  3977
EFTLAB           $        3978 -  3978
EFTPHR           $        3979 -  3979
EFTPHT           $        3980 -  3980
EFTRESP          $        3981 -  3981
EFTOTHTF         $        3982 -  3982
EFTTOT           $        3983 -  3983
EPTMDTF          $        3984 -  3984
EPTRES           $        3985 -  3985
EPTTRN84         $        3986 -  3986
EPTRNTF          $        3987 -  3987
EPTLPNTF         $        3988 -  3988
EPTAST           $        3989 -  3989
EPTRAD           $        3990 -  3990
EPTLAB           $        3991 -  3991
EPTPHR           $        3992 -  3992
EPTPHT           $        3993 -  3993
EPTRESP          $        3994 -  3994
EPTOTHTF         $        3995 -  3995
EPTTOT           $        3996 -  3996
EFTTOTH          $        3997 -  3997
EPTTOTH          $        3998 -  3998
EFTTOTLT         $        3999 -  3999
EPTTOTLT         $        4000 -  4000
EEXPTOT          $        4001 -  4001
EXPTHB           $        4002 -  4002
EXPTLB           $        4003 -  4003
TECAR                     4004 -  4011
TEMER                     4012 -  4019
TEHSP                     4020 -  4027
TEINT                     4028 -  4035
TEGST                     4036 -  4043
TEOTH                     4044 -  4051
TETOT                     4052 -  4059
TCCAR                     4060 -  4067
TCMER                     4068 -  4075
TCHSP                     4076 -  4083
TCINT                     4084 -  4091
TCGST                     4092 -  4099
TCOTH                     4100 -  4107
TCTOT                     4108 -  4115
TGCAR                     4116 -  4123
TGMER                     4124 -  4131
TGHSP                     4132 -  4139
TGINT                     4140 -  4147
TGGST                     4148 -  4155
TGOTH                     4156 -  4163
TGTOT                     4164 -  4171
NECAR                     4172 -  4179
NEMER                     4180 -  4187
NEHSP                     4188 -  4195
NEINT                     4196 -  4203
NEGST                     4204 -  4211
NEOTH                     4212 -  4219
NETOT                     4220 -  4227
TPCAR                     4228 -  4235
TPMER                     4236 -  4243
TPHSP                     4244 -  4251
TPINT                     4252 -  4259
TPGST                     4260 -  4267
TPOTH                     4268 -  4275
TPRTOT                    4276 -  4283
HSPTL            $        4284 -  4284
FTEHSP                    4285 -  4292
INTCAR           $        4293 -  4293
FTEMSI                    4294 -  4301
FTECIC                    4302 -  4309
FTENIC                    4310 -  4317
FTEPIC                    4318 -  4325
FTEOIC                    4326 -  4333
FTEINT                    4334 -  4341
CLSMSI           $        4342 -  4342
CLSCIC           $        4343 -  4343
CLSNIC           $        4344 -  4344
CLSPIC           $        4345 -  4345
CLSOIC           $        4346 -  4346
APRN             $        4347 -  4347
FTAPRN                    4348 -  4355
PTAPRN                    4356 -  4363
FTEAPN                    4364 -  4371
APCAR            $        4372 -  4372
APANES           $        4373 -  4373
APEMER           $        4374 -  4374
APSPC            $        4375 -  4375
APED             $        4376 -  4376
APCASE           $        4377 -  4377
APOTH            $        4378 -  4378
FORNRSA          $        4379 -  4379
AFRICA           $        4380 -  4380
KOREA            $        4381 -  4381
CANADA           $        4382 -  4382
PH               $        4383 -  4383
CHINA            $        4384 -  4384
INDIA            $        4385 -  4385
OFRNRS           $        4386 -  4386
RNSCH                     4387 -  4396
PLNTA                     4397 -  4406
ADEPRA                    4407 -  4416
ASSNET                    4417 -  4426
GFEET                     4427 -  4436
CEAMT                     4437 -  4446
ENDMARK         $         4447 -  4447
;
;	
RUN;	
proc contents data=annual2013;run;				


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.annual2013
like work.annual2013;

proc SQL;
insert into isilon.annual2013
select * from work.annual2013;
