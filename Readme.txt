    
	
	
	
	* tag1.0.1
   /
  *tag1.0.0
 /
**===========**=========**=========*==========*====>
br1.0       br1.1      br1.2	 tag0.0    tag0.1 



//===============================================
Branch:
+ Version 1.0  	This version was created by old algorithm (old camera) by using Lab color space and detecting 
		convex, concavex position.  
Tag 1.0.0 	Success for old datas, it is initial version
Tag 1.0.1	Fix error from tag1.0.0, it's adequate version for old data.		

+ Version 1.1  	This version used a new camera, using old algorithm, however it's not effective 

+ Version 1.2  	This version using Hormonophic filter to eliminate the light noises, it's good but the time is
		 unpossible
  
+ Master:
Tag 0.0: Fix lighting as version 1.2, however using subtraction method for background. It also using roundness,
	 convexhull and histogram of RGB space to evaluate.
	 
Tag 0.1: Repair segmentation algorithm and add GLCM algorithm for Tag0.0
 	 










