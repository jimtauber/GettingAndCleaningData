
#CodeBook for the Getting and Cleaning project: tidy dataset
##Data source
The data used for this project originated as part of experiments at the Smartlab – Non Linear Complex Systems Laboratory. Full information can be found at  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .
Dataset used by this script was provided by the John Hopkins University Data Science program and hosted at - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . Assumption is made that the data is a true copy and has not been altered from the original source.  The data will be downloaded and unzipped into a subdirectory of the current working directory of the R/RStudio environment. For the sake of clarity and ease of use, the directory will be renamed (data) from (UCI HAR Dataset) as provided in the zip file.
##Tool Selection
The program is written using the (plyr),(dplyr) and (data.table) packages. Each offered functions that improved data handling or increased speed of access. In addition the (dplyr) made the code clearer for future programmers to read. 
##Data load process
The process of loading the data files is broken into two sections in the code. This was done for two reasons. First the dataset itself was extracted into two sets that carried intelligence and also the process of troubleshooting any data corruption would be easier in the temp tables created during the load process. 
The flat files are read in in and converted to tbl_df data frames for compatibility with the selected tools. 
##Feature Selection
Included in the zip file are  README and features.txt files to clarify the descriptions of the data. The features.txt file lists the type of observations made and contains some intelligence in the naming. As these align with the columns of the x_test and x_train, it will be used to name the columns.  However some changes needed to be made to the text to make them readable and meet compatibility with the R environment. 
The data was clustered into three observations recording the X, Y and Z axis readings. Also included in the naming convention were traits of time (t), frequency (f), and method of recoding ( Accelerometer or Gyroscope). I substituted the long names for each of these shortened identifiers using the gsub() function. Example - tBodyAcc-mean()-X became time.BodyAccelerometer-mean.x-axis.
The requirements for the exercise were to extract only the columns that contained either mean calculations or standard deviations. This was done in two passes over the data using the grep() function for the terms std and mean. The later ignored case as it appeared in both formats in the data. 
##Activity
The next step was to replace the supplied codes for the activities for each observation with English long names. This was provided in the table( activity_labels.txt). 
At this point the program has created a master data frame that contains all of the required data and properly labeled.
##Tidy Data
The final step is to create a tidy data set and report on the requested calculation. This was achieved by using the group_by() function and selecting first (subject) the identifier for the person executing the task and then (activity). Finally, the summarize_each() function formatted the data in a tidy wide format. 
