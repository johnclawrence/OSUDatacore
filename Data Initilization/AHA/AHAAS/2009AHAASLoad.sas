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
DATA ANNUAL2009_1;

INfile 'X:\AHA\AHAAS Raw Data\FY2009 ASDB\FLAT\pubas09' lrecl=3273 recfm=f;				

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

CNTRL		$	42	-	43	   
SERV		$	44	-	45	   
SERVOTH		$	46	-	75	   
RADMCHI		$	76	-	76	   
HSACODE		$	77	-	81	   
HSANAME		$	82	-	106	   
HRRCODE		$	107	-	109	   
HRRNAME		$	110	-	134	   
MTYPE		$	135	-	136	   
MLOS		$	137	-	137	   
MNAME		$	138	-	227	   
MADMIN		$	228	-	319	   
MLOCADDR	$	320	-	379	   
MLOCCITY	$	380	-	399	   
MLOCSTCD	$	400	-	401	   
MLOCZIP		$	402	-	411	   
MSTATE		$	412	-	413	   
AREA		$	414	-	416	   
TELNO		$	417	-	423	   
RESP		$	424	-	424	   
CHC			$	425	-	425	   
BSC			$	426	-	426	   
MHSMEMB		$	427	-	427	   
SUBS		$	428	-	428	   
MNGT		$	429	-	429	   
MNGTNAME	$	430	-	489	   
MNGTCITY	$	490	-	509	   
MNGTSTCD	$	510	-	511	   
NETWRK		$	512	-	512	   
NETNAME		$	513	-	572	   
NETCT		$	573	-	602	   
NETSC		$	603	-	604	   
NETPHONE	$	605	-	614	   
GROUP		$	615	-	615	   
GPONAME		$	616	-	695	   
GPOCITY		$	696	-	715	   
GPOST		$	716	-	717	   
PHYGP		$	718	-	718	   
LTCHF		$	719	-	719	   
LTCHC		$	720	-	720	   
LTNM		$	721	-	750	   
LTCT		$	751	-	770	   
LTST		$	771	-	772	   
NPI			$	773	-	773	   
NPINUM			774	-	783	   
CLUSTER			784	-	784	   
SYSID		$	785	-	788	   
SYSNAME		$	789	-	873	   
SYSADDR		$	874	-	918	   
SYSCITY		$	919	-	938	   
SYSST		$	939	-	940	   
SYSZIP		$	941	-	950	   
SYSAREA		$	951	-	953	   
SYSTELN		$	954	-	961	   
SPC    		$	962	-	991	   
SYSTITLE	$	992	-	1071	   
COMMTY		$	1072-	1072	   
MCRNUM		$	1073-	1078	   
@1079 LAT 10.7					   
@1089 LONG 10.7					   
CNTYNAME	$	1099	-	1143	   
CBSANAME	$	1144	-	1203	   
CBSATYPE	$	1204	-	1211	   
LOS				$	1212	-	1212	   
CBSACODE    	$	1213	-	1217	   
MCNTYCD	$	1218	-	1220	   
FCOUNTY	$	1221	-	1225	   
FSTCD	$	1226	-	1227	   
FCNTYCD	$	1228	-	1230	   
CITYRK	$	1231	-	1233	   
MAPP1	$	1234	-	1234	   
MAPP2	$	1235	-	1235	   
MAPP3	$	1236	-	1236	   
MAPP5	$	1237	-	1237	   
MAPP6	$	1238	-	1238	   
MAPP7	$	1239	-	1239	   
MAPP8	$	1240	-	1240	   
MAPP9	$	1241	-	1241	   
MAPP10	$	1242	-	1242	   
MAPP11	$	1243	-	1243	   
MAPP12	$	1244	-	1244	   
MAPP13	$	1245	-	1245	   
MAPP16	$	1246	-	1246	   
MAPP17	$	1247	-	1247	   
MAPP18	$	1248	-	1248	   
MAPP19	$	1249	-	1249	   
MAPP20	$	1250	-	1250	   
MAPP21	$	1251	-	1251	   
AHAMBR	$	1252	-	1252	   
MISSION	$	1253	-	1253	   
LTPLAN	$	1254	-	1254	   
RESOURCE	$	1255	-	1255	   
BENEFIT	$	1256	-	1256	   
BUILD	$	1257	-	1257	   
FUND	$	1258	-	1258	   
HWELL	$	1259	-	1259	   
HSASSESS	$	1260	-	1260	   
HSIND	$	1261	-	1261	   
CAPASS	$	1262	-	1262	   
ASSUSE	$	1263	-	1263	   
CTRACK	$	1264	-	1264	   
QUALREP	$	1265	-	1265	   
GRACE	$	1266	-	1266	   
GLANG	$	1267	-	1267	   
ILEAD	$	1268	-	1268	   
DIVERS	$	1269	-	1269	   
ELEADS	$	1270	-	1270	   
DEVADM	$	1271	-	1271	   
SNT		$	1272	-	1272	   
TRIAGE	$	1273	-	1273	   
TRGOTH	$	1274	-	1323	   
SUNITS	$	1324	-	1324	   
IPAHOS	$	1325	-	1325	   
IPASYS	$	1326	-	1326	   
IPANET	$	1327	-	1327	   
GPWWHOS	$	1328	-	1328	   
GPWWSYS	$	1329	-	1329	   
GPWWNET	$	1330	-	1330	   
OPHOHOS	$	1331	-	1331	   
OPHOSYS	$	1332	-	1332	   
OPHONET	$	1333	-	1333	   
CPHOHOS	$	1334	-	1334	   
CPHOSYS	$	1335	-	1335	   
CPHONET	$	1336	-	1336	   
MSOHOS	$	1337	-	1337	   
MSOSYS	$	1338	-	1338	   
MSONET	$	1339	-	1339	   
ISMHOS	$	1340	-	1340	   
ISMSYS	$	1341	-	1341	   
ISMNET	$	1342	-	1342	   
EQMODHOS	$	1343	-	1343	   
EQMODSYS	$	1344	-	1344	   
EQMODNET	$	1345	-	1345	   
FOUNDHOS	$	1346	-	1346	   
FOUNDSYS	$	1347	-	1347	   
FOUNDNET	$	1348	-	1348	   
PHYOTH		$	1349	-	1398	   
PHYHOS		$	1399	-	1399	   
PHYSYS		$	1400	-	1400	   
PHYNET		$	1401	-	1401	   
IPHMOHOS	$	1402	-	1402	   
IPHMOSYS	$	1403	-	1403	   
IPHMONET	$	1404	-	1404	   
IPHMOVEN	$	1405	-	1405	   
IPPPOHOS	$	1406	-	1406	   
IPPPOSYS	$	1407	-	1407	   
IPPPONET	$	1408	-	1408	   
IPPPOVEN	$	1409	-	1409	   
IPFEEHOS	$	1410	-	1410	   
IPFEESYS	$	1411	-	1411	   
IPFEENET	$	1412	-	1412	   
IPFEEVEN	$	1413	-	1413	   
HMO86		$	1414	-	1414	   
HMOCON		$	1415	-	1418	   
PPO86		$	1419	-	1419	   
PPOCON		$	1420	-	1423	   
CAPCON94	$	1424	-	1424	   
CAPCOV	$	1425	-	1432	   
IPAP	$	1433	-	1440	   
GPWP	$	1441	-	1448	   
OPHP	$	1449	-	1456	   
CPHP	$	1457	-	1464	   
MSOP	$	1465	-	1472	   
ISMP	$	1473	-	1480	   
EQMP	$	1481	-	1488	   
FNDP	$	1489	-	1496	   
PHYP	$	1497	-	1504	   
JNTPH	$	1505	-	1505	   
JNLS	$	1506	-	1506	   
JNTAMB	$	1507	-	1507	   
JNTCTR	$	1508	-	1508	   
JNTOTH	$	1509	-	1509	   
LSHTXT	$	1510	-	1559	   
JNTLSC	$	1560	-	1560	   
JNTLSO	$	1561	-	1561	   
JNTLSS	$	1562	-	1562	   
JNTLST	$	1563	-	1563	   
JNTTXT	$	1564	-	1613	   
JNTMD	$	1614	-	1614	   
GENBD		1615	-	1618	   
PEDBD		1619	-	1622	   
OBBD		1623	-	1626	   
MSICBD		1627	-	1630	   
CICBD		1631	-	1634	   
NICBD		1635	-	1638	   
NINTBD		1639	-	1642	   
PEDICBD		1643	-	1646	   
BRNBD		1647	-	1650	   
OTHICBD		1651	-	1654	   
SPCICBD		1655	-	1658	   
REHABBD		1659	-	1662	   
ALCHBD		1663	-	1666	   
PSYBD		1667	-	1670	   
SNBD88		1671	-	1674	   
ICFBD88		1675	-	1678	   
ACULTBD		1679	-	1682	   
OTHLBD94	1683	-	1686	   
OTHBD94		1687	-	1690	   
HOSPBD		1691	-	1694	   
OBLEV		$	1695	-	1695	   
GENHOS		$	1696	-	1696	   
GENSYS		$	1697	-	1697	   
GENNET		$	1698	-	1698	   
GENVEN		$	1699	-	1699	   
PEDHOS		$	1700	-	1700	   
PEDSYS		$	1701	-	1701	   
PEDNET		$	1702	-	1702	   
PEDVEN		$	1703	-	1703	   
OBHOS		$	1704	-	1704	   
OBSYS		$	1705	-	1705	   
OBNET		$	1706	-	1706	   
OBVEN		$	1707	-	1707	   
MSICHOS		$	1708	-	1708	   
MSICSYS		$	1709	-	1709	   
MSICNET		$	1710	-	1710	   
MSICVEN		$	1711	-	1711	   
CICHOS		$	1712	-	1712	   
CICSYS		$	1713	-	1713	   
CICNET		$	1714	-	1714	   
CICVEN		$	1715	-	1715	   
NICHOS		$	1716	-	1716	   
NICSYS		$	1717	-	1717	   
NICNET		$	1718	-	1718	   
NICVEN		$	1719	-	1719	   
NINTHOS		$	1720	-	1720	   
NINTSYS		$	1721	-	1721	   
NINTNET		$	1722	-	1722	   
NINTVEN		$	1723	-	1723	   
PEDICHOS	$	1724	-	1724	   
PEDICSYS	$	1725	-	1725	   
PEDICNET	$	1726	-	1726	   
PEDICVEN	$	1727	-	1727	   
BRNHOS		$	1728	-	1728	   
BRNSYS		$	1729	-	1729	   
BRNNET		$	1730	-	1730	   
BRNVEN		$	1731	-	1731	   
SPCICHOS	$	1732	-	1732	   
SPCICSYS	$	1733	-	1733	   
SPCICNET	$	1734	-	1734	   
SPCICVEN	$	1735	-	1735	   
OTHIHOS		$	1736	-	1736	   
OTHISYS		$	1737	-	1737	   
OTHINET		$	1738	-	1738	   
OTHIVEN		$	1739	-	1739	   
REHABHOS	$	1740	-	1740	   
REHABSYS	$	1741	-	1741	   
REHABNET	$	1742	-	1742	   
REHABVEN	$	1743	-	1743	   
ALCHHOS		$	1744	-	1744	   
ALCHSYS		$	1745	-	1745	   
ALCHNET		$	1746	-	1746	   
ALCHVEN		$	1747	-	1747	   
PSYHOS		$	1748	-	1748	   
PSYSYS		$	1749	-	1749	   
PSYNET		$	1750	-	1750	   
PSYVEN		$	1751	-	1751	   
SNHOS		$	1752	-	1752	   
SNSYS		$	1753	-	1753	   
SNNET		$	1754	-	1754	   
SNVEN		$	1755	-	1755	   
ICFHOS		$	1756	-	1756	   
ICFSYS		$	1757	-	1757	   
ICFNET		$	1758	-	1758	   
ICFVEN		$	1759	-	1759	   
ACUHOS		$	1760	-	1760	   
ACUSYS		$	1761	-	1761	   
ACUNET		$	1762	-	1762	   
ACUVEN		$	1763	-	1763	   
OTHLTHOS	$	1764	-	1764	   
OTHLTSYS	$	1765	-	1765	   
OTHLTNET	$	1766	-	1766	   
OTHLTVEN	$	1767	-	1767	   
OTHCRHOS	$	1768	-	1768	   
OTHCRSYS	$	1769	-	1769	   
OTHCRNET	$	1770	-	1770	   
OTHCRVEN	$	1771	-	1771	   
ADULTHOS	$	1772	-	1772	   
ADULTSYS	$	1773	-	1773	   
ADULTNET	$	1774	-	1774	   
ADULTVEN	$	1775	-	1775	   
AIRBHOS		$	1776	-	1776	   
AIRBSYS		$	1777	-	1777	   
AIRBNET		$	1778	-	1778	   
AIRBVEN		$	1779	-	1779	   
AIRBROOM		1780	-	1783	   
ALCOPHOS	$	1784	-	1784	   
ALCOPSYS	$	1785	-	1785	   
ALCOPNET	$	1786	-	1786	   
ALCOPVEN	$	1787	-	1787	   
ALZHOS  	$	1788	-	1788	   
ALZSYS		$	1789	-	1789	   
ALZNET		$	1790	-	1790	   
ALZVEN		$	1791	-	1791	   
AMBHOS		$	1792	-	1792	   
AMBSYS		$	1793	-	1793	   
AMBNET		$	1794	-	1794	   
AMBVEN		$	1795	-	1795	   
AMBSHOS		$	1796	-	1796	   
AMBSSYS		$	1797	-	1797	   
AMBSNET		$	1798	-	1798	   
AMBSVEN		$	1799	-	1799	   
ARTHCHOS	$	1800	-	1800	   
ARTHCSYS	$	1801	-	1801	   
ARTHCNET	$	1802	-	1802	   
ARTHCVEN	$	1803	-	1803	   
ASSTLHOS	$	1804	-	1804	   
ASSTLSYS	$	1805	-	1805	   
ASSTLNET	$	1806	-	1806	   
ASSTLVEN	$	1807	-	1807	   
AUXHOS		$	1808	-	1808	   
AUXSYS		$	1809	-	1809	   
AUXNET		$	1810	-	1810	   
AUXVEN		$	1811	-	1811	   
BWHTHOS		$	1812	-	1812	   
BWHTSYS		$	1813	-	1813	   
BWHTNET		$	1814	-	1814	   
BWHTVEN		$	1815	-	1815	   
BROOMHOS	$	1816	-	1816	   
BROOMSYS	$	1817	-	1817	   
BROOMNET	$	1818	-	1818	   
BROOMVEN	$	1819	-	1819	   
BLDOHOS		$	1820	-	1820	   
BLDOSYS		$	1821	-	1821	   
BLDONET		$	1822	-	1822	   
BLDOVEN		$	1823	-	1823	   
MAMMSHOS	$	1824	-	1824	   
MAMMSSYS	$	1825	-	1825	   
MAMMSNET	$	1826	-	1826	   
MAMMSVEN	$	1827	-	1827	   
ACARDHOS	$	1828	-	1828	   
ACARDSYS	$	1829	-	1829	   
ACARDNET	$	1830	-	1830	   
ACARDVEN	$	1831	-	1831	   
PCARDHOS	$	1832	-	1832	   
PCARDSYS	$	1833	-	1833	   
PCARDNET	$	1834	-	1834	   
PCARDVEN	$	1835	-	1835	   
ACLABHOS	$	1836	-	1836	   
ACLABSYS	$	1837	-	1837	   
ACLABNET	$	1838	-	1838	   
ACLABVEN	$	1839	-	1839	   
PCLABHOS	$	1840	-	1840	   
PCLABSYS	$	1841	-	1841	   
PCLABNET	$	1842	-	1842	   
PCLABVEN	$	1843	-	1843	   
ICLABHOS	$	1844	-	1844	   
ICLABSYS	$	1845	-	1845	   
ICLABNET	$	1846	-	1846	   
ICLABVEN	$	1847	-	1847	   
PELABHOS	$	1848	-	1848	   
PELABSYS	$	1849	-	1849	   
PELABNET	$	1850	-	1850	   
PELABVEN	$	1851	-	1851	   
ADTCHOS		$	1852	-	1852	   
ADTCSYS		$	1853	-	1853	   
ADTCNET		$	1854	-	1854	   
ADTCVEN		$	1855	-	1855	   
PEDCSHOS	$	1856	-	1856	   
PEDCSSYS	$	1857	-	1857	   
PEDCSNET	$	1858	-	1858	   
PEDCSVEN	$	1859	-	1859	   
ADTEHOS		$	1860	-	1860	   
ADTESYS		$	1861	-	1861	   
ADTENET		$	1862	-	1862	   
ADTEVEN		$	1863	-	1863	   
PEDEHOS		$	1864	-	1864	   
PEDESYS		$	1865	-	1865	   
PEDENET		$	1866	-	1866	   
PEDEVEN		$	1867	-	1867	   
CHABHOS		$	1868	-	1868	   
CHABSYS		$	1869	-	1869	   
CHABNET		$	1870	-	1870	   
CHABVEN		$	1871	-	1871	   
CMNGTHOS	$	1872	-	1872	   
CMNGTSYS	$	1873	-	1873	   
CMNGTNET	$	1874	-	1874	   
CMNGTVEN	$	1875	-	1875	   
CHAPHOS		$	1876	-	1876	   
CHAPSYS		$	1877	-	1877	   
CHAPNET		$	1878	-	1878	   
CHAPVEN		$	1879	-	1879	   
CHTHHOS 	$	1880	-	1880	   
CHTHSYS 	$	1881	-	1881	   
CHTHNET 	$	1882	-	1882	   
CHTHVEN 	$	1883	-	1883	   
CWELLHOS	$	1884	-	1884	   
CWELLSYS	$	1885	-	1885	   
CWELLNET	$	1886	-	1886	   
CWELLVEN	$	1887	-	1887	   
CHIHOS		$	1888	-	1888	   
CHISYS		$	1889	-	1889	   
CHINET		$	1890	-	1890	   
CHIVEN		$	1891	-	1891	   
COUTRHOS	$	1892	-	1892	   
COUTRSYS	$	1893	-	1893	   
COUTRNET	$	1894	-	1894	   
COUTRVEN	$	1895	-	1895	   
COMPHOS		$	1896	-	1896	   
COMPSYS		$	1897	-	1897	   
COMPNET		$	1898	-	1898	   
COMPVEN		$	1899	-	1899	   
CAOSHOS		$	1900	-	1900	   
CAOSSYS		$	1901	-	1901	   
CAOSNET		$	1902	-	1902	   
CAOSVEN		$	1903	-	1903	   
CPREVHOS	$	1904	-	1904	   
CPREVSYS	$	1905	-	1905	   
CPREVNET	$	1906	-	1906	   
CPREVVEN	$	1907	-	1907	   
DENTSHOS	$	1908	-	1908	   
DENTSSYS	$	1909	-	1909	   
DENTSNET	$	1910	-	1910	   
DENTSVEN	$	1911	-	1911	   
EMDEPHOS	$	1912	-	1912	   
EMDEPSYS	$	1913	-	1913	   
EMDEPNET	$	1914	-	1914	   
EMDEPVEN	$	1915	-	1915	   
FSERHOS		$	1916	-	1916	   
FSERSYS		$	1917	-	1917	   
FSERNET		$	1918	-	1918	   
FSERVEN		$	1919	-	1919	   
FSERYN		$	1920	-	1920	   
TRAUMHOS	$	1921	-	1921	   
TRAUMSYS	$	1922	-	1922	   
TRAUMNET	$	1923	-	1923	   
TRAUMVEN	$	1924	-	1924	   
TRAUML90	$	1925	-	1925	   
ENBHOS		$	1926	-	1926	   
ENBSYS		$	1927	-	1927	   
ENBNET		$	1928	-	1928	   
ENBVEN		$	1929	-	1929	   
ENDOCHOS	$	1930	-	1930	   
ENDOCSYS	$	1931	-	1931	   
ENDOCNET	$	1932	-	1932	   
ENDOCVEN	$	1933	-	1933	   
ENDOUHOS	$	1934	-	1934	   
ENDOUSYS	$	1935	-	1935	   
ENDOUNET	$	1936	-	1936	   
ENDOUVEN	$	1937	-	1937	   
ENDOAHOS	$	1938	-	1938	   
ENDOASYS	$	1939	-	1939	   
ENDOANET	$	1940	-	1940	   
ENDOAVEN	$	1941	-	1941	   
ENDOEHOS	$	1942	-	1942	   
ENDOESYS	$	1943	-	1943	   
ENDOENET	$	1944	-	1944	   
ENDOEVEN	$	1945	-	1945	   
ENDORHOS	$	1946	-	1946	   
ENDORSYS	$	1947	-	1947	   
ENDORNET	$	1948	-	1948	   
ENDORVEN	$	1949	-	1949	   
ENRHOS		$	1950	-	1950	   
ENRSYS		$	1951	-	1951	   
ENRNET		$	1952	-	1952	   
ENRVEN		$	1953	-	1953	   
ESWLHOS		$	1954	-	1954	   
ESWLSYS		$	1955	-	1955	   
ESWLNET		$	1956	-	1956	   
ESWLVEN		$	1957	-	1957	   
FRTCHOS 	$	1958	-	1958	   
FRTCSYS 	$	1959	-	1959	   
FRTCNET 	$	1960	-	1960	   
FRTCVEN 	$	1961	-	1961	   
FITCHOS		$	1962	-	1962	   
FITCSYS		$	1963	-	1963	   
FITCNET		$	1964	-	1964	   
FITCVEN		$	1965	-	1965	   
OPCENHOS	$	1966	-	1966	   
OPCENSYS	$	1967	-	1967	   
OPCENNET	$	1968	-	1968	   
OPCENVEN	$	1969	-	1969	   
GERSVHOS	$	1970	-	1970	   
GERSVSYS	$	1971	-	1971	   
GERSVNET	$	1972	-	1972	   
GERSVVEN	$	1973	-	1973	   
HLTHFHOS	$	1974	-	1974	   
HLTHFSYS	$	1975	-	1975	   
HLTHFNET	$	1976	-	1976	   
HLTHFVEN	$	1977	-	1977	   
HLTHCHOS	$	1978	-	1978	   
HLTHCSYS	$	1979	-	1979	   
HLTHCNET	$	1980	-	1980	   
HLTHCVEN	$	1981	-	1981	   
GNTCHOS 	$	1982	-	1982	   
GNTCSYS 	$	1983	-	1983	   
GNTCNET 	$	1984	-	1984	   
GNTCVEN 	$	1985	-	1985	   
HLTHSHOS	$	1986	-	1986	   
HLTHSSYS	$	1987	-	1987	   
HLTHSNET	$	1988	-	1988	   
HLTHSVEN	$	1989	-	1989	   
HLTRHOS		$	1990	-	1990	   
HLTRSYS		$	1991	-	1991	   
HLTRNET		$	1992	-	1992	   
HLTRVEN		$	1993	-	1993	   
HEMOHOS		$	1994	-	1994	   
HEMOSYS		$	1995	-	1995	   
HEMONET		$	1996	-	1996	   
HEMOVEN		$	1997	-	1997	   
AIDSSHOS	$	1998	-	1998	   
AIDSSSYS	$	1999	-	1999	   
AIDSSNET	$	2000	-	2000	   
AIDSSVEN	$	2001	-	2001	   
HOMEHHOS	$	2002	-	2002	   
HOMEHSYS	$	2003	-	2003	   
HOMEHNET	$	2004	-	2004	   
HOMEHVEN	$	2005	-	2005	   
HOSPCHOS	$	2006	-	2006	   
HOSPCSYS	$	2007	-	2007	   
HOSPCNET	$	2008	-	2008	   
HOSPCVEN	$	2009	-	2009	   
OPHOSHOS	$	2010	-	2010	   
OPHOSSYS	$	2011	-	2011	   
OPHOSNET	$	2012	-	2012	   
OPHOSVEN	$	2013	-	2013	   
IMPRHOS		$	2014	-	2014	   
IMPRSYS		$	2015	-	2015	   
IMPRNET		$	2016	-	2016	   
IMPRVEN		$	2017	-	2017	   
ICARHOS		$	2018	-	2018	   
ICARSYS		$	2019	-	2019	   
ICARNET		$	2020	-	2020	   
ICARVEN		$	2021	-	2021	   
LINGHOS		$	2022	-	2022	   
LINGSYS		$	2023	-	2023	   
LINGNET		$	2024	-	2024	   
LINGVEN		$	2025	-	2025	   
MEALSHOS	$	2026	-	2026	   
MEALSSYS	$	2027	-	2027	   
MEALSNET	$	2028	-	2028	   
MEALSVEN	$	2029	-	2029	   
MOHSHOS		$	2030	-	2030	   
MOHSSYS		$	2031	-	2031	   
MOHSNET		$	2032	-	2032	   
MOHSVEN		$	2033	-	2033	   
NEROHOS		$	2034	-	2034	   
NEROSYS		$	2035	-	2035	   
NERONET		$	2036	-	2036	   
NEROVEN		$	2037	-	2037	   
NUTRPHOS	$	2038	-	2038	   
NUTRPSYS	$	2039	-	2039	   
NUTRPNET	$	2040	-	2040	   
NUTRPVEN	$	2041	-	2041	   
OCCHSHOS	$	2042	-	2042	   
OCCHSSYS	$	2043	-	2043	   
OCCHSNET	$	2044	-	2044	   
OCCHSVEN	$	2045	-	2045	   
ONCOLHOS	$	2046	-	2046	   
ONCOLSYS	$	2047	-	2047	   
ONCOLNET	$	2048	-	2048	   
ONCOLVEN	$	2049	-	2049	   
ORTOHOS		$	2050	-	2050	   
ORTOSYS		$	2051	-	2051	   
ORTONET		$	2052	-	2052	   
ORTOVEN		$	2053	-	2053	   
OPSRGHOS	$	2054	-	2054	   
OPSRGSYS	$	2055	-	2055	   
OPSRGNET	$	2056	-	2056	   
OPSRGVEN	$	2057	-	2057	   
PAINHOS		$	2058	-	2058	   
PAINSYS		$	2059	-	2059	   
PAINNET		$	2060	-	2060	   
PAINVEN		$	2061	-	2061	   
PALHOS		$	2062	-	2062	   
PALSYS		$	2063	-	2063	   
PALNET		$	2064	-	2064	   
PALVEN		$	2065	-	2065	   
IPALHOS		$	2066	-	2066	   
IPALSYS		$	2067	-	2067	   
IPALNET		$	2068	-	2068	   
IPALVEN		$	2069	-	2069	   
PCAHOS		$	2070	-	2070	   
PCASYS		$	2071	-	2071	   
PCANET		$	2072	-	2072	   
PCAVEN		$	2073	-	2073	   
PATEDHOS	$	2074	-	2074	   
PATEDSYS	$	2075	-	2075	   
PATEDNET	$	2076	-	2076	   
PATEDVEN	$	2077	-	2077	   
PATRPHOS	$	2078	-	2078	   
PATRPSYS	$	2079	-	2079	   
PATRPNET	$	2080	-	2080	   
PATRPVEN	$	2081	-	2081	   
RASTHOS		$	2082	-	2082	   
RASTSYS		$	2083	-	2083	   
RASTNET		$	2084	-	2084	   
RASTVEN		$	2085	-	2085	   
REDSHOS		$	2086	-	2086	   
REDSSYS		$	2087	-	2087	   
REDSNET		$	2088	-	2088	   
REDSVEN		$	2089	-	2089	   
RHBOPHOS	$	2090	-	2090	   
RHBOPSYS	$	2091	-	2091	   
RHBOPNET	$	2092	-	2092	   
RHBOPVEN	$	2093	-	2093	   
RPRSHOS		$	2094	-	2094	   
RPRSSYS		$	2095	-	2095	   
RPRSNET		$	2096	-	2096	   
RPRSVEN		$	2097	-	2097	   
RBOTHOS		$	2098	-	2098	   
RBOTSYS		$	2099	-	2099	   
RBOTNET		$	2100	-	2100	   
RBOTVEN		$	2101	-	2101	   
RSIMHOS		$	2102	-	2102	   
RSIMSYS		$	2103	-	2103	   
RSIMNET		$	2104	-	2104	   
RSIMVEN		$	2105	-	2105	   
PCDEPHOS	$	2106	-	2106	   
PCDEPSYS	$	2107	-	2107	   
PCDEPNET	$	2108	-	2108	   
PCDEPVEN	$	2109	-	2109	   
PSYCAHOS	$	2110	-	2110	   
PSYCASYS	$	2111	-	2111	   
PSYCANET	$	2112	-	2112	   
PSYCAVEN	$	2113	-	2113	   
PSYLSHOS	$	2114	-	2114	   
PSYLSSYS	$	2115	-	2115	   
PSYLSNET	$	2116	-	2116	   
PSYLSVEN	$	2117	-	2117	   
PSYEDHOS	$	2118	-	2118	   
PSYEDSYS	$	2119	-	2119	   
PSYEDNET	$	2120	-	2120	   
PSYEDVEN	$	2121	-	2121	   
PSYEMHOS	$	2122	-	2122	   
PSYEMSYS	$	2123	-	2123	   
PSYEMNET	$	2124	-	2124	   
PSYEMVEN	$	2125	-	2125	   
PSYGRHOS	$	2126	-	2126	   
PSYGRSYS	$	2127	-	2127	   
PSYGRNET	$	2128	-	2128	   
PSYGRVEN	$	2129	-	2129	   
PSYOPHOS	$	2130	-	2130	   
PSYOPSYS	$	2131	-	2131	   
PSYOPNET	$	2132	-	2132	   
PSYOPVEN	$	2133	-	2133	   
PSYPHHOS	$	2134	-	2134	   
PSYPHSYS	$	2135	-	2135	   
PSYPHNET	$	2136	-	2136	   
PSYPHVEN	$	2137	-	2137	   
CTSCNHOS	$	2138	-	2138	   
CTSCNSYS	$	2139	-	2139	   
CTSCNNET	$	2140	-	2140	   
CTSCNVEN	$	2141	-	2141	   
DRADFHOS	$	2142	-	2142	   
DRADFSYS	$	2143	-	2143	   
DRADFNET	$	2144	-	2144	   
DRADFVEN	$	2145	-	2145	   
EBCTHOS 	$	2146	-	2146	   
EBCTSYS 	$	2147	-	2147	   
EBCTNET 	$	2148	-	2148	   
EBCTVEN 	$	2149	-	2149	   
FFDMHOS		$	2150	-	2150	   
FFDMSYS		$	2151	-	2151	   
FFDMNET		$	2152	-	2152	   
FFDMVEN		$	2153	-	2153	   
MRIHOS		$	2154	-	2154	   
MRISYS		$	2155	-	2155	   
MRINET		$	2156	-	2156	   
MRIVEN		$	2157	-	2157	   
IMRIHOS		$	2158	-	2158	   
IMRISYS		$	2159	-	2159	   
IMRINET		$	2160	-	2160	   
IMRIVEN		$	2161	-	2161	   
MSCTHOS 	$	2162	-	2162	   
MSCTSYS 	$	2163	-	2163	   
MSCTNET 	$	2164	-	2164	   
MSCTVEN 	$	2165	-	2165	   
MSCTGHOS	$	2166	-	2166	   
MSCTGSYS	$	2167	-	2167	   
MSCTGNET	$	2168	-	2168	   
MSCTGVEN	$	2169	-	2169	   
PETHOS		$	2170	-	2170	   
PETSYS		$	2171	-	2171	   
PETNET		$	2172	-	2172	   
PETVEN		$	2173	-	2173	   
PETCTHOS	$	2174	-	2174	   
PETCTSYS	$	2175	-	2175	   
PETCTNET	$	2176	-	2176	   
PETCTVEN	$	2177	-	2177	   
SPECTHOS	$	2178	-	2178	   
SPECTSYS	$	2179	-	2179	   
SPECTNET	$	2180	-	2180	   
SPECTVEN	$	2181	-	2181	   
ULTSNHOS	$	2182	-	2182	   
ULTSNSYS	$	2183	-	2183	   
ULTSNNET	$	2184	-	2184	   
ULTSNVEN	$	2185	-	2185	   
IGRTHOS		$	2186	-	2186	   
IGRTSYS		$	2187	-	2187	   
IGRTNET		$	2188	-	2188	   
IGRTVEN		$	2189	-	2189	   
IMRTHOS 	$	2190	-	2190	   
IMRTSYS 	$	2191	-	2191	   
IMRTNET 	$	2192	-	2192	   
IMRTVEN 	$	2193	-	2193	   
PTONHOS		$	2194	-	2194	   
PTONSYS		$	2195	-	2195	   
PTONNET		$	2196	-	2196	   
PTONVEN		$	2197	-	2197	   
BEAMHOS		$	2198	-	2198	   
BEAMSYS		$	2199	-	2199	   
BEAMNET		$	2200	-	2200	   
BEAMVEN		$	2201	-	2201	   
SRADHOS		$	2202	-	2202	   
SRADSYS		$	2203	-	2203	   
SRADNET		$	2204	-	2204	   
SRADVEN		$	2205	-	2205	   
RETIRHOS	$	2206	-	2206	   
RETIRSYS	$	2207	-	2207	   
RETIRNET	$	2208	-	2208	   
RETIRVEN	$	2209	-	2209	   
ROBOHOS		$	2210	-	2210	   
ROBOSYS		$	2211	-	2211	   
ROBONET		$	2212	-	2212	   
ROBOVEN		$	2213	-	2213	   
SLEPHOS		$	2214	-	2214	   
SLEPSYS		$	2215	-	2215	   
SLEPNET		$	2216	-	2216	   
SLEPVEN		$	2217	-	2217	   
SOCWKHOS	$	2218	-	2218	   
SOCWKSYS	$	2219	-	2219	   
SOCWKNET	$	2220	-	2220	   
SOCWKVEN	$	2221	-	2221	   
SPORTHOS	$	2222	-	2222	   
SPORTSYS	$	2223	-	2223	   
SPORTNET	$	2224	-	2224	   
SPORTVEN	$	2225	-	2225	   
SUPPGHOS	$	2226	-	2226	   
SUPPGSYS	$	2227	-	2227	   
SUPPGNET	$	2228	-	2228	   
SUPPGVEN	$	2229	-	2229	   
SWBDHOS		$	2230	-	2230	   
SWBDSYS		$	2231	-	2231	   
SWBDNET		$	2232	-	2232	   
SWBDVEN		$	2233	-	2233	   
TEENSHOS	$	2234	-	2234	   
TEENSSYS	$	2235	-	2235	   
TEENSNET	$	2236	-	2236	   
TEENSVEN	$	2237	-	2237	   
TOBHOS		$	2238	-	2238	   
TOBSYS		$	2239	-	2239	   
TOBNET		$	2240	-	2240	   
TOBVEN		$	2241	-	2241	   
OTBONHOS	$	2242	-	2242	   
OTBONSYS	$	2243	-	2243	   
OTBONNET	$	2244	-	2244	   
OTBONVEN	$	2245	-	2245	   
HARTHOS		$	2246	-	2246	   
HARTSYS		$	2247	-	2247	   
HARTNET		$	2248	-	2248	   
HARTVEN		$	2249	-	2249	   
KDNYHOS		$	2250	-	2250	   
KDNYSYS		$	2251	-	2251	   
KDNYNET		$	2252	-	2252	   
KDNYVEN		$	2253	-	2253	   
LIVRHOS		$	2254	-	2254	   
LIVRSYS		$	2255	-	2255	   
LIVRNET		$	2256	-	2256	   
LIVRVEN		$	2257	-	2257	   
LUNGHOS		$	2258	-	2258	   
LUNGSYS		$	2259	-	2259	   
LUNGNET		$	2260	-	2260	   
LUNGVEN		$	2261	-	2261	   
TISUHOS		$	2262	-	2262	   
TISUSYS		$	2263	-	2263	   
TISUNET		$	2264	-	2264	   
TISUVEN		$	2265	-	2265	   
OTOTHHOS	$	2266	-	2266	   
OTOTHSYS	$	2267	-	2267	   
OTOTHNET	$	2268	-	2268	   
OTOTHVEN	$	2269	-	2269	   
TPORTHOS	$	2270	-	2270	   
TPORTSYS	$	2271	-	2271	   
TPORTNET	$	2272	-	2272	   
TPORTVEN	$	2273	-	2273	   
URGCCHOS	$	2274	-	2274	   
URGCCSYS	$	2275	-	2275	   
URGCCNET	$	2276	-	2276	   
URGCCVEN	$	2277	-	2277	   
VRCSHOS		$	2278	-	2278	   
VRCSSYS		$	2279	-	2279	   
VRCSNET		$	2280	-	2280	   
VRCSVEN		$	2281	-	2281	   
VOLSVHOS	$	2282	-	2282	   
VOLSVSYS	$	2283	-	2283	   
VOLSVNET	$	2284	-	2284	   
VOLSVVEN	$	2285	-	2285	   
WOMHCHOS	$	2286	-	2286	   
WOMHCSYS	$	2287	-	2287	   
WOMHCNET	$	2288	-	2288	   
WOMHCVEN	$	2289	-	2289	   
WMGTHOS		$	2290	-	2290	   
WMGTSYS		$	2291	-	2291	   
WMGTNET		$	2292	-	2292	   
WMGTVEN		$   2293	-	2293	   
EXPTOT		2294	-	2303	   
EXPTHA		2304	-	2318	   
EXPTLA		2319	-	2333	   
CPPCT		2334	-	2337	   
CAPRSK		2338	-	2341	   
PAYTOT		2342	-	2351	   
NPAYBEN		2352	-	2361	   
PAYTOTH		2362	-	2371	   
NPAYBENH	2372	-	2381	   
PAYTOTLT	2382	-	2391	   
NPAYBENL	2392	-	2401	   
LBEDSA		2402	-	2407	   
BDTOT		2408	-	2411	   
ADMTOT		2412	-	2417	   
IPDTOT		2418	-	2425	   
BDH			2426	-	2429	   
ADMH		2430	-	2435	   
IPDH		2436	-	2443	   
LBEDLA		2444	-	2449	   
BDLT		2450	-	2453	   
ADMLT		2454	-	2459	   
IPDLT		2460	-	2467	   
MCRDC		2468	-	2473	   
MCRIPD		2474	-	2481	   
MCDDC		2482	-	2487	   
MCDIPD		2488	-	2495	   
MCRDCH		2496	-	2501	   
MCRIPDH		2502	-	2509	   
MCDDCH		2510	-	2515	   
MCDIPDH		2516	-	2523	   
MCRDCLT		2524	-	2529	   
MCRIPDLT	2530	-	2537	   
MCDDCLT		2538	-	2543	   
MCDIPDLT	2544	-	2551	   
BASSIN		2552	-	2555	   
BIRTHS		2556	-	2561	   
SUROPIP		2562	-	2567	   
SUROPOP		2568	-	2573	   
SUROPTOT	2574	-	2579	   
VEM			2580	-	2587	   
VOTH		2588	-	2595	   
VTOT		2596	-	2603	   
FTMDTF		2604	-	2608	   
FTRES		2609	-	2613	   
FTTRAN84	2614	-	2618	   
FTRNTF		2619	-	2623	   
FTLPNTF		2624	-	2628	   
FTAST		2629	-	2633	   
FTRAD		2634	-	2638	   
FTLAB		2639	-	2643	   
FTPHR		2644	-	2648	   
FTPHT		2649	-	2653	   
FTRESP		2654	-	2658	   
FTOTHTF		2659	-	2663	   
FTTOT		2664	-	2668	   
PTMDTF		2669	-	2673	   
PTRES		2674	-	2678	   
PTTRAN84	2679	-	2683	   
PTRNTF		2684	-	2688	   
PTLPNTF		2689	-	2693	   
PTAST		2694	-	2698	   
PTRAD		2699	-	2703	   
PTLAB		2704	-	2708	   
PTPHR		2709	-	2713	   
PTPHT		2714	-	2718	   
PTRESP		2719	-	2723	   
PTOTHTF		2724	-	2728	   
PTTOT		2729	-	2733	   
FTTOTH		2734	-	2738	   
PTTOTH		2739	-	2743	   
FTTOTLT		2744	-	2748	   
PTTOTLT		2749	-	2753	   
FTED    	2754	-	2761	   
FTER    	2762	-	2769	   
FTET    	2770	-	2777	   
FTEN    	2778	-	2785	   
FTEP    	2786	-	2793	   
FTEAP   	2794	-	2801	   
FTERAD		2802	-	2809	   
FTELAB		2810	-	2817	   
FTEPH		2818	-	2825	   
FTEPHT		2826	-	2833	   
FTERESP		2834	-	2841	   
FTEO    	2842	-	2849	   
FTETF   	2850	-	2857	   
FTEU    	2858	-	2865	   
ADC			2866	-	2873	   
ADJADM		2874	-	2881	   
ADJPD		2882	-	2889	   
ADJADC		2890	-	2897	   
FTEMD		2898	-	2905	   
FTERN		2906	-	2913	   
FTELPN		2914	-	2921	   
FTERES		2922	-	2929	   
FTETRAN		2930	-	2937	   
FTETTRN		2938	-	2945	   
FTEOTH94	2946	-	2953	   
FTEH		2954	-	2961	   
FTENH		2962	-	2969	   
FTE		    2970	-	2977	   
OPRA		2978	-	2981	   
EADMTOT		$	2982	-	2982	   
EIPDTOT		$	2983	-	2983	   
EADMH		$	2984	-	2984	   
EIPDH		$	2985	-	2985	   
EADMLT		$	2986	-	2986	   
EIPDLT		$	2987	-	2987	   
EMCRDC		$	2988	-	2988	   
EMCRIPD		$	2989	-	2989	   
EMCDDC		$	2990	-	2990	   
EMCDIPD		$	2991	-	2991	   
EMCRDCH		$	2992	-	2992	   
EMCRIPDH	$	2993	-	2993	   
EMCDDCH		$	2994	-	2994	   
EMCDIPDH	$	2995	-	2995	   
EMCRDCLT	$	2996	-	2996	   
EMCRPDLT	$	2997	-	2997	   
EMCDDCLT	$	2998	-	2998	   
EMCDPDLT	$	2999	-	2999	   
EBIRTHS		$	3000	-	3000	   
ESUROPIP	$	3001	-	3001	   
ESUROPOP	$	3002	-	3002	   
ESUROPTO	$	3003	-	3003	   
EVEM		$	3004	-	3004	   
EVOTH		$	3005	-	3005	   
EVTOT		$	3006	-	3006	   
EPAYTOT		$	3007	-	3007	   
ENPAYBEN	$	3008	-	3008	   
EPAYTOTH	$	3009	-	3009	   
ENPYBENH	$	3010	-	3010	   
EPYTOTLT	$	3011	-	3011	   
ENPBENLT	$	3012	-	3012	   
EFTMDTF		$	3013	-	3013	   
EFTRES		$	3014	-	3014	   
EFTTRN84	$	3015	-	3015	   
EFTRNTF		$	3016	-	3016	   
EFTLPNTF	$	3017	-	3017	   
EFTAST		$	3018	-	3018	   
EFTRAD		$	3019	-	3019	   
EFTLAB		$	3020	-	3020	   
EFTPHR		$	3021	-	3021	   
EFTPHT		$	3022	-	3022	   
EFTRESP		$	3023	-	3023	   
EFTOTHTF	$	3024	-	3024	   
EFTTOT		$	3025	-	3025	   
EPTMDTF		$	3026	-	3026	   
EPTRES		$	3027	-	3027	   
EPTTRN84	$	3028	-	3028	   
EPTRNTF		$	3029	-	3029	   
EPTLPNTF	$	3030	-	3030	   
EPTAST		$	3031	-	3031	   
EPTRAD		$	3032	-	3032	   
EPTLAB		$	3033	-	3033	   
EPTPHR		$	3034	-	3034	   
EPTPHT		$	3035	-	3035	   
EPTRESP		$	3036	-	3036	   
EPTOTHTF	$	3037	-	3037	   
EPTTOT		$	3038	-	3038	   
EFTTOTH		$	3039	-	3039	   
EPTTOTH		$	3040	-	3040	   
EFTTOTLT	$	3041	-	3041	   
EPTTOTLT	$	3042	-	3042	   
EEXPTOT		$	3043	-	3043	   
EXPTHB		$	3044	-	3044	   
EXPTLB		$   3045	-	3045	   
HSPTL    	$	3046	-	3046	   
HSPFT    		3047	-	3054	   
HSPPT    		3055	-	3062	   
HSPGP    	$	3063	-	3063	   
HSPPG    	$	3064	-	3064	   
HSPETH   	$	3065	-	3065	   
HSPUP    	$	3066	-	3066	   
HSPOTH   	$	3067	-	3067	   
FTEHSP			3068	-	3075	   
INTCAR		$	3076	-	3076	   
FTMSIA			3077	-	3081	   
FTCICA			3082	-	3086	   
FTNICA			3087	-	3091	   
FTPICA			3092	-	3096	   
FTOICA			3097	-	3101	   
FTTINTA			3102	-	3106	   
PTMSIA			3107	-	3111	   
PTCICA			3112	-	3116	   
PTNICA			3117	-	3121	   
PTPICA			3122	-	3126	   
PTOICA			3127	-	3131	   
PTTINTA			3132	-	3136	   
FTEMSI			3137	-	3144	   
FTECIC			3145	-	3152	   
FTENIC			3153	-	3160	   
FTEPIC			3161	-	3168	   
FTEOIC			3169	-	3176	   
FTEINT			3177	-	3184	   
MSIC1		$	3185	-	3188	   
CIC1		$	3189	-	3192	   
NIC1		$	3193	-	3196	   
PIC1		$	3197	-	3200	   
OIC1		$	3201	-	3204	   

