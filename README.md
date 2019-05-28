Getting and Cleaning Data Course Project
==================================================================
Human Activity Recognition Using Smartphones Dataset

Version 2.0
==================================================================
Raw Data obtained from : 
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

==================================================================

This document presents a solution to sort the raw data collected during the experiment and stored in ".txt" files. 

Reminder : 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a
constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly
partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding
windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion
components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to
have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was
obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Note : Features are normalized and bounded within [-1,1].

Manipulation on the initial data to obtain the current version using the run_analysis function
======================================

The "run_analysis" function runs in 5 steps, each corresponding to one of the requirements of the Coursera assignment : 

**1/** Let's download the zip file from the website and unzip the data.
I used the same process to upload separately tables for the test group and the train group : 
   - Using the read.table function on the documents "X_test.txt" and "X_train.txt", we create 2 data frames to "X_test" and "X_train".
   - Both datasets have 561 columns, each corresponding to one feature. 
   - Add a column "group" and pass it the value "test" or "train", so that we can remember to which group it belonged initially.
   - We need 2 more columns to store subject and activity. To do so, upload the corresponding files and use the cbind function.
Once both sets are ready, merge them in a single dataframe named "X" using the rbind function.
This single dataset should have 564 colums and 10 299 rows.
   This step corresponds to requirement 1 in the Coursera assignment.

**2/** Let's import the file with variable labels and use it to appropriately label the data set with descriptive variable names.
To do so, upload the "features.txt" file into a data frame named "features".
In this data frame, make sure that the class of the 2nd column is "character". 
Then add 3 additional labels "group", "subject" and "activity" to match the corresponding columns created during step 1. 
Finally, use the function "colnames" to pass those labels into the column names of the data.frame "X".
   This step corresponds to requirement 4 in the Coursera assignment.

**3/** Let's use descriptive activity names to name the activities in the data set. 
First, upload the activity labels from the corresponding file "activity-labels.txt" in a data frame called activity_labels.
Now, we need to match the numeric values from our dataset to the activity labels.
Use nested loops to review each row of the dataset "X" and compare the value of the "activity" variable with the value assigned to each activity in the activity_labels data frame. 
Whenever the two values match, the corresponding activity label is passed into the row. 
   This step correspond to requirement 3 in the Coursera assignment.

**4/** Let's extract only the measurements on the mean and standard deviation for each measurement.
Use a regexp to select variables using the Mean() or Std() functions. Among the dataset, there were several variables using the words "Mean" and "Std" without brackets. I chose to ignore those variables and focus on the variables where I was sure to use the function mean() or std()
   This step corresponds to requirement 2 in the Coursera assignment.

**5/** From the data set in step 4, create a second, independent tidy data set named "finalX" with the average of each variable for each activity and each subject.
The function group_by allows us to sort the data using different levels. We can also use the "group" level to remind us whether the subject was in test group or train group.
   This step corresponds to requirement 5 in the Coursera assignment.

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
