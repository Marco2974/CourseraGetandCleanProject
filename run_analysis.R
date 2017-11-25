# Coursera - course: Getting and Cleaning Data
# script for course project 
library(dplyr)

# 1: Merging the training and testing set
fileTrain<-"./UCI HAR Dataset/train/X_train.txt"
fileActTrain<-"./UCI HAR Dataset/train/y_train.txt"
fileSubTrain<-"./UCI HAR Dataset/train/subject_train.txt"
fileTest<-"./UCI HAR Dataset/test/X_test.txt"
fileActTest<-"./UCI HAR Dataset/test/y_test.txt"
fileSubTest<-"./UCI HAR Dataset/test/subject_test.txt"
fileFeatures<-"./UCI HAR Dataset/features.txt"
train<-read.table(fileTrain, header = FALSE)
trainAct<-read.table(fileActTrain, header = FALSE)
trainSub<-read.table(fileSubTrain, header = FALSE)
test<-read.table(fileTest, header = FALSE)
testAct<-read.table(fileActTest, header = FALSE)
testSub<-read.table(fileSubTest, header = FALSE)
train<-cbind(trainSub, trainAct, train)
rm("trainSub", "trainAct")
test<-cbind(testSub, testAct, test)
rm("testSub", "testAct")
total<-rbind(train, test)
rm("train", "test")
features<-read.table(fileFeatures, header = FALSE)
col_names<-c("Subject", "Activity")
colnames(total)<-append(col_names, make.names(features[,2], unique = TRUE))
rm("features")
rm("col_names")

# 2: Extracts the measurements on the mean and 
# standard deviation for each measurement.
ft_select<-grep("Subject|Activity|mean|std", names(total), value = FALSE)
data_select<-select(total, ft_select)
rm("total")
rm("ft_select")

# 3: Uses descriptive activity names to name the activities
# in the data set
fileActLabels<-"./UCI HAR Dataset/activity_labels.txt"
act_labels<-read.table(fileActLabels, header = FALSE)
data_select$Activity<-act_labels[,2][data_select$Activity]
rm("act_labels")
rm(list = ls(pattern="file"))

# 4: Appropriately labels the data set with descriptive variable names. 
names(data_select)<-gsub("\\.", "", names(data_select))
names(data_select)<-gsub("^t", "time", names(data_select))
names(data_select)<-gsub("^f", "freq", names(data_select))
names(data_select)<-gsub("Acc", "Acceleration", names(data_select))
names(data_select)<-gsub("Mag", "Magnitude", names(data_select))
names(data_select)<-gsub("BodyBody", "Body", names(data_select))
names(data_select)<-gsub("Gyro", "Gyroscope", names(data_select))
names(data_select)<-gsub("mean", ".mean", names(data_select))
names(data_select)<-gsub("std", ".std", names(data_select))

# 5: From the data set in step 4, creates a second, independent 
# tidy data set with the average of each variable for each activity and each subject.
data_select$Subject<-as.factor(data_select$Subject)
data_select<-tbl_df(data_select)
data_group<-group_by(data_select, Subject, Activity)
avg_group<-summarise_each(data_group, funs(mean))
rm("data_select")
rm("data_group")
write.csv(avg_group, "getAndCleanSubmit.csv", row.names = FALSE)


