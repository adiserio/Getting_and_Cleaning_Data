# Author: Angela Di Serio
# Course: Getting and Cleaning Data
# Date:   June 2015
#
# Script to create a Tidy data set for the Training and Test Data
#-------------------------------------------------------------------------------------
# Step 1.
# Merge training and test sets to create one data set

# a) Build Training data
#    A data frame object DataTrain is built using the following files
#      X_train.txt       561-feature vector with time and frequency domain variables
#      features.txt      List of all features to be used as variable names
#      subject_train.txt Identifier of the subject who carried out the experiment 
#
#      TrainVsTest variable is added to identify whether the data belong to the 
#      Train or Test group

# Read 561-feature vector from X_train.txt 
message("Reading Training Data File")
flush.console()
if (!file.exists("./train")) {
	stop("Directory ./train does not exist")
}	
trainData  <- read.table("./train/X_train.txt", header=FALSE)

message("Reading original features names and transforming variable names")
flush.console
varLabels <- read.table("./features.txt")
varLabels <- t(varLabels[,2])

# Labels read from features file are tranformed to valid names in R
# replacing  "-"  for  "_"
#            ",", for  "."
#            "()" for  "_"
varLabels<-gsub("\\-","_",varLabels)
varLabels<-gsub("\\(\\)","_",varLabels)
varLabels<-gsub("[,]",".",varLabels)

# Set the names of the Training Data Frame 
names(trainData)<-varLabels

# Combining subject identification and activity with Training Data Frame
subject<-read.table("./train/subject_train.txt")
activity<-read.table("./train/y_train.txt")
DataTrain<-cbind(subject,activity)
DataTrain$Type <- "Train"
names(DataTrain)<-c("subjectID","activityID","TrainVsTest")

DataTrain<-cbind(DataTrain,trainData)

# b) Build Test data
#    A data frame object DataTest is built using the following files
#      X_test.txt        561-feature vector with time and frequency domain variables
#      features.txt      List of all features to be used as variable names
#      subject_test.txt  Identifier of the subject who carried out the experiment 

# Read 561-feature vector from X_test.txt 
message("Reading Test Data File")
flush.console()
if (!file.exists("./test")) {
	stop("Directory ./test does not exist")
}	

testData  <- read.table("./test/X_test.txt", header=FALSE)
names(testData)<-varLabels
 
# Combining subject identification and activity with Test Data Frame
subject<-read.table("./test/subject_test.txt")
activity<-read.table("./test/y_test.txt")
DataTest <- cbind(subject,activity)
DataTest$Type <-"Test"
names(DataTest)<-c("subjectID","activityID","TrainVsTest")

DataTest<-cbind(DataTest,testData)
DataTotal<-rbind(DataTest,DataTrain)

#-------------------------------------------------------------------------------------
# Step 2. Extract only measurements on the mean and standard deviation 
#
colToKeep<-grep("mean_|std_",names(DataTotal))
TrainTest<-DataTotal[,c(1,2,3,colToKeep)]
varLabels <-names(TrainTest)
varLabels<-gsub("mean_","mean",varLabels)
varLabels<-gsub("std_","std",varLabels)
names(TrainTest)<-varLabels

# Remove temporal variables
rm(trainData,testData,DataTest,activity,subject,DataTrain,colToKeep,DataTotal,varLabels)

#-------------------------------------------------------------------------------------
# Step 3.  Assign descriptive activity name to the activities in the data set
#
activityLabels<-read.table("./activity_labels.txt")
TrainTest$activityID<- activityLabels[TrainTest$activityID,2]

rm(activityLabels)

# Step 4. Label the data set with descriptive names. 
# Done!


# Step 5. Create an independent tidy data set with the average of each variable 
#         for each activity and each subject

# This step requires the dplyr package
# pldyr package will be installed if necessary

list.of.packages <- c("dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

require(dplyr)
TidyData<- tbl_df(TrainTest)
NewTidyData<- (TidyData %>% 
  group_by(activityID,subjectID) %>% 
  summarise_each_(funs(mean(.,na.rm=TRUE)), names(TidyData)[-c(1,2,3)]))

  TidyData <- as.data.frame(NewTidyData)
  write.table(TidyData,file="TidyData.txt", sep=",",row.name=FALSE)
  
rm(NewTidyData,new.packages,list.of.packages)

