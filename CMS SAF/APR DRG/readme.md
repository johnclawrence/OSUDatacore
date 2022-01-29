This folder is all about how you calculate a APR/DRG code from medical claims data. 

What is a DRG code?
    A DRG code is a diagnosis related grouper. It baiscally represents a group of simliar diagnosis. For example, Heart Failure, Heart failure a bunch of ICD-10 codes but can be represented by 1 or a few DRG codes.

Why do I care about DRG codes?
    DRG codes are a quick way to identify groups of patients. This matters mostly because insurance companies have a general amount of money that they expect to pay for a particulear DRG code. This is kind of like CCI or elixhauser, but based on more than just diagnoses. 

How many types of DRG codes are there?
As it turns out, a bunch. But, as a broad simplification, in the united states, 2 are used.
1 are MS-DGR codes, these are the DRG codes that CMS uses to talk about their patients, and it broadly breaks down into 3 different codes:
    1 for the DRG without complications
    1 for the DRG with minor complications
    1 for the DRG with major complications
    There are broadly outlined as part of IPPS and if you care to learn more about it here is a link https://www.cms.gov/Medicare/Medicare-Fee-for-Service-Payment/AcuteInpatientPPS/MS-DRG-Classifications-and-Software

2 are APR-DRG codes, these codes are what everyone else uses. This is a code set built by 3M, everyone uses it, the documentation on this is sparse and arcane, and the algorithem is updated every year. As far as I can tell, every hospital just has a license with 3M and a magic box / calculator that they input a bunch of variables into and it spits out the APR-DRG.

The APR-DRG has 3 components
    1 a DRG code (the APR-DRG code, or, generally this is what everyone that isn't CMS calls a DRG code)
    2 a SOI code (on a scale from 1-4 what is the severity of a particulear illness, 4 is not equally bad, for example having a SOI of 4 for a broken arm is not equivalent to having a SOI of 4 for a stroke)
    3 a ROM code (On a scale from 1-4 what is the risk of mortality, I haven't used this one yet and I'm sure when I do I'll update 
    this documentation)

Figuring out how to calculate a DRG code money without giving 3M money is basically impossible as far as I can tell... However AHRQ has a limited set of DRG codes in a public license from 3M, so we're going to use those. 

https://qualityindicators.ahrq.gov/Software/SAS.aspx is where you get the free stuff. 

We're going to get APR-DRGs for our dataset (where possible) through the following process

Step 1: Modify the CMS dataset in SQL to match what we need the input to be
Step 2: Export the dataset to flat files
Step 3: Run the test.exe script in the zip file
Step 4: parse the results of that test script in python
Step 5: upload the parsed results into SQL

I am going to provide code for step 1 and 4 in their own folders
Step 2 and 5 are straightforward. 
Step 3 is arcane computer magic. 

Here is how you do step 3. 

Step 1, you open the command line
Step 2, you navigate (CD) to the folder that has the data you want to get DRGs for (as well as the other files from the zip)
Step 3, you execute the following code
testapr.exe aprlim.dll ..\gapr_v380.ctl ..\umap.ctl ..\testdata2.txt 0 > somepath/filename.txt | ThatSamesomepath/filename.txt

What you're doing before the > is executing the commandline operation
What you're doing after the > is saving the output to the commandline to a text file.
I'm sure there is a better way to do this, but hey, it took me hours just to get this far. 

But yeah, basically you're going to run that code for every file you need DRG for (mostly inpatient)
There are some supporting files that I used when figuring this out, namely APRDRG Format Example.xlsx in the repo.  I think I can probably share the zip file as well so I will.  (Its the APRDRG_LIMITED_GROUPER_2021.zip file)