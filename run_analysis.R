#This is the course project for the Getting and Cleaning Data Coursera course.
# load the required packages
library(dplyr)
library(reshape2)

# download the data zip file and unzip it into the work directory.  
if(!file.exists("getdata.zip")){
  fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL,"./getdata.zip")
}
if(!file.exists("UCI HAR Dataset")){
unzip("getdata.zip")
 }

# load training and test datasets along with their activity data for each of them.
TrainData = read.table("./UCI HAR Dataset/train/X_train.txt")
TrainActivityData = read.table("./UCI HAR Dataset/train/y_train.txt")

TestData = read.table("./UCI HAR Dataset/test/X_test.txt")
TestActivityData = read.table("./UCI HAR Dataset/test/y_test.txt")

# load the subject data files for both train and test datasets.
TrainSubject = read.table("./UCI HAR Dataset/train/subject_train.txt",sep="")
TestSubject = read.table("./UCI HAR Dataset/test/subject_test.txt",sep="")

#load the features information and activity labels
FeatureInfo = read.table("./UCI HAR Dataset/features.txt",sep="")
ActivityLabels<-read.table("./UCI HAR Dataset/activity_labels.txt")
# editing the feature names to make the names more accessible  
FeatureInfo$V2 <- make.names(names=FeatureInfo$V2, unique=TRUE, allow_ = TRUE)

# label the columns in each dataset based on the feature labels
colnames(TestData)<-FeatureInfo$V2
colnames(TrainData)<-FeatureInfo$V2

# selecting columns of only mean and std.The colomns that contain "Mean" and "meanFreq" 
#are not included as they do not represent the mean values calculated from the signals
TestMeanSTD<-TestData %>% select(contains(".mean."),contains("std"))
TrainMeanSTD<-TrainData %>% select(contains(".mean."),contains("std"))
#merging the two datasets
AllData<- rbind(cbind(TestSubject,TestActivityData,TestMeanSTD),cbind(TrainSubject,TrainActivityData,TrainMeanSTD))

# label the subject and activity columns in each dataset
colnames(AllData)[2]="activity"
colnames(AllData)[1]="subject"

# converting the activity column to factor so that the activities are descriptive instead of numeric.
AllData$activity<-factor(AllData$activity,levels=ActivityLabels$V1,labels=ActivityLabels$V2)

#generating a tidy data with the average of each variable for each activity and each subject.


MeltedData <- melt(AllData, id = c("subject", "activity"))
MyTidyData <- dcast(MeltedData , subject + activity ~ variable,mean)

#saving the TidyData as a text file. Note that this data is a wide format tidy data.
write.table(MTidyData ,"MyTidyData.txt")






