# Getting and Cleaning Data Course Project Code Book

## Purpose
This project is meant to show how data can be collected and prepared as tidy data for analysis. This code book describes the variables and summarizes calculated.

## Source Data
The source dcaata for this project data is collected from accelerometers for the Samsung Galaxy S smartphone and can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data was manually downloaded to my hard drive rather than using the script to download the data.

A full description of the Data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## The source files that describe and contain the data can be found in the zip file and include the following:
* README.txt
* features_info.txt
* activity_labels.txt
* features.txt
* subject_train.txt
* subject_test.txt
* x_train.txt
* y_train.txt
* x_test.txt
* y_test.txt

## Steps performed
The run_analysis.R script performs the following steps:

* Store the data from the files in memory using the following variables:
1. xtrf = x_train.txt
2. ytrf = y_train.txt
3. xtef = x_test.txt
4. ytef = y_test.txt
5. trainSubjectData = subject_train.txt
6. testSubjectData = subject_test.txt
7. featuresData = feature.txt

* Extract the features to be used as column names and store in featureVector variable and then add column names to columns for xtrf, ytrf, xtef, ytef, trainSubjectData and testSubjectData

* Use column bind to concatenate the train data together (subjectTraindData, ytrf and xtrf) and use mutate to add a column indicating "train" for each row; save this to the trainData variable

* Use column bind to concatenate the test data together (subjectTestdData, ytef and xtef) and use mutate to add a column indicating "test" for each row; save this to the testData variable

* Use row bind to concatenate the testData and trainData together in store in mergedData variable

* Extract the measurements on the mean and standard deviation (using grep function) and write the results to a file called mergedData.csv

* Determine the mean by subject and activity using the aggregate function and store in the variable avgData

* Update the names of the columns to show that they represent the mean by prepending the column name with "mean" and placing parenthesis around the column names

* Write the results to a file called avgData.csv


