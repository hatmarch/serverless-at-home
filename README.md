# Adventures in “Domestic Serverless”
serverless-at-home

Serverless programming is popping up everywhere and its popularity is only increasing.  Some have posited that it is the age of “Serverless 2.0”.  But does one have to have to go to a public cloud provider to be able to build a serverless solution?  Is there room for choice and transparency in serverless platforms?  Perhaps most importantly: Can the promise of serverless be harnessed without a credit card?

I had a humble problem that translated well into serverless: having recently installed solar panels, I wanted to drive the color of an LED light based on the amount of excess solar capacity was being generated and see how much I could automate the running of certain devices based on that capacity.  Given that all the data (and “things” required for this) were only available within my own local home network, using public cloud implementations of serverless did not seem feasible.  I decided to see answers existed in the Open Source community.

In this talk, I report on my attempt to build a fully domestic and fully serverless implementation of this solar capacity LED light indicator (powered by disused laptops or whatever compute resources I could find in my home).  My domestic serverless adventure leads me through the use of three different Open Source implementations of serverless computing (and just a little bit of IoT); with absolutely no help from any of those public cloud providers.  

Hands-on observations of the strengths and weaknesses of each implementation abound.  These observations in turn drive insights about the suitability of these projects to larger (or even commercial) workloads and what it might mean for the future of serverless computing.
