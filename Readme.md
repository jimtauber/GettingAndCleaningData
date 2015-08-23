# Getting and Cleaning Data: Course Project
## Introduction
This repository contains the course project for the John Hopkins University course "Getting and Cleaning data", part of the Data Science specialization hosted by Coursera. The high level objective is to obtain data from an on-line repository, examine the provided information, combine and clean the necessary files and produce a tidy data report using R, RStudio and a variety of packages. The following are the notes on the process.
## About the raw data
For the original explanation of the data please refer to the README.txt file in ./data once this script has been run. 
This project is concerned with the Training and Test data sets provided. This subset of the dataset contains 
X_train / X_test : observation data 
Y_train / y_test: participant information for each observation
Features: categories of data collected and recorded in the X file  
Activities: provides a code to English table of the activities observed 

##About the script and the tidy dataset
The script called run_analysis.R which will gather the data files, clean and merge the test and training sets together. Prerequisites for this script:
1. The R packages (dplyr), (data.table), (tidyr) and (plyr).

During the processing of the files the data is cleaned, labeled and merged. The resulting data frame is reduced to contain only columns that have to do with mean and standard deviation, information on the activity and label identifying the participant.

The script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.

##About the Code Book
The CodeBook.md file explains the transformations performed and the resulting data and variables.

##additional
While the code in this project is my own creation, credit should be given to David Hood for psudo-code provided at the Coursera support site.
The Github repository includes a PDF(tidyReportSnip) that shows a formatted output of the first five columns and first 24 rows, for ease of review. The full report contains 180 observations and 88 variables. If you prefer, you can import the processed data  using read.table().


