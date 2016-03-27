# This script is the final course project for Getting and Cleaning
# Data. The script will perform the following tasks using data collected 
# from the accelerometers of Samsung Galaxy S smartphones:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

# Full descriptions of the data can be found here: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# You need to pass in the directory where data is located for a relative path

run_analysis <- function(directory){
  
  # read files in
  xtrainFile <- paste(directory, "/train/X_train.txt", sep = "")
  ytrainFile <- paste(directory, "/train/y_train.txt", sep = "")
  xtestFile <- paste(directory, "/test/X_test.txt", sep = "")
  ytestFile <- paste(directory, "/test/y_test.txt", sep = "")
  featuresFile <- paste(directory, "/features.txt", sep = "")
  trainSubjects <- paste(directory, "/train/subject_train.txt", sep = "")
  testSubjects <- paste(directory, "/test/subject_test.txt", sep = "")
  
  xtrf <- fread(xtrainFile, header = FALSE)
  ytrf <- fread(ytrainFile, header = FALSE)
  xtef <- fread(xtestFile, header = FALSE)
  ytef <- fread(ytestFile, header = FALSE)
  featuresData <- read.csv(featuresFile, header = FALSE, sep = " ")
  trainSubjectData <- read.csv(trainSubjects, header = FALSE, sep = " ")
  testSubjectData <- read.csv(testSubjects, header = FALSE, sep = " ")
  
    # Create column names before merging
  # extract the features to a vector to use as the column heading for the data
  featureVector <- as.vector(featuresData[,2])
  
  # add column names
  colnames(xtrf) <- featureVector
  colnames(xtef) <- featureVector
  
  
  # give the subject and activity data a column name before merging
  colnames(trainSubjectData) <- "subject"
  colnames(testSubjectData) <- "subject"
  colnames(ytrf) <- "activity"
  colnames(ytef) <- "activity"
  
  # bind the columns together 
  # requires two column binds: one to bind the subject identifier and the activity  
  # and the next to bind the data, but we also need to add a column to show that this 
  # is related to the train data
  
  trainData <- cbind(trainSubjectData, ytrf)
  trainData <- mutate(trainData, datatype = "train")
  trainData <- cbind(trainData, xtrf)
  
  # do the same for the test data
  testData <- cbind(testSubjectData, ytef)
  testData <- mutate(testData, datatype = "test")
  testData <- cbind(testData, xtef)
  
  # now lets merge the test and train data
  mergedData <- rbind(trainData, testData)
  
  # now lets extract measurements on the mean and standard deviation
  # and write the results to a file.
  mergedData <- mergedData[,grep("activity|subject|datatype|mean|std", names(mergedData))]
  mergedFilename <- paste(directory, "/mergedData.csv", sep = "")
  
  # write the data out to a file
  write.csv(mergedData, file = mergedFilename, row.names = FALSE)
  
  # now lets get the mean by subject and activity
  avgData <- aggregate(mergedData, by = list(mergedData$subject, mergedData$activity), 
                       FUN = "mean")
  avgData <- avgData[,grep("activity|subject|mean|std", names(avgData))]
  
  # update the colum names to reflect that these are the mean by subject/activity
  names(avgData) <- gsub("([a-zA-Z0-9]+-mean[()-XYZ]*)", "mean(\\1)", names(avgData))
  names(avgData) <- gsub("([a-zA-Z0-9]+-std[()-XYZ]*)", "mean(\\1)", names(avgData))
  
  # write it out to a file
  avgFilename <- paste(directory, "/avgData.csv", sep = "")
  write.csv(avgData, file = avgFilename, row.names = FALSE)
  
}