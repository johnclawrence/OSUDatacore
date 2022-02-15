Paper-05#463    Does primary care diabetes management provided to Medicare patients differ between primary care physicians and nurse practitioners?
                    So this paper uses 2012 SAF data... but based on the 5% sample. And I have the 100% sample, and as it turns out, there is no way to GET the 5% sample from the 100% sample... So do I can I can do this exactly? No. But I can probably do it pretty close. https://onlinelibrary-wiley-com.proxy.lib.ohio-state.edu/doi/10.1111/jan.13108

Lets get to the methods
    We conducted a cross-sectional retrospective study using the 2012 US Medicare National Claims History file for analysis. These data are commonly known as the five per cent Standard Analytic File (SAF).
        So right off the bat, the 5% and the 100% cannot be mapped for 2012, so I'll be doing this analysis with the 100%.
    DM2 according to the broad three-digit ICD-9 code (250).
    
    further restricted to those who was seen in a primary care setting by one of two billing provider types: primary care physician (family practice or internal medicine) or NP
        exclusively saw a primary care physician without any follow-up by an NP and patients who exclusively saw an NP without any follow-up by a primary care physician.
            So I'm guessing by looking at the revenue file? 
    Figure 1 flow chart!!! Now I can see -exactly- when I screw up my mapping and by how much.
            So it looks like we're braking down as only NP or only PCP, and by Encounter (Claim_NO)
    So from here, they calculated MPI... medical productivity index 
        MPI is looking at Diagnosis and Procedures for a given encounter. 
        This is referenced in ParenTe 2011,2013 quite a bit and I'm going to need to look at their work to reproduce MPI. 

        So I have the inputs so I assume I will be able to get the outputs. Okay... So I have my MPI/Provider/DM2 groups... 
        And then we further restricted to the 10 most common ICD-9 codes... and we looked at cost information....

        Okay, and the rest just looks like math. 

So as of this review, I think that I could reproduce this, yeah. 

2/7/2022, today's goal is to build the cohort and build the initial dataset!, So, lets look at the paper and see what that looks like. 

So the big issue is that they use the 5% and I use the 100%, that's not the end of the world; however, I suspect my numbers should be 20, is, times there from a cohort perspective...
So lets start at the beginning, 
100% 2012 Medicare... but more than that, which sub files are they using... they say the initial file is 53,424,266, so we're talking about beneficiaries. 
Instantly I realize... I don't have the 2012 denominator file loaded. So I need to fix that problem first. 

