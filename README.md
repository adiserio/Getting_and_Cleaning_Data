# Getting and Cleaning Data Course Project
#### Angela Di Serio

This repository includes the following files:
 1.  run_analysis.R
 2.  CodeBook.md

####**run_analysis.R**
It is an R script that cleans data collected from the accelerometers from the Samsung Galaxy S 
smartphone and prepares a tidy data that can be used for later analysis.
The input data used by the run_analysis script could be downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

run_analysis.R performs the followwing steps:
 1. Combines train and test sets to create one merged data set (DataTotal)
    * Reads train data set: X_train.txt 
    * Reads the list of all features: features.txt that corresponds to the column names of X_train.txt (X_test.txt)
    * All punctuation marks are removed from the column names 
	* Set the names for the Merged Data Set
	* Reads subject_train.txt that contains the identification of the subject who performed the activity for each windows sample.
	* Reads activity labels (y_train.txt) that identifiy the activity perfomed by the subject
    * A new variables (TrainVsTest) is included to identify these set as Training Data
    * Combines subject, activity and train set (column bind)
    
	* Reads test set: X_test.txt 
	* Reads subject_test.txt that contains the identification of the subject who performed the activity for each windows sample.
    * Reads activity labels (y_test.txt) which identifiy the activity perfomed by the subject
    * Combines subject, activity and test data set (column bind)
	* Set the variable TrainVsTest to test
    * Merges train and test data sets using  a row binding  
2. Extracts only the measurement on the mean and standard deviation for each measures. Measures with meanFreq were not included
