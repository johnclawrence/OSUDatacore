Paper-08#37     Comparative Effectiveness of New Approaches to Improve Mortality Risk Models From Medicare Claims Data.
                    This is probably a hit. It depends on to what extent I can re-implmement thier models but I would be suprised if I can't atleast build their dataset.
On to the methods!
    cohort is looking for 30 day all cause motality for AMI / HF / pneumonia in the SAF and denom files, looking for principle diagnosis from 2013-2015 (This can be done) using icd0-10 codes, 65 plus, excluding people discharged against meidcal device. And they used claims for 12 months before the index admission (So they're using 2012 data, which is fine, i've got that. )

    So they tested 3 risk models... 
    One is present on admission codes, I assume that is a variable that i have.
        CMS mortality measures risk model was developed before POA exclude that. and they tested if they put PoA into the model if it did a better job... So I need to learn about CMS mortality measures risk model.


        historcial conditions from PoA...

        So they're not 3 new risk models, they're three modifications of risk models. Oh this is going to be fun to figure out.
        