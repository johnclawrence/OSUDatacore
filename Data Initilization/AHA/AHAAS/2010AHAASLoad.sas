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
DATA ANNUAL2010_1;

INfile 'X:\AHA\AHAAS Raw Data\FY2010 ASDB\FLAT\pubas10.asc' lrecl=3720 recfm=f;				

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
CNTRL    $     42      -       43
SERV     $     44      -       45
SERVOTH  $     46      -       75
RADMCHI  $     76      -       76
HSACODE  $     77      -       81
HSANAME  $     82      -       106
HRRCODE  $     107     -       109
HRRNAME  $     110     -       134
MTYPE    $     135     -       136
MLOS     $     137     -       137
MNAME    $     138     -       227
MADMIN   $     228     -       319
MLOCADDR $     320     -       379
MLOCCITY $     380     -       399
MLOCSTCD $     400     -       401
MLOCZIP  $     402     -       411
MSTATE   $     412     -       413
AREA     $     414     -       416
TELNO    $     417     -       423
RESP     $     424     -       424
CHC      $     425     -       425
BSC      $     426     -       426
MHSMEMB  $     427     -       427
SUBS     $     428     -       428
MNGT     $     429     -       429
MNGTNAME $     430     -       489
MNGTCITY $     490     -       509
MNGTSTCD $     510     -       511
NETWRK   $     512     -       512
NETNAME  $     513     -       572
NETCT    $     573     -       602
NETSC    $     603     -       604
NETPHONE $     605     -       614
GROUP    $     615     -       615
GPONAME  $     616     -       695
GPOCITY  $     696     -       715
GPOST    $     716     -       717
SUPLY    $     718     -       718
SUPNM    $     719     -       778
PHYGP    $     779     -       779
LTCHF    $     780     -       780
LTCHC    $     781     -       781
LTNM     $     782     -       811
LTCT     $     812     -       831
LTST     $     832     -       833
NPI      $     834     -       834
NPINUM   $     835     -       844
CLUSTER  $     845     -       845
SYSID    $     846     -       849
SYSNAME  $     850     -       934
SYSADDR  $     935     -       979
SYSCITY  $     980     -       999
SYSST    $     1000    -       1001
SYSZIP   $     1002    -       1011
SYSAREA  $     1012    -       1014
SYSTELN  $     1015    -       1022
SPC      $     1023    -       1052
SYSTITLE $     1053    -       1132
COMMTY   $     1133    -       1133
MCRNUM   $     1134    -       1139
@1140 LAT 10.7
@1150 LONG 10.7
CNTYNAME $     1160    -       1204
CBSANAME $     1205    -       1264
CBSATYPE $     1265    -       1272
LOS      $     1273    -       1273
CBSACODE $     1274    -       1278
MCNTYCD  $     1279    -       1281
FCOUNTY  $     1282    -       1286
FSTCD    $     1287    -       1288
FCNTYCD  $     1289    -       1291
CITYRK   $     1292    -       1294
MAPP1    $     1295    -       1295
MAPP2    $     1296    -       1296
MAPP3    $     1297    -       1297
MAPP5    $     1298    -       1298
MAPP6    $     1299    -       1299
MAPP7    $     1300    -       1300
MAPP8    $     1301    -       1301
MAPP9    $     1302    -       1302
MAPP10   $     1303    -       1303
MAPP11   $     1304    -       1304
MAPP12   $     1305    -       1305
MAPP13   $     1306    -       1306
MAPP16   $     1307    -       1307
MAPP18   $     1308    -       1308
MAPP19   $     1309    -       1309
MAPP20   $     1310    -       1310
MAPP21   $     1311    -       1311
AHAMBR   $     1312    -       1312
MISSION  $     1313    -       1313
LTPLAN   $     1314    -       1314
RESOURCE $     1315    -       1315
BENEFIT  $     1316    -       1316
BUILD    $     1317    -       1317
FUND     $     1318    -       1318
HWELL    $     1319    -       1319
HSASSESS $     1320    -       1320
HSIND    $     1321    -       1321
CAPASS   $     1322    -       1322
ASSUSE   $     1323    -       1323
CTRACK   $     1324    -       1324
QUALREP  $     1325    -       1325
GRACE    $     1326    -       1326
GLANG    $     1327    -       1327
ILEAD    $     1328    -       1328
DIVERS   $     1329    -       1329
ELEADS   $     1330    -       1330
DEVADM   $     1331    -       1331
SNT      $     1332    -       1332
TRIAGE   $     1333    -       1333
TRGOTH   $     1334    -       1383
SUNITS   $     1384    -       1384
IPAHOS   $     1385    -       1385
IPASYS   $     1386    -       1386
IPANET   $     1387    -       1387
GPWWHOS  $     1388    -       1388
GPWWSYS  $     1389    -       1389
GPWWNET  $     1390    -       1390
OPHOHOS  $     1391    -       1391
OPHOSYS  $     1392    -       1392
OPHONET  $     1393    -       1393
CPHOHOS  $     1394    -       1394
CPHOSYS  $     1395    -       1395
CPHONET  $     1396    -       1396
MSOHOS   $     1397    -       1397
MSOSYS   $     1398    -       1398
MSONET   $     1399    -       1399
ISMHOS   $     1400    -       1400
ISMSYS   $     1401    -       1401
ISMNET   $     1402    -       1402
EQMODHOS $     1403    -       1403
EQMODSYS $     1404    -       1404
EQMODNET $     1405    -       1405
FOUNDHOS $     1406    -       1406
FOUNDSYS $     1407    -       1407
FOUNDNET $     1408    -       1408
PHYOTH   $     1409    -       1458
PHYHOS   $     1459    -       1459
PHYSYS   $     1460    -       1460
PHYNET   $     1461    -       1461
IPHMOHOS $     1462    -       1462
IPHMOSYS $     1463    -       1463
IPHMONET $     1464    -       1464
IPHMOVEN $     1465    -       1465
IPPPOHOS $     1466    -       1466
IPPPOSYS $     1467    -       1467
IPPPONET $     1468    -       1468
IPPPOVEN $     1469    -       1469
IPFEEHOS $     1470    -       1470
IPFEESYS $     1471    -       1471
IPFEENET $     1472    -       1472
IPFEEVEN $     1473    -       1473
HMO86    $     1474    -       1474
HMOCON         1475    -       1478
PPO86    $     1479    -       1479
PPOCON         1480    -       1483
CAPCON94$      1484    -       1484
CAPCOV         1485    -       1492
IPAP           1493    -       1500
GPWP           1501    -       1508
OPHP           1509    -       1516
CPHP           1517    -       1524
MSOP           1525    -       1532
ISMP           1533    -       1540
EQMP           1541    -       1548
FNDP           1549    -       1556
PHYP           1557    -       1564
FTMT           1565    -       1572
JNTPH    $     1573    -       1573
JNLS     $     1574    -       1574
JNTAMB   $     1575    -       1575
JNTCTR   $     1576    -       1576
JNTOTH   $     1577    -       1577
LSHTXT   $     1578    -       1627
JNTLSC   $     1628    -       1628
JNTLSO   $     1629    -       1629
JNTLSS   $     1630    -       1630
JNTLST   $     1631    -       1631
JNTTXT   $     1632    -       1681
JNTMD    $     1682    -       1682
GENBD          1683    -       1686
PEDBD          1687    -       1690
OBBD           1691    -       1694
MSICBD         1695    -       1698
CICBD          1699    -       1702
NICBD          1703    -       1706
NINTBD         1707    -       1710
PEDICBD        1711    -       1714
BRNBD          1715    -       1718
OTHICBD        1719    -       1722
SPCICBD        1723    -       1726
REHABBD        1727    -       1730
ALCHBD         1731    -       1734
PSYBD          1735    -       1738
SNBD88         1739    -       1742
ICFBD88        1743    -       1746
ACULTBD        1747    -       1750
OTHLBD94       1751    -       1754
OTHBD94        1755    -       1758
HOSPBD         1759    -       1762
OBLEV    $     1763    -       1763
GENHOS   $     1764    -       1764
GENSYS   $     1765    -       1765
GENNET   $     1766    -       1766
GENVEN   $     1767    -       1767
PEDHOS   $     1768    -       1768
PEDSYS   $     1769    -       1769
PEDNET   $     1770    -       1770
PEDVEN   $     1771    -       1771
OBHOS    $     1772    -       1772
OBSYS    $     1773    -       1773
OBNET    $     1774    -       1774
OBVEN    $     1775    -       1775
MSICHOS  $     1776    -       1776
MSICSYS  $     1777    -       1777
MSICNET  $     1778    -       1778
MSICVEN  $     1779    -       1779
CICHOS   $     1780    -       1780
CICSYS   $     1781    -       1781
CICNET   $     1782    -       1782
CICVEN   $     1783    -       1783
NICHOS   $     1784    -       1784
NICSYS   $     1785    -       1785
NICNET   $     1786    -       1786
NICVEN   $     1787    -       1787
NINTHOS  $     1788    -       1788
NINTSYS  $     1789    -       1789
NINTNET  $     1790    -       1790
NINTVEN  $     1791    -       1791
PEDICHOS $     1792    -       1792
PEDICSYS $     1793    -       1793
PEDICNET $     1794    -       1794
PEDICVEN $     1795    -       1795
BRNHOS   $     1796    -       1796
BRNSYS   $     1797    -       1797
BRNNET   $     1798    -       1798
BRNVEN   $     1799    -       1799
SPCICHOS $     1800    -       1800
SPCICSYS $     1801    -       1801
SPCICNET $     1802    -       1802
SPCICVEN $     1803    -       1803
OTHIHOS  $     1804    -       1804
OTHISYS  $     1805    -       1805
OTHINET  $     1806    -       1806
OTHIVEN  $     1807    -       1807
REHABHOS $     1808    -       1808
REHABSYS $     1809    -       1809
REHABNET $     1810    -       1810
REHABVEN $     1811    -       1811
ALCHHOS  $     1812    -       1812
ALCHSYS  $     1813    -       1813
ALCHNET  $     1814    -       1814
ALCHVEN  $     1815    -       1815
PSYHOS   $     1816    -       1816
PSYSYS   $     1817    -       1817
PSYNET   $     1818    -       1818
PSYVEN   $     1819    -       1819
SNHOS    $     1820    -       1820
SNSYS    $     1821    -       1821
SNNET    $     1822    -       1822
SNVEN    $     1823    -       1823
ICFHOS   $     1824    -       1824
ICFSYS   $     1825    -       1825
ICFNET   $     1826    -       1826
ICFVEN   $     1827    -       1827
ACUHOS   $     1828    -       1828
ACUSYS   $     1829    -       1829
ACUNET   $     1830    -       1830
ACUVEN   $     1831    -       1831
OTHLTHOS $     1832    -       1832
OTHLTSYS $     1833    -       1833
OTHLTNET $     1834    -       1834
OTHLTVEN $     1835    -       1835
OTHCRHOS $     1836    -       1836
OTHCRSYS $     1837    -       1837
OTHCRNET $     1838    -       1838
OTHCRVEN $     1839    -       1839
ADULTHOS $     1840    -       1840
ADULTSYS $     1841    -       1841
ADULTNET $     1842    -       1842
ADULTVEN $     1843    -       1843
AIRBHOS  $     1844    -       1844
AIRBSYS  $     1845    -       1845
AIRBNET  $     1846    -       1846
AIRBVEN  $     1847    -       1847
AIRBROOM       1848    -       1851
ALCOPHOS $     1852    -       1852
ALCOPSYS $     1853    -       1853
ALCOPNET $     1854    -       1854
ALCOPVEN $     1855    -       1855
ALZHOS   $     1856    -       1856
ALZSYS   $     1857    -       1857
ALZNET   $     1858    -       1858
ALZVEN   $     1859    -       1859
AMBHOS   $     1860    -       1860
AMBSYS   $     1861    -       1861
AMBNET   $     1862    -       1862
AMBVEN   $     1863    -       1863
AMBSHOS  $     1864    -       1864
AMBSSYS  $     1865    -       1865
AMBSNET  $     1866    -       1866
AMBSVEN  $     1867    -       1867
ARTHCHOS $     1868    -       1868
ARTHCSYS $     1869    -       1869
ARTHCNET $     1870    -       1870
ARTHCVEN $     1871    -       1871
ASSTLHOS $     1872    -       1872
ASSTLSYS $     1873    -       1873
ASSTLNET $     1874    -       1874
ASSTLVEN $     1875    -       1875
AUXHOS   $     1876    -       1876
AUXSYS   $     1877    -       1877
AUXNET   $     1878    -       1878
AUXVEN   $     1879    -       1879
BWHTHOS  $     1880    -       1880
BWHTSYS  $     1881    -       1881
BWHTNET  $     1882    -       1882
BWHTVEN  $     1883    -       1883
BROOMHOS $     1884    -       1884
BROOMSYS $     1885    -       1885
BROOMNET $     1886    -       1886
BROOMVEN $     1887    -       1887
BLDOHOS  $     1888    -       1888
BLDOSYS  $     1889    -       1889
BLDONET  $     1890    -       1890
BLDOVEN  $     1891    -       1891
MAMMSHOS $     1892    -       1892
MAMMSSYS $     1893    -       1893
MAMMSNET $     1894    -       1894
MAMMSVEN $     1895    -       1895
ACARDHOS $     1896    -       1896
ACARDSYS $     1897    -       1897
ACARDNET $     1898    -       1898
ACARDVEN $     1899    -       1899
PCARDHOS $     1900    -       1900
PCARDSYS $     1901    -       1901
PCARDNET $     1902    -       1902
PCARDVEN $     1903    -       1903
ACLABHOS $     1904    -       1904
ACLABSYS $     1905    -       1905
ACLABNET $     1906    -       1906
ACLABVEN $     1907    -       1907
PCLABHOS $     1908    -       1908
PCLABSYS $     1909    -       1909
PCLABNET $     1910    -       1910
PCLABVEN $     1911    -       1911
ICLABHOS $     1912    -       1912
ICLABSYS $     1913    -       1913
ICLABNET $     1914    -       1914
ICLABVEN $     1915    -       1915
PELABHOS $     1916    -       1916
PELABSYS $     1917    -       1917
PELABNET $     1918    -       1918
PELABVEN $     1919    -       1919
ADTCHOS  $     1920    -       1920
ADTCSYS  $     1921    -       1921
ADTCNET  $     1922    -       1922
ADTCVEN  $     1923    -       1923
PEDCSHOS $     1924    -       1924
PEDCSSYS $     1925    -       1925
PEDCSNET $     1926    -       1926
PEDCSVEN $     1927    -       1927
ADTEHOS  $     1928    -       1928
ADTESYS  $     1929    -       1929
ADTENET  $     1930    -       1930
ADTEVEN  $     1931    -       1931
PEDEHOS  $     1932    -       1932
PEDESYS  $     1933    -       1933
PEDENET  $     1934    -       1934
PEDEVEN  $     1935    -       1935
CHABHOS  $     1936    -       1936
CHABSYS  $     1937    -       1937
CHABNET  $     1938    -       1938
CHABVEN  $     1939    -       1939
CMNGTHOS $     1940    -       1940
CMNGTSYS $     1941    -       1941
CMNGTNET $     1942    -       1942
CMNGTVEN $     1943    -       1943
CHAPHOS  $     1944    -       1944
CHAPSYS  $     1945    -       1945
CHAPNET  $     1946    -       1946
CHAPVEN  $     1947    -       1947
CHTHHOS  $     1948    -       1948
CHTHSYS  $     1949    -       1949
CHTHNET  $     1950    -       1950
CHTHVEN  $     1951    -       1951
CWELLHOS $     1952    -       1952
CWELLSYS $     1953    -       1953
CWELLNET $     1954    -       1954
CWELLVEN $     1955    -       1955
CHIHOS   $     1956    -       1956
CHISYS   $     1957    -       1957
CHINET   $     1958    -       1958
CHIVEN   $     1959    -       1959
COUTRHOS $     1960    -       1960
COUTRSYS $     1961    -       1961
COUTRNET $     1962    -       1962
COUTRVEN $     1963    -       1963
COMPHOS  $     1964    -       1964
COMPSYS  $     1965    -       1965
COMPNET  $     1966    -       1966
COMPVEN  $     1967    -       1967
CAOSHOS  $     1968    -       1968
CAOSSYS  $     1969    -       1969
CAOSNET  $     1970    -       1970
CAOSVEN  $     1971    -       1971
CPREVHOS $     1972    -       1972
CPREVSYS $     1973    -       1973
CPREVNET $     1974    -       1974
CPREVVEN $     1975    -       1975
DENTSHOS $     1976    -       1976
DENTSSYS $     1977    -       1977
DENTSNET $     1978    -       1978
DENTSVEN $     1979    -       1979
EMDEPHOS $     1980    -       1980
EMDEPSYS $     1981    -       1981
EMDEPNET $     1982    -       1982
EMDEPVEN $     1983    -       1983
FSERHOS  $     1984    -       1984
FSERSYS  $     1985    -       1985
FSERNET  $     1986    -       1986
FSERVEN  $     1987    -       1987
FSERYN   $     1988    -       1988
TRAUMHOS $     1989    -       1989
TRAUMSYS $     1990    -       1990
TRAUMNET $     1991    -       1991
TRAUMVEN $     1992    -       1992
TRAUML90 $     1993    -       1993
ENBHOS   $     1994    -       1994
ENBSYS   $     1995    -       1995
ENBNET   $     1996    -       1996
ENBVEN   $     1997    -       1997
ENDOCHOS $     1998    -       1998
ENDOCSYS $     1999    -       1999
ENDOCNET $     2000    -       2000
ENDOCVEN $     2001    -       2001
ENDOUHOS $     2002    -       2002
ENDOUSYS $     2003    -       2003
ENDOUNET $     2004    -       2004
ENDOUVEN $     2005    -       2005
ENDOAHOS $     2006    -       2006
ENDOASYS $     2007    -       2007
ENDOANET $     2008    -       2008
ENDOAVEN $     2009    -       2009
ENDOEHOS $     2010    -       2010
ENDOESYS $     2011    -       2011
ENDOENET $     2012    -       2012
ENDOEVEN $     2013    -       2013
ENDORHOS $     2014    -       2014
ENDORSYS $     2015    -       2015
ENDORNET $     2016    -       2016
ENDORVEN $     2017    -       2017
ENRHOS   $     2018    -       2018
ENRSYS   $     2019    -       2019
ENRNET   $     2020    -       2020
ENRVEN   $     2021    -       2021
ESWLHOS  $     2022    -       2022
ESWLSYS  $     2023    -       2023
ESWLNET  $     2024    -       2024
ESWLVEN  $     2025    -       2025
FRTCHOS  $     2026    -       2026
FRTCSYS  $     2027    -       2027
FRTCNET  $     2028    -       2028
FRTCVEN  $     2029    -       2029
FITCHOS  $     2030    -       2030
FITCSYS  $     2031    -       2031
FITCNET  $     2032    -       2032
FITCVEN  $     2033    -       2033
OPCENHOS $     2034    -       2034
OPCENSYS $     2035    -       2035
OPCENNET $     2036    -       2036
OPCENVEN $     2037    -       2037
GERSVHOS $     2038    -       2038
GERSVSYS $     2039    -       2039
GERSVNET $     2040    -       2040
GERSVVEN $     2041    -       2041
HLTHFHOS $     2042    -       2042
HLTHFSYS $     2043    -       2043
HLTHFNET $     2044    -       2044
HLTHFVEN $     2045    -       2045
HLTHCHOS $     2046    -       2046
HLTHCSYS $     2047    -       2047
HLTHCNET $     2048    -       2048
HLTHCVEN $     2049    -       2049
GNTCHOS  $     2050    -       2050
GNTCSYS  $     2051    -       2051
GNTCNET  $     2052    -       2052
GNTCVEN  $     2053    -       2053
HLTHSHOS $     2054    -       2054
HLTHSSYS $     2055    -       2055
HLTHSNET $     2056    -       2056
HLTHSVEN $     2057    -       2057
HLTRHOS  $     2058    -       2058
HLTRSYS  $     2059    -       2059
HLTRNET  $     2060    -       2060
HLTRVEN  $     2061    -       2061
HEMOHOS  $     2062    -       2062
HEMOSYS  $     2063    -       2063
HEMONET  $     2064    -       2064
HEMOVEN  $     2065    -       2065
AIDSSHOS $     2066    -       2066
AIDSSSYS $     2067    -       2067
AIDSSNET $     2068    -       2068
AIDSSVEN $     2069    -       2069
HOMEHHOS $     2070    -       2070
HOMEHSYS $     2071    -       2071
HOMEHNET $     2072    -       2072
HOMEHVEN $     2073    -       2073
HOSPCHOS $     2074    -       2074
HOSPCSYS $     2075    -       2075
HOSPCNET $     2076    -       2076
HOSPCVEN $     2077    -       2077
OPHOSHOS $     2078    -       2078
OPHOSSYS $     2079    -       2079
OPHOSNET $     2080    -       2080
OPHOSVEN $     2081    -       2081
IMPRHOS  $     2082    -       2082
IMPRSYS  $     2083    -       2083
IMPRNET  $     2084    -       2084
IMPRVEN  $     2085    -       2085
ICARHOS  $     2086    -       2086
ICARSYS  $     2087    -       2087
ICARNET  $     2088    -       2088
ICARVEN  $     2089    -       2089
LINGHOS  $     2090    -       2090
LINGSYS  $     2091    -       2091
LINGNET  $     2092    -       2092
LINGVEN  $     2093    -       2093
MEALSHOS $     2094    -       2094
MEALSSYS $     2095    -       2095
MEALSNET $     2096    -       2096
MEALSVEN $     2097    -       2097
MOHSHOS  $     2098    -       2098
MOHSSYS  $     2099    -       2099
MOHSNET  $     2100    -       2100
MOHSVEN  $     2101    -       2101
NEROHOS  $     2102    -       2102
NEROSYS  $     2103    -       2103
NERONET  $     2104    -       2104
NEROVEN  $     2105    -       2105
NUTRPHOS $     2106    -       2106
NUTRPSYS $     2107    -       2107
NUTRPNET $     2108    -       2108
NUTRPVEN $     2109    -       2109
OCCHSHOS $     2110    -       2110
OCCHSSYS $     2111    -       2111
OCCHSNET $     2112    -       2112
OCCHSVEN $     2113    -       2113
ONCOLHOS $     2114    -       2114
ONCOLSYS $     2115    -       2115
ONCOLNET $     2116    -       2116
ONCOLVEN $     2117    -       2117
ORTOHOS  $     2118    -       2118
ORTOSYS  $     2119    -       2119
ORTONET  $     2120    -       2120
ORTOVEN  $     2121    -       2121
OPSRGHOS $     2122    -       2122
OPSRGSYS $     2123    -       2123
OPSRGNET $     2124    -       2124
OPSRGVEN $     2125    -       2125
PAINHOS  $     2126    -       2126
PAINSYS  $     2127    -       2127
PAINNET  $     2128    -       2128
PAINVEN  $     2129    -       2129
PALHOS   $     2130    -       2130
PALSYS   $     2131    -       2131
PALNET   $     2132    -       2132
PALVEN   $     2133    -       2133
IPALHOS  $     2134    -       2134
IPALSYS  $     2135    -       2135
IPALNET  $     2136    -       2136
IPALVEN  $     2137    -       2137
PCAHOS   $     2138    -       2138
PCASYS   $     2139    -       2139
PCANET   $     2140    -       2140
PCAVEN   $     2141    -       2141
PATEDHOS $     2142    -       2142
PATEDSYS $     2143    -       2143
PATEDNET $     2144    -       2144
PATEDVEN $     2145    -       2145
PATRPHOS $     2146    -       2146
PATRPSYS $     2147    -       2147
PATRPNET $     2148    -       2148
PATRPVEN $     2149    -       2149
RASTHOS  $     2150    -       2150
RASTSYS  $     2151    -       2151
RASTNET  $     2152    -       2152
RASTVEN  $     2153    -       2153
REDSHOS  $     2154    -       2154
REDSSYS  $     2155    -       2155
REDSNET  $     2156    -       2156
REDSVEN  $     2157    -       2157
RHBOPHOS $     2158    -       2158
RHBOPSYS $     2159    -       2159
RHBOPNET $     2160    -       2160
RHBOPVEN $     2161    -       2161
RPRSHOS  $     2162    -       2162
RPRSSYS  $     2163    -       2163
RPRSNET  $     2164    -       2164
RPRSVEN  $     2165    -       2165
RBOTHOS  $     2166    -       2166
RBOTSYS  $     2167    -       2167
RBOTNET  $     2168    -       2168
RBOTVEN  $     2169    -       2169
RSIMHOS  $     2170    -       2170
RSIMSYS  $     2171    -       2171
RSIMNET  $     2172    -       2172
RSIMVEN  $     2173    -       2173
PCDEPHOS $     2174    -       2174
PCDEPSYS $     2175    -       2175
PCDEPNET $     2176    -       2176
PCDEPVEN $     2177    -       2177
PSYCAHOS $     2178    -       2178
PSYCASYS $     2179    -       2179
PSYCANET $     2180    -       2180
PSYCAVEN $     2181    -       2181
PSYLSHOS $     2182    -       2182
PSYLSSYS $     2183    -       2183
PSYLSNET $     2184    -       2184
PSYLSVEN $     2185    -       2185
PSYEDHOS $     2186    -       2186
PSYEDSYS $     2187    -       2187
PSYEDNET $     2188    -       2188
PSYEDVEN $     2189    -       2189
PSYEMHOS $     2190    -       2190
PSYEMSYS $     2191    -       2191
PSYEMNET $     2192    -       2192
PSYEMVEN $     2193    -       2193
PSYGRHOS $     2194    -       2194
PSYGRSYS $     2195    -       2195
PSYGRNET $     2196    -       2196
PSYGRVEN $     2197    -       2197
PSYOPHOS $     2198    -       2198
PSYOPSYS $     2199    -       2199
PSYOPNET $     2200    -       2200
PSYOPVEN $     2201    -       2201
PSYPHHOS $     2202    -       2202
PSYPHSYS $     2203    -       2203
PSYPHNET $     2204    -       2204
PSYPHVEN $     2205    -       2205
CTSCNHOS $     2206    -       2206
CTSCNSYS $     2207    -       2207
CTSCNNET $     2208    -       2208
CTSCNVEN $     2209    -       2209
DRADFHOS $     2210    -       2210
DRADFSYS $     2211    -       2211
DRADFNET $     2212    -       2212
DRADFVEN $     2213    -       2213
EBCTHOS  $     2214    -       2214
EBCTSYS  $     2215    -       2215
EBCTNET  $     2216    -       2216
EBCTVEN  $     2217    -       2217
FFDMHOS  $     2218    -       2218
FFDMSYS  $     2219    -       2219
FFDMNET  $     2220    -       2220
FFDMVEN  $     2221    -       2221
MRIHOS   $     2222    -       2222
MRISYS   $     2223    -       2223
MRINET   $     2224    -       2224
MRIVEN   $     2225    -       2225
IMRIHOS  $     2226    -       2226
IMRISYS  $     2227    -       2227
IMRINET  $     2228    -       2228
IMRIVEN  $     2229    -       2229
MSCTHOS  $     2230    -       2230
MSCTSYS  $     2231    -       2231
MSCTNET  $     2232    -       2232
MSCTVEN  $     2233    -       2233
MSCTGHOS $     2234    -       2234
MSCTGSYS $     2235    -       2235
MSCTGNET $     2236    -       2236
MSCTGVEN $     2237    -       2237
PETHOS   $     2238    -       2238
PETSYS   $     2239    -       2239
PETNET   $     2240    -       2240
PETVEN   $     2241    -       2241
PETCTHOS $     2242    -       2242
PETCTSYS $     2243    -       2243
PETCTNET $     2244    -       2244
PETCTVEN $     2245    -       2245
SPECTHOS $     2246    -       2246
SPECTSYS $     2247    -       2247
SPECTNET $     2248    -       2248
SPECTVEN $     2249    -       2249
ULTSNHOS $     2250    -       2250
ULTSNSYS $     2251    -       2251
ULTSNNET $     2252    -       2252
ULTSNVEN $     2253    -       2253
IGRTHOS  $     2254    -       2254
IGRTSYS  $     2255    -       2255
IGRTNET  $     2256    -       2256
IGRTVEN  $     2257    -       2257
IMRTHOS  $     2258    -       2258
IMRTSYS  $     2259    -       2259
IMRTNET  $     2260    -       2260
IMRTVEN  $     2261    -       2261
PTONHOS  $     2262    -       2262
PTONSYS  $     2263    -       2263
PTONNET  $     2264    -       2264
PTONVEN  $     2265    -       2265
BEAMHOS  $     2266    -       2266
BEAMSYS  $     2267    -       2267
BEAMNET  $     2268    -       2268
BEAMVEN  $     2269    -       2269
SRADHOS  $     2270    -       2270
SRADSYS  $     2271    -       2271
SRADNET  $     2272    -       2272
SRADVEN  $     2273    -       2273
RETIRHOS $     2274    -       2274
RETIRSYS $     2275    -       2275
RETIRNET $     2276    -       2276
RETIRVEN $     2277    -       2277
ROBOHOS  $     2278    -       2278
ROBOSYS  $     2279    -       2279
ROBONET  $     2280    -       2280
ROBOVEN  $     2281    -       2281
RURLHOS  $     2282    -       2282
RURLSYS  $     2283    -       2283
RURLNET  $     2284    -       2284
RURLVEN  $     2285    -       2285
SLEPHOS  $     2286    -       2286
SLEPSYS  $     2287    -       2287
SLEPNET  $     2288    -       2288
SLEPVEN  $     2289    -       2289
SOCWKHOS $     2290    -       2290
SOCWKSYS $     2291    -       2291
SOCWKNET $     2292    -       2292
SOCWKVEN $     2293    -       2293
SPORTHOS $     2294    -       2294
SPORTSYS $     2295    -       2295
SPORTNET $     2296    -       2296
SPORTVEN $     2297    -       2297
SUPPGHOS $     2298    -       2298
SUPPGSYS $     2299    -       2299
SUPPGNET $     2300    -       2300
SUPPGVEN $     2301    -       2301
SWBDHOS  $     2302    -       2302
SWBDSYS  $     2303    -       2303
SWBDNET  $     2304    -       2304
SWBDVEN  $     2305    -       2305
TEENSHOS $     2306    -       2306
TEENSSYS $     2307    -       2307
TEENSNET $     2308    -       2308
TEENSVEN $     2309    -       2309
TOBHOS   $     2310    -       2310
TOBSYS   $     2311    -       2311
TOBNET   $     2312    -       2312
TOBVEN   $     2313    -       2313
OTBONHOS $     2314    -       2314
OTBONSYS $     2315    -       2315
OTBONNET $     2316    -       2316
OTBONVEN $     2317    -       2317
HARTHOS  $     2318    -       2318
HARTSYS  $     2319    -       2319
HARTNET  $     2320    -       2320
HARTVEN  $     2321    -       2321
KDNYHOS  $     2322    -       2322
KDNYSYS  $     2323    -       2323
KDNYNET  $     2324    -       2324
KDNYVEN  $     2325    -       2325
LIVRHOS  $     2326    -       2326
LIVRSYS  $     2327    -       2327
LIVRNET  $     2328    -       2328
LIVRVEN  $     2329    -       2329
LUNGHOS  $     2330    -       2330
LUNGSYS  $     2331    -       2331
LUNGNET  $     2332    -       2332
LUNGVEN  $     2333    -       2333
TISUHOS  $     2334    -       2334
TISUSYS  $     2335    -       2335
TISUNET  $     2336    -       2336
TISUVEN  $     2337    -       2337
OTOTHHOS $     2338    -       2338
OTOTHSYS $     2339    -       2339
OTOTHNET $     2340    -       2340
OTOTHVEN $     2341    -       2341
TPORTHOS $     2342    -       2342
TPORTSYS $     2343    -       2343
TPORTNET $     2344    -       2344
TPORTVEN $     2345    -       2345
URGCCHOS $     2346    -       2346
URGCCSYS $     2347    -       2347
URGCCNET $     2348    -       2348
URGCCVEN $     2349    -       2349
VRCSHOS  $     2350    -       2350
VRCSSYS  $     2351    -       2351
VRCSNET  $     2352    -       2352
VRCSVEN  $     2353    -       2353
VOLSVHOS $     2354    -       2354
VOLSVSYS $     2355    -       2355
VOLSVNET $     2356    -       2356
VOLSVVEN $     2357    -       2357
WOMHCHOS $     2358    -       2358
WOMHCSYS $     2359    -       2359
WOMHCNET $     2360    -       2360
WOMHCVEN $     2361    -       2361
WMGTHOS  $     2362    -       2362
WMGTSYS  $     2363    -       2363
WMGTNET  $     2364    -       2364
WMGTVEN  $     2365    -       2365
EXPTOT         2366    -       2375
EXPTHA         2376    -       2390
EXPTLA         2391    -       2405
CPPCT          2406    -       2409
CAPRSK         2410    -       2413
DPEXA          2414    -       2423
INTEXA         2424    -       2433
SUPEXA         2434    -       2443
NPAYBEN        2444    -       2453
PAYTOT         2454    -       2463
PAYTOTH        2464    -       2473
NPAYBENH       2474    -       2483
PAYTOTLT       2484    -       2493
NPAYBENL       2494    -       2503
LBEDSA         2504    -       2509
BDTOT          2510    -       2513
ADMTOT         2514    -       2519
IPDTOT         2520    -       2527
BDH            2528    -       2531
ADMH           2532    -       2537
IPDH           2538    -       2545
LBEDLA         2546    -       2551
BDLT           2552    -       2555
ADMLT          2556    -       2561
IPDLT          2562    -       2569
MCRDC          2570    -       2575
MCRIPD         2576    -       2583
MCDDC          2584    -       2589
MCDIPD         2590    -       2597
MCRDCH         2598    -       2603
MCRIPDH        2604    -       2611
MCDDCH         2612    -       2617
MCDIPDH        2618    -       2625
MCRDCLT        2626    -       2631
MCRIPDLT       2632    -       2639
MCDDCLT        2640    -       2645
MCDIPDLT       2646    -       2653
BASSIN         2654    -       2657
BIRTHS         2658    -       2663
SUROPIP        2664    -       2669
SUROPOP        2670    -       2675
SUROPTOT       2676    -       2681
VEM            2682    -       2689
VOTH           2690    -       2697
VTOT           2698    -       2705
FTMDTF         2706    -       2710
FTRES          2711    -       2715
FTTRAN84       2716    -       2720
FTRNTF         2721    -       2725
FTLPNTF        2726    -       2730
FTAST          2731    -       2735
FTRAD          2736    -       2740
FTLAB          2741    -       2745
FTPHR          2746    -       2750
FTPHT          2751    -       2755
FTRESP         2756    -       2760
FTOTHTF        2761    -       2765
FTTOT          2766    -       2770
PTMDTF         2771    -       2775
PTRES          2776    -       2780
PTTRAN84       2781    -       2785
PTRNTF         2786    -       2790
PTLPNTF        2791    -       2795
PTAST          2796    -       2800
PTRAD          2801    -       2805
PTLAB          2806    -       2810
PTPHR          2811    -       2815
PTPHT          2816    -       2820
PTRESP         2821    -       2825
PTOTHTF        2826    -       2830
PTTOT          2831    -       2835
FTTOTH         2836    -       2840
PTTOTH         2841    -       2845
FTTOTLT        2846    -       2850
PTTOTLT        2851    -       2855
FTED           2856    -       2863
FTER           2864    -       2871
FTET           2872    -       2879
FTEN           2880    -       2887
FTEP           2888    -       2895
FTEAP          2896    -       2903
FTERAD         2904    -       2911
FTELAB         2912    -       2919
FTEPH          2920    -       2927
FTEPHT         2928    -       2935
FTERESP        2936    -       2943
FTEO           2944    -       2951
FTETF          2952    -       2959
FTERNLT        2960    -       2967
FTEU           2968    -       2975
VMD            2976    -       2983
VRES           2984    -       2991
VTTRN          2992    -       2999
VRN            3000    -       3007
VLPN           3008    -       3015
VAST           3016    -       3023
VRAD           3024    -       3031
VLAB           3032    -       3039
VPHR           3040    -       3047
VPHT           3048    -       3055
VRSP           3056    -       3063
VOTHL          3064    -       3071
VTOTL          3072    -       3079
VRNH           3080    -       3087
VTNH           3088    -       3095
ADC            3096    -       3103
ADJADM         3104    -       3111
ADJPD          3112    -       3119
ADJADC         3120    -       3127
FTEMD          3128    -       3135
FTERN          3136    -       3143
FTELPN         3144    -       3151
FTERES         3152    -       3159
FTETRAN        3160    -       3167
FTETTRN        3168    -       3175
FTEOTH94       3176    -       3183
FTEH           3184    -       3191
FTENH          3192    -       3199
FTE            3200    -       3207
OPRA           3208    -       3211
EADMTOT  $     3212    -       3212
EIPDTOT  $     3213    -       3213
EADMH    $     3214    -       3214
EIPDH    $     3215    -       3215
EADMLT   $     3216    -       3216
EIPDLT   $     3217    -       3217
EMCRDC   $     3218    -       3218
EMCRIPD  $     3219    -       3219
EMCDDC   $     3220    -       3220
EMCDIPD  $     3221    -       3221
EMCRDCH  $     3222    -       3222
EMCRIPDH $     3223    -       3223
EMCDDCH  $     3224    -       3224
EMCDIPDH $     3225    -       3225
EMCRDCLT $     3226    -       3226
EMCRPDLT $     3227    -       3227
EMCDDCLT $     3228    -       3228
EMCDPDLT $     3229    -       3229
EBIRTHS  $     3230    -       3230
ESUROPIP $     3231    -       3231
ESUROPOP $     3232    -       3232
ESUROPTO $     3233    -       3233
EVEM     $     3234    -       3234
EVOTH    $     3235    -       3235
EVTOT    $     3236    -       3236
EPAYTOT  $     3237    -       3237
ENPAYBEN $     3238    -       3238
EPAYTOTH $     3239    -       3239
ENPYBENH $     3240    -       3240
EPYTOTLT $     3241    -       3241
ENPBENLT $     3242    -       3242
EFTMDTF  $     3243    -       3243
EFTRES   $     3244    -       3244
EFTTRN84 $     3245    -       3245
EFTRNTF  $     3246    -       3246
EFTLPNTF $     3247    -       3247
EFTAST   $     3248    -       3248
EFTRAD   $     3249    -       3249
EFTLAB   $     3250    -       3250
EFTPHR   $     3251    -       3251
EFTPHT   $     3252    -       3252
EFTRESP  $     3253    -       3253
EFTOTHTF $     3254    -       3254
EFTTOT   $     3255    -       3255
EPTMDTF  $     3256    -       3256
EPTRES   $     3257    -       3257
EPTTRN84 $     3258    -       3258
EPTRNTF  $     3259    -       3259
EPTLPNTF $     3260    -       3260
EPTAST   $     3261    -       3261
EPTRAD   $     3262    -       3262
EPTLAB   $     3263    -       3263
EPTPHR   $     3264    -       3264
EPTPHT   $     3265    -       3265
EPTRESP  $     3266    -       3266
EPTOTHTF $     3267    -       3267
EPTTOT   $     3268    -       3268
EFTTOTH  $     3269    -       3269
EPTTOTH  $     3270    -       3270
EFTTOTLT $     3271    -       3271
EPTTOTLT $     3272    -       3272
EEXPTOT  $     3273    -       3273
EXPTHB   $     3274    -       3274
EXPTLB   $     3275    -       3275
TECAR          3276    -       3283
TEMER          3284    -       3291
TEHSP          3292    -       3299

