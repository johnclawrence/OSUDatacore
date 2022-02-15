Where to begin here...
So The definition of this work is....
I will identify up to 30 candidate peer-reviewed research articles as test use cases to ensure the robustness of TARSS. A preliminary search identified 5331 peer-reviewed research articles published from 2015 through 2020. I will focus the scope of candidates by:

1   Execute a search strategy developed with the assistance of the Research and Education Department at the Health Services Library at The Ohio State University (OSU). 
2   Exclude articles published as commentaries, editorials, systematic or narrative reviews.
3   Limiting research to data OSU is authorized to use. The current data use agreement with CMS includes ambulatory sensitive conditions of care in an inpatient setting since 2015. 
4   Limiting candidates to those that use only CMS-PPS Inpatient Prospective Payment System (IPPS) and no other datasets, and only topics of ambulatory sensitive conditions of care.

So when I wrote this there were some mistakes, the range I was looking at was too wide (from a date perspective) and too narrow (from a topic / data perspective)

First, my dataset is 2015-2020. If I was actually doing this (and I do not believe that I am anymore) the earliest an article that uses these data would be published is 2017. The medicare dataset becomes availiable in November of the following year. For example, the 2020 dataset becomes availiable in November of 2021. Then you have to get the data, process the data into a dataset, run analysis, write a paper, go through the review process, basically what I'm saying is there is actually no way you're doing that in the span of a month, especially in december. So the earliest an article using the 2015 CMS dataset could possibably be published is 2017 (And I think it's likely, when I look to the data, that literally none will be published in that year)

First what was the search strategy developed
    The spirit of the search strategy is to look at every article that I could under my DUA.
        Under my DUA I was looking at ACSC in an inpatient setting. 
        And under my intrepretation at the time I couldn't merge the dataset with anything for any reason.
    Then, some pratical limitations were added
        1, ICD10 only, so only looking at studies that uses data after 2015 (because icd10 was implmented starting on October 1 2015
        2, English only (Because, well, I only speak english)
        3, Jounral Articles Only (Because, again, I'm only reviewing the litrerature, not all scientific knowledge.)
        4, no more than 30 (Law of large numbers, and this looked like it might become endless)
    
    So under these rules I worked with the library to come up with some criteria (after a little bit of reviewing)
    At a high level, the papers are always going to reference either medicare or CMS
    And they are going to always mention that they dataset is called Claims Data, Administrative Claims, or refer to the datasets as an SAF or MBSF
    So the final search (third iteration) ended up being: (("Medicare"[All Fields] OR "CMS"[All Fields]) AND ("claims data"[All Fields] OR "Administrative claims"[All Fields] OR "SAF"[All Fields] OR "MBSF"[All Fields])) AND (2017:2020[pdat])

    So this search is 1372 articles. Which, honestly, is a just fine set of articles to start with. That's not an overwhelmingly large number.
    The articles I searched for this are in the pubmed-medicareor-set.txt file in this folder. 

    I am looking for papers about ACSC, so I am going to start by searching for ACSC ACSC are defined by PQI, PQI are defined by AHRQ https://qualityindicators.ahrq.gov/modules/pqi_resources.aspx#techspecs 
    Broadly we're talking about
    Diabetes PQI 1, 3, 14, 16
    COPD PQI 5
    Hypertension PQI 7
    Heart Failure PQI 8
    Pneumonia PQI 11
    UTIs PQI 12
    Young Asthma PQI 14 (So not this.)

    So the first step is to search for papers about... Diabetes, COPD, Hypertension, Heart Failure, Pneumonia, and UTIs. 
        Also, I search by author because it's easier to find duplicates that way.
    Search 1, Diabetes, 131
    -   Maybe #960 - Association of Ambulatory Hemodynamic Monitoring of Heart Failure With Clinical Outcomes in a Concurrent Matched Cohort Analysis.
            This paper uses CMS as a control, It's not a -good- candidate, but it's possible. 
            This paper could be excluded because it references local EMR data.
    +   Maybe #666 County-Level Socioeconomic Disparities in Use of Medical Services for Management of Infections by Medicare Beneficiaries With Diabetes-United States, 2012.
            This paper uses 2012's ARF, it's also 2012, and -technically- out of scope, even if it is possible. [This is paper 3 currently]
            This paper could be excluded because it uses pre2015 data.
    +   Maybe #1193 A Cost-Effectiveness Analysis Comparing Single-use and Traditional Negative Pressure Wound Therapy to Treat Chronic Venous and Diabetic Foot Ulcers.
            This paper is using markov chains, and those are converging but not deterministic. 
            This paper could be excluded because it is non-deterministic.
    +   Yes #126 Older adult visits to the emergency department for ambulatory care sensitive conditions. [This is paper 1 currently]
            So obviously this paper uses outpatient claims but that's fine.
    ?   Maybe #463 Does primary care diabetes management provided to Medicare patients differ between primary care physicians and nurse practitioners?
            So this paper uses 2012 SAF data... but based on the 5% sample. And I have the 100% sample, and as it turns out, there is no way to GET the 5% sample from the 100% sample... So do I can I can do this exactly? No. But I can probably do it pretty close. https://onlinelibrary-wiley-com.proxy.lib.ohio-state.edu/doi/10.1111/jan.13108
    Of the 131 diabetes articles
        60 used data from a different data
        47 used data from before 2012
        11 used the RIF
        7 were duplicates
        1 was not claims research
        5 were Yes / Maybes
    Search 2, COPD there are 7 articles that were filtered out in the previous search, and 24 new ones.
        Probably #529 Hospitalizations for ambulatory care sensitive conditions and unplanned readmissions among Medicare beneficiaries with Alzheimer's disease.
            It starts in 2003 but that's solid. it looks like it uses the SAF so it probably does. 
        Probably #1003 Association Between Initiation of Pulmonary Rehabilitation After Hospitalization for COPD and 1-Year Survival Among Medicare Beneficiaries
            Again, this looks like a win; however, it might also be using the RIF
        Of the 24 new articles
        12 pre 2012
        7 other datasets
        1 duplicate
        2 RIF
        2 Maybe/Yes
    Search 3,  Hypertension (The most common PQI, more common than all the other PQI combined because America)
        There are 25 hypertension articles already processed, and 21 left to look at. 
        10 pre 2012
        10 other datasets
        1 RIF
    Search 4,   Heart Failure PQI 8
        there are 28 articles about heart failure already processed and 63 more to look at.
        Probably #1245 Ambulatory Hemodynamic Monitoring Reduces Heart Failure Hospitalizations in “Real-World” Clinical Practice
            starts in 2014, references geographic data but I don't actually see anything from the RIF, so this might actually be doable!
        Probably #377 The cost impact to Medicare of shifting treatment of worsening heart failure from inpatient to outpatient management settings.
            It has the 5% vs 100% sample issue but like, it should still be possible to replicate
        Yes #777 Problematic Risk Adjustment in National Healthcare Safety Network Measures. [This is paper 2]
        Maybe #37 Comparative Effectiveness of New Approaches to Improve Mortality Risk Models From Medicare Claims Data.
            This is probably a hit. It depends on to what extent I can re-implmement thier models but I would be suprised if I can't atleast build their dataset.
        Maybe #83 Development and Testing of Improved Models to Predict Payment Using Centers for Medicare & Medicaid Services Claims Data.
            This is basically the same idea as 37, with the same potential limitations... honestly this might literally be the same paper? But I don't know until I dig further in.
        Yes #91 Hot spotting surgical patients undergoing hepatopancreatic procedures.
            Seeing as how this one was literally done at my institution by a professer I know on a DUA that I'm on, I feel comfy that fufills my criteria. 
        29 pre 2012
        23 other datasets
        0 duplicate
        5 RIF
        6 Maybe/Yes
    Search 5,   Pneumonia PQI 11
        Maybe #146 Association Between Postoperative Pneumonia and 90-Day Episode Payments and Outcomes Among Medicare Beneficiaries Undergoing Cardiac Surgery.
            This looks doable but it might use Medpar and not SAF and I can't tell that until I get into it
        18 filtered already. 15 more to look at. 
        10 Pre 2012
        3 Other Datasets
        1 RIF
        1 Maybe
    Search 6,   UTIs PQI 12
        6 Filtered Already, 2 not yet reviewed.
        2 Pre 2012
    Search 7 ACSC / ambulatory care-sensitive conditions / Prevention Quality Indicators 
        ACSC (2) ambulatory care-sensitive conditions (2 more) Prevention Quality Indicators (5 more)
        Maybe #53 Development and Validation of an Administrative Claims-based Measure for All-cause 30-day Risk-standardized Readmissions After Discharge From Inpatient Psychiatric Facilities.
        Maybe #841 Variation in Facility-Level Rates of All-Cause and Potentially Preventable 30-Day Hospital Readmissions Among Medicare Fee-for-Service Beneficiaries After Discharge From Postacute Inpatient Rehabilitation.
        I think their methods are stocastic so I'm not sure i can do them. 
        5 Other Dataset
        2 Pre 2012
        2 Maybe

    Search 8 Avoidable Hospitalizations (Because that's what this is really all about)
        11 more were found
        Maybe #466 Trends in health service use and potentially avoidable hospitalizations before Alzheimer's disease diagnosis: A matched, retrospective study of US Medicare beneficiaries
            The problem with this one is, again, random sampling. I should get the same result but we shall see, right?
        5 Other Datasets
        5 Pre 2012

    A bit about the categories.
    The categories were pick 1, in that, even if a paper fell into more than 1 group, I only selected 1 group.
    
    The first Check I filtered on was duplicate. If the paper had the same-ish title, and the same authors and a simliar abstract, I said the second paper was a duplicate and moved on. 
    
    The second Check was dataset and data years
        Pre 2012 means that the article references data from before 2012 for its findings (not necessarially CMS data)
        Other datasets means the article references data that is not puiblically availiable that I do not have for its findings. Sometimes this is a different claims dataset, sometimes this is a CMS dataset that I do not have (Like DME) and sometimes this is something unrelated to claims like a survey or an EMR.
    These two groups were selected at the same time, it really was, which of these two criteria did a given paper fail first from me reading the abstract, did it reference other datasets or did it include data that was too old.

    The third check is RIF.
        If the dataset looks like it's the right range (or if range isn't mentioned) And the dataset looks like it's the right one (or isn't mentioned) Does the abract or paper talk about doing something that can only be done with the RIF (Zipcode level analysis, more or less) Not all RIF are going to be CMS data; however, I suspect that almost all of them will be. 

    If the paper is use the CMS-SAF Dataset after 2012, I give it a deeper look to and it will almost always get a maybe at this point. (Even if I don't have the EXACT data it uses such as the 5% vs 100% sample issue)
    