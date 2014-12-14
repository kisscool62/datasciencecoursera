working_directory <- 'E:\\workspace\\R\\coursera\\getting_data_project\\datasciencecoursera\\getting_data'
setwd(working_directory)

library(dplyr)
library(tidyr)

features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("id_activity", "activity_name")

## names
names <- as.character(features[, 2])
## getting mean and std deviation columns
mean_columns <- as.character(features[grep(".*-mean\\(\\).*-[X|Y|Z]", features[,2]), 2])
std_columns <- as.character(features[grep(".*-std.*-[X|Y|Z]", features[,2]), 2])

## 1) merging test and train
# merging subject
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subjects <- rbind(subject_test, subject_train)
names(subjects) <- "subjects"

# merging x
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X <- rbind(X_test, X_train)
names(X) <- names

# merging x
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y <- rbind(y_test, y_train)
names(y) <- "activity"


# merging boddy acc x
#body_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
#body_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
#body_acc_x <- rbind(body_acc_x_test, body_acc_x_train)

# merging boddy acc y
#body_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
#body_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
#body_acc_y <- rbind(body_acc_y_test, body_acc_y_train)


# merging boddy acc z
#body_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
#body_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
#body_acc_z <- rbind(body_acc_z_test, body_acc_z_train)


# merging boddy gyro x
#body_gyro_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
#body_gyro_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
#body_gyro_x <- rbind(body_gyro_x_test, body_gyro_x_train)
#names(body_gyro_x) <- names

# merging boddy gyro y
#body_gyro_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
#body_gyro_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
#body_gyro_y <- rbind(body_gyro_y_test, body_gyro_y_train)


# merging boddy gyro z
#body_gyro_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
#body_gyro_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
#body_gyro_z <- rbind(body_gyro_z_test, body_gyro_z_train)


# merging total acc x
#total_acc_x_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
#total_acc_x_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
#total_acc_x <- rbind(total_acc_x_test, total_acc_x_train)

# merging total acc y
#total_acc_y_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
#total_acc_y_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
#total_acc_y <- rbind(total_acc_y_test, total_acc_y_train)


# merging total acc z
#total_acc_z_test <- read.table("UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
#total_acc_z_train <- read.table("UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")
#total_acc_z <- rbind(total_acc_z_test, total_acc_z_train)


mean_x <- X[, mean_columns]
std_x <- X[, std_columns]


new_X <- cbind(mean_x, std_x)
new_X <- cbind(y, new_X)
new_X <- cbind(subjects, new_X)
# now new_X is a data frame with a column of subjects, activity columns, mean measures, std measures

#now put variables in values
other <- gather(new_X, label, value, 3:48)
tidy <- separate(other, col = "label", into = c("feature", "agregate", "axial"), sep="-")

unique(tidy$axial)

activity_labeled <- as.character(sapply(X=as.character(tidy$activity), FUN= function(ac){activity_labels[activity_labels$id_activity == ac,2]}))

tidy_labeled <- cbind(tidy, activity_labeled)

#renaming some variables, removing non labeled columns
result <- select(tidy_labeled, subjects, activity = activity_labeled, feature, agregate, axis = axial, value)

#mutate subjects into numeric to avoid sorting issues
result <- mutate(result, subjects = as.numeric(subjects))
result <- mutate(result, value = as.numeric(value))
result <- mutate(result, axis = as.character(axis))
result <- mutate(result, agregate = as.character(agregate))
result <- mutate(result, feature = as.character(feature))

grp <- group_by(result, subjects, activity, feature, agregate, axis)
summary <- summarize(grp, value = mean(value))
df <- data.frame(summary)
result <- spread(df, agregate, value)
        
result <- arrange(result, subjects, activity, feature, axis)


#write data