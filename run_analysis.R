## script for getting and cleaning data course project

## download and unzip file into data directory

if(!file.exists("data")) {
      dir.create("data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, "data/HARDataset.zip", "curl")
dateDownloaded <- date ()
unzip("data/HARDataset.zip", exdir = "data")

SubjectTest <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
XTest <- read.table("data/UCI HAR Dataset/test/X_test.txt")
YTest <- read.table("data/UCI HAR Dataset/test/y_test.txt")

SubjectTrain <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
XTrain <- read.table("data/UCI HAR Dataset/train/X_train.txt")
YTrain <- read.table("data/UCI HAR Dataset/train/y_train.txt")

var_names <- read.table("data/UCI HAR Dataset/features.txt")
var_names <- var_names[, 2]

activities <- read.table("data/UCI HAR Dataset/activity_labels.txt")

colnames(XTest) <- var_names
colnames(XTrain) <- var_names

colnames(YTest) <- "Activity"
colnames(YTrain) <- "Activity"

YTest$ActivityDescr = activities[match(YTest$Activity, activities$V1), "V2"]
YTrain$ActivityDescr = activities[match(YTrain$Activity, activities$V1), "V2"]

colnames(SubjectTest) <- "Subject"
colnames(SubjectTrain) <- "Subject"

GroupTest <- as.data.frame(rep("Test", times = 2947))
colnames(GroupTest) <- "VolunteerSet"
GroupTrain <- as.data.frame(rep("Train", times = 7352))
colnames(GroupTrain) <- "VolunteerSet"

XTest <- cbind(YTest, XTest)
XTest <- cbind(SubjectTest, XTest)
XTest <- cbind(GroupTest, XTest)

XTrain <- cbind(YTrain, XTrain)
XTrain <- cbind(SubjectTrain, XTrain)
XTrain <- cbind(GroupTrain, XTrain)

XData <- rbind(XTrain, XTest)

XDataM <- XData[, c(1,2,3,4,grep("mean\\(", var_names) + 4)]
XDataS <- XData[, grep("std\\(", var_names) + 4]
XDataMS <- cbind(XDataM, XDataS)

XDataAverages <- aggregate(XDataMS[,5:70], XDataMS[,1:4], FUN = mean)
write.csv(XDataAverages, "some_X_data_averages.csv")
