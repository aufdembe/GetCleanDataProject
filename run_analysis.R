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

colnames(XTest) <- var_names
colnames(XTrain) <- var_names
