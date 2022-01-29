import pandas as pd
import re
import os
dirname = os.path.dirname(__file__)
def pqi(df):
    #PQI
    year='2017'
    dx='dxall'
    df[dx]='^'+df[dx].astype(str)
    pqi01=re.compile("\^+(?:E1011|E10641|E1065|E1100|E1101|E11641|E1165)",re.IGNORECASE)
    pqi03=re.compile("\^+(?:E1022|E1029|E10311|E10319|E10321|E10329|E10331|E10339|E10341|E10349|E10351|E10359|E1036|E1039|E1040|E1041|E1042|E1043|E1044|E1049|E1051|E1052|E1059|E10610|E10618|E10620|E10621|E10622|E10628|E10630|E10638|E1069|E108|E1121|E1122|E1129|E11311|E11319|E11321|E11329|E11331|E11339|E11341|E11349|E11351|E11359|E1136|E1139|E1140|E1141|E1142|E1143|E1144|E1149|E1151|E1152|E1159|E11610|E11618|E11620|E11621|E11622|E11628|E11630|E11638|E1169|E118)",re.IGNORECASE)
    pqi05=re.compile("\^+(?:J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|2016|J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|2016|J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|2016|J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998|2016|J410|J411|J418|J42|J430|J431|J432|J438|J439|J440|J441|J449|J470|J471|J479|J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998)",re.IGNORECASE)
    pqi05NOT=re.compile("\^+(?:E840|E8411|E8419|E848|E849|J8483|J84841|J84842|J84843|J84848|P270|P271|P278|P279|Q254|Q311|Q312|Q313|Q315|Q318|Q319|Q320|Q321|Q322|Q323|Q324|Q330|Q331|Q332|Q333|Q334|Q335|Q336|Q338|Q339|Q340|Q341|Q348|Q349|Q390|Q391|Q392|Q393|Q394|Q893)",re.IGNORECASE)
    pqi07=re.compile("\^+(?:I10|I119|I129|I1310)",re.IGNORECASE)
    pqi07NOT=re.compile("\^+(?:I129|I1310|03170AD|03170AF|031209D|031209F|03120AD|03120AF|03120JD|03120JF|03120KD|03120KF|03120ZD|03120ZF|031309D|031309F|03130AD|03130AF|03130JD|03130JF|03130KD|03130KF|03130ZD|03130ZF|031409D|031409F|03140AD|03140AF|03140JD|03140JF|03140KD|03140KF|03140ZD|03140ZF|031509D|031509F|03150AD|03150AF|03150JD|03150JF|03150KD|03150KF|03150ZD|03150ZF|031609D|031609F|03160AD|03160AF|03160JD|03160JF|03160KD|03160KF|03160ZD|03160ZF|031709D|031709F|03170JD|03170JF|03170KD|03170KF|03170ZD|03170ZF|031809D|031809F|03180AD|03180AF|03180JD|03180JF|03180KD|03180KF|03180ZD|03180ZF|031909F|03190AF|03190JF|03190KF|03190ZF|031A09F|031A0AF|031A0JF|031A0KF|031A0ZF|031B09F|031B0AF|031B0JF|031B0KF|031B0ZF|031C09F|031C0AF|031C0JF|031C0KF|031C0ZF|03PY07Z|03PY0JZ|03PY0KZ|03PY37Z|03PY3JZ|03PY3KZ|03PY47Z|03PY4JZ|03PY4KZ|03WY0JZ|03WY3JZ|03WY4JZ|03WYXJZ|05HY33Z|06HY33Z)",re.IGNORECASE)
    pqi08=re.compile("\^+(?:I0981|I110|I130|I132|I501|I5020|I5021|I5022|I5023|I5030|I5031|I5032|I5033|I5040|I5041|I5042|I5043|I509)",re.IGNORECASE)
    pqi11=re.compile("\^+(?:J13|J14|J15211|J15212|J153|J154|J157|J159|J160|J168|J180|J181|J188|J189)",re.IGNORECASE)
    pqi11NOT=re.compile("\^+(?:D5700|D5701|D5702|D571|D57211|D57212|D57219|D5740|D57411|D57412|D57419|D5780|D57811|D57812|D57819)",re.IGNORECASE)
    pqi12=re.compile("\^+(?:N10|N119|N12|N151|N159|N16|N2884|N2885|N2886|N3000|N3001|N3090|N3091|N390)",re.IGNORECASE)
    pqi12NOT=re.compile("\^+(?:N110|N111|N118|N119|N1370|N1371|N13721|N13722|N13729|N13731|N13732|N13739|N139|Q600|Q601|Q602|Q603|Q604|Q605|Q606|Q6100|Q6101|Q6102|Q6111|Q6119|Q612|Q613|Q614|Q615|Q616|Q617|Q618|Q619|Q620|Q6210|Q6211|Q6212|Q622|Q6231|Q6232|Q6239|Q624|Q625|Q6260|Q6261|Q6262|Q6263|Q6269|Q627|Q628|Q630|Q631|Q632|Q633|Q638|Q639|Q6410|Q6411|Q6412|Q6419|Q642|Q6431|Q6432|Q6433|Q6439|Q645|Q646|Q6470|Q6471|Q6472|Q6473|Q6474|Q6475|Q6479|Q648|Q649)",re.IGNORECASE)
    pqi13=re.compile("\^+(?:E1065|E1165|E10649|E11649)",re.IGNORECASE)
    pqi13NOT=re.compile("\^+(?:I200|I201|I208|I209|I240|I248|I249|I25110|I25111|I25118|I25119|I25700|I25701|I25708|I25709|I25710|I25711|I25718|I25719|I25720|I25721|I25728|I25729|I25730|I25731|I25738|I25739|I25751|I25758|I25759|I25760|I25761|I25768|I25769|I25790|I25791|I25798|I25799)",re.IGNORECASE)
    pqi15=re.compile("\^+(?:J4521|J4522|J4531|J4532|J4541|J4542|J4551|J4552|J45901|J45902|J45990|J45991|J45998)",re.IGNORECASE)
    pqi15NOT=re.compile("\^+(?:E840|E8411|E8419|E848|E849|J8483|J84841|J84842|J84843|J84848|P270|P271|P278|P279|Q311|Q312|Q313|Q315|Q318|Q319|Q320|Q321|Q322|Q323|Q324|Q330|Q331|Q332|Q333|Q334|Q335|Q336|Q338|Q339|Q340|Q341|Q348|Q349|Q390|Q391|Q392|Q393|Q394|Q893)",re.IGNORECASE)
    pqi16=re.compile("\^+(?:0Y620ZZ|0Y630ZZ|0Y640ZZ|0Y670ZZ|0Y680ZZ|0Y6C0Z1|0Y6C0Z2|0Y6C0Z3|0Y6D0Z1|0Y6D0Z2|0Y6D0Z3|0Y6F0ZZ|0Y6G0ZZ|0Y6H0Z1|0Y6H0Z2|0Y6H0Z3|0Y6J0Z1|0Y6J0Z2|0Y6J0Z3|0Y6M0Z0|0Y6M0Z4|0Y6M0Z5|0Y6M0Z6|0Y6M0Z7|0Y6M0Z8|0Y6M0Z9|0Y6M0ZB|0Y6M0ZC|0Y6M0ZD|0Y6M0ZF|0Y6N0Z0|0Y6N0Z4|0Y6N0Z5|0Y6N0Z6|0Y6N0Z7|0Y6N0Z8|0Y6N0Z9|0Y6N0ZB|0Y6N0ZC|0Y6N0ZD|0Y6N0ZF)",re.IGNORECASE)
    pqi16AND=re.compile("\^+(?:E1010|E1011|E1021|E1022|E1029|E10311|E10319|E10321|E10329|E10331|E10339|E10341|E10349|E10351|E10359|E1036|E1039|E1040|E1041|E1042|E1043|E1044|E1049|E1051|E1052|E1059|E10610|E10618|E10620|E10621|E10622|E10628|E10630|E10638|E10641|E10649|E1065|E1069|E108|E109|E1100|E1101|E1121|E1122|E1129|E11311|E11319|E11321|E11329|E11331|E11339|E11341|E11349|E11351|E11359|E1136|E1139|E1140|E1141|E1142|E1143|E1144|E1149|E1151|E1152|E1159|E11610|E11618|E11620|E11621|E11622|E11628|E11630|E11638|E11641|E11649|E1165|E1169|E118|E119|E1300|E1301|E1310|E1311|E1321|E1322|E1329|E13311|E13319|E13321|E13329|E13331|E13339|E13341|E13349|E13351|E13359|E1336|E1339|E1340|E1341|E1342|E1343|E1344|E1349|E1351|E1352|E1359|E13610|E13618|E13620|E13621|E13622|E13628|E13630|E13638|E13641|E13649|E1365|E1369|E138|E139)",re.IGNORECASE)
    pqi16NOT=re.compile("\^+(?:S78011A|S78012A|S78019A|S78021A|S78022A|S78029A|S78111A|S78112A|S78119A|S78121A|S78122A|S78129A|S78911A|S78912A|S78919A|S78921A|S78922A|S78929A|S88011A|S88012A|S88019A|S88021A|S88022A|S88029A|S88111A|S88112A|S88119A|S88121A|S88122A|S88129A|S88911A|S88912A|S88919A|S88921A|S88922A|S88929A|S98011A|S98012A|S98019A|S98021A|S98022A|S98029A|S98111A|S98112A|S98119A|S98121A|S98122A|S98129A|S98131A|S98132A|S98139A|S98141A|S98142A|S98149A|S98211A|S98212A|S98219A|S98221A|S98229A|S98311A|S98312A|S98319A|S98321A|S98322A|S98329A|S98911A|S98912A|S98919A|S98921A|S98922A|S98929A)",re.IGNORECASE)
    pqi02=re.compile("\^+(?:K352|K353|K3580|K3589|K37)",re.IGNORECASE)
    pqi09=re.compile("\^+(?:P0501|P0502|P0503|P0504|P0505|P0506|P0507|P0508|P0511|P0512|P0513|P0514|P0515|P0516|P0517|P0518|P0700|P0701|P0702|P0703|P0710|P0714|P0715|P0716|P0717|P0718)",re.IGNORECASE)
    pqi10=re.compile("\^+(?:E860|E861|E869|E870|A080|A0811|A0819|A082|A0831|A0832|A0839|A084|A088|A09|K5289|K529|N170|N170|N172|N178|N179|N19|N990)",re.IGNORECASE)
    pqi10NOT=re.compile("\^+(?:I120|I1311|I132|N185|N186)",re.IGNORECASE)
    #Note to self Append ^ to dx
    df['pqi01']=df[dx].str.contains(pqi01, regex=True)
    df['pqi02']=df[dx].str.contains(pqi02, regex=True)
    df['pqi03']=df[dx].str.contains(pqi03, regex=True)
    df['pqi05A']=df[dx].str.contains(pqi05, regex=True)
    df['pqi05NOT']=df[dx].str.contains(pqi05NOT, regex=True)
    df['pqi05']=(df['pqi05A']&~df['pqi05NOT'])
    df['pqi07A']=df[dx].str.contains(pqi07, regex=True)
    df['pqi07NOT']=df[dx].str.contains(pqi07NOT, regex=True)
    df['pqi07']=(df['pqi07A']&~df['pqi07NOT'])
    df['pqi08']=df[dx].str.contains(pqi08, regex=True)
    df['pqi09']=df[dx].str.contains(pqi09, regex=True)
    df['pqi10A']=df[dx].str.contains(pqi10, regex=True)
    df['pqi10NOT']=df[dx].str.contains(pqi10NOT, regex=True)
    df['pqi10']=(df['pqi10A']&~df['pqi10NOT'])
    df['pqi11A']=df[dx].str.contains(pqi11, regex=True)
    df['pqi11NOT']=df[dx].str.contains(pqi11NOT, regex=True)
    df['pqi11']=(df['pqi11A']&~df['pqi11NOT'])
    df['pqi12A']=df[dx].str.contains(pqi12, regex=True)
    df['pqi12NOT']=df[dx].str.contains(pqi12NOT, regex=True)
    df['pqi12']=(df['pqi12A']&~df['pqi12NOT'])
    df['pqi13A']=df[dx].str.contains(pqi13, regex=True)
    df['pqi13NOT']=df[dx].str.contains(pqi13NOT, regex=True)
    df['pqi13']=(df['pqi13A']&~df['pqi13NOT'])
    df['pqi15A']=df[dx].str.contains(pqi15, regex=True)
    df['pqi15NOT']=df[dx].str.contains(pqi15NOT, regex=True)
    df['pqi15']=(df['pqi15A']&~df['pqi15NOT'])
    df['pqi16A']=df[dx].str.contains(pqi16, regex=True)
    df['pqi16NOT']=df[dx].str.contains(pqi16NOT, regex=True)
    df['pqi16A2']=df[dx].str.contains(pqi16AND, regex=True)
    df['pqi16']=(df['pqi16A']&df['pqi16A2']&~df['pqi16NOT'])
    df.drop(['pqi05A', 'pqi05NOT','pqi07A','pqi07NOT','pqi10A','pqi10NOT','pqi11A','pqi11NOT','pqi12A','pqi12NOT','pqi13A','pqi13NOT','pqi15A','pqi15NOT','pqi16A','pqi16NOT','pqi16A2'], axis=1, inplace=True)

    #CCI
    #Myocardial infarction 1 DC
    CCI01=re.compile("\^+(?:i21|i22|i252)",re.IGNORECASE)
    #Congestive heart failure 1 DC
    CCI02=re.compile("\^+(?:i099|i110|i130|i132|i255|i420|i425|i426|i427|i428|i429|i43|i50|P290)",re.IGNORECASE)
    #Preipheral vascular disease 1 DC
    CCI03=re.compile("\^+(?:i70|i71|i731|i738|i739|i771|i790|i792|K551|K558|K559|Z958|Z959)",re.IGNORECASE)
    #Cerebrovascular disease 1 DC
    CCI04=re.compile("\^+(?:g45|g46|h340|I6)",re.IGNORECASE)
    #Dementia 1 DC
    CCI05=re.compile("\^+(?:F00|F01|F02|F03|F051|g30|G311)",re.IGNORECASE) 
    #Chronic pulmonary disease 1 DC
    CCI06=re.compile("\^+(?:i278|i279|J40|J41|J42|J43|J44|J45|J46|J47|J60|J61|J62|J63|J64|J65|J66|J67|J684|J701|J703)",re.IGNORECASE)
    #Rheuamatic disease 1 DC
    CCI07=re.compile("\^+(?:M05|M06|M315|M32|M33|M34|M351|M353|M360)",re.IGNORECASE)
    #Peptic ulcer disease 1 DC
    CCI08=re.compile("\^+(?:K25|K26|K27|K28)",re.IGNORECASE)
    #Mild liver disease 1 DC
    CCI09=re.compile("\^+(?:B18|K700|K701|K702|K703|K709|K713|K714|K715|K717|K73|K74|K760|K762|K763|K764|K768|K769|Z944)",re.IGNORECASE)
    #Diabetes w/o chronic complications 1 DC
    CCI10=re.compile("\^+(?:E100|E101|E106|E108|E109|E110|E111|E116|E118|E119|E120|E121|E126|E128|E129|E130|E131|E136|E138|E139|E140|E141|E146|E148|E149)",re.IGNORECASE)
    #Diabetes /w chronic complications 2 DC
    CCI11=re.compile("\^+(?:E102|E103|E104|E105|E107|E112|E113|E114|E115|E117|E122|E123|E124|E125|E127|E132|E133|E134|E135|E137|E142|E143|E144|E145|E147)",re.IGNORECASE)
    #Hemiplegia or paraplegia 2 DC
    CCI12=re.compile("\^+(?:G041|G114|G801|G802|G81|G82|G830|G831|G832|G833|G834|G839)",re.IGNORECASE)
    #Renal disease 2 DC
    CCI13=re.compile("\^+(?:i120|i131|N032|N033|N034|N035|N036|N037|N052|N053|N054|N055|N056|N057|N18|N19|N250|Z490|Z491|Z492|Z940|Z992)",re.IGNORECASE)
    #Any Malignacy 2 DC
    CCI14=re.compile("\^+(?:C0|C1|C20|C21|C22|C23|C24|C25|C26|C30|C31|C32|C33|C34|C37|C38|C39|C40|C41|C43|C45|C46|C47|C48|C49|C50|C51|C52|C53|C54|C55|C56|C57|C58|C6|C70|C71|C72|C73|C74|C75|C76|C81|C82|C83|C84|C85|C88|C90|C91|C92|C93|C94|C95|C96|C97)",re.IGNORECASE)
    #Moderate or severe liver disease 3 DC
    CCI15=re.compile("\^+(?:i850|i859|i864|i982|K704|K711|K721|K729|K765|K766|K767)",re.IGNORECASE)
    #Metastatic solid tumor 6
    CCI16=re.compile("\^+(?:C77|C78|C79|C80)",re.IGNORECASE)
    #AIDS/HIV 6
    CCI17=re.compile("\^+(?:B20|B21|B22|B24)",re.IGNORECASE)
    df['CCI01']=df[dx].str.contains(CCI01, regex=True)
    df['CCI02']=df[dx].str.contains(CCI02, regex=True)
    df['CCI03']=df[dx].str.contains(CCI03, regex=True)
    df['CCI04']=df[dx].str.contains(CCI04, regex=True)
    df['CCI05']=df[dx].str.contains(CCI05, regex=True)
    df['CCI06']=df[dx].str.contains(CCI06, regex=True)
    df['CCI07']=df[dx].str.contains(CCI07, regex=True)
    df['CCI08']=df[dx].str.contains(CCI08, regex=True)
    df['CCI09']=df[dx].str.contains(CCI09, regex=True)
    df['CCI10']=df[dx].str.contains(CCI10, regex=True)
    df['CCI11']=df[dx].str.contains(CCI11, regex=True)
    df['CCI12']=df[dx].str.contains(CCI12, regex=True)
    df['CCI13']=df[dx].str.contains(CCI13, regex=True)
    df['CCI14']=df[dx].str.contains(CCI14, regex=True)
    df['CCI15']=df[dx].str.contains(CCI15, regex=True)
    df['CCI16']=df[dx].str.contains(CCI16, regex=True)
    df['CCI17']=df[dx].str.contains(CCI17, regex=True)
    df['CCI']=(df['CCI01']*1+df['CCI02']*1+df['CCI03']*1+df['CCI04']*1+df['CCI05']*1+df['CCI06']*1+df['CCI07']*1+df['CCI08']*1+df['CCI09']*1+df['CCI10']*1+df['CCI11']*2+df['CCI12']*2+df['CCI13']*2+df['CCI14']*2+df['CCI15']*3+df['CCI16']*6+df['CCI17']*6)
    df.drop(['CCI01','CCI02','CCI03','CCI04','CCI05','CCI06','CCI07','CCI08','CCI09','CCI10','CCI11','CCI12','CCI13','CCI14','CCI15','CCI16','CCI17'], axis=1, inplace=True)
    #Elixhauser DC
    #congestive heart failure DC
    Elix01=re.compile("\^+(?:i099|i110|i130|i132|i255|i420|i425|i426|i427|i428|i429|i43|i50|p290)",re.IGNORECASE)
    #cardiac arrhythmias DC
    Elix02=re.compile("\^+(?:i441|i442|i443|i456|i459|i47|i48|i49|r000|r001|r008|t821|z450|z950)",re.IGNORECASE)
    #valvular disease DC
    Elix03=re.compile("\^+(?:a520|i05|i06|i07|i08|i091|i098|i34|i35|i36|i37|i38|i39|q230|q231|q232|q233|z952|z953|z954)",re.IGNORECASE)
    #pulmonary circulation disorders DC
    Elix04=re.compile("\^+(?:i26|i27|i280|i288|i289)",re.IGNORECASE)
    #peripheral vascular disorders DC
    Elix05=re.compile("\^+(?:i70|i71|i731|i738|i739|i771|i790|i792|k551|k558|k559|z958|z959)",re.IGNORECASE)
    #hypertension, incopmplicated DC
    Elix06=re.compile("\^+(?:i10)",re.IGNORECASE)
    #hypertension, complicated DC
    Elix07=re.compile("\^+(?:i11|i12|i13|i15)",re.IGNORECASE)
    #paralysis DC
    Elix08=re.compile("\^+(?:g041|g114|g801|g802|g81|g82|g830|g831|g832|g833|g834|g839)",re.IGNORECASE)
    #other neurological disorders DC
    Elix09=re.compile("\^+(?:g10|g11|g12|g13|g20|g21|g22|g254|g255|g312|g318|g319|g32|g35|g36|g37|g40|g41|g931|g934|r470|r56)",re.IGNORECASE)
    #chronic pulmonary disease DC
    Elix10=re.compile("\^+(?:i278|i279|j40|j41|j42|j43|j44|j45|j46|j47|j60|j61|j62|j63|j64|j65|j66|j67|j684|j701|j703)",re.IGNORECASE)
    #diabetes uncomplicated DC
    Elix11=re.compile("\^+(?:e100|e101|e109|e110|e111|e119|e120|e121|e129|e130|e131|e139|e140|e141|e149)",re.IGNORECASE)
    #diabetes complicated DC
    Elix12=re.compile("\^+(?:e102|e103|e104|e105|e106|e107|e108|e112|e113|e114|e115|e116|e117|e118|e122|e123|e124|e125|e126|e127|e128|e132|e133|e134|e135|e136|e137|e138|e142|e143|e144|e145|e146|e147|e148)",re.IGNORECASE)
    #hypothyroidism DC
    Elix13=re.compile("\^+(?:E00|E01|e02|e03|e890)",re.IGNORECASE)
    #renalfailure DC
    Elix14=re.compile("\^+(?:i120|i131|n18|n19|n250|z490|z491|z492|z940|z992)",re.IGNORECASE)
    #liverdisease DC
    Elix15=re.compile("\^+(?:b18|i85|i864|i982|k70|k711|k713|k714|k715|k717|k72|k73|k74|k760|k762|k763|k764|k765|k766|k767|k768|k769|z944)",re.IGNORECASE)
    #peptic ulcer disease excluding bleeding DC
    Elix16=re.compile("\^+(?:k257|k259|k267|k269|k277|k279|k287|k289)",re.IGNORECASE)
    #HIV Aids DC
    Elix17=re.compile("\^+(?:b20|b21|b22|b24)",re.IGNORECASE)
    #lymphoma DC
    Elix18=re.compile("\^+(?:c81|c82|c83|c84|c85|c88|c96|c900|c902)",re.IGNORECASE)
    #metastatic cancer DC
    Elix19=re.compile("\^+(?:C77|c78|c79|c80)",re.IGNORECASE)
    #solid tumor without metastasis DC
    Elix20=re.compile("\^+(?:c0|c1|c20|c21|c22|c23|c24|c25|c26|c30|c31|c32|c33|c34|c37|c38|c39|c40|c41|c43|c45|c46|c47|c48|c49|c50|c51|c52|c53|c54|c55|c56|c57|c58|c6|c70|c71|c72|c73|c74|c75|c76|c97)",re.IGNORECASE)
    #rheumatoid arthritis / collagen vascular diseases DC
    Elix21=re.compile("\^+(?:L940|L941|L943|mo5|m06|m08|m120|m123|m30|m310|m311|m312|m313|m32|m33|m34|m35|m45|m461|m468|m469)",re.IGNORECASE)
    #coagulopathy DC
    Elix22=re.compile("\^+(?:d65|d66|d67|d68|d691|d693|d694|d695|d696)",re.IGNORECASE)
    #obesity DC
    Elix23=re.compile("\^+(?:e66)",re.IGNORECASE)
    #weight loss DC
    Elix24=re.compile("\^+(?:e40|e41|e42|e43|e44|e45|e46|r634|r64)",re.IGNORECASE)
    #fluid and electrolyte disorders DC
    Elix25=re.compile("\^+(?:e222|e86|e87)",re.IGNORECASE)
    #blood loss anemia DC
    Elix26=re.compile("\^+(?:d500)",re.IGNORECASE)
    #deficiency anemia DC
    Elix27=re.compile("\^+(?:d508|d509|d51|d52|d53)",re.IGNORECASE)
    #alcohol abuse DC
    Elix28=re.compile("\^+(?:f10|e52|g621|i426|k292|k700|k703|k709|t51|z502|z714|z721)",re.IGNORECASE)
    #drug abuse DC
    Elix29=re.compile("\^+(?:f11|f12|f13|f14|f15|f16|f18|f19|z715|z722)",re.IGNORECASE)
    #psychoses DC
    Elix30=re.compile("\^+(?:f20|f22|f23|f24|f25|f28|f29|f302|f312|f315)",re.IGNORECASE)
    #depression DC
    Elix31=re.compile("\^+(?:f204|f313|f314|f315|f32|f33|f341|f412|f432)",re.IGNORECASE)
    df['Elix01']=df[dx].str.contains(Elix01, regex=True)
    df['Elix02']=df[dx].str.contains(Elix02, regex=True)
    df['Elix03']=df[dx].str.contains(Elix03, regex=True)
    df['Elix04']=df[dx].str.contains(Elix04, regex=True)
    df['Elix05']=df[dx].str.contains(Elix05, regex=True)
    df['Elix06']=df[dx].str.contains(Elix06, regex=True)
    df['Elix07']=df[dx].str.contains(Elix07, regex=True)
    df['Elix08']=df[dx].str.contains(Elix08, regex=True)
    df['Elix09']=df[dx].str.contains(Elix09, regex=True)
    df['Elix10']=df[dx].str.contains(Elix10, regex=True)
    df['Elix11']=df[dx].str.contains(Elix11, regex=True)
    df['Elix12']=df[dx].str.contains(Elix12, regex=True)
    df['Elix13']=df[dx].str.contains(Elix13, regex=True)
    df['Elix14']=df[dx].str.contains(Elix14, regex=True)
    df['Elix15']=df[dx].str.contains(Elix15, regex=True)
    df['Elix16']=df[dx].str.contains(Elix16, regex=True)
    df['Elix17']=df[dx].str.contains(Elix17, regex=True)
    df['Elix18']=df[dx].str.contains(Elix18, regex=True)
    df['Elix19']=df[dx].str.contains(Elix19, regex=True)
    df['Elix20']=df[dx].str.contains(Elix20, regex=True)
    df['Elix21']=df[dx].str.contains(Elix21, regex=True)
    df['Elix22']=df[dx].str.contains(Elix22, regex=True)
    df['Elix23']=df[dx].str.contains(Elix23, regex=True)
    df['Elix24']=df[dx].str.contains(Elix24, regex=True)
    df['Elix25']=df[dx].str.contains(Elix25, regex=True)
    df['Elix26']=df[dx].str.contains(Elix26, regex=True)
    df['Elix27']=df[dx].str.contains(Elix27, regex=True)
    df['Elix28']=df[dx].str.contains(Elix28, regex=True)
    df['Elix29']=df[dx].str.contains(Elix29, regex=True)
    df['Elix30']=df[dx].str.contains(Elix30, regex=True)
    df['Elix31']=df[dx].str.contains(Elix31, regex=True)
    filepath = os.path.join(dirname,'2017inp_pqi.csv')
    if os.path.exists(filepath):
        df.to_csv(filepath,mode='a', index=False, header=None)
    if not os.path.exists(filepath):
        df.to_csv(filepath,mode='w', index=False)
 
    
if __name__ == '__main__':
    dataset= os.path.join(dirname, '2017inp.csv')
    df = pd.read_csv(dataset, chunksize=200000)
    for arg in df:
        try: pqi(arg)
        except:print(" Failed")
        print(".")
    print("end")
