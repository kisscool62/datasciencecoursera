
library(dplyr)
library(tidyr)

###
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("id_activity", "activity_name")

## names
feature_names <- as.character(features[, 2])

### 1) merging test and train
## merging subject
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# add train rows to test rows
subjects <- rbind(subject_test, subject_train)

#setting names to subjects
names(subjects) <- "subjects"

## merging X
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")

# add train rows to test rows
X <- rbind(X_test, X_train)

#setting names to X
names(X) <- feature_names

## merging y
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# add train rows to test rows
y <- rbind(y_test, y_train)

# setting namee to activity
names(y) <- "activity"

### 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## getting mean and std deviation columns
mean_columns <- as.character(features[grep(".*-mean\\(\\).*-[X|Y|Z]", features[,2]), 2])
std_columns <- as.character(features[grep(".*-std.*-[X|Y|Z]", features[,2]), 2])
mean_x <- X[, mean_columns]
std_x <- X[, std_columns]

## building a new X data set with only wanted columns
new_X <- cbind(mean_x, std_x)
new_X <- cbind(y, new_X)
new_X <- cbind(subjects, new_X)
# now new_X is a data frame with a column of subjects, activity columns, mean measures, std measures

#now put variables in values
# transform (for instance) fBodyAcc-mean()-Z coluns in values put in a column named label, and original value is put in column value
other <- gather(new_X, label, value, 3:50)

# separates fBodyAcc-mean()-Z into fBodyAcc, mean(), Z columns. The same for std()
tidy <- separate(other, col = "label", into = c("feature", "agregate", "axial"), sep="-")

unique(tidy$axial)

### 3. Uses descriptive activity names to name the activities in the data set
activity_labeled <- as.character(sapply(X=as.character(tidy$activity), FUN= function(ac){activity_labels[activity_labels$id_activity == ac,2]}))

tidy_labeled <- cbind(tidy, activity_labeled)

### 4. Appropriately labels the data set with descriptive variable names
#renaming some variables, removing non labeled columns
result <- select(tidy_labeled, subjects, activity = activity_labeled, feature, agregate, axis = axial, value)

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
#mutate subjects into numeric to avoid sorting issues
tidy_data_set <- mutate(result, subjects = as.numeric(subjects))
tidy_data_set <- mutate(tidy_data_set, value = as.numeric(value))
tidy_data_set <- mutate(tidy_data_set, axis = as.character(axis))
tidy_data_set <- mutate(tidy_data_set, feature = as.character(feature))
tidy_data_set <- mutate(tidy_data_set, agregate = as.character(agregate))

grp <- group_by(tidy_data_set, subjects, activity, feature, agregate, axis)
summary <- summarize(grp, value = mean(value))
df <- data.frame(summary)
tidy_data_set <- spread(df, agregate, value)

tidy_data_set <- arrange(tidy_data_set, subjects, activity, feature, axis)


