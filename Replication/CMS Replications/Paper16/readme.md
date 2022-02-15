 Association of Ambulatory Hemodynamic Monitoring of Heart Failure With Clinical Outcomes in a Concurrent Matched Cohort Analysis.
 https://jamanetwork.com/journals/jamacardiology/fullarticle/2732637

 The methods!
 This matched cohort study using Centers for Medicare and Medicaid Services (CMS) administrative claims data from the Standard Analytic File was designed to evaluate clinical outcomes in beneficiaries of fee-for-service Medicare programs\
    Yep this I can do. This is SAF so, so far so good. 
  who received a PAP sensor implant after US Food and Drug Administration approval of the device for commercial use (from June 1, 2014, onward) compared with matched control patients who did not receive a sensor. 
    Uh huh... Well I'm sure they describe what this means? 
  Claims data include Part A inpatient claims, Part B outpatient claims, and the associated denominator files.
    This implies SAF, and I have A and B.
  Inpatient and outpatient files contain institutional claims with International Classification of Diseases, Ninth Revision, Clinical Modification and Tenth Revision, Clinical Modification diagnosis codes, procedure codes, and reimbursement associated with inpatient stays or ambulatory visits. 
    Yes, infact, they do. 
  The denominator files include unique deidentified patient identification numbers, age, sex, geographic location, race/ethnicity, date of death, and information about program eligibility and Medicare insurance enrollment.
    Yes, infact, it does. 

We identified patients implanted with a PAP sensor using inpatient claims associated with the procedure codes 38.26, 02HQ30Z, or 02HR30Z and outpatient claims associated with Current Procedural Terminology codes C9741 and C2624 (eTable 1 in the Supplement). 
    Well great, that's easy, I can do that. 
Because Medicare data were available through March 31, 2017, only patients who received implants on or prior to March 31, 2016, were included, to ensure a minimum of 12 months of potential follow-up time. 
    That's great. That makes the time range very clear. 2017 is the end of the dataset.
The cohort was limited to patients with continuous, fee-for-service Medicare insurance enrollment (Medicare parts A and B) for at least 12 months before and after sensor implant. 
    And 2013 is the beginning. 
Health maintenance organization paid claims are excluded from the CMS data set; accordingly, health maintenance organization–insured patients were excluded to avoid incomplete data.
    Well, uh, I can figure this out. there are some variables that define HMO in the Denomin/MBSF

Using the full Medicare data set, a matched control was identified for each patient that received the CardioMEMS hemodynamic sensor (Abbott). 
    huh... matched control, eh? I wonder how they did that in a way that I'm going to be able to reproduce.

Potential control patients were first identified based on the presence of at least 1 HF hospitalization between July 1, 2013, and March 31, 2016, yielding a population of 1.5 million patients with HF. 
    Well, Yep, I can reproduce the contro' population atleast.

The date of implant for each patient undergoing PAP sensor implant was used as an anchor point to identify the matched control patients. For example, if the patient in the treatment cohort was implanted with a sensor on January 1, 2016, this date served as a temporal reference point to find a matched control patient with an identical clinical profile in the 12 months prior to that date. All patient characteristics used for matching were retrieved in the 12 months preceding the anchor date.
    With an identical clinical profile... I sure do hope they define what that means.

A stepwise, iterative algorithm was then used to identify the closest match between a patient who received an implant and a patient who did not receive an implant. 
    Words.
In each iterative run of the algorithm, matched pairs were withdrawn from further consideration. 
    Okay, so taking passes to identify progressivavly worse matches,
After 3 steps of the iterative algorithm, matched controls were identified for 1087 of the 1185 patients who received implants. 

An identical match was defined in each iterative run based on sequential matching of demographic attributes (sex, race, history of implantable cardioverter defibrillator or cardiac resynchronization therapy implant, end-stage renal disease status, and age within 5 years), 
    This is easy
then comorbidities (diabetes, hypertension, renal disorders, pulmonary disorders, and arrhythmia), 
    I assume there is a standard definition here. They dont' call it out but i'll use CCI or Elix
followed by the closest propensity score (derived using logistic regression). 
    I've been avoiding this part. 
Additionally, patients were matched if they incurred an identical number of HF and non-HF hospitalizations and if the timing of each HF hospitalization was within 4 months. 
    Okay... So this is a fourth criteria. interesting... Well this will be uh, interesting. 


Comorbidities for each patient were determined from outpatient and inpatient encounters in the 12 months prior to the anchoring point. 
    Okay, that's easy to do, just looking back and definining all diagnosis in the window. 
Detailed diagnoses codes for the comorbidities of diabetes, hypertension, renal disorders, pulmonary disorders, and arrhythmia10,11 are provided in eTable 2 in the Supplement. 
    Great, that's just what I needed. 
A hospitalization was deemed to be HF-associated based on the presence of diagnoses codes attributed to HF as defined by CMS methods (eTable 3 in the Supplement).12 
    Also great. THis paper is involved but well defined atleast. 
In the treatment cohort, we identified preimplant HF events as those for which a diagnosis code of HF was recorded anywhere in the hospitalization claim; after sensor implant, we used only HF events that were the primary reason for admission.
    Okay...
In the control cohort, we counted all HF events in which an HF diagnosis code was the primary reason for hospitalization to ensure that this cohort included only patients who met the approved indication (namely, an HF hospitalization in the preceding 12 months). For both treatment and control cohorts, all other hospitalizations that did not have a HF diagnosis were classified as non-HF events.
    So I don't see a reason why I can't do this. So I've got that going for me. 