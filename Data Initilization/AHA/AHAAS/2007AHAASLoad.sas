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
DATA ANNUAL2007;

INfile 'X:\AHA\AHAAS Raw Data\FY2007 ASDB\FLAT\pubas07' lrecl=2969 recfm=f;				

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
@0042   CNTRL           2.
@0044   SERV            2.
@0046   SERVOTH        $30.
@0076   RADMCHI         1.
@0077   MHSMEMB        $1.
@0078   SYSID          $4.
@0082   SUBS            1.
@0083   MNGT            1.
@0084   MNGTNAME       $30.
@0114   MNGTCITY       $20.
@0134   MNGTSTCD       $2.
@0136   NETWRK          1.
@0137   NETNAME        $30.
@0167   NETAREA        $3.
@0170   NETTELNO       $7.
@0177   GENBD           4.
@0181   PEDBD           4.
@0185   OBBD            4.
@0189   MSICBD          4.
@0193   CICBD           4.
@0197   NICBD           4.
@0201   NINTBD          4.
@0205   PEDICBD         4.
@0209   BRNBD           4.
@0213   SPCICBD         4.
@0217   OTHICBD         4.
@0221   REHABBD         4.
@0225   ALCHBD          4.
@0229   PSYBD           4.
@0233   SNBD88          4.
@0237   ICFBD88         4.
@0241   ACULTBD         4.
@0245   OTHLBD94        4.
@0249   OTHBD94         4.
@0253   HOSPBD          4.
@0257   OBLEV           1.
@0258   GENHOS          1.
@0259   GENSYS          1.
@0260   GENNET          1.
@0261   GENVEN          1.
@0262   PEDHOS          1.
@0263   PEDSYS          1.
@0264   PEDNET          1.
@0265   PEDVEN          1.
@0266   OBHOS           1.
@0267   OBSYS           1.
@0268   OBNET           1.
@0269   OBVEN           1.
@0270   MSICHOS         1.
@0271   MSICSYS         1.
@0272   MSICNET         1.
@0273   MSICVEN         1.
@0274   CICHOS          1.
@0275   CICSYS          1.
@0276   CICNET          1.
@0277   CICVEN          1.
@0278   NICHOS          1.
@0279   NICSYS          1.
@0280   NICNET          1.
@0281   NICVEN          1.
@0282   NINTHOS         1.
@0283   NINTSYS         1.
@0284   NINTNET         1.
@0285   NINTVEN         1.
@0286   PEDICHOS        1.
@0287   PEDICSYS        1.
@0288   PEDICNET        1.
@0289   PEDICVEN        1.
@0290   BRNHOS          1.
@0291   BRNSYS          1.
@0292   BRNNET          1.
@0293   BRNVEN          1.
@0294   SPCICHOS        1.
@0295   SPCICSYS        1.
@0296   SPCICNET        1.
@0297   SPCICVEN        1.
@0298   OTHIHOS         1.
@0299   OTHISYS         1.
@0300   OTHINET         1.
@0301   OTHIVEN         1.
@0302   REHABHOS        1.
@0303   REHABSYS        1.
@0304   REHABNET        1.
@0305   REHABVEN        1.
@0306   ALCHHOS         1.
@0307   ALCHSYS         1.
@0308   ALCHNET         1.
@0309   ALCHVEN         1.
@0310   PSYHOS          1.
@0311   PSYSYS          1.
@0312   PSYNET          1.
@0313   PSYVEN          1.
@0314   SNHOS           1.
@0315   SNSYS           1.
@0316   SNNET           1.
@0317   SNVEN           1.
@0318   ICFHOS          1.
@0319   ICFSYS          1.
@0320   ICFNET          1.
@0321   ICFVEN          1.
@0322   ACUHOS          1.
@0323   ACUSYS          1.
@0324   ACUNET          1.
@0325   ACUVEN          1.
@0326   OTHLTHOS        1.
@0327   OTHLTSYS        1.
@0328   OTHLTNET        1.
@0329   OTHLTVEN        1.
@0330   OTHCRHOS        1.
@0331   OTHCRSYS        1.
@0332   OTHCRNET        1.
@0333   OTHCRVEN        1.
@0334   ADULTHOS        1.
@0335   ADULTSYS        1.
@0336   ADULTNET        1.
@0337   ADULTVEN        1.
@0338   AIRBHOS         1.
@0339   AIRBSYS         1.
@0340   AIRBNET         1.
@0341   AIRBVEN         1.
@0342   AIRBROOM        4.
@0346   ALCOPHOS        1.
@0347   ALCOPSYS        1.
@0348   ALCOPNET        1.
@0349   ALCOPVEN        1.
@0350   ALZHOS          1.
@0351   ALZSYS          1.
@0352   ALZNET          1.
@0353   ALZVEN          1.
@0354   AMBHOS          1.
@0355   AMBSYS          1.
@0356   AMBNET          1.
@0357   AMBVEN          1.
@0358   AMBSHOS         1.
@0359   AMBSSYS         1.
@0360   AMBSNET         1.
@0361   AMBSVEN         1.
@0362   ARTHCHOS        1.
@0363   ARTHCSYS        1.
@0364   ARTHCNET        1.
@0365   ARTHCVEN        1.
@0366   ASSTLHOS        1.
@0367   ASSTLSYS        1.
@0368   ASSTLNET        1.
@0369   ASSTLVEN        1.
@0370   AUXHOS          1.
@0371   AUXSYS          1.
@0372   AUXNET          1.
@0373   AUXVEN          1.
@0374   BWHTHOS         1.
@0375   BWHTSYS         1.
@0376   BWHTNET         1.
@0377   BWHTVEN         1.
@0378   BROOMHOS        1.
@0379   BROOMSYS        1.
@0380   BROOMNET        1.
@0381   BROOMVEN        1.
@0382   BLDOHOS         1.
@0383   BLDOSYS         1.
@0384   BLDONET         1.
@0385   BLDOVEN         1.
@0386   MAMMSHOS        1.
@0387   MAMMSSYS        1.
@0388   MAMMSNET        1.
@0389   MAMMSVEN        1.
@0390   ACLABHOS        1.
@0391   ACLABSYS        1.
@0392   ACLABNET        1.
@0393   ACLABVEN        1.
@0394   PCLABHOS        1.
@0395   PCLABSYS        1.
@0396   PCLABNET        1.
@0397   PCLABVEN        1.
@0398   ICLABHOS        1.
@0399   ICLABSYS        1.
@0400   ICLABNET        1.
@0401   ICLABVEN        1.
@0402   PELABHOS        1.
@0403   PELABSYS        1.
@0404   PELABNET        1.
@0405   PELABVEN        1.
@0406   ADTCHOS         1.
@0407   ADTCSYS         1.
@0408   ADTCNET         1.
@0409   ADTCVEN         1.
@0410   PEDCSHOS        1.
@0411   PEDCSSYS        1.
@0412   PEDCSNET        1.
@0413   PEDCSVEN        1.
@0414   CHABHOS         1.
@0415   CHABSYS         1.
@0416   CHABNET         1.
@0417   CHABVEN         1.
@0418   CMNGTHOS        1.
@0419   CMNGTSYS        1.
@0420   CMNGTNET        1.
@0421   CMNGTVEN        1.
@0422   CHAPHOS         1.
@0423   CHAPSYS         1.
@0424   CHAPNET         1.
@0425   CHAPVEN         1.
@0426   CHTHHOS         1.
@0427   CHTHSYS         1.
@0428   CHTHNET         1.
@0429   CHTHVEN         1.
@0430   CWELLHOS        1.
@0431   CWELLSYS        1.
@0432   CWELLNET        1.
@0433   CWELLVEN        1.
@0434   CHIHOS          1.
@0435   CHISYS          1.
@0436   CHINET          1.
@0437   CHIVEN          1.
@0438   COUTRHOS        1.
@0439   COUTRSYS        1.
@0440   COUTRNET        1.
@0441   COUTRVEN        1.
@0442   COMPHOS         1.
@0443   COMPSYS         1.
@0444   COMPNET         1.
@0445   COMPVEN         1.
@0446   CAOSHOS         1.
@0447   CAOSSYS         1.
@0448   CAOSNET         1.
@0449   CAOSVEN         1.
@0450   CPREVHOS        1.
@0451   CPREVSYS        1.
@0452   CPREVNET        1.
@0453   CPREVVEN        1.
@0454   DENTSHOS        1.
@0455   DENTSSYS        1.
@0456   DENTSNET        1.
@0457   DENTSVEN        1.
@0458   EMDEPHOS        1.
@0459   EMDEPSYS        1.
@0460   EMDEPNET        1.
@0461   EMDEPVEN        1.
@0462   FSERHOS         1.
@0463   FSERSYS         1.
@0464   FSERNET         1.
@0465   FSERVEN         1.
@0466   FSERYN          1.
@0467   TRAUMHOS        1.
@0468   TRAUMSYS        1.
@0469   TRAUMNET        1.
@0470   TRAUMVEN        1.
@0471   TRAUML90        1.
@0472   ENBHOS          1.
@0473   ENBSYS          1.
@0474   ENBNET          1.
@0475   ENBVEN          1.
@0476   HOSPCHOS        1.
@0477   HOSPCSYS        1.
@0478   HOSPCNET        1.
@0479   HOSPCVEN        1.
@0480   PAINHOS         1.
@0481   PAINSYS         1.
@0482   PAINNET         1.
@0483   PAINVEN         1.
@0484   PALHOS          1.
@0485   PALSYS          1.
@0486   PALNET          1.
@0487   PALVEN          1.
@0488   IPALHOS         1.
@0489   IPALSYS         1.
@0490   IPALNET         1.
@0491   IPALVEN         1.
@0492   ENDOUHOS        1.
@0493   ENDOUSYS        1.
@0494   ENDOUNET        1.
@0495   ENDOUVEN        1.
@0496   ENDOAHOS        1.
@0497   ENDOASYS        1.
@0498   ENDOANET        1.
@0499   ENDOAVEN        1.
@0500   ENDOEHOS        1.
@0501   ENDOESYS        1.
@0502   ENDOENET        1.
@0503   ENDOEVEN        1.
@0504   ENDORHOS        1.
@0505   ENDORSYS        1.
@0506   ENDORNET        1.
@0507   ENDORVEN        1.
@0508   ENRHOS          1.
@0509   ENRSYS          1.
@0510   ENRNET          1.
@0511   ENRVEN          1.
@0512   ESWLHOS         1.
@0513   ESWLSYS         1.
@0514   ESWLNET         1.
@0515   ESWLVEN         1.
@0516   FITCHOS         1.
@0517   FITCSYS         1.
@0518   FITCNET         1.
@0519   FITCVEN         1.
@0520   OPCENHOS        1.
@0521   OPCENSYS        1.
@0522   OPCENNET        1.
@0523   OPCENVEN        1.
@0524   GERSVHOS        1.
@0525   GERSVSYS        1.
@0526   GERSVNET        1.
@0527   GERSVVEN        1.
@0528   HLTHFHOS        1.
@0529   HLTHFSYS        1.
@0530   HLTHFNET        1.
@0531   HLTHFVEN        1.
@0532   HLTHCHOS        1.
@0533   HLTHCSYS        1.
@0534   HLTHCNET        1.
@0535   HLTHCVEN        1.
@0536   HLTHSHOS        1.
@0537   HLTHSSYS        1.
@0538   HLTHSNET        1.
@0539   HLTHSVEN        1.
@0540   HLTRHOS         1.
@0541   HLTRSYS         1.
@0542   HLTRNET         1.
@0543   HLTRVEN         1.
@0544   HEMOHOS         1.
@0545   HEMOSYS         1.
@0546   HEMONET         1.
@0547   HEMOVEN         1.
@0548   AIDSSHOS        1.
@0549   AIDSSSYS        1.
@0550   AIDSSNET        1.
@0551   AIDSSVEN        1.
@0552   HOMEHHOS        1.
@0553   HOMEHSYS        1.
@0554   HOMEHNET        1.
@0555   HOMEHVEN        1.
@0556   OPHOSHOS        1.
@0557   OPHOSSYS        1.
@0558   OPHOSNET        1.
@0559   OPHOSVEN        1.
@0560   IMPRHOS         1.
@0561   IMPRSYS         1.
@0562   IMPRNET         1.
@0563   IMPRVEN         1.
@0564   ICARHOS         1.
@0565   ICARSYS         1.
@0566   ICARNET         1.
@0567   ICARVEN         1.
@0568   LINGHOS         1.
@0569   LINGSYS         1.
@0570   LINGNET         1.
@0571   LINGVEN         1.
@0572   MEALSHOS        1.
@0573   MEALSSYS        1.
@0574   MEALSNET        1.
@0575   MEALSVEN        1.
@0576   MOHSHOS         1.
@0577   MOHSSYS         1.
@0578   MOHSNET         1.
@0579   MOHSVEN         1.
@0580   NEROHOS         1.
@0581   NEROSYS         1.
@0582   NERONET         1.
@0583   NEROVEN         1.
@0584   NUTRPHOS        1.
@0585   NUTRPSYS        1.
@0586   NUTRPNET        1.
@0587   NUTRPVEN        1.
@0588   OCCHSHOS        1.
@0589   OCCHSSYS        1.
@0590   OCCHSNET        1.
@0591   OCCHSVEN        1.
@0592   ONCOLHOS        1.
@0593   ONCOLSYS        1.
@0594   ONCOLNET        1.
@0595   ONCOLVEN        1.
@0596   ORTOHOS         1.
@0597   ORTOSYS         1.
@0598   ORTONET         1.
@0599   ORTOVEN         1.
@0600   OPSRGHOS        1.
@0601   OPSRGSYS        1.
@0602   OPSRGNET        1.
@0603   OPSRGVEN        1.
@0604   PCAHOS          1.
@0605   PCASYS          1.
@0606   PCANET          1.
@0607   PCAVEN          1.
@0608   PATEDHOS        1.
@0609   PATEDSYS        1.
@0610   PATEDNET        1.
@0611   PATEDVEN        1.
@0612   PATRPHOS        1.
@0613   PATRPSYS        1.
@0614   PATRPNET        1.
@0615   PATRPVEN        1.
@0616   RHBOPHOS        1.
@0617   RHBOPSYS        1.
@0618   RHBOPNET        1.
@0619   RHBOPVEN        1.
@0620   PCDEPHOS        1.
@0621   PCDEPSYS        1.
@0622   PCDEPNET        1.
@0623   PCDEPVEN        1.
@0624   PSYCAHOS        1.
@0625   PSYCASYS        1.
@0626   PSYCANET        1.
@0627   PSYCAVEN        1.
@0628   PSYLSHOS        1.
@0629   PSYLSSYS        1.
@0630   PSYLSNET        1.
@0631   PSYLSVEN        1.
@0632   PSYEDHOS        1.
@0633   PSYEDSYS        1.
@0634   PSYEDNET        1.
@0635   PSYEDVEN        1.
@0636   PSYEMHOS        1.
@0637   PSYEMSYS        1.
@0638   PSYEMNET        1.
@0639   PSYEMVEN        1.
@0640   PSYGRHOS        1.
@0641   PSYGRSYS        1.
@0642   PSYGRNET        1.
@0643   PSYGRVEN        1.
@0644   PSYOPHOS        1.
@0645   PSYOPSYS        1.
@0646   PSYOPNET        1.
@0647   PSYOPVEN        1.
@0648   PSYPHHOS        1.
@0649   PSYPHSYS        1.
@0650   PSYPHNET        1.
@0651   PSYPHVEN        1.
@0652   RADTHHOS        1.
@0653   RADTHSYS        1.
@0654   RADTHNET        1.
@0655   RADTHVEN        1.
@0656   IGRTHOS         1.
@0657   IGRTSYS         1.
@0658   IGRTNET         1.
@0659   IGRTVEN         1.
@0660   IMRTHOS         1.
@0661   IMRTSYS         1.
@0662   IMRTNET         1.
@0663   IMRTVEN         1.
@0664   PTONHOS         1.
@0665   PTONSYS         1.
@0666   PTONNET         1.
@0667   PTONVEN         1.
@0668   BEAMHOS         1.
@0669   BEAMSYS         1.
@0670   BEAMNET         1.
@0671   BEAMVEN         1.
@0672   SRADHOS         1.
@0673   SRADSYS         1.
@0674   SRADNET         1.
@0675   SRADVEN         1.
@0676   CTSCNHOS        1.
@0677   CTSCNSYS        1.
@0678   CTSCNNET        1.
@0679   CTSCNVEN        1.
@0680   DRADFHOS        1.
@0681   DRADFSYS        1.
@0682   DRADFNET        1.
@0683   DRADFVEN        1.
@0684   EBCTHOS         1.
@0685   EBCTSYS         1.
@0686   EBCTNET         1.
@0687   EBCTVEN         1.
@0688   FFDMHOS         1.
@0689   FFDMSYS         1.
@0690   FFDMNET         1.
@0691   FFDMVEN         1.
@0692   MRIHOS          1.
@0693   MRISYS          1.
@0694   MRINET          1.
@0695   MRIVEN          1.
@0696   IMRIHOS         1.
@0697   IMRISYS         1.
@0698   IMRINET         1.
@0699   IMRIVEN         1.
@0700   MSCTHOS         1.
@0701   MSCTSYS         1.
@0702   MSCTNET         1.
@0703   MSCTVEN         1.
@0704   MSCTGHOS        1.
@0705   MSCTGSYS        1.
@0706   MSCTGNET        1.
@0707   MSCTGVEN        1.
@0708   PETHOS          1.
@0709   PETSYS          1.
@0710   PETNET          1.
@0711   PETVEN          1.
@0712   PETCTHOS        1.
@0713   PETCTSYS        1.
@0714   PETCTNET        1.
@0715   PETCTVEN        1.
@0716   SPECTHOS        1.
@0717   SPECTSYS        1.
@0718   SPECTNET        1.
@0719   SPECTVEN        1.
@0720   ULTSNHOS        1.
@0721   ULTSNSYS        1.
@0722   ULTSNNET        1.
@0723   ULTSNVEN        1.
@0724   FRTCHOS         1.
@0725   FRTCSYS         1.
@0726   FRTCNET         1.
@0727   FRTCVEN         1.
@0728   GNTCHOS         1.
@0729   GNTCSYS         1.
@0730   GNTCNET         1.
@0731   GNTCVEN         1.
@0732   RETIRHOS        1.
@0733   RETIRSYS        1.
@0734   RETIRNET        1.
@0735   RETIRVEN        1.
@0736   ROBOHOS         1.
@0737   ROBOSYS         1.
@0738   ROBONET         1.
@0739   ROBOVEN         1.
@0740   SLEPHOS         1.
@0741   SLEPSYS         1.
@0742   SLEPNET         1.
@0743   SLEPVEN         1.
@0744   SOCWKHOS        1.
@0745   SOCWKSYS        1.
@0746   SOCWKNET        1.
@0747   SOCWKVEN        1.
@0748   SPORTHOS        1.
@0749   SPORTSYS        1.
@0750   SPORTNET        1.
@0751   SPORTVEN        1.
@0752   SUPPGHOS        1.
@0753   SUPPGSYS        1.
@0754   SUPPGNET        1.
@0755   SUPPGVEN        1.
@0756   SWBDHOS         1.
@0757   SWBDSYS         1.
@0758   SWBDNET         1.
@0759   SWBDVEN         1.
@0760   TEENSHOS        1.
@0761   TEENSSYS        1.
@0762   TEENSNET        1.
@0763   TEENSVEN        1.
@0764   TOBHOS          1.
@0765   TOBSYS          1.
@0766   TOBNET          1.
@0767   TOBVEN          1.
@0768   OTBONHOS        1.
@0769   OTBONSYS        1.
@0770   OTBONNET        1.
@0771   OTBONVEN        1.
@0772   HARTHOS         1.
@0773   HARTSYS         1.
@0774   HARTNET         1.
@0775   HARTVEN         1.
@0776   KDNYHOS         1.
@0777   KDNYSYS         1.
@0778   KDNYNET         1.
@0779   KDNYVEN         1.
@0780   LIVRHOS         1.
@0781   LIVRSYS         1.
@0782   LIVRNET         1.
@0783   LIVRVEN         1.
@0784   LUNGHOS         1.
@0785   LUNGSYS         1.
@0786   LUNGNET         1.
@0787   LUNGVEN         1.
@0788   TISUHOS         1.
@0789   TISUSYS         1.
@0790   TISUNET         1.
@0791   TISUVEN         1.
@0792   OTOTHHOS        1.
@0793   OTOTHSYS        1.
@0794   OTOTHNET        1.
@0795   OTOTHVEN        1.

