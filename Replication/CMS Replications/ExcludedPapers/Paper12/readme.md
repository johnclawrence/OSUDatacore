 Development and Validation of an Administrative Claims-based Measure for All-cause 30-day Risk-standardized Readmissions After Discharge From Inpatient Psychiatric Facilities.
    https://pubmed.ncbi.nlm.nih.gov/32106165/
    https://ovidsp-dc2-ovid-com.proxy.lib.ohio-state.edu/ovid-a/ovidweb.cgi?&S=PEMEFPFECAEBEPOKIPNJFHPFGAHIAA00&Link+Set=jb.search.31%7c33%7csl_10&Counter5=TOC_article%7c00005650-202003000-00006%7covft%7covftdb%7covftv

    From the methods!
    We used medical encounter claims from Medicare FFS Parts A and B, and the Medicare Denominator file to assemble a national cohort of all admissions to freestanding IPFs or IPF units within acute care hospitals with admission and discharge dates between January 1, 2012, and December 31, 2013 (index admissions).
        Sure, INP / OUT / MBSF from 2012/2013, Okay. And they refer to it as the denominator file, that means they're using the LDS. So all green so far.

     IPFs are identified via provider code. 
        So they have a list of all IPFs that fit their criteria... interesting. I'll need to figure that out then.

     Qualifying admissions (ie, index admissions) were required to have a principal diagnosis indicating psychiatric illness or dementia/ Alzheimer disease based on Clinical Classifications Software (CCS) groupings of International Classification of Disease Version 9—Clinical Modification (ICD9-CM) diagnosis codes (CCS 650 to 670).
        I don't have CCS software, but I'm sure I can figure this out, it can't be worse than APR-DRG... THough I assume it's a simliar sort of monster.

        13 Patients were required to be alive at discharge, aged above 18 years at admission, 
            uhhh, why though... Why is 18 years of age your boundry if you're using the medicare dataset, the population is 65+ or an outlier.

        and have continuous Medicare FFS enrollment 12 months before index admission through 1-month postdischarge. 
            So... This requires the 2011 dataset... Or are you starting (truely) in 2013 and not 2012...


        In addition to patients who qualify for Medicare benefits due to age, index admissions included Medicare enrollees aged below 65 years who may qualify for Medicare if they have a disability, where disability is defined by CMS as receipt of Social Security benefits for ≥24 months or confirmed diagnosis of select terminal and/or severe illnesses


        So, paragraph 1,, I need to figure out IPF units, CCS codes, and how they're determining their start date.

    Index admissions were excluded if 
        discharged against medical advice (Easy),
        had unreliable data (eg, age above 115 y) (uhhh. what other than age though),
        were transferred to another IPF or acute care facility (easy), or
        were readmitted within <3 days (annoying, arbitrary, but easy). 


    So as I explored how they define IPFs... they use data from the IPF-PPS dataset, a CMS dataset that I do not have... so there's that.
    