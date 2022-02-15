Paper 3 County-Level Socioeconomic Disparities in Use of Medical Services for Management of Infections by Medicare Beneficiaries With Diabetes-United States, 2012

https://pubmed.ncbi.nlm.nih.gov/31136524/
Starts with generating roughly infinite summary statistics!
https://view.officeapps.live.com/op/view.aspx?src=https%3A%2F%2Fcdn-links.lww.com%2Fpermalink%2Fjphmp%2Fa%2Fjphmp_2018_03_01_chang_1700436_sdc1.docx&wdOrigin=BROWSELINK

Nothing ambiguous about their dataset, Medicare 2012 MBSF (demon) files linked to Carrier, Out, Inp, and Medpar (redundant)
Step 1 though is I need to define diabetes. The algo they reference is Centers for Medicare & Medicaid Services. Chronic Conditions Data Warehouse: Medicare Administrative Data User Guide. Baltimore, MD: Centers for Medicare & Medicaid Services; 2017. https://www.ccwdata.org/web/guest/home. the CMS Chronic Condition Data Warehouse predefined algorithm for classifying beneficiaries into those with and without diabetes at the end of 2012.
    So I don't have that for the LDS because that's a SAF thing; however I suspect I can recreate the algorithem because it should just be based on icd-9 codes. 
        https://www2.ccwdata.org/web/guest/condition-categories
        So, we're looking at these with a 2 year lookback (problimatic because I don't have 2011 but we will see how different the numbers appear)
        
        CCW is defining diabetes as having... 
        DX 249.00, 249.01, 249.10, 249.11, 249.20, 249.21, 249.30, 249.31, 249.40, 249.41, 249.50, 249.51, 249.60, 249.61, 249.70, 249.71, 249.80, 249.81, 249.90, 249.91, 
        250.00, 250.01, 250.02, 250.03, 250.10, 250.11, 250.12, 250.13, 250.20, 250.21, 250.22, 250.23, 250.30, 250.31, 250.32, 250.33, 250.40, 250.41, 250.42, 250.43, 250.50, 250.51, 250.52, 250.53, 250.60, 250.61, 250.62, 250.63, 250.70, 250.71, 250.72, 250.73, 250.80, 250.81, 250.82, 250.83, 250.90, 250.91, 250.92, 250.93, 
        357.2, 362.01, 362.02, 362.03, 362.04, 362.05, 362.06, 366.41

    So next is from Quan CCI enhanced: 250.4-250.7,250.0-250.3,250.8,250.9
                        CCI Deyo: 250.0-250.3 ,250.7, 250.4-250.6
                        Eilxhauser: 250.0-250.7,250.9
                        Elixhauser Ahrq: 250.0-250.9 , 775.1, 648.0
                        elix Enhanced : 250.0-250.9

    And finally is from the PQI ICD-9, we're looking at PQI 1,3,14,16 which is... again, only looking at 250 codes... 
        So CCW is odd, they're looking at 249.x and stuff between 357-366... What even are those 
            Oh interesting 249 are just flavours of controlled T2 diabetes
            and the 300 codes are also just... flavours of diabetes. Okay. 

    well, if I'm going to be doing diagnosis regexing (and I am going to be doing diagnosis regexing) Then I might as well figure out every thing I'm going to be doing. 
        Supplemental Figure 1
        Inclusion Criteria is Diabetes by the algo above. 
            Age from MBSF
            Race from MBSF
            Census Region from MBSF
            Medicare status code from MBSF
            Dual Eligibility code from MBSF
            Hospital Emergency Visit from Revenue File (done in paper one but will be explained again here) and looking at admitted vs discharged, well we shall see how they did this! there are several ways
            Comorbidities (Acute myocardial infarction, heart failure, chronic kidney disease, ischemic heart disease, peripheral vascular disease, stroke/transient ischemic attack (stroke), chronic obstructive pulmonary disease, end-stage renal disease, diabetic neuropathy, hyperglycemia (uncontrolled diabetes mellitus), hip/pelvic fracture, and depression.)  That's not CCI... And I don't think that that is elixhauser either. Okay, so these are CCW variables.
            finally are...
            Site-Specific Infections        Pneumonia, influenza, postoperative infection, urinary tract infection, gangrene, foot infection, and bacterial septicemia.
            Pathogen-specific Infections    Streptococcal and meningococcal, dermatophytosis, herpes zoster, candidiasis, and viral hepatitis.
            and HHST specific infections    Viral hepatitis, tuberculosis, human immunodeficiency virus infection, and sexually transmitted diseases (including chlamydia, syphilis, gonorrhea, human papillomavirus, and genital herpes).

            Part of the struggle at this point is that... I'm worried that I can't actually implmement the algos from CCW and I want to pause at this point before continuing...Some of these above look back 2 years. As a result I don't actually believe I can replicate the CCW algos on the 2012 dataset as 2012 is the oldest data that I have... So lets see if there is some way to get CCW data linked to the denom file, because that makes this all possible. Hoenstly I am going to take a stab at it. Even if it's not exact it should be very very close. The only ones that look back more than a year are like heart failure and diabetes... And if it's all that different because of the 2 year thing I'll just use 2013 data and do an extension. 

            So Lets continue, those bottom 3. 
            "We identified site-specific infection or pathogen-specific infection for persons with diabetes who had 1 or more FFS reimbursement claims with defined groups of diagnosis codes from the International Classification of Diseases, Ninth Revision, Clinical Modification"
            Okay, Cool, so what are the diagnosis groups. Citation 21 maybe...
            They also say "persons who received services for HIV infection had 1 or more inpatient claims or 2 or more outpatient claims. Persons who received services for hepatitis, sexually transmitted diseases, or tuberculosis had 1 or more inpatient or outpatient claims" Which I think means that you need 2 HIV outpatient claims to count... Though I don't know why they made this distinction

            On to citation 21! Research Data Assistance Center. http://www.resdac.org/cms-data/search?f%5b0%5d=im_field_data_file_category%3A46 well 5 years later that page doesn't exist.
            Maybe they're using msdrg... Nope, msdrg doesn't group like that, neither does APR-DRG... Huh... And these terms aren't commonly used... did this paper just make up those terms and groups without any explination? HHST surely isn't something they made up... right? It is not. Okay. Well. Fine. They don't reference a citation for how they define these things. So I'm going to define them with the best providence I can figure out.

            My goal is to use diagnosis groupers where possible because they auto-update and don't care about ICD codes. As much as I want to use DRGs I can't because people only get one, and I think I'm looking for people that have -any- of these. So I am going to use AHRQ Definitions first because my research is about ACSCs which are defined by PQIs which are their thing, and AHRQ's thing is doing these kinds of ontoligies. though before I get into this too far.... the paper references ahrf

            Pneumonia
            Influenza
            Postoperative infection
            UTI
            Gangrene
            Foot Infection
            Sepsis

            Streptococcal Infection
            meningococcal Infection
            dermatophytosis
            herpes zoster
            candidiasis
            viral hepatitis

             Viral hepatitis
             tuberculosis
             human immunodeficiency virus infection
             and sexually transmitted diseases
                chlamydia
                syphilis
                gonorrhea
                human papillomavirus
                genital herpes



    ahrf https://data.hrsa.gov/topics/health-workforce/ahrf oh... uh.... the website only goes back 3 years. reaching out to NCHWA to get old data. 

    So this is paused until I get that dataset. 