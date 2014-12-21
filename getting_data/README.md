==================================================================
# Human Activity Recognition Using Smartphones Dataset
## Version 1.0
==================================================================
### Pascal AUREGAN
### Coursera
### Getting and Cleaning Data
==================================================================
* This data set is created from
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

* Original data and description can be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

* The goal of the script is to extract means and standard deviations from the original data. Mean and standard deviation should be the value for each subject, each activity, each feature, each axis.

==================================================================

30 volonteers participate in getting data several activities. We will call it subjects.

Here is the original description better than the mine: 
Each subject performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz.

==================================================================

The directory includes the following files:
- README.md
- run_analysis.R: the script wich performs the trasformation
- main.R: script setting the working directory, run the script, write result in txt file and csv file
- tidy_data_set.txt: output as table in txt file. Each column is separated by " "
- tidy_data_set.csv: output as table in csv file. Each column is separated by ","

==================================================================

### What the script does

==================================================================

##### run_analysis.R
==================================================================
*description of the script*

comments in the script are: 
- \#\# 1. is a comment describing the steps writen bellow
- \#\# 1) is a comment describing the steps of project expectations

1. the first step is to read files where labels are stored

2. then test and train files are merged:
    - subjects
    - X

3. set columns names to X which are the features read previously

4. extract only mean and standard deviation columns

5. Then the goal is to extract information from those column names. In Each column names is stored 3 informations: feature, axis, agregate (mean or standard deviation)

6. At this step we just have to rename some variables and arrange them. I sorted activity names in desc order to conform the order given in the original description.

==================================================================

### CODEBOOK

==================================================================
##### tidy_data_set.txt
==================================================================
*table, each column is separated by a ' '*

- subjects: volonteer's id. range [1, 30]
- activity: belongs to [WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING]
- feature: belongs to ["fBodyAcc", "fBodyAccJerk", "fBodyGyro", "tBodyAcc", "tBodyAccJerk", "tBodyGyro", "tBodyGyroJerk", "tGravityAcc"]
- axis: axis of the feature recorded in 3 dimensions, belongs to ["X", "Y", "Z"]
- mean(): mean of values of recorded features for each axis, on ieach feature for each activity, for each subject. Bounded within [-1, 1] 
- std(): mean standard deviation of values of recorded features for each axis, on ieach feature for each activity, for each subject. Bounded within [-1, 1]

==================================================================
##### tidy_data_set.csv
==================================================================
*table, each column is separated by a ','*

- subjects: volonteer's id. range [1, 30]
- activity: belongs to [WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING]
- feature: belongs to ["fBodyAcc", "fBodyAccJerk", "fBodyGyro", "tBodyAcc", "tBodyAccJerk", "tBodyGyro", "tBodyGyroJerk", "tGravityAcc"]
- axis: axis of the feature recorded in 3 dimensions, belongs to ["X", "Y", "Z"]
- mean(): mean of values of recorded features for each axis, on ieach feature for each activity, for each subject
- std(): mean standard deviation of values of recorded features for each axis, on ieach feature for each activity, for each subject

