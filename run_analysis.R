library(dplyr)

# Section 0: Dataset Preparation and Extraction.
filename <- "UCI_Dataset.zip"

# Download the file if the file does not exists 
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
}  

# Create a folder where the Data set will be unzipped
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# Section 1: Merging the training and test sets to create one data set.

# Reading feature vector
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

# Reading training data sets and assigning variable names
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# Reading test data sets and assigning variable names
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# Reading activity labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Merging of training and test data sets
x1 <- rbind(x_train, x_test)
y1 <- rbind(y_train, y_test)
sub <- rbind(subject_train, subject_test)

combinedDataset <- cbind(sub, y1, x1)


# Section 2: Subset extraction of mean and standard deviation for each measurement.

DataSubset <- combinedDataset %>% select(subject, code, contains("mean"), contains("std"))


# Section 3: Set descriptive activity names to name the activities in the data set.

DataSubset$code <- activities[DataSubset$code, 2]


# Section 4: Descriptive variable name assignment to activities.

names(DataSubset)[2] = "activity"

names(DataSubset)<-gsub("Acc", "Accelerometer", names(DataSubset))
names(DataSubset)<-gsub("Angle", "Angle", names(DataSubset))
names(DataSubset)<-gsub("BodyBody", "Body", names(DataSubset))
names(DataSubset)<-gsub("gravity", "Gravity", names(DataSubset))
names(DataSubset)<-gsub("Gyro", "Gyroscope", names(DataSubset))
names(DataSubset)<-gsub("^f", "Frequency", names(DataSubset))
names(DataSubset)<-gsub("Mag", "Magnitude", names(DataSubset))
names(DataSubset)<-gsub("^t", "Time", names(DataSubset))
names(DataSubset)<-gsub("tBody", "TimeBody", names(DataSubset))

names(DataSubset)<-gsub("-mean()", "Mean", names(DataSubset), ignore.case = TRUE)
names(DataSubset)<-gsub("-std()", "STD", names(DataSubset), ignore.case = TRUE)
names(DataSubset)<-gsub("-freq()", "Frequency", names(DataSubset), ignore.case = TRUE)


# Section 5: Tidy data containing the Mean of each variable for each activity and each subject.

TidyData <- DataSubset %>%
  group_by(subject, activity) %>%
  summarise_all(tibble::lst(mean))

# Tidy data for submission
write.table(TidyData, "TidyData.txt", row.name=FALSE)