;
;	
RUN;	
proc contents data=annual2010_1;run;				

DATA ANNUAL2010_2;

INfile 'X:\AHA\AHAAS Raw Data\FY2010 ASDB\FLAT\pubas10.asc' lrecl=3720 recfm=f;				

INPUT
@0001   ID             $7.
TEINT          3300    -       3307
TEGST          3308    -       3315
TEOTH          3316    -       3323
TETOT          3324    -       3331
TCCAR          3332    -       3339
TCMER          3340    -       3347
TCHSP          3348    -       3355
TCINT          3356    -       3363
TCGST          3364    -       3371
TCOTH          3372    -       3379
TCTOT          3380    -       3387
TGCAR          3388    -       3395
TGMER          3396    -       3403
TGHSP          3404    -       3411
TGINT          3412    -       3419
TGGST          3420    -       3427
TGOTH          3428    -       3435
TGTOT          3436    -       3443
NECAR          3444    -       3451
NEMER          3452    -       3459
NEHSP          3460    -       3467
NEINT          3468    -       3475
NEGST          3476    -       3483
NEOTH          3484    -       3491
NETOT          3492    -       3499
TPCAR          3500    -       3507
TPMER          3508    -       3515
TPHSP          3516    -       3523
TPINT          3524    -       3531
TPGST          3532    -       3539
TPOTH          3540    -       3547
TPRTOT         3548    -       3555
HSPTL    $     3556    -       3556
FTEHSP         3557    -       3564
INTCAR   $     3565    -       3565
FTEMSI         3566    -       3573
FTECIC         3574    -       3581
FTENIC         3582    -       3589
FTEPIC         3590    -       3597
FTEOIC         3598    -       3605
FTEINT         3606    -       3613
CLSMSI   $     3614    -       3614
CLSCIC   $     3615    -       3615
CLSNIC   $     3616    -       3616
CLSPIC   $     3617    -       3617
CLSOIC   $     3618    -       3618
CLSINT   $     3619    -       3619
APRN     $     3620    -       3620
FTAPRN         3621    -       3628
PTAPRN         3629    -       3636
FTEAPN         3637    -       3644
APCAR    $     3645    -       3645
APANES   $     3646    -       3646
APEMER   $     3647    -       3647
APSPC    $     3648    -       3648
APED     $     3649    -       3649
APCASE   $     3650    -       3650
APOTH    $     3651    -       3651
FORNRSA  $     3652    -       3652
AFRICA   $     3653    -       3653
KOREA    $     3654    -       3654
CANADA   $     3655    -       3655
PH       $     3656    -       3656
CHINA    $     3657    -       3657
INDIA    $     3658    -       3658
OFRNRS   $     3659    -       3659
PLNTA          3660    -       3669
ADEPRA         3670    -       3679
ASSNET         3680    -       3689
GFEET          3690    -       3699
CEAMT          3700    -       3709
MMBTU          3710    -       3715
MMBTR          3716    -       3718
EHLTH    $     3719    -       3719
ENDMARK  $     3720    -       3720
;
;	
RUN;			
proc contents data=annual2010_2;run;


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.annual2010_1 
like work.annual2010_1;