;
;	
RUN;	
proc contents data=annual2009_1;run;				

DATA ANNUAL2009_2;

INfile 'X:\AHA\AHAAS Raw Data\FY2009 ASDB\FLAT\pubas09' lrecl=3273 recfm=f;				

INPUT
@0001   ID             $7.
FORNRSA		$	3205	-	3205	   
AFRICA		$	3206	-	3206	   
KOREA		$	3207	-	3207	   
CANADA		$	3208	-	3208	   
PH			$	3209	-	3209	   
CHINA		$	3210	-	3210	   
INDIA		$	3211	-	3211	   
OFRNRS		$	3212	-	3212	   
PLNTA			3213	-	3222	   
ADEPRA			3223	-	3232	   
ASSNET			3233	-	3242	   
GFEET			3243	-	3252	   
CEAMT			3253	-	3262	   
MMBTU			3263	-	3268	   
MMBTR			3269	-	3271	   
EHLTH		$	3272	-	3272	   
ENDMARK 	$	3273	-	3273	   

;
;	
RUN;			
proc contents data=annual2009_2;run;


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.annual2009_1 
like work.annual2009_1;

proc SQL;
insert into isilon.annual2009_1
select * from work.annual2009_1;

proc SQL;
create table isilon.annual2009_2 
like work.annual2009_2;

proc SQL;
insert into isilon.annual2009_2
select * from work.annual2009_2;

*Create the all table by combining all the columns from table 1 and 2.;
*because of SQL limitations, make the variables after the 1000 variable sparse (other than the last one);
PROC SQL;
CONNECT using isilon;
EXECUTE(
CREATE TABLE [AHA].[annual2009](
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
	[PHYGP] [varchar](1) NULL,
	[LTCHF] [varchar](1) NULL,
	[LTCHC] [varchar](1) NULL,
	[LTNM] [varchar](30) NULL,
	[LTCT] [varchar](20) NULL,
	[LTST] [varchar](2) NULL,
	[NPI] [varchar](1) NULL,
	[NPINUM] [float] NULL,
	[CLUSTER] [float] NULL,
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
	[MAPP17] [varchar](1) NULL,
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
	[HMOCON] [varchar](4) NULL,
	[PPO86] [varchar](1) NULL,
	[PPOCON] [varchar](4) NULL,
	[CAPCON94] [varchar](1) NULL,
	[CAPCOV] [varchar](8) NULL,
	[IPAP] [varchar](8) NULL,
	[GPWP] [varchar](8) NULL,
	[OPHP] [varchar](8) NULL,
	[CPHP] [varchar](8) NULL,
	[MSOP] [varchar](8) NULL,
	[ISMP] [varchar](8) NULL,
	[EQMP] [varchar](8) NULL,
	[FNDP] [varchar](8) NULL,
	[PHYP] [varchar](8) NULL,
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
	[PAYTOT] [float] NULL,
	[NPAYBEN] [float] NULL,
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
	[FTEU] [float] NULL,
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
	[EPTTOTLT] [varchar](1) NULL,
	[EEXPTOT] [varchar](1) NULL,
	[EXPTHB] [varchar](1) NULL,
	[EXPTLB] [varchar](1) NULL,
	[HSPTL] [varchar](1) NULL,
	[HSPFT] [float] NULL,
	[HSPPT] [float] NULL,
	[HSPGP] [varchar](1) NULL,
	[HSPPG] [varchar](1) NULL,
	[HSPETH] [varchar](1) NULL,
	[HSPUP] [varchar](1) NULL,
	[HSPOTH] [varchar](1) NULL,
	[FTEHSP] [float] NULL,
	[INTCAR] [varchar](1) NULL,
	[FTMSIA] [float] NULL,
	[FTCICA] [float] NULL,
	[FTNICA] [float] NULL,
	[FTPICA] [float] NULL,
	[FTOICA] [float] NULL,
	[FTTINTA] [float] NULL,
	[PTMSIA] [float] NULL,
	[PTCICA] [float] NULL,
	[PTNICA] [float] NULL,
	[PTPICA] [float] NULL,
	[PTOICA] [float] NULL,
	[PTTINTA] [float] NULL,
	[FTEMSI] [float] NULL,
	[FTECIC] [float] NULL,
	[FTENIC] [float] NULL,
	[FTEPIC] [float] NULL,
	[FTEOIC] [float] NULL,
	[FTEINT] [float] NULL,
	[MSIC1] [varchar](4) NULL,
	[CIC1] [varchar](4) NULL,
	[NIC1] [varchar](4) NULL,
	[PIC1] [varchar](4) NULL,
	[OIC1] [varchar](4) NULL,
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
	insert into AHA.annual2009([ID]
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
      ,[MAPP17]
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
      ,[PAYTOT]
      ,[NPAYBEN]
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
      ,[FTEU]
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
      ,[HSPTL]
      ,[HSPFT]
      ,[HSPPT]
      ,[HSPGP]
      ,[HSPPG]
      ,[HSPETH]
      ,[HSPUP]
      ,[HSPOTH]
      ,[FTEHSP]
      ,[INTCAR]
      ,[FTMSIA]
      ,[FTCICA]
      ,[FTNICA]
      ,[FTPICA]
      ,[FTOICA]
      ,[FTTINTA]
      ,[PTMSIA]
      ,[PTCICA]
      ,[PTNICA]
      ,[PTPICA]
      ,[PTOICA]
      ,[PTTINTA]
      ,[FTEMSI]
      ,[FTECIC]
      ,[FTENIC]
      ,[FTEPIC]
      ,[FTEOIC]
      ,[FTEINT]
      ,[MSIC1]
      ,[CIC1]
      ,[NIC1]
      ,[PIC1]
      ,[OIC1]
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
  	FROM [Isilon].aha.[annual2009_1] as a
  	inner join isilon.aha.annual2009_2 as b on a.id=b.id
) BY isilon;
quit;