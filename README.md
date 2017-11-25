# Coursera - Getting and Cleaning Data Course Project

Data set: "Human Activity Recognition Using Smartphones Data Set" from "UCI Machine Learning Repository"

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The goal is to create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
   The code merges the subject vector with the activities vector and with the measurements in the train and test set (cbind),
   creating two data frames, and then merges the training and testing set (rbind).
   
2. Extracts only the measurements on the mean and standard deviation for each measurement.
   The code select the coloumns of the measurments witn the pattern "mean" or "std" in the name.
   
3. Uses descriptive activity names to name the activities in the data set
   The number of the activity is replaced with the laber (es. "WALKING")
   
4. Appropriately labels the data set with descriptive variable names.
   The names of the variables are modified to be more descriptive.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity
   and each subject.
   Using the package "dplyr" the data are grouped by subject and activities and summarised.

