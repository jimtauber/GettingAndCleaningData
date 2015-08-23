# Coursera - Getting and Cleaning Data, John Hoppkins University
# Project
# Author: Jim Tauber
# Date: 22 AUG 2015
## Merge data sets provided into a master file, clean the data and produce
## a reduced tidy dataset as outlined.
library(plyr)
library(data.table)
library(dplyr)

## Download and extract files
##fileUrl <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
##download.file(fileUrl, dest=("./dataset.zip"), mode="wb")
##unzip("./dataset.zip")
##file.rename(from="./UCI HAR Dataset", to="./data")

#Load data from flat files to tables
featuresf <- read.table("./data/features.txt")
subject_testf <- read.table("./data/test/subject_test.txt")
x_testf <- read.table("./data/test/X_test.txt")
y_testf <- read.table("./data/test/y_test.txt")
#convert tables to dplyr tbl_df data frames
features <- tbl_df(featuresf)
subject_test <- tbl_df(subject_testf)
x_test <- tbl_df(x_testf)
y_test <- tbl_df(y_testf)
# claen up 
rm(x_testf)
rm(y_testf)
rm(subject_testf)
rm(featuresf)
# create header info for x_test using features table and converting to English
x_temp <- as.data.frame(gsub("\\(|\\)","", features$V2))
x_temp <- as.data.frame(gsub("^t","time.",x_temp[,1]))
x_temp <- as.data.frame(gsub("-X",".x-axis",x_temp[,1]))
x_temp <- as.data.frame(gsub("-Y", ".y-axis", x_temp[,1]))
x_temp <- as.data.frame(gsub("-Z", ".z-axis", x_temp[,1]))
x_temp <- as.data.frame(gsub("Acc", "Accelerometer", x_temp[,1]))
x_temp <- as.data.frame(gsub("^f", "freq.", x_temp[,1]))
x_temp <- as.data.frame(gsub("Gyro","gyroscope", x_temp[,1]))
x_clean <- tbl_df(x_temp)

rm(x_temp)
names(x_clean) <- c("V1")
#attach column names
colnames(x_test) <- t(x_clean$V1)

#Checkpoint - KNOWN GOOD

#extract the columns that contain MEAN and STD
## ignore.case allows for mean and Mean, both of whaich are used in names
mean_t <- grep("mean", names(x_test), value = FALSE, ignore.case = TRUE)
meanDF1 <- x_test[mean_t]
sd_t <- grep("std", names(x_test), value = FALSE, ignore.case = FALSE)
sdDF1 <- x_test[sd_t]
rm(mean_t)
rm(sd_t)


# create new columns using y_test and subject_test
colnames(y_test) <- c("activity")
colnames(subject_test) <- c("subject")
master_test <- cbind(subject_test[,1],y_test[,1],meanDF1,sdDF1)

## load the training data 
subject_trainf <- read.table("./data/train/subject_train.txt")
x_trainf <- read.table("./data/train/X_train.txt")
y_trainf <- read.table("./data/train/y_train.txt")
#convert tables to dplyr tbl_df data frames
subject_train <- tbl_df(subject_trainf)
x_train <- tbl_df(x_trainf)
y_train <- tbl_df(y_trainf)
# claen up 
rm(x_trainf)
rm(y_trainf)
rm(subject_trainf)
# attach column names, reuse x_clean
colnames(x_train) <- t(x_clean$V1)

#KNOWN GOOD

#extract the columns that contain MEAN and STD
## ignore.case allows for mean and Mean, both of whaich are used in names
mean_t <- grep("mean", names(x_train), value = FALSE, ignore.case = TRUE)
meanDF2 <- x_train[mean_t]
sd_t <- grep("std", names(x_train), value = FALSE, ignore.case = FALSE)
sdDF2 <- x_train[sd_t]
rm(mean_t)
rm(sd_t)

# create new columns using y_train and subject_train
colnames(y_train) <- c("activity")
colnames(subject_train) <- c("subject")
master_train <- cbind(subject_train[,1],y_train[,1],meanDF2,sdDF2)


## create a single data set from extracted columns of train and test
masterDF <- rbind(master_train,master_test)

## Clean-up
rm(features)
rm(master_test)
rm(master_train)
rm(meanDF1)
rm(meanDF2)
rm(sdDF1)
rm(sdDF2)
rm(subject_test)
rm(subject_train)
rm(x_test)
rm(x_train)
rm(y_train)
rm(y_test)


## replace activity index with english names from activity_labels.txt

masterDF$activity <- as.character(masterDF$activity)
masterDF$activity[masterDF$activity == 1] <- "Walking"
masterDF$activity[masterDF$activity == 2] <- "Walking Upstairs"
masterDF$activity[masterDF$activity == 3] <- "Walking Downstairs"
masterDF$activity[masterDF$activity == 4] <- "Sitting"
masterDF$activity[masterDF$activity == 5] <- "Standing"
masterDF$activity[masterDF$activity == 6] <- "Laying"
masterDF$activity <- as.factor(masterDF$activity)
masterDF$subject <- as.factor(masterDF$subject)

### grouping
groupDF <- group_by(masterDF, subject, activity)


report <-groupDF %>% 
                group_by(subject, activity) %>% 
                summarise_each(funs(mean))
write.table(report,"./report.txt", row.names= FALSE)
