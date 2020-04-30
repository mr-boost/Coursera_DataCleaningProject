#the main function run_analysis() merges training and test data and does the necessary 
#calculations to come out with the tidy dataset that is written to output\tidydata.txt 
#and returned by the function

run_analysis <- function()
{
    #extract training data
    traindata <- getDataset("train")
    #extract test data
    testdata <- getDataset("test")
    #Merges the training and the test sets to create one data set
    data <- rbind(traindata, testdata)
    
    #Extracts only the measurements on the mean and standard deviation for each measurement
    data_mean_std <- data[,grep("^subject$|^activity$|std\\(\\)|mean\\(\\)", names(data))]
    
    #Create a second, independent tidy data set with the average of each variable 
    #for each activity and each subject
    library(dplyr)
    data_by <- group_by(data_mean_std, subject, activity)
    data_sum <- summarise_all(data_by,mean,na.rm = TRUE)
    write.table(data_sum, file=".\\output\\tidydata.txt", row.names = FALSE)
    data_sum

}

## Returns train or test dataset and appropriately label 
## the data set with descriptive variable names and activity name. 
getDataset <- function(dataset ="train")
    
{
    datafolder <- ".\\UCI HAR Dataset\\"
    features <- read.table(paste0(datafolder,"features.txt"))
    
    subject <- read.table(paste0(datafolder, "\\",dataset,"\\subject_",dataset,".txt"))
    colnames(subject) <- c("subject")
    X <- read.table(paste0(datafolder, "\\",dataset,"\\X_",dataset,".txt"))
    colnames(X) <- features[,2]
    y_values <- read.table(paste0(datafolder, "\\",dataset,"\\y_",dataset,".txt"))
    
    # Use descriptive activity names to name the activities in the data set
    activity_labels <- read.table(paste0(datafolder,"activity_labels.txt"))
    activity <- factor(y_values[,1], activity_labels[,1],labels = activity_labels[,2])
    
    body_acc_x <- read.table(paste0(datafolder, "\\",dataset,"\\Inertial Signals\\body_acc_x_",dataset,".txt"))
    colnames(body_acc_x) <- c(paste0("body_acc_x_",seq(1,128)))
    body_acc_y <- read.table(paste0(datafolder, ".\\",dataset,"\\Inertial Signals\\body_acc_y_",dataset,".txt"))
    colnames(body_acc_y) <- c(paste0("body_acc_y_",seq(1,128)))
    body_acc_z <- read.table(paste0(datafolder, ".\\",dataset,"\\Inertial Signals\\body_acc_z_",dataset,".txt"))
    colnames(body_acc_z) <- c(paste0("body_acc_z_",seq(1,128)))
    body_gyro_x <- read.table(paste0(datafolder, ".\\",dataset,"\\Inertial Signals\\body_gyro_x_",dataset,".txt"))
    colnames(body_gyro_x) <- c(paste0("body_gyro_x_",seq(1,128)))
    body_gyro_y <- read.table(paste0(datafolder, ".\\",dataset,"\\Inertial Signals\\body_gyro_y_",dataset,".txt"))
    colnames(body_gyro_y) <- c(paste0("body_gyro_y_",seq(1,128)))
    body_gyro_z <- read.table(paste0(datafolder, ".\\",dataset,"\\Inertial Signals\\body_gyro_z_",dataset,".txt"))
    colnames(body_gyro_z) <- c(paste0("body_gyro_z_",seq(1,128)))
    total_acc_x <- read.table(paste0(datafolder, ".\\",dataset,"\\Inertial Signals\\total_acc_x_",dataset,".txt"))
    colnames(total_acc_x) <- c(paste0("total_acc_x_",seq(1,128)))
    total_acc_y <- read.table(paste0(datafolder, ".\\",dataset,"\\Inertial Signals\\total_acc_y_",dataset,".txt"))
    colnames(total_acc_y) <- c(paste0("total_acc_y_",seq(1,128)))
    total_acc_z <- read.table(paste0(datafolder, ".\\",dataset,"\\Inertial Signals\\total_acc_z_",dataset,".txt"))
    colnames(total_acc_z) <- c(paste0("total_acc_z_",seq(1,128)))
    cbind(subject, activity, body_acc_x, body_acc_y, body_acc_z, body_gyro_x, body_gyro_y, body_gyro_z, total_acc_x, total_acc_y, total_acc_z, X)
    }