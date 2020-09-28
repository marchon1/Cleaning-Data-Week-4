## Getting and Cleaning data

## Data description:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## project data:
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## This script creates an R script called run_analysis.R that does the following:

## 1 Merge the training and the test sets to create one data set.
## 2 Extracts only the measurements on the mean and standard deviation 
##   for each measurement.
## 3 Uses descriptive activity names to name the activities in the data set
## 4 Appropriately label the data set with descriptive variable names.
## 5 From the data set in step 4, creates a second, independent tidy data set 
##   with the average of each variable for each activity and each subject.

library(dplyr)
library(plyr)

#Features and activity labels
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
activity_labels<- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#Read from the train data
Xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
Ytrain<-read.table("./UCI HAR Dataset/train/Y_train.txt", col.names = "code")

#Read from test data
Xtest<-read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
Ytest<-read.table("./UCI HAR Dataset/test/Y_test.txt", col.names = "code")

#Combind data from train and test together
X <- rbind(Xtrain, Xtest)
Y <- rbind(Ytrain, Ytest)
Subj <- rbind(subtrain, subtest)
combdata<-cbind(Subj, Y, X)

#Get the mean and std rows from combined data
combdata2 <- combdata[,grepl( "subject|code|mean|std", colnames(combdata))]

#Renaming the col names
names(combdata2)<- gsub("[\\(\\)-]", "", names(combdata2))
names(combdata2)<- gsub("Acc","Accelerometer",names(combdata2))
names(combdata2)<- gsub("Gyro","Gyroscope",names(combdata2))
names(combdata2)<- gsub("Mag","Magnitude",names(combdata2))
names(combdata2)<- gsub("^t", "Time", names(combdata2))
names(combdata2)<- gsub("^f", "Frequency", names(combdata2))
names(combdata2)<- gsub("tBody", "TimeBody", names(combdata2))
names(combdata2)<- gsub("mean", "Mean", names(combdata2))
names(combdata2)<- gsub("std", "StandardDev", names(combdata2))

#Independent data set
finaldata <- combdata2 %>%
  group_by(subject, code) %>%
  summarise_all(funs(mean))
write.table(finaldata, file = "run_analysis.txt", row.name=FALSE)