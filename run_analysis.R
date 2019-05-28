## The following script provides a solution to extract, clean and sort out data from the experiment mentionned in the course.
## The expected result is a preview of a tidy data set presenting the average of each variable for each activity and each subject. 
## We conduct the analysis in 5 steps. 
## For more details on the methodology, refer to the readme file and codebook attached in the Github repository. 

run_analysis <- function() {
      library(dplyr)
  
## **1st step** : let's download the zip file from the website and store the data locally.
## We create two seperate tables for the test subjects and the train subjects.
## After adding subjects and activity to both datasets using the cbind function, we merge them in a single dataset using the rbind function.
## Note that we also added  an extra "group" variable to remind us if the subject was part of the testing or training group.
  
      if(!dir.exists("./UCI HAR Dataset")) {dir.create("./UCI HAR Dataset")}
      fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      print("Initiating download")
      download.file(fileUrl, destfile = "./data.zip", method ="curl")
      print("Download succeeded")
      unzip("./data.zip")
      print("Data unzipped")
      
##For test : 
      X_testPath <- "./UCI HAR Dataset/test/X_test.txt"
      y_testPath <- "./UCI HAR Dataset/test/y_test.txt"
      subject_testPath <- "./UCI HAR Dataset/test/subject_test.txt"
      X_test <- read.table(X_testPath)
      y_test <- read.table(y_testPath)
      sj_test <- read.table(subject_testPath)
      X_test = mutate(X_test, group = "test")
      X_test <- cbind(X_test, y_test, sj_test)

## For train : 
      X_trainPath <- "./UCI HAR Dataset/train/X_train.txt"
      y_trainPath <- "./UCI HAR Dataset/train/y_train.txt"
      subject_trainPath <- "./UCI HAR Dataset/train/subject_train.txt"
      X_train <- read.table(X_trainPath)
      y_train <- read.table(y_trainPath)
      sj_train <- read.table(subject_trainPath)
      X_train = mutate(X_train, group = "train")
      X_train <- cbind(X_train, y_train, sj_train)    

## We merge test and train datasets in a single dataset : 
      X <- rbind(X_test, X_train)
      print("Test and train data merged into dataset X")

## **2nd step** : let's import the file with variable labels and use it to appropriately label the data set with descriptive variable names.
## This step correspond to requirement 4 in the Coursera assignment.
      
      featuresPath <- "./UCI HAR Dataset/features.txt"
      features <- read.table(featuresPath)
      features[[2]] <- as.character(features[[2]])
      features[562,]=c(562,"group")
      features[563,]=c(563,"activity")
      features[564,]=c(564,"subject")
      colnames(X) <- features[[2]]
      print("Variable names successfully added")
      
## **3rd step** : let's use descriptive activity names to name the activities in the data set. 
## To do so, we import the "activity_labels" file.
## And we use a loop that reviews each row of the dataset "X" and finds the corresponding activity label. 
## This step correspond to requirement 3 in the Coursera assignment.
      
      activityPath <- "./UCI HAR Dataset/activity_labels.txt"
      activity_labels <- read.table(activityPath)
      for (i in 1:nrow(X)) {
        for (j in 1:nrow(activity_labels)) {
          if(X[i,563] == activity_labels[j,1]) {
            X[i,563] <- as.character(activity_labels[j,2])
          }
        }
      }
      print("Activity labels successfully added")
      
## Now we have a dataset with activity labels !
      print("X preview :")
      print(str(X))
      
## **4th step** : Let's extract only the measurements on the mean and standard deviation for each measurement.
## We use a regexp to select variables using the Mean() or Std() functions.
## This step correspond to requirement 2 in the Coursera assignment.
      
      ms_regexp <- grep("(|)[Mm]ean\\()|[Ss]td\\()|activity|group|subject",colnames(X), value = TRUE)
      X_mean_std <- X[, ms_regexp]
      
## **5th step** : From the data set in step 4, we create a second, independent tidy data set named "finalX" with the average of each variable for each activity and each subject.
## This step correspond to requirement 5 in the Coursera assignment.
      
      finalX <- group_by(X_mean_std,group, subject, activity)
      finalX <- summarise_all(finalX,mean)
      print("Creation of a 2nd dataset with the average of each variable for each activity and each subject")
      print(head(finalX))
      print("End of analysis.")
}

##Thank you for reviewing!
