The Goal of this Dictionary and Sample is to provide a sample of what the Carescape dataset looks like.

Terms:
CSN = contact serial number, it's the unique identifier for a patient visit.
ADT = Admission Discharge Transport (It's a patient arriving, leaving, or moving around. )
MAR = Medication Administration Record

Contained are samples from the following files...

From the Telemetry Machines...
Measurement
    Every Row in this table is a measurement from a bedside instrument (like a pulseOx) every 2 seconds. 
Alarm
    Every Row in this table is an instance of an Alarm on a bed (like a code blue)
Waveform
    Every Row in this table are the readings from an EKG lead aggregated every 2 seconds at 360 HZ (So 720 readings per row)

From the EMR
Allergy
    Every Row of this table is an allergy and a rection
Base Pop
    Every Row of this table is a hospital admission / Discharge.
Demographics
    Every Row of this table are demographics
Flowsheets
    Every Row of this table are the results of a flowsheet row.
ICU
    Every Row of this table is an ICU ADT
LAB_Orders
    Every Row of this table is a lab order and its result
Location
    Every Row are the ADTs
Medication
    Every Row is a medication Order
Orders
    Every row is a procedure order (Nor Medicine or Lab)
Social_Hx
    Every Row is Tobacco / Alcohol use for a patient

As a more in depth data dictionary
Common Variable
hashMRN This is the Hashed MRN, This is the consistent patient identifier between tables.
PAT_ENC_CSN_ID This is the Contact Serial Number that is the unique identifier for an ambulatory encounter or hospital encounter.
INPATIENT_DATA_ID This is the unique identifier for the inpatient hospital visit
All dates in this dataset have been modified by up to 14 days and date modifications are consistent for a given patient.

Measurement Name
hashedMRN
pollTime            When the measurement is gathered
mesname             The name of the device recording the measurement
msite               the site of that measurement 
muom                the unit of measure for that measurement
mtext               the value of that measurement

Alarm   The name of the file contains the hashedMSN, the Location, and the Date
hashedMRN           
pollTime            When the alarm is being sent
abnormalFlags       What is the type of the alarm (ECG-Rythem-Artifact, numLimit-mean-High Central Venous, etc)
inactivation-state  A, PN, SP, ST, I don't know what these mean.
sil                 I don't know what this means
setlow              Lower Bound of range
sethi               Upper Bound of range
chan-value          value that's causing the alarm

Waveform
hashedMRN           
pollTime            When the waveform is being recorded
mgname              the name of the waveform (ECG-I#1)
mgGain              The set gain (normally 1.000)
MgHz                I'm not sure what this is? it's not normally called out. 
mgWave              A ^ delimited list of readings.
mguom               The unit of measure (typically uV)
mgsite              The site of the reading (Typically none)
mgscale             The scale of the reading (2.44? I'm not sure what this is)
mginvalid           Invalid readings, a ^ delimited list, I'm not totally sure what these are / how they would be used. 
mgmissing           Missing readings, a ^ delimited list, I'm not totally sure what these are / how they would be used. 
mgPoints            Number of Data points (480, because it's 240 hz, not 360 hz)
mgPointsByters      I don't know what this is
mgMin               Min if there is a cap
mgMax               Max if there is a cap
mgOffset            instrument offset

Table:  Allergy
    hashMRN
    PAT_ENC_CSN_ID
    Allergy                 This is a particular drug or class of chemicals (Sulfa Antibiotics, Amoxicilin, KDC)
    Allergy_Reaction        This is a string description
Table: Base_Pop
    PAT_ENC_CSN_ID
    INPATIENT_DATA_ID
    hashMRN
    Admission_Type          Inpatient vs Emergency
    Admit_Source            How they got there (referral, outside hospital, etc)
    LOS_Hours               How long this visit lasted in hours
    REASON_VISIT_NAME       String for why they came (Chest Pain, Vomiting, etc)
    HOSP_ADMSN_TIME         Admission Datetime
    HOSP_DISCH_TIME         Discharge Datetime
    Discharge_Destination   Where they went after discharged (Home, Some other Hospital)
    Primary_ICD10           ICD Code for primary diagnosis
    Primary_Diagnosis       Plain English Diagnosis
    Secondary_ICD10         ICD Code for secondary diagnosis
    Secondary_Diagnosis     Plain English Diagnosis
Table: Demographics
    hashMRN
    PAT_ENC_CSN_ID
    Gender                  Medical Sex (M/F)
    Age_June1               Age as of June1 before Encounter
    Marital_Status          Marital status as of the encounter (Married, Single, Widowed)
    Patient_Race            Patient Race (White, Black, Asian, Other, This field is multi-select)
    Ethnicity               Hispanic/Latino or Not
    Preferred_Language      English, Spanish, etc.
    ABO_RH_Blood_Type       This field is free text, so, for example, this could be OPOS, O POS, O POSITIVE, OPOSITIVE you get the the idea.
Table: Flowsheets
    PAT_ENC_CSN_ID
    hashMRN
    FLO_MEAS_ID             The EMR Key for a flowsheet measure (The type of flowsheet row) 1000292037295
    flo_meas_name           The Name of that flowsheet measure (programatic name) R OSU IP RT VENT STATUS
    disp_name               The Display name of that flowsheet measure (display name) Ventilator Status
    MEAS_VALUE              This is the value of in that row
    MEAS_COMMENT            This is the comment left in that row
    RECORDED_TIME           This is when that row was recorded
    fsd_id                  This is the unique ID of that flowsheet row (A row can have multiple measures)
    Flow_Type               This is the type of that row.
Table: ICU
    hashMRN
    PAT_ENC_CSN_ID
    event_id                I do not know what this is.
    IN_Event_Type           I do not know what this is.
    DEPARTMENT_ID           Department ID of the ICU
    DEPARTMENT_NAME         Department Name of the ICU 
    Start_Time              Start Date Time in ICU
    End_Time                End Date Time in ICU
    OUT_Event_Type          Why the patient left (I don't have the category list for this yet)
    LOS                     Length of Stay in Minutes

Table: Lab_Orders
    hashMRN
    Order_type              This is always Lab
    DESCRIPTION             This is the plain Text name of the lab
    PROC_ID                 This is the programmatic procedure ID for the lab
    COMPONENT_NAME          This is the name of the component of that lab (A given lab might have multiple components)
    ORDER_STATUS_C          This is the order status category Value
    order_status            This is the plaintext version of that category value
    ORDERING_DATE           When the lab was ordered
    RESULT_DATE             When the lab was resulted
    ORD_NUM_VALUE           The numeric result of the lab
    ORD_VALUE               The text result of the lab (also a number of the lab returns a number)
    COMPONENT_COMMENT       Comment on the lab (I don't see abnormal, this looks like it's a comment left by the lab tech like "Slightly hemolyzed")
    Ordering_CSN            CSN when the lab was ordered
    Resulting_CSN           CSN when the lab was resulted

Table: Location
    hashMRN
    PAT_ENC_CSN_ID
    event_id                I do not know what this is.
    IN_Event_Type           I do not know what this is.
    DEPARTMENT_ID           Department ID in charge of the location
    DEPARTMENT_NAME         Department Name in charge of the location
    BED_ID                  The unique identifier for a bed
    ROOM_ID                 The unique identifier for a room
    Start_Time              When the patient arrived in that bed
    End_Time                When the patient left that bed
    OUT_Event_Type          Why the patient left (I don't have the category list for this yet)
    LOS                     Length of Stay in Minutes

Table: Medications
    hashMRN
    MEDICATION              Plaintext Name of the medication
    ORDERING_DATE           Date the medication was ordered
    START_DATE              Datetime the medication was administered
    END_DATE                Datetime the medication was stopped
    ORDERING_MODE           Where the administration happened
    HV_DISCRETE_DOSE        The dose of the medication
    HV_DISCRET_DOSE_UNIT    The units of measure of that dose
    FREQUENCY               The frequency of that dose (continuous vs how often)
    MAR_DOSE                The dose listed on the MAR
    MAR_DOSE_UNIT           The unit of that dose on the MAR
    MAR_TAKEN_TIME          The time the action happened on the MAR
    MAR_ACTION              The action taken on the mar (such as a dose or rate change for an IV)
    MAR_ROUTE               Where the medication was delivered
    PAT_ENC_CSN_ID          The CSN where the medication was ordered or where the change was made.

Table: Orders
    hashMRN
    Order_type              What type of order it is (Point of Care, Blood Bank, ECG)
    DESCRIPTION             Plaintext Name of the order
    PROC_ID                 EMR ID for the procedure
    ORDER_STATUS_C          Category List Status for the order
    order_status            Plaintext version of that category list
    ORDERING_DATE           When the order was ordered
    RESULT_DATE             When the order occurred
    ORD_NUM_VALUE           The numerical result of that order
    ORD_VALUE               The plaintext result of that order (such as A POS for a blood type text)
    COMPONENT_COMMENT       The comment on that order
    Ordering_CSN            The CSN where the order was ordered
    Resulting_CSN           The CSN where the order was resulted

Table: Social_Hx
    hashMRN
    TOBACCO_USER_C          I don't have the definition of this category list
    SMOKING_TOB_USE_C       I don't have the definition of this category list
    SMOKING_START_DATE      Date when the patient started smoking
    SMOKING_QUIT_DATE       Date when the patient stopped smoking 
    CIGARETTES_YN           Do they smoke cigarettes, Y/N
    PIPES_YN                Do they smoke pipes Y/N
    CIGARS_YN               Do they smoke Cigars Y/N
    TOBACCO_PAK_PER_DY      How many packs per day
    TOBACCO_USED_YEARS      For how many years
    TOBACCO_COMMENT         Note left by provider
    SMOKELESS_TOB_USE       Do they use smokeless Tobacco
    SNUFF_YN                Do they use nose Tobacco
    CHEW_YN                 Do they use chewing tobacco
    SMOKELESS_QUIT_DATE     When did they quit using smokeless Tobacco
    ALCOHOL_USE_C           I don't have the definition of this category list
    ALCOHOL_SRC_C           I don't have the definition of this category list
    ALCOHOL_FREQ_C          I don't have the definition of this category list
    ALCOHOL_DRINKS_PER_DAY_CI don't have the definition of this category list
    ALCOHOL_BINGE_C         I don't have the definition of this category list
    ALCOHOL_OZ_PER_WK       How many ounces of alcohol per week
    ALCOHOL_COMMENT         Comment left by provider
    DRUG_SRC_C              I don't have the definition of this category list
    IV_DRUG_USER_YN         I don't have the definition of this category list
    ILL_DRUG_USER_C         I don't have the definition of this category list
    ILLICIT_DRUG_FREQ       I don't have the definition of this category list
    ILLICIT_DRUG_CMT        Comment left by provider

