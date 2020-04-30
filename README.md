#run_analysis.R

This script analyses the "Human Activity Recognition Using Smartphones Dataset" Version 1.0
 
The main function run_analysis() merges training and test data and does the necessary 
calculations to come out with the tidy dataset that is written to *output\tidydata.txt*. Furthermore, The function returns the resulting dataset. 

#Tidy dataset
The resulting dataset includes summary measurements for each one of the 30 subjects for each activity on Acceleration and Velocity.
For more information on the resulting dataset, check CodeBook.md

#Internals
run_analysis() uses an internal function getDataset(dataset ="train") that returns either train or test dataset and appropriately labels the dataset with descriptive variable names and activity name. 


For more information on the input dataset, check:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones