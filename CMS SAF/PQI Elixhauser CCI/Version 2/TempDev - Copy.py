import pymssql as sql
import pandas as pd
import re
import os
import multiprocessing as mp
global dirname
global filetar
dirname = os.path.dirname(__file__)
filetar='2015out'


def fileDownload():
    conn = sql.connect(server='sql-ctlst-vp01\\TP', database='CAT1')
    cursor = conn.cursor()
    cursor.execute("""with denom1 as(
    SELECT [DESY_SORT_KEY],claim_no,2015 as [REFERENCE_YEAR], '^'+isnull([ICD_DGNS_CD1],'')+'^'+isnull([ICD_DGNS_CD2],'')+'^'+isnull([ICD_DGNS_CD3],'')+'^'+isnull([ICD_DGNS_CD4],'')+'^'+isnull([ICD_DGNS_CD5],'')+'^'+isnull([ICD_DGNS_CD6],'')+'^'+isnull([ICD_DGNS_CD7],'')+'^'+isnull([ICD_DGNS_CD8],'')+'^'+isnull([ICD_DGNS_CD9],'')+'^'+isnull([ICD_DGNS_CD10],'')+'^'+isnull([ICD_DGNS_CD11],'')+'^'+isnull([ICD_DGNS_CD12],'')+'^'+isnull([ICD_DGNS_CD13],'')+'^'+isnull([ICD_DGNS_CD14],'')+'^'+isnull([ICD_DGNS_CD15],'')+'^'+isnull([ICD_DGNS_CD16],'')+'^'+isnull([ICD_DGNS_CD17],'')+'^'+isnull([ICD_DGNS_CD18],'')+'^'+isnull([ICD_DGNS_CD19],'')+'^'+isnull([ICD_DGNS_CD20],'')+'^'+isnull([ICD_DGNS_CD21],'')+'^'+isnull([ICD_DGNS_CD22],'')+'^'+isnull([ICD_DGNS_CD23],'')+'^'+isnull([ICD_DGNS_CD24],'')+'^'+isnull([ICD_DGNS_CD25],'') as dxall,'^'+isnull([ICD_PRCDR_CD1],'')+'^'+isnull([ICD_PRCDR_CD2],'')+'^'+isnull([ICD_PRCDR_CD3],'')+'^'+isnull([ICD_PRCDR_CD4],'')+'^'+isnull([ICD_PRCDR_CD5],'')+'^'+isnull([ICD_PRCDR_CD6],'')+'^'+isnull([ICD_PRCDR_CD7],'')+'^'+isnull([ICD_PRCDR_CD8],'')+'^'+isnull([ICD_PRCDR_CD9],'')+'^'+isnull([ICD_PRCDR_CD10],'')+'^'+isnull([ICD_PRCDR_CD11],'')+'^'+isnull([ICD_PRCDR_CD12],'')+'^'+isnull([ICD_PRCDR_CD13],'')+'^'+isnull([ICD_PRCDR_CD14],'')+'^'+isnull([ICD_PRCDR_CD15],'')+'^'+isnull([ICD_PRCDR_CD16],'')+'^'+isnull([ICD_PRCDR_CD17],'')+'^'+isnull([ICD_PRCDR_CD18],'')+'^'+isnull([ICD_PRCDR_CD19],'')+'^'+isnull([ICD_PRCDR_CD20],'')+'^'+isnull([ICD_PRCDR_CD21],'')+'^'+isnull([ICD_PRCDR_CD22],'')+'^'+isnull([ICD_PRCDR_CD23],'')+'^'+isnull([ICD_PRCDR_CD24],'')+'^'+isnull([ICD_PRCDR_CD25],'') as prall
    FROM [CAT1].[cms].[out_claimsj_2015])
    Select a.*
    from denom1 as a
        """)
    data=cursor.fetchall()
    df=pd.DataFrame(data, columns = [desc[0] for desc in cursor.description])
    df.to_csv(os.path.join(dirname,filetar+ 'tempSql.csv'))

def pqi(df):
    #PQI
    
    PQI01	=re.compile("\^+(?:E1010|E1011|E10641|E1065|E1100|E1101|E11641|E1165)",re.IGNORECASE)
    PQI02	=re.compile("\^+(?:K352|K353)",re.IGNORECASE)
    PQI03	=re.compile("\^+(?:E1021|E1022|E1029|E10311|E10319|E10321|E10329|E10331|E10339|E10341|E1121|E1122|E1129|E11311|E11319|E11321|E11331|E11329|E11339|E11341|E10349|E10351|E10359|E1036|E1039|E1040|E1041|E1042|E1043|E1044|E1049|E1051|E1052|E1059|E11349|E11351|E11359|E1136|E1139|E1140|E1141|E1142|E1143|E1144|E1149|E1151|E1152|E1159|E10610|E10618|E10620|E10621|E10622|E10628|E10630|E10638|E1069|E108|E11610|E11618|E11620|E11621|E11622|E11628|E11630|E11638|E1169|E118)",re.IGNORECASE)
    PQI05	=re.compile("\^+(?:J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|J470|J471|J479)",re.IGNORECASE)
    PQI05NOT	=re.compile("\^+(?:E840|E8411|E8419|E848|E849|J8483|J84841|J84842|J84843|J84848|P270|P271|P278|P279|Q254|Q311|Q312|Q313|Q315|Q318|Q319|Q320|Q321|Q322|Q323|Q324|Q330|Q331|Q332|Q333|Q334|Q335|Q336|Q338|Q339|Q340|Q341|Q348|Q349|Q390|Q391|Q392|Q393|Q394)",re.IGNORECASE)
    PQI07	=re.compile("\^+(?:I10|I119|I129|I1310)",re.IGNORECASE)
    PQI07NOT	=re.compile("\^+(?:I129|I1310)",re.IGNORECASE)
    PQI07NOTProc=re.compile("\^+(?:03170AD|031209D|031209F|03120AD|03120AF|03120JD|03120JF|03120KD|03120KF|03120ZD|03120ZF|031309D|031309F|03130AD|03130AF|03130JD|03130JF|03130KD|03130KF|03130ZD|03130ZF|031409D|031409F|03140AD|03140AF|03140JD|03140JF|03140KD|03140KF|03140ZD|03140ZF|031509D|031509F|03150AD|03150AF|03150JD|03150JF|03150KD|03150KF|03150ZD|03150ZF|031609D|031609F|03160AD|03160AF|03160JD|03160JF|03160KD|03160KF|03160ZD|03160ZF|031709D|031709F|03170AF|03170JD|03170JF|03170KD|03170KF|03170ZD|03170ZF|031809D|031809F|03180AD|03180AF|03180JD|03180JF|03180KD|03180KF|03180ZD|03180ZF|031909F|03190AF|03190JF|03190KF|03190ZF|031A09F|031A0AF|031A0JF|031A0KF|031A0ZF|031B09F|031B0AF|031B0JF|031B0KF|031B0ZF|031C09F|031C0AF|031C0JF|031C0KF|031C0ZF|03PY07Z|03PY0JZ|03PY0KZ|03PY37Z|03PY3JZ|03PY3KZ|03PY47Z|03PY4JZ|03PY4KZ|03WY0JZ|03WY3JZ|03WY4JZ|03WYXJZ|05HY33Z|06HY33Z)",re.IGNORECASE)
    PQI08	=re.compile("\^+(?:I0981|I110|I130|I132|I501|I5020|I5021|I5022|I5023|I5030|I5031|I5032|I5033|I5040|I5041|I5042|I5043|I509)",re.IGNORECASE)
    PQI09	=re.compile("\^+(?:P0501|P0502|P0503|P0504|P0505|P0506|P0507|P0508|P0511|P0512|P0513|P0514|P0515|P0516|P0517|P0518|P0700|P0701|P0702|P0703|P0710|P0714|P0715|P0716|P0717|P0718)",re.IGNORECASE)
    PQI10	=re.compile("\^+(?:E860|E869|E861|E870|A080|A0811|A0819|A082|A0831|A0832|A0839|A084|A088|A09|K5289|K529|N170|N171|N172|N178|N179|N19|N990)",re.IGNORECASE)
    PQI10NOT	=re.compile("\^+(?:I120|N185|N186|I1311|I132)",re.IGNORECASE)
    PQI11	=re.compile("\^+(?:J13|J14|J15211|J15212|J153|J154|J157|J159|J160|J168|J180|J181|J188|J189)",re.IGNORECASE)
    PQI11NOT	=re.compile("\^+(?:D5700|D5701|D5702|D571|D5720|D57211|D57212|D57219|D5740|D57411|D57412|D57419|D5780|D57811|D57812|D57819)",re.IGNORECASE)
    PQI12	=re.compile("\^+(?:N10|N119|N12|N151|N159|N16|N2884|N2885|N2886|N3000|N3001|N3090|N3091)",re.IGNORECASE)
    PQI12NOT	=re.compile("\^+(?:N110|N111|N118|N119|N1370|N1371|N13721|N13722|N13729|N13731|N13732|N13739|N139|Q600|Q601|Q602|Q603|Q604|Q605|Q606|Q6100|Q6101|Q6102|Q6111|Q6119|Q612|Q613|Q614|Q615|Q618|Q619|Q620|Q6210|Q6211|Q6212|Q622|Q6231|Q6232|Q6239|Q624|Q625|Q6260|Q6261|Q6262|Q6263|Q6269|Q627|Q628|Q630|Q631|Q632|Q633|Q638|Q639|Q6410|Q6411|Q6419|Q642|Q6431|Q6432|Q6433|Q6439|Q645|Q646|Q6470|Q6471|Q6472|Q6473|Q6474|Q6475|Q6479|Q648|Q649)",re.IGNORECASE)
    PQI14	=re.compile("\^+(?:E1065|E1165|E10649|E11649)",re.IGNORECASE)
    PQI15	=re.compile("\^+(?:J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998)",re.IGNORECASE)
    PQI15NOT	=re.compile("\^+(?:E840|E8411|E8419|E848|E849|J8483|J84841|J84842|J84843|J84848|P270|P271|P278|P279|Q254|Q311|Q312|Q313|Q315|Q318|Q319|Q320|Q321|Q322|Q323|Q324|Q330|Q331|Q332|Q333|Q334|Q335|Q336|Q338|Q339|Q340|Q341|Q348|Q349|Q390|Q391|Q392|Q393|Q394|Q893)",re.IGNORECASE)
    PQI16Proc	=re.compile("\^+(?:0Y620ZZ|0Y630ZZ|0Y640ZZ|0Y670ZZ|0Y680ZZ|0Y6C0Z1|0Y6C0Z2|0Y6C0Z3|0Y6D0Z1|0Y6D0Z2|0Y6D0Z3|0Y6F0ZZ|0Y6G0ZZ|0Y6H0Z1|0Y6H0Z2|0Y6H0Z3|0Y6J0Z1|0Y6J0Z2|0Y6J0Z3|0Y6M0Z0|0Y6M0Z4|0Y6M0Z5|0Y6M0Z6|0Y6M0Z7|0Y6M0Z8|0Y6M0Z9|0Y6M0ZB|0Y6M0ZC|0Y6M0ZD|0Y6M0ZF|0Y6N0Z0|0Y6N0Z4|0Y6N0Z5|0Y6N0Z6|0Y6N0Z7|0Y6N0Z8|0Y6N0Z9|0Y6N0ZB|0Y6N0ZC|0Y6N0ZD|0Y6N0ZF)",re.IGNORECASE)
    PQI16AND	=re.compile("\^+(?:E1010|E1011|E1021|E1022|E1029|E10311|E10319|E10321|E10329|E10331|E10339|E10341|E10349|E10351|E10359|E1036|E1039|E1040|E1041|E1042|E1043|E1044|E1049|E1051|E1052|E1059|E10610|E10618|E10620|E10621|E10622|E10628|E10630|E10638|E10641|E10649|E1065|E1069|E108|E109|E1100|E1101|E1121|E1122|E1129|E11311|E11319|E11321|E11329|E11331|E11339|E11341|E11349|E11351|E11359|E1136|E1139|E1140|E1141|E1142|E1143|E1144|E1149|E1151|E1152|E1159|E11610|E11618|E11620|E11621|E11622|E11628|E11630|E11638|E11641|E11649|E1165|E1169|E118|E119|E1300|E1301|E1310|E1311|E1321|E1322|E1329|E13311|E13319|E13321|E13329|E13331|E13339|E13341|E13349|E13351|E13359|E1336|E1339|E1340|E1341|E1342|E1343|E1344|E1349|E1351|E1352|E1359|E13610|E13618|E13620|E13621|E13622|E13628|E13630|E13638|E13641|E13649|E1365|E1369|E138|E139)",re.IGNORECASE)
    PQI16NOTPROC	=re.compile("\^+(?:S78011A|S78012A|S78019A|S78021A|S78022A|S78029A|S78111A|S78112A|S78119A|S78121A|S78122A|S78129A|S78911A|S78912A|S78919A|S78921A|S78922A|S78929A|S88011A|S88012A|S88019A|S88021A|S88022A|S88029A|S88111A|S88112A|S88119A|S88121A|S88122A|S88129A|S88911A|S88912A|S88919A|S88921A|S88922A|S88929A|S98011A|S98012A|S98019A|S98021A|S98022A|S98029A|S98111A|S98112A|S98119A|S98121A|S98122A|S98129A|S98131A|S98132A|S98139A|S98141A|S98142A|S98149A|S98211A|S98212A|S98219A|S98221A|S98222A|S98229A|S98311A|S98312A|S98319A|S98321A|S98322A|S98329A|S98911A|S98912A|S98919A|S98921A|S98922A|S98929A)",re.IGNORECASE)
 
    df['PQI01']=df['dxall'].str.contains(PQI01, regex=True)
    df['PQI02']=df['dxall'].str.contains(PQI02, regex=True)
    df['PQI03']=df['dxall'].str.contains(PQI03, regex=True)
    df['PQI05a']=df['dxall'].str.contains(PQI05, regex=True)
    df['PQI05NOT']=df['dxall'].str.contains(PQI05NOT, regex=True)
    df['PQI05']=(df['PQI05a']&~df['PQI05NOT'])
    df['PQI07a']=df['dxall'].str.contains(PQI07, regex=True)
    df['PQI07NOT']=df['dxall'].str.contains(PQI07NOT, regex=True)
    df['PQI07NOTProc']=df['prall'].str.contains(PQI07NOTProc, regex=True)
    df['PQI07']=(df['PQI07a']&~df['PQI07NOTProc']&~df['PQI07NOT'])
    df['PQI08']=df['dxall'].str.contains(PQI08, regex=True)
    df['PQI09']=df['dxall'].str.contains(PQI09, regex=True)
    df['PQI10a']=df['dxall'].str.contains(PQI10, regex=True)
    df['PQI10NOT']=df['dxall'].str.contains(PQI10NOT, regex=True)
    df['PQI10']=(df['PQI10a']&~df['PQI10NOT'])
    df['PQI11a']=df['dxall'].str.contains(PQI11, regex=True)
    df['PQI11NOT']=df['dxall'].str.contains(PQI11NOT, regex=True)
    df['PQI11']=(df['PQI11a']&~df['PQI11NOT'])
    df['PQI12a']=df['dxall'].str.contains(PQI12, regex=True)
    df['PQI12NOT']=df['dxall'].str.contains(PQI12NOT, regex=True)
    df['PQI12']=(df['PQI12a']&~df['PQI12NOT'])
    df['PQI14']=df['dxall'].str.contains(PQI14, regex=True)
    df['PQI15a']=df['dxall'].str.contains(PQI15, regex=True)
    df['PQI15NOT']=df['dxall'].str.contains(PQI15NOT, regex=True)
    df['PQI15']=(df['PQI15a']&~df['PQI15a'])
    df['PQI16Proc']=df['prall'].str.contains(PQI16Proc, regex=True)
    df['PQI16AND']=df['dxall'].str.contains(PQI16AND, regex=True)
    df['PQI16NOTPROC']=df['prall'].str.contains(PQI16NOTPROC, regex=True)
    df['PQI16']=(df['PQI16Proc']&df['PQI16AND']&~df['PQI16NOTPROC'])
    df.drop(['PQI05a', 'PQI05NOT','PQI07a','PQI07NOT','PQI07NOTProc','PQI10a','PQI10NOT','PQI11a','PQI11NOT','PQI12a','PQI12NOT','PQI15a','PQI15NOT','PQI16Proc','PQI16AND','PQI16NOTPROC'], axis=1, inplace=True)

    #CCI
    #Myocardial infarction 1 DC
    CCI01	=re.compile("\^+(?:410|412)",re.IGNORECASE)
    #Congestive heart failure 1 DC
    CCI02	=re.compile("\^+(?:428)",re.IGNORECASE)
    #Preipheral vascular disease 1 DC
    CCI03	=re.compile("\^+(?:4439|441|785|v434)",re.IGNORECASE)
    CCI03p	=re.compile("\^+(?:3848)",re.IGNORECASE)
    #Cerebrovascular disease 1 DC
    CCI04	=re.compile("\^+(?:430|431|432|433|434|435|436|437|438)",re.IGNORECASE)
    #Dementia 1 DC
    CCI05	=re.compile("\^+(?:290)",re.IGNORECASE)
    #Chronic pulmonary disease 1 DC
    CCI06	=re.compile("\^+(?:49|501|502|503|504|505|5064)",re.IGNORECASE)
    #Rheuamatic disease 1 DC
    CCI07	=re.compile("\^+(?:7100|7101|7104|7140|7141|7142|71481|725)",re.IGNORECASE)
    #Peptic ulcer disease 1 DC
    CCI08	=re.compile("\^+(?:531|532|733|734)",re.IGNORECASE)
    #Mild liver disease 1 DC
    CCI09	=re.compile("\^+(?:5712|5714|5715|5716)",re.IGNORECASE)
    #Diabetes w/o chronic complications 1 DC
    CCI10	=re.compile("\^+(?:2500|2501|2502|2503|2507)",re.IGNORECASE)
    #Diabetes /w chronic complications 2 DC
    CCI11	=re.compile("\^+(?:2504|2505|2506)",re.IGNORECASE)
    #Hemiplegia or paraplegia 2 DC
    CCI12	=re.compile("\^+(?:3441|342)",re.IGNORECASE)
    #Renal disease 2 DC
    CCI13	=re.compile("\^+(?:582|5830|5831|5832|5833|5834|5835|5836|5837|585|586|588)",re.IGNORECASE)
    #Any Malignacy 2 DC
    CCI14	=re.compile("\^+(?:14|15|16|170|171|172|174|175|176|177|178|179|18|190|191|192|193|194|1950|1951|1592|1953|1954|1955|1956|1957|1958|200|201|202|203|204|205|206|207|208)",re.IGNORECASE)
    #Moderate or severe liver disease 3 DC
    CCI15	=re.compile("\^+(?:4560|4561|45620|45621|5722|5723|5724|5725|5726|5727|5728)",re.IGNORECASE)
    #Metastatic solid tumor 6
    CCI16	=re.compile("\^+(?:196|197|198|1990|1991)",re.IGNORECASE)
    #AIDS/HIV 6
    CCI17	=re.compile("\^+(?:42|43|44)",re.IGNORECASE)

    df['CCI01']=df['dxall'].str.contains(CCI01, regex=True)
    df['CCI02']=df['dxall'].str.contains(CCI02, regex=True)
    df['CCI03a']=df['dxall'].str.contains(CCI03, regex=True)
    df['CCI03p']=df['prall'].str.contains(CCI03p, regex=True)
    df['CCI03']=(df['CCI03a']|df['CCI03p'])
    df['CCI04']=df['dxall'].str.contains(CCI04, regex=True)
    df['CCI05']=df['dxall'].str.contains(CCI05, regex=True)
    df['CCI06']=df['dxall'].str.contains(CCI06, regex=True)
    df['CCI07']=df['dxall'].str.contains(CCI07, regex=True)
    df['CCI08']=df['dxall'].str.contains(CCI08, regex=True)
    df['CCI09']=df['dxall'].str.contains(CCI09, regex=True)
    df['CCI10']=df['dxall'].str.contains(CCI10, regex=True)
    df['CCI11']=df['dxall'].str.contains(CCI11, regex=True)
    df['CCI12']=df['dxall'].str.contains(CCI12, regex=True)
    df['CCI13']=df['dxall'].str.contains(CCI13, regex=True)
    df['CCI14']=df['dxall'].str.contains(CCI14, regex=True)
    df['CCI15']=df['dxall'].str.contains(CCI15, regex=True)
    df['CCI16']=df['dxall'].str.contains(CCI16, regex=True)
    df['CCI17']=df['dxall'].str.contains(CCI17, regex=True)
    df['CCI']=(df['CCI01']*1+df['CCI02']*1+df['CCI03']*1+df['CCI04']*1+df['CCI05']*1+df['CCI06']*1+df['CCI07']*1+df['CCI08']*1+df['CCI09']*1+df['CCI10']*1+df['CCI11']*2+df['CCI12']*2+df['CCI13']*2+df['CCI14']*2+df['CCI15']*3+df['CCI16']*6+df['CCI17']*6)
    df.drop(['CCI03a','CCI03p'], axis=1, inplace=True)

    #Elixhauser DC
    #congestive heart failure DC
    ELX01	=re.compile("\^+(?:39891|40211|40291|41411|40413|40491|40493|428)",re.IGNORECASE)
    #cardiac arrhythmias DC
    ELX02	=re.compile("\^+(?:42610|42611|42613|4262|4263|4264|42650|42651|42652|42653|4266|4267|4268|4270|4272|42731|42760|4279|7850|V450|V533)",re.IGNORECASE)
    #valvular disease DC
    ELX03	=re.compile("\^+(?:0932|394|395|396|3970|3971|4240|4241|4242|4243|4244|4245|4246|4247|4248|42490|42491|7463|7464|7465|7466|V422|V433)",re.IGNORECASE)
    #pulmonary circulation disorders DC
    ELX04	=re.compile("\^+(?:416|4179)",re.IGNORECASE)
    #peripheral vascular disorders DC
    ELX05	=re.compile("\^+(?:440|4412|4414|4417|4419|4431|4432|4433|4434|4435|4436|4437|4438|4439|4471|5571|5579|V434)",re.IGNORECASE)
    #hypertension, incopmplicated DC
    ELX06	=re.compile("\^+(?:4011|4019)",re.IGNORECASE)
    #hypertension, complicated DC
    ELX07	=re.compile("\^+(?:40210|40290|40410|40490|51|4059)",re.IGNORECASE)
    #paralysis DC
    ELX08	=re.compile("\^+(?:3420|3421|3429|343|344)",re.IGNORECASE)
    #other neurological disorders DC
    ELX09	=re.compile("\^+(?:3319|3320|3334|3335|334|335|340|3411|3412|3413|3414|3415|3416|3417|3418|3419|3450|3451|3454|3455|3458|3459|3481|3483|7803|7843)",re.IGNORECASE)
    #chronic pulmonary disease DC
    ELX10	=re.compile("\^+(?:490|491|4920|4921|4922|4923|4924|4925|4926|4927|4928|4930|4931|4932|4933|4934|4935|4936|4937|4938|4939|494|495|496|497|498|499|500|501|502|503|504|505|5064)",re.IGNORECASE)
    #diabetes uncomplicated DC
    ELX11	=re.compile("\^+(?:2500|2501|2502|2503)",re.IGNORECASE)
    #diabetes complicated DC
    ELX12	=re.compile("\^+(?:2504|2505|2506|2507|2509)",re.IGNORECASE)
    #hypothyroidism DC
    ELX13	=re.compile("\^+(?:243|2440|2441|2442|2448|2449)",re.IGNORECASE)
    #renalfailure DC
    ELX14	=re.compile("\^+(?:40311|40391|40412|40492|585|586|V420|V451|V560|V568)",re.IGNORECASE)
    #liverdisease DC
    ELX15	=re.compile("\^+(?:07032|07033|07054|4560|4561|4562|570|572|573|574|575|576|577|578|579|5723|5728|V427)",re.IGNORECASE)
    #peptic ulcer disease excluding bleeding DC
    ELX16	=re.compile("\^+(?:53170|53190|53270|53290|53370|53390|53470|53490|V1271)",re.IGNORECASE)
    #HIV Aids DC
    ELX17	=re.compile("\^+(?:042|043|044)",re.IGNORECASE)
    #lymphoma DC
    ELX18	=re.compile("\^+(?:200|201|2020|2021|2022|2023|2025|2026|2027|2028|2022030|2038|2386|2733|V1071|V1072|V1079)",re.IGNORECASE)
    #metastatic cancer DC
    ELX19	=re.compile("\^+(?:196|197|198|199)",re.IGNORECASE)
    #solid tumor without metastasis DC
    ELX20	=re.compile("\^+(?:14|15|16|170|171|172|174|175|179|18|190|191|192|193|194|195|V10)",re.IGNORECASE)
    #rheumatoid arthritis / collagen vascular diseases DC
    ELX21	=re.compile("\^+(?:7010|710|714|720|725)",re.IGNORECASE)
    #coagulopathy DC
    ELX22	=re.compile("\^+(?:286|2871|2873|2874|2875)",re.IGNORECASE)
    #obesity DC
    ELX23	=re.compile("\^+(?:278)",re.IGNORECASE)
    #weight loss DC
    ELX24	=re.compile("\^+(?:260|261|262|263)",re.IGNORECASE)
    #fluid and electrolyte disorders DC
    ELX25	=re.compile("\^+(?:276)",re.IGNORECASE)
    #blood loss anemia DC
    ELX26	=re.compile("\^+(?:2800)",re.IGNORECASE)
    #deficiency anemia DC
    ELX27	=re.compile("\^+(?:2801|2812|2823|2834|2845|2856|2867|2878|2889|2859)",re.IGNORECASE)
    #alcohol abuse DC
    ELX28	=re.compile("\^+(?:2911|2912|2915|2916|2917|2918|2919|3039|3050|V113)",re.IGNORECASE)
    #drug abuse DC
    ELX29	=re.compile("\^+(?:2920|29282|29283|29284|29285|29286|29287|29288|29289|2929|3040|3052|3053|3054|3055|3056|3057|3058|3059)",re.IGNORECASE)
    #psychoses DC
    ELX30	=re.compile("\^+(?:295|296|297|298|2991)",re.IGNORECASE)
    #depression DC
    ELX31	=re.compile("\^+(?:3004|30112|3090|3091|311)",re.IGNORECASE)    
    df['ELX01']=df['dxall'].str.contains(ELX01, regex=True)
    df['ELX02']=df['dxall'].str.contains(ELX02, regex=True)
    df['ELX03']=df['dxall'].str.contains(ELX03, regex=True)
    df['ELX04']=df['dxall'].str.contains(ELX04, regex=True)
    df['ELX05']=df['dxall'].str.contains(ELX05, regex=True)
    df['ELX06']=df['dxall'].str.contains(ELX06, regex=True)
    df['ELX07']=df['dxall'].str.contains(ELX07, regex=True)
    df['ELX08']=df['dxall'].str.contains(ELX08, regex=True)
    df['ELX09']=df['dxall'].str.contains(ELX09, regex=True)
    df['ELX10']=df['dxall'].str.contains(ELX10, regex=True)
    df['ELX11']=df['dxall'].str.contains(ELX11, regex=True)
    df['ELX12']=df['dxall'].str.contains(ELX12, regex=True)
    df['ELX13']=df['dxall'].str.contains(ELX13, regex=True)
    df['ELX14']=df['dxall'].str.contains(ELX14, regex=True)
    df['ELX15']=df['dxall'].str.contains(ELX15, regex=True)
    df['ELX16']=df['dxall'].str.contains(ELX16, regex=True)
    df['ELX17']=df['dxall'].str.contains(ELX17, regex=True)
    df['ELX18']=df['dxall'].str.contains(ELX18, regex=True)
    df['ELX19']=df['dxall'].str.contains(ELX19, regex=True)
    df['ELX20']=df['dxall'].str.contains(ELX20, regex=True)
    df['ELX21']=df['dxall'].str.contains(ELX21, regex=True)
    df['ELX22']=df['dxall'].str.contains(ELX22, regex=True)
    df['ELX23']=df['dxall'].str.contains(ELX23, regex=True)
    df['ELX24']=df['dxall'].str.contains(ELX24, regex=True)
    df['ELX25']=df['dxall'].str.contains(ELX25, regex=True)
    df['ELX26']=df['dxall'].str.contains(ELX26, regex=True)
    df['ELX27']=df['dxall'].str.contains(ELX27, regex=True)
    df['ELX28']=df['dxall'].str.contains(ELX28, regex=True)
    df['ELX29']=df['dxall'].str.contains(ELX29, regex=True)
    df['ELX30']=df['dxall'].str.contains(ELX30, regex=True)
    df['ELX31']=df['dxall'].str.contains(ELX31, regex=True)
    x=mp.current_process()
    xx=x.name
    filepath = os.path.join(dirname,filetar+ '_pqi_'+xx+'.csv')
    if os.path.exists(filepath):
        df.to_csv(filepath,chunksize=20000,mode='a', index=False, header=None)
    if not os.path.exists(filepath):
        df.to_csv(filepath,chunksize=20000,mode='w', index=False)

if __name__ == '__main__':
    fileDownload()
    tempDataset= os.path.join(dirname,filetar+ 'tempSql.csv')
    df = pd.read_csv(tempDataset, chunksize=200000 )

    pool = mp.Pool(processes = (mp.cpu_count()-1))
    for arg in df:
        try: pool.apply_async(pqi, args=(arg,))
        #try: pqi(data)
        except:print(" Failed")
        print(".")
    pool.close()
    pool.join()
    print("parse completed")
    datasetout= os.path.join(dirname,filetar+ '_pqiall.csv')
    for file in os.listdir(dirname):
        if file[:11]==(filetar+"_pqi"):
            print(file)
            df=pd.read_csv(os.path.join(dirname,file))
            if os.path.exists(datasetout):
                df.to_csv(datasetout,chunksize=200000,mode='a', index=False, header=None)
            if not os.path.exists(datasetout):
                df.to_csv(datasetout,chunksize=200000,mode='w', index=False)
            os.remove(os.path.join(dirname,file))
            print(file+" combined")
    print("combine complete")
