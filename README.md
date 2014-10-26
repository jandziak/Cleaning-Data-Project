Cleaning-Data-Project
=====================



The used for assignment represent data collected from the accelerometersfrom the Samsung Galaxy S smartphone. 
Description of the data availiable is in File README.md and at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# Data preparation and tidy data set 
##Data set cleaning
On the beggining data has been loaded. Until that moment data had been treated sepparately for test and training data. Next step was to create one common set. After that, there was labels added instead of activity numbers and data labels with descriptive variable names attached to collumns. At that point there was extracted data regarding means and standard deviations to be subject for tidy data set.   
##Tidy set obtain
Function evalFun is basic tool for evaluation basic statistics like mean, standard deviation and so on. It could be used in further analysis. 
Using function evalFun there has been tidy data set created and finally saved using function write.table()