proc SQL;
insert into isilon.annual2010_1
select * from work.annual2010_1;

proc SQL;
create table isilon.annual2010_2 
like work.annual2010_2;

proc SQL;
insert into isilon.annual2010_2
select * from work.annual2010_2;

*Create the all table by combining all the columns from table 1 and 2.;
*because of SQL limitations, make the variables after the 1000 variable sparse (other than the last one);
PROC SQL;
CONNECT using isilon;
EXECUTE(
CREATE TABLE [AHA].[annual2010](
	[ID] [varchar](7) NULL,
	[REG] [varchar](1) NULL,
	[STCD] [varchar](2) NULL,
	[HOSPN] [varchar](4) NULL,
	[DTBEG] [varchar](10) NULL,
	[DBEGM] [varchar](2) NULL,
	[DBEGD] [varchar](2) NULL,
	[DBEGY] [varchar](4) NULL,
	[DTEND] [varchar](10) NULL,
	[DENDM] [varchar](2) NULL,
	[DENDD] [varchar](2) NULL,
	[DENDY] [varchar](4) NULL,
	[DCOV] [float] NULL,
	[FYR] [float] NULL,
	[FISYR] [varchar](10) NULL,
	[FISM] [varchar](2) NULL,
	[FISD] [varchar](2) NULL,
	[FISY] [varchar](4) NULL,
	[CNTRL] [varchar](2) NULL,
	[SERV] [varchar](2) NULL,
	[SERVOTH] [varchar](30) NULL,
	[RADMCHI] [varchar](1) NULL,
	[HSACODE] [varchar](5) NULL,
	[HSANAME] [varchar](25) NULL,
	[HRRCODE] [varchar](3) NULL,
	[HRRNAME] [varchar](25) NULL,
	[MTYPE] [varchar](2) NULL,
	[MLOS] [varchar](1) NULL,
	[MNAME] [varchar](90) NULL,
	[MADMIN] [varchar](92) NULL,
	[MLOCADDR] [varchar](60) NULL,
	[MLOCCITY] [varchar](20) NULL,
	[MLOCSTCD] [varchar](2) NULL,
	[MLOCZIP] [varchar](10) NULL,
	[MSTATE] [varchar](2) NULL,
	[AREA] [varchar](3) NULL,
	[TELNO] [varchar](7) NULL,
	[RESP] [varchar](1) NULL,
	[CHC] [varchar](1) NULL,
	[BSC] [varchar](1) NULL,
	[MHSMEMB] [varchar](1) NULL,
	[SUBS] [varchar](1) NULL,
	[MNGT] [varchar](1) NULL,
	[MNGTNAME] [varchar](60) NULL,
	[MNGTCITY] [varchar](20) NULL,
	[MNGTSTCD] [varchar](2) NULL,
	[NETWRK] [varchar](1) NULL,
	[NETNAME] [varchar](60) NULL,
	[NETCT] [varchar](30) NULL,
	[NETSC] [varchar](2) NULL,
	[NETPHONE] [varchar](10) NULL,
	[GROUP] [varchar](1) NULL,
	[GPONAME] [varchar](80) NULL,
	[GPOCITY] [varchar](20) NULL,
	[GPOST] [varchar](2) NULL,
	[SUPLY] [varchar](1) NULL,
	[SUPNM] [varchar](60) NULL,
	[PHYGP] [varchar](1) NULL,
	[LTCHF] [varchar](1) NULL,
	[LTCHC] [varchar](1) NULL,
	[LTNM] [varchar](30) NULL,
	[LTCT] [varchar](20) NULL,
	[LTST] [varchar](2) NULL,
	[NPI] [varchar](1) NULL,
	[NPINUM] [varchar](10) NULL,
	[CLUSTER] [varchar](1) NULL,
	[SYSID] [varchar](4) NULL,
	[SYSNAME] [varchar](85) NULL,
	[SYSADDR] [varchar](45) NULL,
	[SYSCITY] [varchar](20) NULL,
	[SYSST] [varchar](2) NULL,
	[SYSZIP] [varchar](10) NULL,
	[SYSAREA] [varchar](3) NULL,
	[SYSTELN] [varchar](8) NULL,
	[SPC] [varchar](30) NULL,
	[SYSTITLE] [varchar](80) NULL,
	[COMMTY] [varchar](1) NULL,
	[MCRNUM] [varchar](6) NULL,
	[LAT] [float] NULL,
	[LONG] [float] NULL,
	[CNTYNAME] [varchar](45) NULL,
	[CBSANAME] [varchar](60) NULL,
	[CBSATYPE] [varchar](8) NULL,
	[LOS] [varchar](1) NULL,
	[CBSACODE] [varchar](5) NULL,
	[MCNTYCD] [varchar](3) NULL,
	[FCOUNTY] [varchar](5) NULL,
	[FSTCD] [varchar](2) NULL,
	[FCNTYCD] [varchar](3) NULL,
	[CITYRK] [varchar](3) NULL,
	[MAPP1] [varchar](1) NULL,
	[MAPP2] [varchar](1) NULL,
	[MAPP3] [varchar](1) NULL,
	[MAPP5] [varchar](1) NULL,
	[MAPP6] [varchar](1) NULL,
	[MAPP7] [varchar](1) NULL,
	[MAPP8] [varchar](1) NULL,
	[MAPP9] [varchar](1) NULL,
	[MAPP10] [varchar](1) NULL,
	[MAPP11] [varchar](1) NULL,
	[MAPP12] [varchar](1) NULL,
	[MAPP13] [varchar](1) NULL,
	[MAPP16] [varchar](1) NULL,
	[MAPP18] [varchar](1) NULL,
	[MAPP19] [varchar](1) NULL,
	[MAPP20] [varchar](1) NULL,
	[MAPP21] [varchar](1) NULL,
	[AHAMBR] [varchar](1) NULL,
	[MISSION] [varchar](1) NULL,
	[LTPLAN] [varchar](1) NULL,
	[RESOURCE] [varchar](1) NULL,
	[BENEFIT] [varchar](1) NULL,
	[BUILD] [varchar](1) NULL,
	[FUND] [varchar](1) NULL,
	[HWELL] [varchar](1) NULL,
	[HSASSESS] [varchar](1) NULL,
	[HSIND] [varchar](1) NULL,
	[CAPASS] [varchar](1) NULL,
	[ASSUSE] [varchar](1) NULL,
	[CTRACK] [varchar](1) NULL,
	[QUALREP] [varchar](1) NULL,
	[GRACE] [varchar](1) NULL,
	[GLANG] [varchar](1) NULL,
	[ILEAD] [varchar](1) NULL,
	[DIVERS] [varchar](1) NULL,
	[ELEADS] [varchar](1) NULL,
	[DEVADM] [varchar](1) NULL,
	[SNT] [varchar](1) NULL,
	[TRIAGE] [varchar](1) NULL,
	[TRGOTH] [varchar](50) NULL,
	[SUNITS] [varchar](1) NULL,
	[IPAHOS] [varchar](1) NULL,
	[IPASYS] [varchar](1) NULL,
	[IPANET] [varchar](1) NULL,
	[GPWWHOS] [varchar](1) NULL,
	[GPWWSYS] [varchar](1) NULL,
	[GPWWNET] [varchar](1) NULL,
	[OPHOHOS] [varchar](1) NULL,
	[OPHOSYS] [varchar](1) NULL,
	[OPHONET] [varchar](1) NULL,
	[CPHOHOS] [varchar](1) NULL,
	[CPHOSYS] [varchar](1) NULL,
	[CPHONET] [varchar](1) NULL,
	[MSOHOS] [varchar](1) NULL,
	[MSOSYS] [varchar](1) NULL,
	[MSONET] [varchar](1) NULL,
	[ISMHOS] [varchar](1) NULL,
	[ISMSYS] [varchar](1) NULL,
	[ISMNET] [varchar](1) NULL,
	[EQMODHOS] [varchar](1) NULL,
	[EQMODSYS] [varchar](1) NULL,
	[EQMODNET] [varchar](1) NULL,
	[FOUNDHOS] [varchar](1) NULL,
	[FOUNDSYS] [varchar](1) NULL,
	[FOUNDNET] [varchar](1) NULL,
	[PHYOTH] [varchar](50) NULL,
	[PHYHOS] [varchar](1) NULL,
	[PHYSYS] [varchar](1) NULL,
	[PHYNET] [varchar](1) NULL,
	[IPHMOHOS] [varchar](1) NULL,
	[IPHMOSYS] [varchar](1) NULL,
	[IPHMONET] [varchar](1) NULL,
	[IPHMOVEN] [varchar](1) NULL,
	[IPPPOHOS] [varchar](1) NULL,
	[IPPPOSYS] [varchar](1) NULL,
	[IPPPONET] [varchar](1) NULL,
	[IPPPOVEN] [varchar](1) NULL,
	[IPFEEHOS] [varchar](1) NULL,
	[IPFEESYS] [varchar](1) NULL,
	[IPFEENET] [varchar](1) NULL,
	[IPFEEVEN] [varchar](1) NULL,
	[HMO86] [varchar](1) NULL,
	[HMOCON] [float] NULL,
	[PPO86] [varchar](1) NULL,
	[PPOCON] [float] NULL,
	[CAPCON94] [varchar](1) NULL,
	[CAPCOV] [float] NULL,
	[IPAP] [float] NULL,
	[GPWP] [float] NULL,
	[OPHP] [float] NULL,
	[CPHP] [float] NULL,
	[MSOP] [float] NULL,
	[ISMP] [float] NULL,
	[EQMP] [float] NULL,
	[FNDP] [float] NULL,
	[PHYP] [float] NULL,
	[FTMT] [float] NULL,
	[JNTPH] [varchar](1) NULL,
	[JNLS] [varchar](1) NULL,
	[JNTAMB] [varchar](1) NULL,
	[JNTCTR] [varchar](1) NULL,
	[JNTOTH] [varchar](1) NULL,
	[LSHTXT] [varchar](50) NULL,
	[JNTLSC] [varchar](1) NULL,
	[JNTLSO] [varchar](1) NULL,
	[JNTLSS] [varchar](1) NULL,
	[JNTLST] [varchar](1) NULL,
	[JNTTXT] [varchar](50) NULL,
	[JNTMD] [varchar](1) NULL,
	[GENBD] [float] NULL,
	[PEDBD] [float] NULL,
	[OBBD] [float] NULL,
	[MSICBD] [float] NULL,
	[CICBD] [float] NULL,
	[NICBD] [float] NULL,
	[NINTBD] [float] NULL,
	[PEDICBD] [float] NULL,
	[BRNBD] [float] NULL,
	[OTHICBD] [float] NULL,
	[SPCICBD] [float] NULL,
	[REHABBD] [float] NULL,
	[ALCHBD] [float] NULL,
	[PSYBD] [float] NULL,
	[SNBD88] [float] NULL,
	[ICFBD88] [float] NULL,
	[ACULTBD] [float] NULL,
	[OTHLBD94] [float] NULL,
	[OTHBD94] [float] NULL,
	[HOSPBD] [float] NULL,
	[OBLEV] [varchar](1) NULL,
	[GENHOS] [varchar](1) NULL,
	[GENSYS] [varchar](1) NULL,
	[GENNET] [varchar](1) NULL,
	[GENVEN] [varchar](1) NULL,
	[PEDHOS] [varchar](1) NULL,
	[PEDSYS] [varchar](1) NULL,
	[PEDNET] [varchar](1) NULL,
	[PEDVEN] [varchar](1) NULL,
	[OBHOS] [varchar](1) NULL,
	[OBSYS] [varchar](1) NULL,
	[OBNET] [varchar](1) NULL,
	[OBVEN] [varchar](1) NULL,
	[MSICHOS] [varchar](1) NULL,
	[MSICSYS] [varchar](1) NULL,
	[MSICNET] [varchar](1) NULL,
	[MSICVEN] [varchar](1) NULL,
	[CICHOS] [varchar](1) NULL,
	[CICSYS] [varchar](1) NULL,
	[CICNET] [varchar](1) NULL,
	[CICVEN] [varchar](1) NULL,
	[NICHOS] [varchar](1) NULL,
	[NICSYS] [varchar](1) NULL,
	[NICNET] [varchar](1) NULL,
	[NICVEN] [varchar](1) NULL,
	[NINTHOS] [varchar](1) NULL,
	[NINTSYS] [varchar](1) NULL,
	[NINTNET] [varchar](1) NULL,
	[NINTVEN] [varchar](1) NULL,
	[PEDICHOS] [varchar](1) NULL,
	[PEDICSYS] [varchar](1) NULL,
	[PEDICNET] [varchar](1) NULL,
	[PEDICVEN] [varchar](1) NULL,
	[BRNHOS] [varchar](1) NULL,
	[BRNSYS] [varchar](1) NULL,
	[BRNNET] [varchar](1) NULL,
	[BRNVEN] [varchar](1) NULL,
	[SPCICHOS] [varchar](1) NULL,
	[SPCICSYS] [varchar](1) NULL,
	[SPCICNET] [varchar](1) NULL,
	[SPCICVEN] [varchar](1) NULL,
	[OTHIHOS] [varchar](1) NULL,
	[OTHISYS] [varchar](1) NULL,
	[OTHINET] [varchar](1) NULL,
	[OTHIVEN] [varchar](1) NULL,
	[REHABHOS] [varchar](1) NULL,
	[REHABSYS] [varchar](1) NULL,
	[REHABNET] [varchar](1) NULL,
	[REHABVEN] [varchar](1) NULL,
	[ALCHHOS] [varchar](1) NULL,
	[ALCHSYS] [varchar](1) NULL,
	[ALCHNET] [varchar](1) NULL,
	[ALCHVEN] [varchar](1) NULL,
	[PSYHOS] [varchar](1) NULL,
	[PSYSYS] [varchar](1) NULL,
	[PSYNET] [varchar](1) NULL,
	[PSYVEN] [varchar](1) NULL,
	[SNHOS] [varchar](1) NULL,
	[SNSYS] [varchar](1) NULL,
	[SNNET] [varchar](1) NULL,
	[SNVEN] [varchar](1) NULL,
	[ICFHOS] [varchar](1) NULL,
	[ICFSYS] [varchar](1) NULL,
	[ICFNET] [varchar](1) NULL,
	[ICFVEN] [varchar](1) NULL,
	[ACUHOS] [varchar](1) NULL,
	[ACUSYS] [varchar](1) NULL,
	[ACUNET] [varchar](1) NULL,
	[ACUVEN] [varchar](1) NULL,
	[OTHLTHOS] [varchar](1) NULL,
	[OTHLTSYS] [varchar](1) NULL,
	[OTHLTNET] [varchar](1) NULL,
	[OTHLTVEN] [varchar](1) NULL,
	[OTHCRHOS] [varchar](1) NULL,
	[OTHCRSYS] [varchar](1) NULL,
	[OTHCRNET] [varchar](1) NULL,
	[OTHCRVEN] [varchar](1) NULL,
	[ADULTHOS] [varchar](1) NULL,
	[ADULTSYS] [varchar](1) NULL,
	[ADULTNET] [varchar](1) NULL,
	[ADULTVEN] [varchar](1) NULL,
	[AIRBHOS] [varchar](1) NULL,
	[AIRBSYS] [varchar](1) NULL,
	[AIRBNET] [varchar](1) NULL,
	[AIRBVEN] [varchar](1) NULL,
	[AIRBROOM] [float] NULL,
	[ALCOPHOS] [varchar](1) NULL,
	[ALCOPSYS] [varchar](1) NULL,
	[ALCOPNET] [varchar](1) NULL,
	[ALCOPVEN] [varchar](1) NULL,
	[ALZHOS] [varchar](1) NULL,
	[ALZSYS] [varchar](1) NULL,
	[ALZNET] [varchar](1) NULL,
	[ALZVEN] [varchar](1) NULL,
	[AMBHOS] [varchar](1) NULL,
	[AMBSYS] [varchar](1) NULL,
	[AMBNET] [varchar](1) NULL,
	[AMBVEN] [varchar](1) NULL,
	[AMBSHOS] [varchar](1) NULL,
	[AMBSSYS] [varchar](1) NULL,
	[AMBSNET] [varchar](1) NULL,
	[AMBSVEN] [varchar](1) NULL,
	[ARTHCHOS] [varchar](1) NULL,
	[ARTHCSYS] [varchar](1) NULL,
	[ARTHCNET] [varchar](1) NULL,
	[ARTHCVEN] [varchar](1) NULL,
	[ASSTLHOS] [varchar](1) NULL,
	[ASSTLSYS] [varchar](1) NULL,
	[ASSTLNET] [varchar](1) NULL,
	[ASSTLVEN] [varchar](1) NULL,
	[AUXHOS] [varchar](1) NULL,
	[AUXSYS] [varchar](1) NULL,
	[AUXNET] [varchar](1) NULL,
	[AUXVEN] [varchar](1) NULL,
	[BWHTHOS] [varchar](1) NULL,
	[BWHTSYS] [varchar](1) NULL,
	[BWHTNET] [varchar](1) NULL,
	[BWHTVEN] [varchar](1) NULL,
	[BROOMHOS] [varchar](1) NULL,
	[BROOMSYS] [varchar](1) NULL,
	[BROOMNET] [varchar](1) NULL,
	[BROOMVEN] [varchar](1) NULL,
	[BLDOHOS] [varchar](1) NULL,
	[BLDOSYS] [varchar](1) NULL,
	[BLDONET] [varchar](1) NULL,
	[BLDOVEN] [varchar](1) NULL,
	[MAMMSHOS] [varchar](1) NULL,
	[MAMMSSYS] [varchar](1) NULL,
	[MAMMSNET] [varchar](1) NULL,
	[MAMMSVEN] [varchar](1) NULL,
	[ACARDHOS] [varchar](1) NULL,
	[ACARDSYS] [varchar](1) NULL,
	[ACARDNET] [varchar](1) NULL,
	[ACARDVEN] [varchar](1) NULL,
	[PCARDHOS] [varchar](1) NULL,
	[PCARDSYS] [varchar](1) NULL,
	[PCARDNET] [varchar](1) NULL,
	[PCARDVEN] [varchar](1) NULL,
	[ACLABHOS] [varchar](1) NULL,
	[ACLABSYS] [varchar](1) NULL,
	[ACLABNET] [varchar](1) NULL,
	[ACLABVEN] [varchar](1) NULL,
	[PCLABHOS] [varchar](1) NULL,
	[PCLABSYS] [varchar](1) NULL,
	[PCLABNET] [varchar](1) NULL,
	[PCLABVEN] [varchar](1) NULL,
	[ICLABHOS] [varchar](1) NULL,
	[ICLABSYS] [varchar](1) NULL,
	[ICLABNET] [varchar](1) NULL,
	[ICLABVEN] [varchar](1) NULL,
	[PELABHOS] [varchar](1) NULL,
	[PELABSYS] [varchar](1) NULL,
	[PELABNET] [varchar](1) NULL,
	[PELABVEN] [varchar](1) NULL,
	[ADTCHOS] [varchar](1) NULL,
	[ADTCSYS] [varchar](1) NULL,
	[ADTCNET] [varchar](1) NULL,
	[ADTCVEN] [varchar](1) NULL,
	[PEDCSHOS] [varchar](1) NULL,
	[PEDCSSYS] [varchar](1) NULL,
	[PEDCSNET] [varchar](1) NULL,
	[PEDCSVEN] [varchar](1) NULL,
	[ADTEHOS] [varchar](1) NULL,
	[ADTESYS] [varchar](1) NULL,
	[ADTENET] [varchar](1) NULL,
	[ADTEVEN] [varchar](1) NULL,
	[PEDEHOS] [varchar](1) NULL,
	[PEDESYS] [varchar](1) NULL,
	[PEDENET] [varchar](1) NULL,
	[PEDEVEN] [varchar](1) NULL,
	[CHABHOS] [varchar](1) NULL,
	[CHABSYS] [varchar](1) NULL,
	[CHABNET] [varchar](1) NULL,
	[CHABVEN] [varchar](1) NULL,
	[CMNGTHOS] [varchar](1) NULL,
	[CMNGTSYS] [varchar](1) NULL,
	[CMNGTNET] [varchar](1) NULL,
	[CMNGTVEN] [varchar](1) NULL,
	[CHAPHOS] [varchar](1) NULL,
	[CHAPSYS] [varchar](1) NULL,
	[CHAPNET] [varchar](1) NULL,
	[CHAPVEN] [varchar](1) NULL,
	[CHTHHOS] [varchar](1) NULL,
	[CHTHSYS] [varchar](1) NULL,
	[CHTHNET] [varchar](1) NULL,
	[CHTHVEN] [varchar](1) NULL,
	[CWELLHOS] [varchar](1) NULL,
	[CWELLSYS] [varchar](1) NULL,
	[CWELLNET] [varchar](1) NULL,
	[CWELLVEN] [varchar](1) NULL,
	[CHIHOS] [varchar](1) NULL,
	[CHISYS] [varchar](1) NULL,
	[CHINET] [varchar](1) NULL,
	[CHIVEN] [varchar](1) NULL,
	[COUTRHOS] [varchar](1) NULL,
	[COUTRSYS] [varchar](1) NULL,
	[COUTRNET] [varchar](1) NULL,
	[COUTRVEN] [varchar](1) NULL,
	[COMPHOS] [varchar](1) NULL,
	[COMPSYS] [varchar](1) NULL,
	[COMPNET] [varchar](1) NULL,
	[COMPVEN] [varchar](1) NULL,
	[CAOSHOS] [varchar](1) NULL,
	[CAOSSYS] [varchar](1) NULL,
	[CAOSNET] [varchar](1) NULL,
	[CAOSVEN] [varchar](1) NULL,
	[CPREVHOS] [varchar](1) NULL,
	[CPREVSYS] [varchar](1) NULL,
	[CPREVNET] [varchar](1) NULL,
	[CPREVVEN] [varchar](1) NULL,
	[DENTSHOS] [varchar](1) NULL,
	[DENTSSYS] [varchar](1) NULL,
	[DENTSNET] [varchar](1) NULL,
	[DENTSVEN] [varchar](1) NULL,
	[EMDEPHOS] [varchar](1) NULL,
	[EMDEPSYS] [varchar](1) NULL,
	[EMDEPNET] [varchar](1) NULL,
	[EMDEPVEN] [varchar](1) NULL,
	[FSERHOS] [varchar](1) NULL,
	[FSERSYS] [varchar](1) NULL,
	[FSERNET] [varchar](1) NULL,
	[FSERVEN] [varchar](1) NULL,
	[FSERYN] [varchar](1) NULL,
	[TRAUMHOS] [varchar](1) NULL,
	[TRAUMSYS] [varchar](1) NULL,
	[TRAUMNET] [varchar](1) NULL,
	[TRAUMVEN] [varchar](1) NULL,
	[TRAUML90] [varchar](1) NULL,
	[ENBHOS] [varchar](1) NULL,
	[ENBSYS] [varchar](1) NULL,
	[ENBNET] [varchar](1) NULL,
	[ENBVEN] [varchar](1) NULL,
	[ENDOCHOS] [varchar](1) NULL,
	[ENDOCSYS] [varchar](1) NULL,
	[ENDOCNET] [varchar](1) NULL,
	[ENDOCVEN] [varchar](1) NULL,
	[ENDOUHOS] [varchar](1) NULL,
	[ENDOUSYS] [varchar](1) NULL,
	[ENDOUNET] [varchar](1) NULL,
	[ENDOUVEN] [varchar](1) NULL,
	[ENDOAHOS] [varchar](1) NULL,
	[ENDOASYS] [varchar](1) NULL,
	[ENDOANET] [varchar](1) NULL,
	[ENDOAVEN] [varchar](1) NULL,
	[ENDOEHOS] [varchar](1) NULL,
	[ENDOESYS] [varchar](1) NULL,
	[ENDOENET] [varchar](1) NULL,
	[ENDOEVEN] [varchar](1) NULL,
	[ENDORHOS] [varchar](1) NULL,
	[ENDORSYS] [varchar](1) NULL,
	[ENDORNET] [varchar](1) NULL,
	[ENDORVEN] [varchar](1) NULL,
	[ENRHOS] [varchar](1) NULL,
	[ENRSYS] [varchar](1) NULL,
	[ENRNET] [varchar](1) NULL,
	[ENRVEN] [varchar](1) NULL,
	[ESWLHOS] [varchar](1) NULL,
	[ESWLSYS] [varchar](1) NULL,
	[ESWLNET] [varchar](1) NULL,
	[ESWLVEN] [varchar](1) NULL,
	[FRTCHOS] [varchar](1) NULL,
	[FRTCSYS] [varchar](1) NULL,
	[FRTCNET] [varchar](1) NULL,
	[FRTCVEN] [varchar](1) NULL,
	[FITCHOS] [varchar](1) NULL,
	[FITCSYS] [varchar](1) NULL,
	[FITCNET] [varchar](1) NULL,
	[FITCVEN] [varchar](1) NULL,
	[OPCENHOS] [varchar](1) NULL,
	[OPCENSYS] [varchar](1) NULL,
	[OPCENNET] [varchar](1) NULL,
	[OPCENVEN] [varchar](1) NULL,
	[GERSVHOS] [varchar](1) NULL,
	[GERSVSYS] [varchar](1) NULL,
	[GERSVNET] [varchar](1) NULL,
	[GERSVVEN] [varchar](1) NULL,
	[HLTHFHOS] [varchar](1) NULL,
	[HLTHFSYS] [varchar](1) NULL,
	[HLTHFNET] [varchar](1) NULL,
	[HLTHFVEN] [varchar](1) NULL,
	[HLTHCHOS] [varchar](1) NULL,
	[HLTHCSYS] [varchar](1) NULL,
	[HLTHCNET] [varchar](1) NULL,
	[HLTHCVEN] [varchar](1) NULL,
	[GNTCHOS] [varchar](1) NULL,
	[GNTCSYS] [varchar](1) NULL,
	[GNTCNET] [varchar](1) NULL,
	[GNTCVEN] [varchar](1) NULL,
	[HLTHSHOS] [varchar](1) NULL,
	[HLTHSSYS] [varchar](1) NULL,
	[HLTHSNET] [varchar](1) NULL,
	[HLTHSVEN] [varchar](1) NULL,
	[HLTRHOS] [varchar](1) NULL,
	[HLTRSYS] [varchar](1) NULL,
	[HLTRNET] [varchar](1) NULL,
	[HLTRVEN] [varchar](1) NULL,
	[HEMOHOS] [varchar](1) NULL,
	[HEMOSYS] [varchar](1) NULL,
	[HEMONET] [varchar](1) NULL,
	[HEMOVEN] [varchar](1) NULL,
	[AIDSSHOS] [varchar](1) NULL,
	[AIDSSSYS] [varchar](1) NULL,
	[AIDSSNET] [varchar](1) NULL,
	[AIDSSVEN] [varchar](1) NULL,
	[HOMEHHOS] [varchar](1) NULL,
	[HOMEHSYS] [varchar](1) NULL,
	[HOMEHNET] [varchar](1) NULL,
	[HOMEHVEN] [varchar](1) NULL,
	[HOSPCHOS] [varchar](1) NULL,
	[HOSPCSYS] [varchar](1) NULL,
	[HOSPCNET] [varchar](1) NULL,
	[HOSPCVEN] [varchar](1) NULL,
	[OPHOSHOS] [varchar](1) NULL,
	[OPHOSSYS] [varchar](1) NULL,
	[OPHOSNET] [varchar](1) NULL,
	[OPHOSVEN] [varchar](1) NULL,
	[IMPRHOS] [varchar](1) NULL,
	[IMPRSYS] [varchar](1) NULL,
	[IMPRNET] [varchar](1) NULL,
	[IMPRVEN] [varchar](1) NULL,
	[ICARHOS] [varchar](1) NULL,
	[ICARSYS] [varchar](1) NULL,
	[ICARNET] [varchar](1) NULL,
	[ICARVEN] [varchar](1) NULL,
	[LINGHOS] [varchar](1) NULL,
	[LINGSYS] [varchar](1) NULL,
	[LINGNET] [varchar](1) NULL,
	[LINGVEN] [varchar](1) NULL,
	[MEALSHOS] [varchar](1) NULL,
	[MEALSSYS] [varchar](1) NULL,
	[MEALSNET] [varchar](1) NULL,
	[MEALSVEN] [varchar](1) NULL,
	[MOHSHOS] [varchar](1) NULL,
	[MOHSSYS] [varchar](1) NULL,
	[MOHSNET] [varchar](1) NULL,
	[MOHSVEN] [varchar](1) NULL,
	[NEROHOS] [varchar](1) NULL,
	[NEROSYS] [varchar](1) NULL,
	[NERONET] [varchar](1) NULL,
	[NEROVEN] [varchar](1) NULL,
	[NUTRPHOS] [varchar](1) NULL,
	[NUTRPSYS] [varchar](1) NULL,
	[NUTRPNET] [varchar](1) NULL,
	[NUTRPVEN] [varchar](1) NULL,
	[OCCHSHOS] [varchar](1) NULL,
	[OCCHSSYS] [varchar](1) NULL,
	[OCCHSNET] [varchar](1) NULL,
	[OCCHSVEN] [varchar](1) NULL,
	[ONCOLHOS] [varchar](1) NULL,
	[ONCOLSYS] [varchar](1) NULL,
	[ONCOLNET] [varchar](1) NULL,
	[ONCOLVEN] [varchar](1) NULL,
	[ORTOHOS] [varchar](1) NULL,
	[ORTOSYS] [varchar](1) NULL,
	[ORTONET] [varchar](1) NULL,
	[ORTOVEN] [varchar](1) NULL,
	[OPSRGHOS] [varchar](1) NULL,
	[OPSRGSYS] [varchar](1) NULL,
	[OPSRGNET] [varchar](1) NULL,
	[OPSRGVEN] [varchar](1) NULL,
	[PAINHOS] [varchar](1) NULL,
	[PAINSYS] [varchar](1) NULL,
	[PAINNET] [varchar](1) NULL,
	[PAINVEN] [varchar](1) NULL,
	[PALHOS] [varchar](1) NULL,
	[PALSYS] [varchar](1) NULL,
	[PALNET] [varchar](1) NULL,
	[PALVEN] [varchar](1) NULL,
	[IPALHOS] [varchar](1) NULL,
	[IPALSYS] [varchar](1) NULL,
	[IPALNET] [varchar](1) NULL,
	[IPALVEN] [varchar](1) NULL,
	[PCAHOS] [varchar](1) NULL,
	[PCASYS] [varchar](1) NULL,
	[PCANET] [varchar](1) NULL,
	[PCAVEN] [varchar](1) NULL,
	[PATEDHOS] [varchar](1) NULL,
	[PATEDSYS] [varchar](1) NULL,
	[PATEDNET] [varchar](1) NULL,
	[PATEDVEN] [varchar](1) NULL,
	[PATRPHOS] [varchar](1) NULL,
	[PATRPSYS] [varchar](1) NULL,
	[PATRPNET] [varchar](1) NULL,
	[PATRPVEN] [varchar](1) NULL,
	[RASTHOS] [varchar](1) NULL,
	[RASTSYS] [varchar](1) NULL,
	[RASTNET] [varchar](1) NULL,
	[RASTVEN] [varchar](1) NULL,
	[REDSHOS] [varchar](1) NULL,
	[REDSSYS] [varchar](1) NULL,
	[REDSNET] [varchar](1) NULL,
	[REDSVEN] [varchar](1) NULL,
	[RHBOPHOS] [varchar](1) NULL,
	[RHBOPSYS] [varchar](1) NULL,
	[RHBOPNET] [varchar](1) NULL,
	[RHBOPVEN] [varchar](1) NULL,
	[RPRSHOS] [varchar](1) NULL,
	[RPRSSYS] [varchar](1) NULL,
	[RPRSNET] [varchar](1) NULL,
	[RPRSVEN] [varchar](1) NULL,
	[RBOTHOS] [varchar](1) NULL,
	[RBOTSYS] [varchar](1) NULL,
	[RBOTNET] [varchar](1) NULL,
	[RBOTVEN] [varchar](1) NULL,
	[RSIMHOS] [varchar](1) NULL,
	[RSIMSYS] [varchar](1) NULL,
	[RSIMNET] [varchar](1) NULL,
	[RSIMVEN] [varchar](1) NULL,
	[PCDEPHOS] [varchar](1) NULL,
	[PCDEPSYS] [varchar](1) NULL,
	[PCDEPNET] [varchar](1) NULL,
	[PCDEPVEN] [varchar](1) NULL,
	[PSYCAHOS] [varchar](1) NULL,
	[PSYCASYS] [varchar](1) NULL,
	[PSYCANET] [varchar](1) NULL,
	[PSYCAVEN] [varchar](1) NULL,
	[PSYLSHOS] [varchar](1) NULL,
	[PSYLSSYS] [varchar](1) NULL,
	[PSYLSNET] [varchar](1) NULL,
	[PSYLSVEN] [varchar](1) NULL,
	[PSYEDHOS] [varchar](1) NULL,
	[PSYEDSYS] [varchar](1) NULL,
	[PSYEDNET] [varchar](1) NULL,
	[PSYEDVEN] [varchar](1) NULL,
	[PSYEMHOS] [varchar](1) NULL,
	[PSYEMSYS] [varchar](1) NULL,
	[PSYEMNET] [varchar](1) NULL,
	[PSYEMVEN] [varchar](1) NULL,
	[PSYGRHOS] [varchar](1) NULL,
	[PSYGRSYS] [varchar](1) NULL,
	[PSYGRNET] [varchar](1) NULL,
	[PSYGRVEN] [varchar](1) NULL,
	[PSYOPHOS] [varchar](1) NULL,
	[PSYOPSYS] [varchar](1) NULL,
	[PSYOPNET] [varchar](1) NULL,
	[PSYOPVEN] [varchar](1) NULL,
	[PSYPHHOS] [varchar](1) NULL,
	[PSYPHSYS] [varchar](1) NULL,
	[PSYPHNET] [varchar](1) NULL,
	[PSYPHVEN] [varchar](1) NULL,
	[CTSCNHOS] [varchar](1) NULL,
	[CTSCNSYS] [varchar](1) NULL,
	[CTSCNNET] [varchar](1) NULL,
	[CTSCNVEN] [varchar](1) NULL,
	[DRADFHOS] [varchar](1) NULL,
	[DRADFSYS] [varchar](1) NULL,
	[DRADFNET] [varchar](1) NULL,
	[DRADFVEN] [varchar](1) NULL,
	[EBCTHOS] [varchar](1) NULL,
	[EBCTSYS] [varchar](1) NULL,
	[EBCTNET] [varchar](1) NULL,
	[EBCTVEN] [varchar](1) NULL,
	[FFDMHOS] [varchar](1) NULL,
	[FFDMSYS] [varchar](1) NULL,
	[FFDMNET] [varchar](1) NULL,
	[FFDMVEN] [varchar](1) NULL,
	[MRIHOS] [varchar](1) NULL,
	[MRISYS] [varchar](1) NULL,
	[MRINET] [varchar](1) NULL,
	[MRIVEN] [varchar](1) NULL,
	[IMRIHOS] [varchar](1) NULL,
	[IMRISYS] [varchar](1) NULL,
	[IMRINET] [varchar](1) NULL,
	[IMRIVEN] [varchar](1) NULL,
	[MSCTHOS] [varchar](1) NULL,
	[MSCTSYS] [varchar](1) NULL,
	[MSCTNET] [varchar](1) NULL,
	[MSCTVEN] [varchar](1) NULL,
	[MSCTGHOS] [varchar](1) NULL,
	[MSCTGSYS] [varchar](1) NULL,
	[MSCTGNET] [varchar](1) NULL,
	[MSCTGVEN] [varchar](1) NULL,
	[PETHOS] [varchar](1) NULL,
	[PETSYS] [varchar](1) NULL,
	[PETNET] [varchar](1) NULL,
	[PETVEN] [varchar](1) NULL,
	[PETCTHOS] [varchar](1) NULL,
	[PETCTSYS] [varchar](1) NULL,
	[PETCTNET] [varchar](1) NULL,
	[PETCTVEN] [varchar](1) NULL,
	[SPECTHOS] [varchar](1) NULL,
	[SPECTSYS] [varchar](1) NULL,
	[SPECTNET] [varchar](1) NULL,
	[SPECTVEN] [varchar](1) NULL,
	[ULTSNHOS] [varchar](1) NULL,
	[ULTSNSYS] [varchar](1) NULL,
	[ULTSNNET] [varchar](1) NULL,
	[ULTSNVEN] [varchar](1) NULL,
	[IGRTHOS] [varchar](1) NULL,
	[IGRTSYS] [varchar](1) NULL,
	[IGRTNET] [varchar](1) NULL,
	[IGRTVEN] [varchar](1) NULL,
	[IMRTHOS] [varchar](1) NULL,
	[IMRTSYS] [varchar](1) NULL,
	[IMRTNET] [varchar](1) NULL,
	[IMRTVEN] [varchar](1) NULL,
	[PTONHOS] [varchar](1) NULL,
	[PTONSYS] [varchar](1) NULL,
	[PTONNET] [varchar](1) NULL,
	[PTONVEN] [varchar](1) NULL,
	[BEAMHOS] [varchar](1) NULL,
	[BEAMSYS] [varchar](1) NULL,
	[BEAMNET] [varchar](1) NULL,
	[BEAMVEN] [varchar](1) NULL,
	[SRADHOS] [varchar](1) NULL,
	[SRADSYS] [varchar](1) NULL,
	[SRADNET] [varchar](1) NULL,
	[SRADVEN] [varchar](1) NULL,
	[RETIRHOS] [varchar](1) NULL,
	[RETIRSYS] [varchar](1) NULL,
	[RETIRNET] [varchar](1) NULL,
	[RETIRVEN] [varchar](1) NULL,
	[ROBOHOS] [varchar](1) NULL,
	[ROBOSYS] [varchar](1) NULL,
	[ROBONET] [varchar](1) NULL,
	[ROBOVEN] [varchar](1) NULL,
	[RURLHOS] [varchar](1) NULL,
	[RURLSYS] [varchar](1) NULL,
	[RURLNET] [varchar](1) NULL,
	[RURLVEN] [varchar](1) NULL,
	[SLEPHOS] [varchar](1) NULL,
	[SLEPSYS] [varchar](1) NULL,
	[SLEPNET] [varchar](1) NULL,
	[SLEPVEN] [varchar](1) NULL,
	[SOCWKHOS] [varchar](1) NULL,
	[SOCWKSYS] [varchar](1) NULL,
	[SOCWKNET] [varchar](1) NULL,
	[SOCWKVEN] [varchar](1) NULL,
	[SPORTHOS] [varchar](1) NULL,
	[SPORTSYS] [varchar](1) NULL,
	[SPORTNET] [varchar](1) NULL,
	[SPORTVEN] [varchar](1) NULL,
	[SUPPGHOS] [varchar](1) NULL,
	[SUPPGSYS] [varchar](1) NULL,
	[SUPPGNET] [varchar](1) NULL,
	[SUPPGVEN] [varchar](1) NULL,
	[SWBDHOS] [varchar](1) NULL,
	[SWBDSYS] [varchar](1) NULL,
	[SWBDNET] [varchar](1) NULL,
	[SWBDVEN] [varchar](1) NULL,
	[TEENSHOS] [varchar](1) NULL,
	[TEENSSYS] [varchar](1) NULL,
	[TEENSNET] [varchar](1) NULL,
	[TEENSVEN] [varchar](1) NULL,
	[TOBHOS] [varchar](1) NULL,
	[TOBSYS] [varchar](1) NULL,
	[TOBNET] [varchar](1) NULL,
	[TOBVEN] [varchar](1) NULL,
	[OTBONHOS] [varchar](1) NULL,
	[OTBONSYS] [varchar](1) NULL,
	[OTBONNET] [varchar](1) NULL,
	[OTBONVEN] [varchar](1) NULL,
	[HARTHOS] [varchar](1) NULL,
	[HARTSYS] [varchar](1) NULL,
	[HARTNET] [varchar](1) NULL,
	[HARTVEN] [varchar](1) NULL,
	[KDNYHOS] [varchar](1) NULL,
	[KDNYSYS] [varchar](1) NULL,
	[KDNYNET] [varchar](1) NULL,
	[KDNYVEN] [varchar](1) NULL,
	[LIVRHOS] [varchar](1) NULL,
	[LIVRSYS] [varchar](1) NULL,
	[LIVRNET] [varchar](1) NULL,
	[LIVRVEN] [varchar](1) NULL,
	[LUNGHOS] [varchar](1) NULL,
	[LUNGSYS] [varchar](1) NULL,
	[LUNGNET] [varchar](1) NULL,
	[LUNGVEN] [varchar](1) NULL,
	[TISUHOS] [varchar](1) NULL,
	[TISUSYS] [varchar](1) NULL,
	[TISUNET] [varchar](1) NULL,
	[TISUVEN] [varchar](1) NULL,
	[OTOTHHOS] [varchar](1) NULL,
	[OTOTHSYS] [varchar](1) NULL,
	[OTOTHNET] [varchar](1) NULL,
	[OTOTHVEN] [varchar](1) NULL,
	[TPORTHOS] [varchar](1) NULL,
	[TPORTSYS] [varchar](1) NULL,
	[TPORTNET] [varchar](1) NULL,
	[TPORTVEN] [varchar](1) NULL,
	[URGCCHOS] [varchar](1) NULL,
	[URGCCSYS] [varchar](1) NULL,
	[URGCCNET] [varchar](1) NULL,
	[URGCCVEN] [varchar](1) NULL,
	[VRCSHOS] [varchar](1) NULL,
	[VRCSSYS] [varchar](1) NULL,
	[VRCSNET] [varchar](1) NULL,
	[VRCSVEN] [varchar](1) NULL,
	[VOLSVHOS] [varchar](1) NULL,
	[VOLSVSYS] [varchar](1) NULL,
	[VOLSVNET] [varchar](1) NULL,
	[VOLSVVEN] [varchar](1) NULL,
	[WOMHCHOS] [varchar](1) NULL,
	[WOMHCSYS] [varchar](1) NULL,
	[WOMHCNET] [varchar](1) NULL,
	[WOMHCVEN] [varchar](1) NULL,
	[WMGTHOS] [varchar](1) NULL,
	[WMGTSYS] [varchar](1) NULL,
	[WMGTNET] [varchar](1) NULL,
	[WMGTVEN] [varchar](1) NULL,
	[EXPTOT] [float] NULL,
	[EXPTHA] [float] NULL,
	[EXPTLA] [float] NULL,
	[CPPCT] [float] NULL,
	[CAPRSK] [float] NULL,
	[DPEXA] [float] NULL,
	[INTEXA] [float] NULL,
	[SUPEXA] [float] NULL,
	[NPAYBEN] [float] NULL,
	[PAYTOT] [float] NULL,
	[PAYTOTH] [float] NULL,
	[NPAYBENH] [float] NULL,
	[PAYTOTLT] [float] NULL,
	[NPAYBENL] [float] NULL,
	[LBEDSA] [float] NULL,
	[BDTOT] [float] NULL,
	[ADMTOT] [float] NULL,
	[IPDTOT] [float] NULL,
	[BDH] [float] NULL,
	[ADMH] [float] NULL,
	[IPDH] [float] NULL,
	[LBEDLA] [float] NULL,
	[BDLT] [float] NULL,
	[ADMLT] [float] NULL,
	[IPDLT] [float] NULL,
	[MCRDC] [float] NULL,
	[MCRIPD] [float] NULL,
	[MCDDC] [float] NULL,
	[MCDIPD] [float] NULL,
	[MCRDCH] [float] NULL,
	[MCRIPDH] [float] NULL,
	[MCDDCH] [float] NULL,
	[MCDIPDH] [float] NULL,
	[MCRDCLT] [float] NULL,
	[MCRIPDLT] [float] NULL,
	[MCDDCLT] [float] NULL,
	[MCDIPDLT] [float] NULL,
	[BASSIN] [float] NULL,
	[BIRTHS] [float] NULL,
	[SUROPIP] [float] NULL,
	[SUROPOP] [float] NULL,
	[SUROPTOT] [float] NULL,
	[VEM] [float] NULL,
	[VOTH] [float] NULL,
	[VTOT] [float] NULL,
	[FTMDTF] [float] NULL,
	[FTRES] [float] NULL,
	[FTTRAN84] [float] NULL,
	[FTRNTF] [float] NULL,
	[FTLPNTF] [float] NULL,
	[FTAST] [float] NULL,
	[FTRAD] [float] NULL,
	[FTLAB] [float] NULL,
	[FTPHR] [float] NULL,
	[FTPHT] [float] NULL,
	[FTRESP] [float] NULL,
	[FTOTHTF] [float] NULL,
	[FTTOT] [float] NULL,
	[PTMDTF] [float] NULL,
	[PTRES] [float] NULL,
	[PTTRAN84] [float] NULL,
	[PTRNTF] [float] NULL,
	[PTLPNTF] [float] NULL,
	[PTAST] [float] NULL,
	[PTRAD] [float] NULL,
	[PTLAB] [float] NULL,
	[PTPHR] [float] NULL,
	[PTPHT] [float] NULL,
	[PTRESP] [float] NULL,
	[PTOTHTF] [float] NULL,
	[PTTOT] [float] NULL,
	[FTTOTH] [float] NULL,
	[PTTOTH] [float] NULL,
	[FTTOTLT] [float] NULL,
	[PTTOTLT] [float] NULL,
	[FTED] [float] NULL,
	[FTER] [float] NULL,
	[FTET] [float] NULL,
	[FTEN] [float] NULL,
	[FTEP] [float] NULL,
	[FTEAP] [float] NULL,
	[FTERAD] [float] NULL,
	[FTELAB] [float] NULL,
	[FTEPH] [float] NULL,
	[FTEPHT] [float] NULL,
	[FTERESP] [float] NULL,
	[FTEO] [float] NULL,
	[FTETF] [float] NULL,
	[FTERNLT] [float] NULL,
	[FTEU] [float] NULL,
	[VMD] [float] NULL,
	[VRES] [float] NULL,
	[VTTRN] [float] NULL,
	[VRN] [float] NULL,
	[VLPN] [float] NULL,
	[VAST] [float] NULL,
	[VRAD] [float] NULL,
	[VLAB] [float] NULL,
	[VPHR] [float] NULL,
	[VPHT] [float] NULL,
	[VRSP] [float] NULL,
	[VOTHL] [float] NULL,
	[VTOTL] [float] NULL,
	[VRNH] [float] NULL,
	[VTNH] [float] NULL,
	[ADC] [float] NULL,
	[ADJADM] [float] NULL,
	[ADJPD] [float] NULL,
	[ADJADC] [float] NULL,
	[FTEMD] [float] NULL,
	[FTERN] [float] NULL,
	[FTELPN] [float] NULL,
	[FTERES] [float] NULL,
	[FTETRAN] [float] NULL,
	[FTETTRN] [float] NULL,
	[FTEOTH94] [float] NULL,
	[FTEH] [float] NULL,
	[FTENH] [float] NULL,
	[FTE] [float] NULL,
	[OPRA] [float] NULL,
	[EADMTOT] [varchar](1) NULL,
	[EIPDTOT] [varchar](1) NULL,
	[EADMH] [varchar](1) NULL,
	[EIPDH] [varchar](1) NULL,
	[EADMLT] [varchar](1) NULL,
	[EIPDLT] [varchar](1) NULL,
	[EMCRDC] [varchar](1) NULL,
	[EMCRIPD] [varchar](1) NULL,
	[EMCDDC] [varchar](1) NULL,
	[EMCDIPD] [varchar](1) NULL,
	[EMCRDCH] [varchar](1) NULL,
	[EMCRIPDH] [varchar](1) NULL,
	[EMCDDCH] [varchar](1) NULL,
	[EMCDIPDH] [varchar](1) NULL,
	[EMCRDCLT] [varchar](1) NULL,
	[EMCRPDLT] [varchar](1) NULL,
	[EMCDDCLT] [varchar](1) NULL,
	[EMCDPDLT] [varchar](1) NULL,
	[EBIRTHS] [varchar](1) NULL,
	[ESUROPIP] [varchar](1) NULL,
	[ESUROPOP] [varchar](1) NULL,
	[ESUROPTO] [varchar](1) NULL,
	[EVEM] [varchar](1) NULL,
	[EVOTH] [varchar](1) NULL,
	[EVTOT] [varchar](1) NULL,
	[EPAYTOT] [varchar](1) NULL,
	[ENPAYBEN] [varchar](1) NULL,
	[EPAYTOTH] [varchar](1) NULL,
	[ENPYBENH] [varchar](1) NULL,
	[EPYTOTLT] [varchar](1) NULL,
	[ENPBENLT] [varchar](1) NULL,
	[EFTMDTF] [varchar](1) NULL,
	[EFTRES] [varchar](1) NULL,
	[EFTTRN84] [varchar](1) NULL,
	[EFTRNTF] [varchar](1) NULL,
	[EFTLPNTF] [varchar](1) NULL,
	[EFTAST] [varchar](1) NULL,
	[EFTRAD] [varchar](1) NULL,
	[EFTLAB] [varchar](1) NULL,
	[EFTPHR] [varchar](1) NULL,
	[EFTPHT] [varchar](1) NULL,
	[EFTRESP] [varchar](1) NULL,
	[EFTOTHTF] [varchar](1) NULL,
	[EFTTOT] [varchar](1) NULL,
	[EPTMDTF] [varchar](1) NULL,
	[EPTRES] [varchar](1) NULL,
	[EPTTRN84] [varchar](1) NULL,
	[EPTRNTF] [varchar](1) NULL,
	[EPTLPNTF] [varchar](1) NULL,
	[EPTAST] [varchar](1) NULL,
	[EPTRAD] [varchar](1) NULL,
	[EPTLAB] [varchar](1) NULL,
	[EPTPHR] [varchar](1) NULL,
	[EPTPHT] [varchar](1) NULL,
	[EPTRESP] [varchar](1) NULL,
	[EPTOTHTF] [varchar](1) NULL,
	[EPTTOT] [varchar](1) NULL,
	[EFTTOTH] [varchar](1) NULL,
	[EPTTOTH] [varchar](1) NULL,
	[EFTTOTLT] [varchar](1) NULL,
	[EPTTOTLT] [varchar](1) SPARSE,
	[EEXPTOT] [varchar](1) SPARSE,
	[EXPTHB] [varchar](1) SPARSE,
	[EXPTLB] [varchar](1) SPARSE,
	[TECAR] [float] SPARSE,
	[TEMER] [float] SPARSE,
	[TEHSP] [float] SPARSE,
	[TEINT] [float] SPARSE,
	[TEGST] [float] SPARSE,
	[TEOTH] [float] SPARSE,
	[TETOT] [float] SPARSE,
	[TCCAR] [float] SPARSE,
	[TCMER] [float] SPARSE,
	[TCHSP] [float] SPARSE,
	[TCINT] [float] SPARSE,
	[TCGST] [float] SPARSE,
	[TCOTH] [float] SPARSE,
	[TCTOT] [float] SPARSE,
	[TGCAR] [float] SPARSE,
	[TGMER] [float] SPARSE,
	[TGHSP] [float] SPARSE,
	[TGINT] [float] SPARSE,
	[TGGST] [float] SPARSE,
	[TGOTH] [float] SPARSE,
	[TGTOT] [float] SPARSE,
	[NECAR] [float] SPARSE,
	[NEMER] [float] SPARSE,
	[NEHSP] [float] SPARSE,
	[NEINT] [float] SPARSE,
	[NEGST] [float] SPARSE,
	[NEOTH] [float] SPARSE,
	[NETOT] [float] SPARSE,
	[TPCAR] [float] SPARSE,
	[TPMER] [float] SPARSE,
	[TPHSP] [float] SPARSE,
	[TPINT] [float] SPARSE,
	[TPGST] [float] SPARSE,
	[TPOTH] [float] SPARSE,
	[TPRTOT] [float] SPARSE,
	[HSPTL] [varchar](1) SPARSE,
	[FTEHSP] [float] SPARSE,
	[INTCAR] [varchar](1) SPARSE,
	[FTEMSI] [float] SPARSE,
	[FTECIC] [float] SPARSE,
	[FTENIC] [float] SPARSE,
	[FTEPIC] [float] SPARSE,
	[FTEOIC] [float] SPARSE,
	[FTEINT] [float] SPARSE,
	[CLSMSI] [varchar](1) SPARSE,
	[CLSCIC] [varchar](1) SPARSE,
	[CLSNIC] [varchar](1) SPARSE,
	[CLSPIC] [varchar](1) SPARSE,
	[CLSOIC] [varchar](1) SPARSE,
	[CLSINT] [varchar](1) SPARSE,
	[APRN] [varchar](1) SPARSE,
	[FTAPRN] [float] SPARSE,
	[PTAPRN] [float] SPARSE,
	[FTEAPN] [float] SPARSE,
	[APCAR] [varchar](1) SPARSE,
	[APANES] [varchar](1) SPARSE,
	[APEMER] [varchar](1) SPARSE,
	[APSPC] [varchar](1) SPARSE,
	[APED] [varchar](1) SPARSE,
	[APCASE] [varchar](1) SPARSE,
	[APOTH] [varchar](1) SPARSE,
	[FORNRSA] [varchar](1) SPARSE,
	[AFRICA] [varchar](1) SPARSE,
	[KOREA] [varchar](1) SPARSE,
	[CANADA] [varchar](1) SPARSE,
	[PH] [varchar](1) SPARSE,
	[CHINA] [varchar](1) SPARSE,
	[INDIA] [varchar](1) SPARSE,
	[OFRNRS] [varchar](1) SPARSE,
	[PLNTA] [float] SPARSE,
	[ADEPRA] [float] SPARSE,
	[ASSNET] [float] SPARSE,
	[GFEET] [float] SPARSE,
	[CEAMT] [float] SPARSE,
	[MMBTU] [float] SPARSE,
	[MMBTR] [float] SPARSE,
	[EHLTH] [varchar](1) SPARSE,
	[ENDMARK] [varchar](1) NULL,
	DetailSet XML COLUMN_SET FOR ALL_SPARSE_COLUMNS)
) BY isilon;
quit;
*The final query inserts into all of the explicit columns of the general table;
*And then select a.* and the explicit columns from table _1;
PROC SQL;
CONNECT using isilon;
EXECUTE(
	insert into AHA.annual2010(
	[ID]
      ,[REG]
      ,[STCD]
      ,[HOSPN]
      ,[DTBEG]
      ,[DBEGM]
      ,[DBEGD]
      ,[DBEGY]
      ,[DTEND]
      ,[DENDM]
      ,[DENDD]
      ,[DENDY]
      ,[DCOV]
      ,[FYR]
      ,[FISYR]
      ,[FISM]
      ,[FISD]
      ,[FISY]
      ,[CNTRL]
      ,[SERV]
      ,[SERVOTH]
      ,[RADMCHI]
      ,[HSACODE]
      ,[HSANAME]
      ,[HRRCODE]
      ,[HRRNAME]
      ,[MTYPE]
      ,[MLOS]
      ,[MNAME]
      ,[MADMIN]
      ,[MLOCADDR]
      ,[MLOCCITY]
      ,[MLOCSTCD]
      ,[MLOCZIP]
      ,[MSTATE]
      ,[AREA]
      ,[TELNO]
      ,[RESP]
      ,[CHC]
      ,[BSC]
      ,[MHSMEMB]
      ,[SUBS]
      ,[MNGT]
      ,[MNGTNAME]
      ,[MNGTCITY]
      ,[MNGTSTCD]
      ,[NETWRK]
      ,[NETNAME]
      ,[NETCT]
      ,[NETSC]
      ,[NETPHONE]
      ,[GROUP]
      ,[GPONAME]
      ,[GPOCITY]
      ,[GPOST]
      ,[SUPLY]
      ,[SUPNM]
      ,[PHYGP]
      ,[LTCHF]
      ,[LTCHC]
      ,[LTNM]
      ,[LTCT]
      ,[LTST]
      ,[NPI]
      ,[NPINUM]
      ,[CLUSTER]
      ,[SYSID]
      ,[SYSNAME]
      ,[SYSADDR]
      ,[SYSCITY]
      ,[SYSST]
      ,[SYSZIP]
      ,[SYSAREA]
      ,[SYSTELN]
      ,[SPC]
      ,[SYSTITLE]
      ,[COMMTY]
      ,[MCRNUM]
      ,[LAT]
      ,[LONG]
      ,[CNTYNAME]
      ,[CBSANAME]
      ,[CBSATYPE]
      ,[LOS]
      ,[CBSACODE]
      ,[MCNTYCD]
      ,[FCOUNTY]
      ,[FSTCD]
      ,[FCNTYCD]
      ,[CITYRK]
      ,[MAPP1]
      ,[MAPP2]
      ,[MAPP3]
      ,[MAPP5]
      ,[MAPP6]
      ,[MAPP7]
      ,[MAPP8]
      ,[MAPP9]
      ,[MAPP10]
      ,[MAPP11]
      ,[MAPP12]
      ,[MAPP13]
      ,[MAPP16]
      ,[MAPP18]
      ,[MAPP19]
      ,[MAPP20]
      ,[MAPP21]
      ,[AHAMBR]
      ,[MISSION]
      ,[LTPLAN]
      ,[RESOURCE]
      ,[BENEFIT]
      ,[BUILD]
      ,[FUND]
      ,[HWELL]
      ,[HSASSESS]
      ,[HSIND]
      ,[CAPASS]
      ,[ASSUSE]
      ,[CTRACK]
      ,[QUALREP]
      ,[GRACE]
      ,[GLANG]
      ,[ILEAD]
      ,[DIVERS]
      ,[ELEADS]
      ,[DEVADM]
      ,[SNT]
      ,[TRIAGE]
      ,[TRGOTH]
      ,[SUNITS]
      ,[IPAHOS]
      ,[IPASYS]
      ,[IPANET]
      ,[GPWWHOS]
      ,[GPWWSYS]
      ,[GPWWNET]
      ,[OPHOHOS]
      ,[OPHOSYS]
      ,[OPHONET]
      ,[CPHOHOS]
      ,[CPHOSYS]
      ,[CPHONET]
      ,[MSOHOS]
      ,[MSOSYS]
      ,[MSONET]
      ,[ISMHOS]
      ,[ISMSYS]
      ,[ISMNET]
      ,[EQMODHOS]
      ,[EQMODSYS]
      ,[EQMODNET]
      ,[FOUNDHOS]
      ,[FOUNDSYS]
      ,[FOUNDNET]
      ,[PHYOTH]
      ,[PHYHOS]
      ,[PHYSYS]
      ,[PHYNET]
      ,[IPHMOHOS]
      ,[IPHMOSYS]
      ,[IPHMONET]
      ,[IPHMOVEN]
      ,[IPPPOHOS]
      ,[IPPPOSYS]
      ,[IPPPONET]
      ,[IPPPOVEN]
      ,[IPFEEHOS]
      ,[IPFEESYS]
      ,[IPFEENET]
      ,[IPFEEVEN]
      ,[HMO86]
      ,[HMOCON]
      ,[PPO86]
      ,[PPOCON]
      ,[CAPCON94]
      ,[CAPCOV]
      ,[IPAP]
      ,[GPWP]
      ,[OPHP]
      ,[CPHP]
      ,[MSOP]
      ,[ISMP]
      ,[EQMP]
      ,[FNDP]
      ,[PHYP]
      ,[FTMT]
      ,[JNTPH]
      ,[JNLS]
      ,[JNTAMB]
      ,[JNTCTR]
      ,[JNTOTH]
      ,[LSHTXT]
      ,[JNTLSC]
      ,[JNTLSO]
      ,[JNTLSS]
      ,[JNTLST]
      ,[JNTTXT]
      ,[JNTMD]
      ,[GENBD]
      ,[PEDBD]
      ,[OBBD]
      ,[MSICBD]
      ,[CICBD]
      ,[NICBD]
      ,[NINTBD]
      ,[PEDICBD]
      ,[BRNBD]
      ,[OTHICBD]
      ,[SPCICBD]
      ,[REHABBD]
      ,[ALCHBD]
      ,[PSYBD]
      ,[SNBD88]
      ,[ICFBD88]
      ,[ACULTBD]
      ,[OTHLBD94]
      ,[OTHBD94]
      ,[HOSPBD]
      ,[OBLEV]
      ,[GENHOS]
      ,[GENSYS]
      ,[GENNET]
      ,[GENVEN]
      ,[PEDHOS]
      ,[PEDSYS]
      ,[PEDNET]
      ,[PEDVEN]
      ,[OBHOS]
      ,[OBSYS]
      ,[OBNET]
      ,[OBVEN]
      ,[MSICHOS]
      ,[MSICSYS]
      ,[MSICNET]
      ,[MSICVEN]
      ,[CICHOS]
      ,[CICSYS]
      ,[CICNET]
      ,[CICVEN]
      ,[NICHOS]
      ,[NICSYS]
      ,[NICNET]
      ,[NICVEN]
      ,[NINTHOS]
      ,[NINTSYS]
      ,[NINTNET]
      ,[NINTVEN]
      ,[PEDICHOS]
      ,[PEDICSYS]
      ,[PEDICNET]
      ,[PEDICVEN]
      ,[BRNHOS]
      ,[BRNSYS]
      ,[BRNNET]
      ,[BRNVEN]
      ,[SPCICHOS]
      ,[SPCICSYS]
      ,[SPCICNET]
      ,[SPCICVEN]
      ,[OTHIHOS]
      ,[OTHISYS]
      ,[OTHINET]
      ,[OTHIVEN]
      ,[REHABHOS]
      ,[REHABSYS]
      ,[REHABNET]
      ,[REHABVEN]
      ,[ALCHHOS]
      ,[ALCHSYS]
      ,[ALCHNET]
      ,[ALCHVEN]
      ,[PSYHOS]
      ,[PSYSYS]
      ,[PSYNET]
      ,[PSYVEN]
      ,[SNHOS]
      ,[SNSYS]
      ,[SNNET]
      ,[SNVEN]
      ,[ICFHOS]
      ,[ICFSYS]
      ,[ICFNET]
      ,[ICFVEN]
      ,[ACUHOS]
      ,[ACUSYS]
      ,[ACUNET]
      ,[ACUVEN]
      ,[OTHLTHOS]
      ,[OTHLTSYS]
      ,[OTHLTNET]
      ,[OTHLTVEN]
      ,[OTHCRHOS]
      ,[OTHCRSYS]
      ,[OTHCRNET]
      ,[OTHCRVEN]
      ,[ADULTHOS]
      ,[ADULTSYS]
      ,[ADULTNET]
      ,[ADULTVEN]
      ,[AIRBHOS]
      ,[AIRBSYS]
      ,[AIRBNET]
      ,[AIRBVEN]
      ,[AIRBROOM]
      ,[ALCOPHOS]
      ,[ALCOPSYS]
      ,[ALCOPNET]
      ,[ALCOPVEN]
      ,[ALZHOS]
      ,[ALZSYS]
      ,[ALZNET]
      ,[ALZVEN]
      ,[AMBHOS]
      ,[AMBSYS]
      ,[AMBNET]
      ,[AMBVEN]
      ,[AMBSHOS]
      ,[AMBSSYS]
      ,[AMBSNET]
      ,[AMBSVEN]
      ,[ARTHCHOS]
      ,[ARTHCSYS]
      ,[ARTHCNET]
      ,[ARTHCVEN]
      ,[ASSTLHOS]
      ,[ASSTLSYS]
      ,[ASSTLNET]
      ,[ASSTLVEN]
      ,[AUXHOS]
      ,[AUXSYS]
      ,[AUXNET]
      ,[AUXVEN]
      ,[BWHTHOS]
      ,[BWHTSYS]
      ,[BWHTNET]
      ,[BWHTVEN]
      ,[BROOMHOS]
      ,[BROOMSYS]
      ,[BROOMNET]
      ,[BROOMVEN]
      ,[BLDOHOS]
      ,[BLDOSYS]
      ,[BLDONET]
      ,[BLDOVEN]
      ,[MAMMSHOS]
      ,[MAMMSSYS]
      ,[MAMMSNET]
      ,[MAMMSVEN]
      ,[ACARDHOS]
      ,[ACARDSYS]
      ,[ACARDNET]
      ,[ACARDVEN]
      ,[PCARDHOS]
      ,[PCARDSYS]
      ,[PCARDNET]
      ,[PCARDVEN]
      ,[ACLABHOS]
      ,[ACLABSYS]
      ,[ACLABNET]
      ,[ACLABVEN]
      ,[PCLABHOS]
      ,[PCLABSYS]
      ,[PCLABNET]
      ,[PCLABVEN]
      ,[ICLABHOS]
      ,[ICLABSYS]
      ,[ICLABNET]
      ,[ICLABVEN]
      ,[PELABHOS]
      ,[PELABSYS]
      ,[PELABNET]
      ,[PELABVEN]
      ,[ADTCHOS]
      ,[ADTCSYS]
      ,[ADTCNET]
      ,[ADTCVEN]
      ,[PEDCSHOS]
      ,[PEDCSSYS]
      ,[PEDCSNET]
      ,[PEDCSVEN]
      ,[ADTEHOS]
      ,[ADTESYS]
      ,[ADTENET]
      ,[ADTEVEN]
      ,[PEDEHOS]
      ,[PEDESYS]
      ,[PEDENET]
      ,[PEDEVEN]
      ,[CHABHOS]
      ,[CHABSYS]
      ,[CHABNET]
      ,[CHABVEN]
      ,[CMNGTHOS]
      ,[CMNGTSYS]
      ,[CMNGTNET]
      ,[CMNGTVEN]
      ,[CHAPHOS]
      ,[CHAPSYS]
      ,[CHAPNET]
      ,[CHAPVEN]
      ,[CHTHHOS]
      ,[CHTHSYS]
      ,[CHTHNET]
      ,[CHTHVEN]
      ,[CWELLHOS]
      ,[CWELLSYS]
      ,[CWELLNET]
      ,[CWELLVEN]
      ,[CHIHOS]
      ,[CHISYS]
      ,[CHINET]
      ,[CHIVEN]
      ,[COUTRHOS]
      ,[COUTRSYS]
      ,[COUTRNET]
      ,[COUTRVEN]
      ,[COMPHOS]
      ,[COMPSYS]
      ,[COMPNET]
      ,[COMPVEN]
      ,[CAOSHOS]
      ,[CAOSSYS]
      ,[CAOSNET]
      ,[CAOSVEN]
      ,[CPREVHOS]
      ,[CPREVSYS]
      ,[CPREVNET]
      ,[CPREVVEN]
      ,[DENTSHOS]
      ,[DENTSSYS]
      ,[DENTSNET]
      ,[DENTSVEN]
      ,[EMDEPHOS]
      ,[EMDEPSYS]
      ,[EMDEPNET]
      ,[EMDEPVEN]
      ,[FSERHOS]
      ,[FSERSYS]
      ,[FSERNET]
      ,[FSERVEN]
      ,[FSERYN]
      ,[TRAUMHOS]
      ,[TRAUMSYS]
      ,[TRAUMNET]
      ,[TRAUMVEN]
      ,[TRAUML90]
      ,[ENBHOS]
      ,[ENBSYS]
      ,[ENBNET]
      ,[ENBVEN]
      ,[ENDOCHOS]
      ,[ENDOCSYS]
      ,[ENDOCNET]
      ,[ENDOCVEN]
      ,[ENDOUHOS]
      ,[ENDOUSYS]
      ,[ENDOUNET]
      ,[ENDOUVEN]
      ,[ENDOAHOS]
      ,[ENDOASYS]
      ,[ENDOANET]
      ,[ENDOAVEN]
      ,[ENDOEHOS]
      ,[ENDOESYS]
      ,[ENDOENET]
      ,[ENDOEVEN]
      ,[ENDORHOS]
      ,[ENDORSYS]
      ,[ENDORNET]
      ,[ENDORVEN]
      ,[ENRHOS]
      ,[ENRSYS]
      ,[ENRNET]
      ,[ENRVEN]
      ,[ESWLHOS]
      ,[ESWLSYS]
      ,[ESWLNET]
      ,[ESWLVEN]
      ,[FRTCHOS]
      ,[FRTCSYS]
      ,[FRTCNET]
      ,[FRTCVEN]
      ,[FITCHOS]
      ,[FITCSYS]
      ,[FITCNET]
      ,[FITCVEN]
      ,[OPCENHOS]
      ,[OPCENSYS]
      ,[OPCENNET]
      ,[OPCENVEN]
      ,[GERSVHOS]
      ,[GERSVSYS]
      ,[GERSVNET]
      ,[GERSVVEN]
      ,[HLTHFHOS]
      ,[HLTHFSYS]
      ,[HLTHFNET]
      ,[HLTHFVEN]
      ,[HLTHCHOS]
      ,[HLTHCSYS]
      ,[HLTHCNET]
      ,[HLTHCVEN]
      ,[GNTCHOS]
      ,[GNTCSYS]
      ,[GNTCNET]
      ,[GNTCVEN]
      ,[HLTHSHOS]
      ,[HLTHSSYS]
      ,[HLTHSNET]
      ,[HLTHSVEN]
      ,[HLTRHOS]
      ,[HLTRSYS]
      ,[HLTRNET]
      ,[HLTRVEN]
      ,[HEMOHOS]
      ,[HEMOSYS]
      ,[HEMONET]
      ,[HEMOVEN]
      ,[AIDSSHOS]
      ,[AIDSSSYS]
      ,[AIDSSNET]
      ,[AIDSSVEN]
      ,[HOMEHHOS]
      ,[HOMEHSYS]
      ,[HOMEHNET]
      ,[HOMEHVEN]
      ,[HOSPCHOS]
      ,[HOSPCSYS]
      ,[HOSPCNET]
      ,[HOSPCVEN]
      ,[OPHOSHOS]
      ,[OPHOSSYS]
      ,[OPHOSNET]
      ,[OPHOSVEN]
      ,[IMPRHOS]
      ,[IMPRSYS]
      ,[IMPRNET]
      ,[IMPRVEN]
      ,[ICARHOS]
      ,[ICARSYS]
      ,[ICARNET]
      ,[ICARVEN]
      ,[LINGHOS]
      ,[LINGSYS]
      ,[LINGNET]
      ,[LINGVEN]
      ,[MEALSHOS]
      ,[MEALSSYS]
      ,[MEALSNET]
      ,[MEALSVEN]
      ,[MOHSHOS]
      ,[MOHSSYS]
      ,[MOHSNET]
      ,[MOHSVEN]
      ,[NEROHOS]
      ,[NEROSYS]
      ,[NERONET]
      ,[NEROVEN]
      ,[NUTRPHOS]
      ,[NUTRPSYS]
      ,[NUTRPNET]
      ,[NUTRPVEN]
      ,[OCCHSHOS]
      ,[OCCHSSYS]
      ,[OCCHSNET]
      ,[OCCHSVEN]
      ,[ONCOLHOS]
      ,[ONCOLSYS]
      ,[ONCOLNET]
      ,[ONCOLVEN]
      ,[ORTOHOS]
      ,[ORTOSYS]
      ,[ORTONET]
      ,[ORTOVEN]
      ,[OPSRGHOS]
      ,[OPSRGSYS]
      ,[OPSRGNET]
      ,[OPSRGVEN]
      ,[PAINHOS]
      ,[PAINSYS]
      ,[PAINNET]
      ,[PAINVEN]
      ,[PALHOS]
      ,[PALSYS]
      ,[PALNET]
      ,[PALVEN]
      ,[IPALHOS]
      ,[IPALSYS]
      ,[IPALNET]
      ,[IPALVEN]
      ,[PCAHOS]
      ,[PCASYS]
      ,[PCANET]
      ,[PCAVEN]
      ,[PATEDHOS]
      ,[PATEDSYS]
      ,[PATEDNET]
      ,[PATEDVEN]
      ,[PATRPHOS]
      ,[PATRPSYS]
      ,[PATRPNET]
      ,[PATRPVEN]
      ,[RASTHOS]
      ,[RASTSYS]
      ,[RASTNET]
      ,[RASTVEN]
      ,[REDSHOS]
      ,[REDSSYS]
      ,[REDSNET]
      ,[REDSVEN]
      ,[RHBOPHOS]
      ,[RHBOPSYS]
      ,[RHBOPNET]
      ,[RHBOPVEN]
      ,[RPRSHOS]
      ,[RPRSSYS]
      ,[RPRSNET]
      ,[RPRSVEN]
      ,[RBOTHOS]
      ,[RBOTSYS]
      ,[RBOTNET]
      ,[RBOTVEN]
      ,[RSIMHOS]
      ,[RSIMSYS]
      ,[RSIMNET]
      ,[RSIMVEN]
      ,[PCDEPHOS]
      ,[PCDEPSYS]
      ,[PCDEPNET]
      ,[PCDEPVEN]
      ,[PSYCAHOS]
      ,[PSYCASYS]
      ,[PSYCANET]
      ,[PSYCAVEN]
      ,[PSYLSHOS]
      ,[PSYLSSYS]
      ,[PSYLSNET]
      ,[PSYLSVEN]
      ,[PSYEDHOS]
      ,[PSYEDSYS]
      ,[PSYEDNET]
      ,[PSYEDVEN]
      ,[PSYEMHOS]
      ,[PSYEMSYS]
      ,[PSYEMNET]
      ,[PSYEMVEN]
      ,[PSYGRHOS]
      ,[PSYGRSYS]
      ,[PSYGRNET]
      ,[PSYGRVEN]
      ,[PSYOPHOS]
      ,[PSYOPSYS]
      ,[PSYOPNET]
      ,[PSYOPVEN]
      ,[PSYPHHOS]
      ,[PSYPHSYS]
      ,[PSYPHNET]
      ,[PSYPHVEN]
      ,[CTSCNHOS]
      ,[CTSCNSYS]
      ,[CTSCNNET]
      ,[CTSCNVEN]
      ,[DRADFHOS]
      ,[DRADFSYS]
      ,[DRADFNET]
      ,[DRADFVEN]
      ,[EBCTHOS]
      ,[EBCTSYS]
      ,[EBCTNET]
      ,[EBCTVEN]
      ,[FFDMHOS]
      ,[FFDMSYS]
      ,[FFDMNET]
      ,[FFDMVEN]
      ,[MRIHOS]
      ,[MRISYS]
      ,[MRINET]
      ,[MRIVEN]
      ,[IMRIHOS]
      ,[IMRISYS]
      ,[IMRINET]
      ,[IMRIVEN]
      ,[MSCTHOS]
      ,[MSCTSYS]
      ,[MSCTNET]
      ,[MSCTVEN]
      ,[MSCTGHOS]
      ,[MSCTGSYS]
      ,[MSCTGNET]
      ,[MSCTGVEN]
      ,[PETHOS]
      ,[PETSYS]
      ,[PETNET]
      ,[PETVEN]
      ,[PETCTHOS]
      ,[PETCTSYS]
      ,[PETCTNET]
      ,[PETCTVEN]
      ,[SPECTHOS]
      ,[SPECTSYS]
      ,[SPECTNET]
      ,[SPECTVEN]
      ,[ULTSNHOS]
      ,[ULTSNSYS]
      ,[ULTSNNET]
      ,[ULTSNVEN]
      ,[IGRTHOS]
      ,[IGRTSYS]
      ,[IGRTNET]
      ,[IGRTVEN]
      ,[IMRTHOS]
      ,[IMRTSYS]
      ,[IMRTNET]
      ,[IMRTVEN]
      ,[PTONHOS]
      ,[PTONSYS]
      ,[PTONNET]
      ,[PTONVEN]
      ,[BEAMHOS]
      ,[BEAMSYS]
      ,[BEAMNET]
      ,[BEAMVEN]
      ,[SRADHOS]
      ,[SRADSYS]
      ,[SRADNET]
      ,[SRADVEN]
      ,[RETIRHOS]
      ,[RETIRSYS]
      ,[RETIRNET]
      ,[RETIRVEN]
      ,[ROBOHOS]
      ,[ROBOSYS]
      ,[ROBONET]
      ,[ROBOVEN]
      ,[RURLHOS]
      ,[RURLSYS]
      ,[RURLNET]
      ,[RURLVEN]
      ,[SLEPHOS]
      ,[SLEPSYS]
      ,[SLEPNET]
      ,[SLEPVEN]
      ,[SOCWKHOS]
      ,[SOCWKSYS]
      ,[SOCWKNET]
      ,[SOCWKVEN]
      ,[SPORTHOS]
      ,[SPORTSYS]
      ,[SPORTNET]
      ,[SPORTVEN]
      ,[SUPPGHOS]
      ,[SUPPGSYS]
      ,[SUPPGNET]
      ,[SUPPGVEN]
      ,[SWBDHOS]
      ,[SWBDSYS]
      ,[SWBDNET]
      ,[SWBDVEN]
      ,[TEENSHOS]
      ,[TEENSSYS]
      ,[TEENSNET]
      ,[TEENSVEN]
      ,[TOBHOS]
      ,[TOBSYS]
      ,[TOBNET]
      ,[TOBVEN]
      ,[OTBONHOS]
      ,[OTBONSYS]
      ,[OTBONNET]
      ,[OTBONVEN]
      ,[HARTHOS]
      ,[HARTSYS]
      ,[HARTNET]
      ,[HARTVEN]
      ,[KDNYHOS]
      ,[KDNYSYS]
      ,[KDNYNET]
      ,[KDNYVEN]
      ,[LIVRHOS]
      ,[LIVRSYS]
      ,[LIVRNET]
      ,[LIVRVEN]
      ,[LUNGHOS]
      ,[LUNGSYS]
      ,[LUNGNET]
      ,[LUNGVEN]
      ,[TISUHOS]
      ,[TISUSYS]
      ,[TISUNET]
      ,[TISUVEN]
      ,[OTOTHHOS]
      ,[OTOTHSYS]
      ,[OTOTHNET]
      ,[OTOTHVEN]
      ,[TPORTHOS]
      ,[TPORTSYS]
      ,[TPORTNET]
      ,[TPORTVEN]
      ,[URGCCHOS]
      ,[URGCCSYS]
      ,[URGCCNET]
      ,[URGCCVEN]
      ,[VRCSHOS]
      ,[VRCSSYS]
      ,[VRCSNET]
      ,[VRCSVEN]
      ,[VOLSVHOS]
      ,[VOLSVSYS]
      ,[VOLSVNET]
      ,[VOLSVVEN]
      ,[WOMHCHOS]
      ,[WOMHCSYS]
      ,[WOMHCNET]
      ,[WOMHCVEN]
      ,[WMGTHOS]
      ,[WMGTSYS]
      ,[WMGTNET]
      ,[WMGTVEN]
      ,[EXPTOT]
      ,[EXPTHA]
      ,[EXPTLA]
      ,[CPPCT]
      ,[CAPRSK]
      ,[DPEXA]
      ,[INTEXA]
      ,[SUPEXA]
      ,[NPAYBEN]
      ,[PAYTOT]
      ,[PAYTOTH]
      ,[NPAYBENH]
      ,[PAYTOTLT]
      ,[NPAYBENL]
      ,[LBEDSA]
      ,[BDTOT]
      ,[ADMTOT]
      ,[IPDTOT]
      ,[BDH]
      ,[ADMH]
      ,[IPDH]
      ,[LBEDLA]
      ,[BDLT]
      ,[ADMLT]
      ,[IPDLT]
      ,[MCRDC]
      ,[MCRIPD]
      ,[MCDDC]
      ,[MCDIPD]
      ,[MCRDCH]
      ,[MCRIPDH]
      ,[MCDDCH]
      ,[MCDIPDH]
      ,[MCRDCLT]
      ,[MCRIPDLT]
      ,[MCDDCLT]
      ,[MCDIPDLT]
      ,[BASSIN]
      ,[BIRTHS]
      ,[SUROPIP]
      ,[SUROPOP]
      ,[SUROPTOT]
      ,[VEM]
      ,[VOTH]
      ,[VTOT]
      ,[FTMDTF]
      ,[FTRES]
      ,[FTTRAN84]
      ,[FTRNTF]
      ,[FTLPNTF]
      ,[FTAST]
      ,[FTRAD]
      ,[FTLAB]
      ,[FTPHR]
      ,[FTPHT]
      ,[FTRESP]
      ,[FTOTHTF]
      ,[FTTOT]
      ,[PTMDTF]
      ,[PTRES]
      ,[PTTRAN84]
      ,[PTRNTF]
      ,[PTLPNTF]
      ,[PTAST]
      ,[PTRAD]
      ,[PTLAB]
      ,[PTPHR]
      ,[PTPHT]
      ,[PTRESP]
      ,[PTOTHTF]
      ,[PTTOT]
      ,[FTTOTH]
      ,[PTTOTH]
      ,[FTTOTLT]
      ,[PTTOTLT]
      ,[FTED]
      ,[FTER]
      ,[FTET]
      ,[FTEN]
      ,[FTEP]
      ,[FTEAP]
      ,[FTERAD]
      ,[FTELAB]
      ,[FTEPH]
      ,[FTEPHT]
      ,[FTERESP]
      ,[FTEO]
      ,[FTETF]
      ,[FTERNLT]
      ,[FTEU]
      ,[VMD]
      ,[VRES]
      ,[VTTRN]
      ,[VRN]
      ,[VLPN]
      ,[VAST]
      ,[VRAD]
      ,[VLAB]
      ,[VPHR]
      ,[VPHT]
      ,[VRSP]
      ,[VOTHL]
      ,[VTOTL]
      ,[VRNH]
      ,[VTNH]
      ,[ADC]
      ,[ADJADM]
      ,[ADJPD]
      ,[ADJADC]
      ,[FTEMD]
      ,[FTERN]
      ,[FTELPN]
      ,[FTERES]
      ,[FTETRAN]
      ,[FTETTRN]
      ,[FTEOTH94]
      ,[FTEH]
      ,[FTENH]
      ,[FTE]
      ,[OPRA]
      ,[EADMTOT]
      ,[EIPDTOT]
      ,[EADMH]
      ,[EIPDH]
      ,[EADMLT]
      ,[EIPDLT]
      ,[EMCRDC]
      ,[EMCRIPD]
      ,[EMCDDC]
      ,[EMCDIPD]
      ,[EMCRDCH]
      ,[EMCRIPDH]
      ,[EMCDDCH]
      ,[EMCDIPDH]
      ,[EMCRDCLT]
      ,[EMCRPDLT]
      ,[EMCDDCLT]
      ,[EMCDPDLT]
      ,[EBIRTHS]
      ,[ESUROPIP]
      ,[ESUROPOP]
      ,[ESUROPTO]
      ,[EVEM]
      ,[EVOTH]
      ,[EVTOT]
      ,[EPAYTOT]
      ,[ENPAYBEN]
      ,[EPAYTOTH]
      ,[ENPYBENH]
      ,[EPYTOTLT]
      ,[ENPBENLT]
      ,[EFTMDTF]
      ,[EFTRES]
      ,[EFTTRN84]
      ,[EFTRNTF]
      ,[EFTLPNTF]
      ,[EFTAST]
      ,[EFTRAD]
      ,[EFTLAB]
      ,[EFTPHR]
      ,[EFTPHT]
      ,[EFTRESP]
      ,[EFTOTHTF]
      ,[EFTTOT]
      ,[EPTMDTF]
      ,[EPTRES]
      ,[EPTTRN84]
      ,[EPTRNTF]
      ,[EPTLPNTF]
      ,[EPTAST]
      ,[EPTRAD]
      ,[EPTLAB]
      ,[EPTPHR]
      ,[EPTPHT]
      ,[EPTRESP]
      ,[EPTOTHTF]
      ,[EPTTOT]
      ,[EFTTOTH]
      ,[EPTTOTH]
      ,[EFTTOTLT]
      ,[EPTTOTLT]
      ,[EEXPTOT]
      ,[EXPTHB]
      ,[EXPTLB]
      ,[TECAR]
      ,[TEMER]
      ,[TEHSP]
	,[TEINT]
      ,[TEGST]
      ,[TEOTH]
      ,[TETOT]
      ,[TCCAR]
      ,[TCMER]
      ,[TCHSP]
      ,[TCINT]
      ,[TCGST]
      ,[TCOTH]
      ,[TCTOT]
      ,[TGCAR]
      ,[TGMER]
      ,[TGHSP]
      ,[TGINT]
      ,[TGGST]
      ,[TGOTH]
      ,[TGTOT]
      ,[NECAR]
      ,[NEMER]
      ,[NEHSP]
      ,[NEINT]
      ,[NEGST]
      ,[NEOTH]
      ,[NETOT]
      ,[TPCAR]
      ,[TPMER]
      ,[TPHSP]
      ,[TPINT]
      ,[TPGST]
      ,[TPOTH]
      ,[TPRTOT]
      ,[HSPTL]
      ,[FTEHSP]
      ,[INTCAR]
      ,[FTEMSI]
      ,[FTECIC]
      ,[FTENIC]
      ,[FTEPIC]
      ,[FTEOIC]
      ,[FTEINT]
      ,[CLSMSI]
      ,[CLSCIC]
      ,[CLSNIC]
      ,[CLSPIC]
      ,[CLSOIC]
      ,[CLSINT]
      ,[APRN]
      ,[FTAPRN]
      ,[PTAPRN]
      ,[FTEAPN]
      ,[APCAR]
      ,[APANES]
      ,[APEMER]
      ,[APSPC]
      ,[APED]
      ,[APCASE]
      ,[APOTH]
      ,[FORNRSA]
      ,[AFRICA]
      ,[KOREA]
      ,[CANADA]
      ,[PH]
      ,[CHINA]
      ,[INDIA]
      ,[OFRNRS]
      ,[PLNTA]
      ,[ADEPRA]
      ,[ASSNET]
      ,[GFEET]
      ,[CEAMT]
      ,[MMBTU]
      ,[MMBTR]
      ,[EHLTH]
      ,[ENDMARK])
	select  a.*
		,[TEINT]
      ,[TEGST]
      ,[TEOTH]
      ,[TETOT]
      ,[TCCAR]
      ,[TCMER]
      ,[TCHSP]
      ,[TCINT]
      ,[TCGST]
      ,[TCOTH]
      ,[TCTOT]
      ,[TGCAR]
      ,[TGMER]
      ,[TGHSP]
      ,[TGINT]
      ,[TGGST]
      ,[TGOTH]
      ,[TGTOT]
      ,[NECAR]
      ,[NEMER]
      ,[NEHSP]
      ,[NEINT]
      ,[NEGST]
      ,[NEOTH]
      ,[NETOT]
      ,[TPCAR]
      ,[TPMER]
      ,[TPHSP]
      ,[TPINT]
      ,[TPGST]
      ,[TPOTH]
      ,[TPRTOT]
      ,[HSPTL]
      ,[FTEHSP]
      ,[INTCAR]
      ,[FTEMSI]
      ,[FTECIC]
      ,[FTENIC]
      ,[FTEPIC]
      ,[FTEOIC]
      ,[FTEINT]
      ,[CLSMSI]
      ,[CLSCIC]
      ,[CLSNIC]
      ,[CLSPIC]
      ,[CLSOIC]
      ,[CLSINT]
      ,[APRN]
      ,[FTAPRN]
      ,[PTAPRN]
      ,[FTEAPN]
      ,[APCAR]
      ,[APANES]
      ,[APEMER]
      ,[APSPC]
      ,[APED]
      ,[APCASE]
      ,[APOTH]
      ,[FORNRSA]
      ,[AFRICA]
      ,[KOREA]
      ,[CANADA]
      ,[PH]
      ,[CHINA]
      ,[INDIA]
      ,[OFRNRS]
      ,[PLNTA]
      ,[ADEPRA]
      ,[ASSNET]
      ,[GFEET]
      ,[CEAMT]
      ,[MMBTU]
      ,[MMBTR]
      ,[EHLTH]
      ,[ENDMARK]
  	FROM [Isilon].[AHA].[annual2010_1] as a
  	inner join isilon.aha.annual2010_2 as b on a.id=b.id
) BY isilon;
quit;