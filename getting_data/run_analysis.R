working_directory <- 'E:\\workspace\\R\\coursera\\getting_data_project\\datasciencecoursera\\getting_data'
setwd(working_directory)


source('merge_train_and_test.R')
root_directory <- "UCI HAR Dataset"
##1. Merges the training and the test sets to create one data set.
##I prefered merging train and test files data sets into new files than merging data sets in memory because it's very long
## merge train and test files into new files
## uncomment the line below to do the job
## comment this line if you do not want to the job each time you want to do the analysis (it's to long)
#this function is in the 'merge_train_and_test.R file in the same repository

#merge_train_and_test(root_directory)

## getting variable names in features.txt
features <- read.table(paste(root_directory, paste('/', 'features.txt', sep='/'), sep='/'), header = F)
names(features) <- c('id', 'name')


## getting the data set to analyse
data_set <- 'test'

path <- paste(root_directory, paste('/', data_set, sep = ""), sep = "")

path

list.files(full.names = TRUE, path = path)

x_measurement_file_path <- paste(path, paste('/', paste(paste('X_', data_set, sep=''), '.txt', sep=''), sep=''), sep='')
y_labels_file_path <- paste(path, paste('/', paste(paste('y_', data_set, sep=''), '.txt', sep=''), sep=''), sep='')
subjects_file_path <- paste(path, paste('/', paste(paste('subject_', data_set, sep=''), '.txt', sep=''), sep=''), sep='')

file.info(x_measurement_file_path)
file.info(y_labels_file_path)

## reading tables
x_measurements <- read.table(x_measurement_file_path, header = F)
y_labels <- read.table(y_labels_file_path, header = F)
subjects <- read.table(subjects_file_path, header = F)

##3. Uses descriptive activity names to name the activities in the data set
##setting column names and adding labels and subject ids
x_measurements$labels <- y_labels
x_measurements$subjects <- subjects
##4. Appropriately labels the data set with descriptive variable names. 
names(x_measurements) <- c(as.character(features$name), 'labels', 'subjects')

wanted_features <- read.table('features.txt', header = F)
names(wanted_features) <- c('id', 'name')

##2. Extracts only the measurements on the mean and standard deviation for each measurement. 
wanted_measurements <- x_measurements[, unlist(as.character(wanted_features$name))]


