Paper 09, Development and Testing of Improved Models to Predict Payment Using Centers for Medicare & Medicaid Services Claims Data
https://jamanetwork.com/journals/jamanetworkopen/fullarticle/2747752

Methods
    Data Source and study sample (Sample is a scarey word)
    condition-specific payment cohorts (AMI, HF, and pneumonia) were constructed using Medicare fee-for-service administrative claims from July 1, 2013, through September 30, 2015, as specified by the publicly reported CMS payment measures
        This I can probably do, this looks like publically referenced disease states...

    Patients younger than 65 years were excluded, but no exclusions were made based on geographic location.
        Good, because I likely don't have the grographic locaiton, though this does imply they have the RIf and not the SAF

    Patients who died within the 30-day period were included, and their payment data are not prorated.
        I'm not sure what this means yet.

    The standardized payment was winsorized at 99.5% to reduce the effect of outliers on model prediction.
        Okay, I can winsorize. That's fine...

    To derive model covariates, candidate risk variables were identified from the index claims and claims within the 12 months, including all inpatient and outpatient claims, before the index admission. Patients without a full 12 months of previous fee-for-service enrollment were excluded.
        So they're looking as far back as 2012 then. That's fine, I have 2012.

    So this all seems quite straightforward
        A cohort based on age and condition, aggregated by the individual, and looking at conditions...
        They use HCCs, I'm not sure what those are yet but I'm sure I can map from DX to HCC, 


        And then they get into a bunch of statistical stuff that I don't understand, but they tell me they did it in R and matlab and I should be able to reproduce that!


        So all and all t his looks quite do-able.