@0796   TPORTHOS        1.
@0797   TPORTSYS        1.
@0798   TPORTNET        1.
@0799   TPORTVEN        1.
@0800   URGCCHOS        1.
@0801   URGCCSYS        1.
@0802   URGCCNET        1.
@0803   URGCCVEN        1.
@0804   VRCSHOS         1.
@0805   VRCSSYS         1.
@0806   VRCSNET         1.
@0807   VRCSVEN         1.
@0808   VOLSVHOS        1.
@0809   VOLSVSYS        1.
@0810   VOLSVNET        1.
@0811   VOLSVVEN        1.
@0812   WOMHCHOS        1.
@0813   WOMHCSYS        1.
@0814   WOMHCNET        1.
@0815   WOMHCVEN        1.
@0816   WMGTHOS         1.
@0817   WMGTSYS         1.
@0818   WMGTNET         1.
@0819   WMGTVEN         1.
@0820   IPAHOS          1.
@0821   IPASYS          1.
@0822   IPANET          1.
@0823   GPWWHOS         1.
@0824   GPWWSYS         1.
@0825   GPWWNET         1.
@0826   OPHOHOS         1.
@0827   OPHOSYS         1.
@0828   OPHONET         1.
@0829   CPHOHOS         1.
@0830   CPHOSYS         1.
@0831   CPHONET         1.
@0832   MSOHOS          1.
@0833   MSOSYS          1.
@0834   MSONET          1.
@0835   ISMHOS          1.
@0836   ISMSYS          1.
@0837   ISMNET          1.
@0838   EQMODHOS        1.
@0839   EQMODSYS        1.
@0840   EQMODNET        1.
@0841   FOUNDHOS        1.
@0842   FOUNDSYS        1.
@0843   FOUNDNET        1.
@0844   IPAP            4.
@0848   GPWP            4.
@0852   OPHP            4.
@0856   CPHP            4.
@0860   MSOP            4.
@0864   ISMP            4.
@0868   EQMP            4.
@0872   FNDP            4.
@0876   JNTPH           1.
@0877   JNLS            1.
@0878   JNTAMB          1.
@0879   JNTCTR          1.
@0880   JNTOTH          1.
@0881   LSHTXT         $50.
@0931   JNTLSC          1.
@0932   JNTLSO          1.
@0933   JNTLSS          1.
@0934   JNTLST          1.
@0935   JNTTXT         $50.
@0985   IPHMOHOS        1.
@0986   IPHMOSYS        1.
@0987   IPHMONET        1.
@0988   IPHMOVEN        1.
@0989   IPPPOHOS        1.
@0990   IPPPOSYS        1.
@0991   IPPPONET        1.
@0992   IPPPOVEN        1.
@0993   IPFEEHOS        1.
@0994   IPFEESYS        1.
@0995   IPFEENET        1.
@0996   IPFEEVEN        1.
@0997   HMO86           1.
@998    HMOCON          4.
@1002   PPO86           1.
@1003   PPOCON          4.
@1007   CPPCT           4.
@1011   CAPRSK          4.
@1015   CAPCON94        1.
@1016   CAPCOV          8.
@1024   SUNITS          1.
@1025   LBEDSA          6.
@1031   BDTOT           4.
@1035   ADMTOT          6.
@1041   IPDTOT          8.
@1049   BDH             4.
@1053   ADMH            6.
@1059   IPDH            8.
@1067   LBEDLA          6.
@1073   BDLT            4.
@1077   ADMLT           6.
@1083   IPDLT           8.
@1091   MCRDC           6.
@1097   MCRIPD          8.
@1105   MCDDC           6.
@1111   MCDIPD          8.
@1119   MCRDCH          6.
@1125   MCRIPDH         8.
@1133   MCDDCH          6.
@1139   MCDIPDH         8.
@1147   MCRDCLT         6.
@1153   MCRIPDLT        8.
@1161   MCDDCLT         6.
@1167   MCDIPDLT        8.
@1175   BASSIN          4.
@1179   BIRTHS          6.
@1185   SUROPIP         6.
@1191   SUROPOP         6.
@1197   SUROPTOT        6.
@1203   OPRA            4.
@1207   VEM             8.
@1215   VOTH            8.
@1223   VTOT            8.
@1231   PAYTOT          10.
@1241   NPAYBEN         10.
@1251   EXPTOT          10.
@1261   PAYTOTH         10.
@1271   NPAYBENH        10.
@1281   EXPTHA          15.
@1296   PAYTOTLT        10.
@1306   NPAYBENL        10.
@1316   EXPTLA          15.
@1331   PLNTA           10.
@1341   ADEPRA          10.
@1351   ASSNET          10.
@1361   GFEET           10.
@1371   CEAMT           10.
@1381   EHLTH           1.
@1382   EHLTHI          1.
@1383   EHLTHM          1.
@1384   EHLTHE          1.
@1385   EHLTHS          1.
@1386   EMEDS           1.
@1387   ELABS           1.
@1388   FTMDTF          5.
@1393   FTRES           5.
@1398   FTTRAN84        5.
@1403   FTRNTF          5.
@1408   FTLPNTF         5.
@1413   FTAST           5.
@1418   FTRAD           5.
@1423   FTLAB           5.
@1428   FTPHR           5.
@1433   FTPHT           5.
@1438   FTRESP          5.
@1443   FTOTHTF         5.
@1448   FTTOT           5.
@1453   PTMDTF          5.
@1458   PTRES           5.
@1463   PTTRAN84        5.
@1468   PTRNTF          5.
@1473   PTLPNTF         5.
@1478   PTAST           5.
@1483   PTRAD           5.
@1488   PTLAB           5.
@1493   PTPHR           5.
@1498   PTPHT           5.
@1503   PTRESP          5.
@1508   PTOTHTF         5.
@1513   PTTOT           5.
@1518   FTTOTH          5.
@1523   PTTOTH          5.
@1528   FTTOTLT         5.
@1533   PTTOTLT         5.
@1538   FTED            8.
@1546   FTER            8.
@1554   FTET            8.
@1562   FTEN            8.
@1570   FTEP            8.
@1578   FTEAP           8.
@1586   FTERAD          8.
@1594   FTELAB          8.
@1602   FTEPH           8.
@1610   FTEPHT          8.
@1618   FTERESP         8.
@1626   FTEO            8.
@1634   FTETF           8.
@1642   FTEU            8.
@1650   HSPTL           1.
@1651   HSPFT           8.
@1659   HSPPT           8.
@1667   FTEHSP          8.
@1675   HSPGP           1.
@1676   HSPPG           1.
@1677   HSPETH          1.
@1678   HSPUP           1.
@1679   HSPOTH          1.
@1680   FTMSIA          5.
@1685   FTCICA          5.
@1690   FTNICA          5.
@1695   FTPICA          5.
@1700   FTOICA          5.
@1705   FTTINTA         5.
@1710   PTMSIA          5.
@1715   PTCICA          5.
@1720   PTNICA          5.
@1725   PTPICA          5.
@1730   PTOICA          5.
@1735   PTTINTA         5.
@1740   FTEMSI          8.
@1748   FTECIC          8.
@1756   FTENIC          8.
@1764   FTEPIC          8.
@1772   FTEOIC          8.
@1780   FTEINT          8.
@1788   FORNRSA         1.
@1789   AFRICA          1.
@1790   KOREA           1.
@1791   CANADA          1.
@1792   PH              1.
@1793   CHINA           1.
@1794   INDIA           1.
@1795   OFRNRS          1.
@1796   MISSION         1.
@1797   LTPLAN          1.
@1798   RESOURCE        1.
@1799   BENEFIT         1.
@1800   BUILD           1.
@1801   FUND            1.
@1802   HWELL           1.
@1803   HSASSESS        1.
@1804   HSIND           1.
@1805   CAPASS          1.
@1806   ASSUSE          1.
@1807   CTRACK          1.
@1808   QUALREP         1.
@1809   GRACE           1.
@1810   GLANG           1.
@1811   ILEAD           1.
@1812   DIVERS          1.
@1813   ELEADS          1.
@1814   DEVADM          1.
@1815   SNT             1.
@1816   MTYPE          $2.
@1818   MLOS            1.
@1819   MCNTRL          2.
@1821   MSERV           2.
MNAME	$	1823	-	1852
MADMIN	$	1853	-	1882
MLOCADDR	$	1883	-	1912
MLOCCITY	$	1913	-	1932
MLOCSTCD	$	1933	-	1934
MLOCZIP	$	1935	-	1939
AREA	$	1940	-	1942
TELNO	$	1943	-	1949
RESP	$	1950	-	1950
CHC	$	1951	-	1951
BSC	$	1952	-	1952
LOS	$	1953	-	1953
ADC	$	1954	-	1961
ADJADM	$	1962	-	1969
ADJPD	$	1970	-	1977
ADJADC	$	1978	-	1985
FTEMD	$	1986	-	1993
FTERN	$	1994	-	2001
FTELPN	$	2002	-	2009
FTERES	$	2010	-	2017
FTETRAN	$	2018	-	2025
FTETTRN	$	2026	-	2033
FTEOTH94	$	2034	-	2041
FTEH	$	2042	-	2049
FTENH	$	2050	-	2057
FTE	$	2058	-	2065
MCNTYCD	$	2066	-	2068
FCOUNTY	$	2069	-	2073
FSTCD	$	2074	-	2075
FCNTYCD	$	2076	-	2078
CITYRK	$	2079	-	2081
MAPP1	$	2082	-	2082
MAPP2	$	2083	-	2083
MAPP3	$	2084	-	2084
MAPP5	$	2085	-	2085
MAPP6	$	2086	-	2086
MAPP7	$	2087	-	2087
MAPP8	$	2088	-	2088
MAPP9	$	2089	-	2089
MAPP10	$	2090	-	2090
MAPP11	$	2091	-	2091
MAPP12	$	2092	-	2092
MAPP13	$	2093	-	2093
MAPP16	$	2094	-	2094
MAPP17	$	2095	-	2095
CAH     	$	2096	-	2096
RRCTR   	$	2097	-	2097
SCPROV  	$	2098	-	2098
EADMTOT	$	2099	-	2099
EIPDTOT	$	2100	-	2100
EADMH	$	2101	-	2101
EIPDH	$	2102	-	2102
EADMLT	$	2103	-	2103
EIPDLT	$	2104	-	2104
EMCRDC	$	2105	-	2105
EMCRIPD	$	2106	-	2106
EMCDDC	$	2107	-	2107
EMCDIPD	$	2108	-	2108
EMCRDCH	$	2109	-	2109
EMCRIPDH	$	2110	-	2110
EMCDDCH	$	2111	-	2111
EMCDIPDH	$	2112	-	2112
EMCRDCLT	$	2113	-	2113
EMCRPDLT	$	2114	-	2114
EMCDDCLT	$	2115	-	2115
EMCDPDLT	$	2116	-	2116
EBIRTHS	$	2117	-	2117
ESUROPIP	$	2118	-	2118
ESUROPOP	$	2119	-	2119
ESUROPTO	$	2120	-	2120
EVEM	$	2121	-	2121
EVOTH	$	2122	-	2122
EVTOT	$	2123	-	2123
EPAYTOT	$	2124	-	2124
ENPAYBEN	$	2125	-	2125
EEXPTOT	$	2126	-	2126
EPAYTOTH	$	2127	-	2127
ENPYBENH	$	2128	-	2128
EPYTOTLT	$	2129	-	2129
ENPBENLT	$	2130	-	2130
EFTMDTF	$	2131	-	2131
EFTRES	$	2132	-	2132
EFTTRN84	$	2133	-	2133
EFTRNTF	$	2134	-	2134
EFTLPNTF	$	2135	-	2135
EFTAST	$	2136	-	2136
EFTRAD	$	2137	-	2137
EFTLAB	$	2138	-	2138
EFTPHR	$	2139	-	2139
EFTPHT	$	2140	-	2140
EFTRESP	$	2141	-	2141
EFTOTHTF	$	2142	-	2142
EFTTOT	$	2143	-	2143
EPTMDTF	$	2144	-	2144
EPTRES	$	2145	-	2145
EPTTRN84	$	2146	-	2146
EPTRNTF	$	2147	-	2147
EPTLPNTF	$	2148	-	2148
EPTAST	$	2149	-	2149
EPTRAD	$	2150	-	2150
EPTLAB	$	2151	-	2151
EPTPHR	$	2152	-	2152
EPTPHT	$	2153	-	2153
EPTRESP	$	2154	-	2154
EPTOTHTF	$	2155	-	2155
EPTTOT	$	2156	-	2156
EFTTOTH	$	2157	-	2157
EPTTOTH	$	2158	-	2158
EFTTOTLT	$	2159	-	2159
EPTTOTLT	$	2160	-	2160
EXPTHB	$	2161	-	2161
EXPTLB	$	2162	-	2162
MSTATE	$	2163	-	2164
NETPHONE	$	2165	-	2174
SYSNAME	$	2175	-	2259
SYSADDR	$	2260	-	2304
SYSCITY	$	2305	-	2324
SYSST	$	2325	-	2326
SYSZIP	$	2327	-	2336
SYSAREA	$	2337	-	2339
SYSTELN	$	2340	-	2347
SYSFNAME	$	2348	-	2362
SYSMNAME	$	2363	-	2372
SYSLNAME	$	2373	-	2387
SYSSUFX	$	2388	-	2392
SYSTITLE	$	2393	-	2447
COMMTY	$	2448	-	2448
MCRNUM	$	2449	-	2454
LAT	$	2455	-	2464
LONG	$	2465	-	2474
CNTYNAME	$	2475	-	2519
AHAMBR	$	2520	-	2520
CLUSTER	$	2521	-	2521
HSACODE	$	2522	-	2526
HSANAME	$	2527	-	2551
HRRCODE	$	2552	-	2554
HRRNAME	$	2555	-	2579
GROUP	$	2580	-	2580
GPO_ID  	$	2581	-	2587
GPONAM  	$	2588	-	2659
GPOCITY  	$	2660	-	2679
GPOST    	$	2680	-	2681
GPOADDR  	$	2682	-	2741
GPOZIP   	$	2742	-	2752
GPOPHONE 	$	2753	-	2765
GPOCONT  	$	2766	-	2795
GPOTITLE 	$	2796	-	2845
GPOWEB   	$	2846	-	2895
CBSACODE    	$	2896	-	2900
CBSANAME	$	2901	-	2960
CBSATYPE	$	2961	-	2968
ENDMARK 	$	2969	-	2969

;
;	
RUN;	
proc contents data=annual2007;run;				


LIBNAME isilon ODBC NOPROMPT="Driver={SQL Server Native Client 11.0};Server=sql-ctlst-vp01\TP;Database=isilon;Trusted_Connection=yes;" SCHEMA = AHA;
*We're just making columns like above and  adding them to SQL;
proc SQL;
create table isilon.annual2007
like work.annual2007;

proc SQL;
insert into isilon.annual2007
select * from work.annual2007;
