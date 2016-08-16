##import used libraries
library(data.table)
library(plyr)
library(dplyr)

##Create directory if it doesnt exists
if(!file.exists("./datafolder")){
    dir.create("./datafolder")
    }
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## add if working on Mac OS (,method="curl")
download.file(fileUrl,destfile="./datafolder/DCDataset.zip") 

##unzip the file downloaded
unzip(zipfile="./datafolder/DCDataset.zip",exdir="./datafolder")

##Read the Test and Train files
TestLabelData  <- read.table("datafolder/UCI HAR Dataset/test/y_test.txt", header = FALSE)
TrainLabelData <- read.table("datafolder/UCI HAR Dataset/train/y_train.txt" ,header = FALSE)
##Merge the train and test label data
LabelData <- rbind(TrainLabelData, TestLabelData)
##Assign proper column name
names(LabelData) <- c("Activity")

##Read the Test and Train Subject files
TestSubjectData  <- read.table("datafolder/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
TrainSubjectData <- read.table("datafolder/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
#Merge the train and test subject data
SubjectData <- rbind(TrainSubjectData, TestSubjectData)
##Assign the proper column name
names(SubjectData) <- c("Subject")

##Read the train and test files
TestSet  <- read.table("datafolder/UCI HAR Dataset/test/X_test.txt" , header = FALSE)
TrainSet <- read.table("datafolder/UCI HAR Dataset/train/X_train.txt", header = FALSE)
##Merge the train and test data sets
Set <- rbind(TrainSet, TestSet)

##Read the column names for the data set
Features <- read.table("datafolder/UCI HAR Dataset/features.txt", header=FALSE)
##Assign a readable column name
names(Features) <- c("Index", "FeatureType")

##Read the Activity names from file
ActivityLabels <- read.table("datafolder/UCI HAR Dataset/activity_labels.txt", header = FALSE)
##Assign a readable column name
names(ActivityLabels) <- c("Index", "ActivityType")

##add feature column names to Set
names(Set) <- Features$FeatureType

##map the activity label and assign them properly
LabelData$Activity <- ActivityLabels[match(LabelData$Activity, ActivityLabels$Index),2]
##Merge the Subject and Activity
mergedSubjectandLabel <- cbind(SubjectData, LabelData)
##Merge the Subject and Activity to the metrics set
DataSet <- cbind(mergedSubjectandLabel, Set)

##Subset the dataset based on the column names that have mean or std
DataSet <- DataSet[,c(1,2,grep("mean\\(\\)|std\\(\\)", names(DataSet)))]

##Replace the column names with a more readable naming convention
names(DataSet)<-gsub("^t", "Time", names(DataSet))
names(DataSet)<-gsub("Acc", "Accelerometer", names(DataSet))
names(DataSet)<-gsub("^f", "Frequency", names(DataSet))
names(DataSet)<-gsub("Gyro", "Gyroscope", names(DataSet))

##Create a tidy data set with new set of aggregations
aggdata <-aggregate(DataSet[,c(-1,-2)], by=list(DataSet$Subject, DataSet$Activity) , FUN=mean)
colnames(aggdata)[colnames(aggdata)=="Group.1"] <- "Subject ID"
colnames(aggdata)[colnames(aggdata)=="Group.2"] <- "Activity ID"
##Write the aggregate data on a new file
write.table(aggdata, file = "tidyAggregate.txt", row.name=FALSE)
