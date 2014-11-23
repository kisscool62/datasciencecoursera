setwd('E:/workspace/R/coursera/getting_data_project/datasciencecoursera/getting_data/')

source('merge_train_and_test.R')
library('RUnit')

should_list_directory_test <- function(){
        files <- list_directory('UCI HAR Dataset')
        
        test_files <- grep('test', files)
        train_files <- grep('train', files)
        
        print(test_files)
        print(train_files)
        print(length(test_files))
        print(length(train_files))
        checkEquals(length(test_files), length(train_files))
        checkEquals(test_files, train_files)
        
}

should_corelate_train_and_test_files_test <- function(){
        print(list_train_and_test_files())
}


#should_list_directory_test()
#should_corelate_train_and_test_files_test()

should_list_train_and_test_files_test <- function(){
        files <- list_train_and_test_files()   
        print(files)
        
        transformed_test_files <- gsub(pattern='test', replacement = 'train', files[,2])
        print("files train")
        print(files[,1])
        print("files test")
        print(files[,2])
        print("full data frame")
        print(transformed_test_files)
        print("train files == transformed test files?")
        checkEquals(target=files[,1], current = transformed_test_files)
}

#should_list_train_and_test_files_test()

should_create_output_file_name <- function(){
        print(gsub(pattern="train", x = "train_supetrainfichier_train.txt", replacement <- "out"))
        
}

#merge_train_and_test("UCI HAR Dataset")

