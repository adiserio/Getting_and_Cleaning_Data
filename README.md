# Getting and Cleaning Data Course Project
Human Activity Recognition Using Smartphones Dataset
#### Angela Di Serio

This repository includes the following files:
 1.  run_analysis.R
 2.  CodeBook.md

 
 
####**run_analysis.R**
It is an R script that cleans data collected from the accelerometers from the Samsung Galaxy S 
smartphone and prepares a tidy data that can be used for later analysis.
The input data used by the run_analysis script could be downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
and the script must be located inside de "UCI HAR Dataset" directory

run_analysis.R performs the followwing steps:
 1. Combines train and test sets to create a merged data set (DataTotal)
   1. train data
     * Reads train data set: X_train.txt 
     * Reads the list of all features: features.txt that corresponds to the column names of X_train.txt (X_test.txt)
     * Since the list of features contains some punctuation marks, these are removed from the column names to produce valid names 
     * Assign the names to object that will contain the merged data 
	 * Reads subject_train.txt which contains the identification of the subject who performed the activity for each windows sample.
	 * Reads activity labels (y_train.txt) which identifiy the activities perfomed by the subject
     * A new variable, TrainVsTest,  is added to identify whether the data corresponds to  a Train or a Test. In this cas a value of "Train" is assigned
     * Combines subject, activity and train data (column bind)
   2. test data 
	 * Reads test data set: X_test.txt 
	 * Reads subject_test.txt which contains the identification of the subject who performed the activity for each windows sample.
     * Reads activity labels (y_test.txt) which identifiy the activity perfomed by the subject
     * Combines subject, activity and test data set (column bind)
	 * Set the variable TrainVsTest to "Test"
     * Merges train and test data sets using  a row binding  
 2. Extracts only the measurement on the mean and standard deviation for each measures. Measures with meanFreq were not included
 3. Asigns descriptive activity names to name the activities in the data set
 4. Creates a tidy data set (TidyData.txt) in the working directory. This file contains the average of each variable grouped by activity and subject.
 
####**CodeBook.md**