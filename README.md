# Getting and Cleaning Data Course Project Read Me 

Instructions on how to run the run_analysis.R script:

1. Manually download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

2. Checkout the run_analysis.R script from GitHub and source into RStudio

3. Load the dplyr library into the RStudio workspace

4. The run_analysis.R script expects the directory where the files were unzipped to be passed in to the funtion, e.g. %PATH%:\wearableData\UCI HAR Dataset; this is the working directory

5. The script will create two files:
  a. mergedData.csv
  b. avgData.csv

