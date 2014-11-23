
source('concatenate_2files.R')

#returns a list of files from root directory
list_directory <- function(root) {
        files <- list.files(full.names = TRUE, root, recursive = TRUE)
        files
}

list_expected_files <- function(files, search){
        filtered_files_indexes <- grep(pattern=search, x=files)
        
        filtered_files <- vector()
        
        for(filtered_file_index in filtered_files_indexes){
                filtered_files <- c(filtered_files, files[filtered_file_index])
        }
        filtered_files
}

#returns a vector with first element train files, second elements test files
list_train_and_test_files <- function(root){
        files <- list_directory(root)
        print(files)
        
        train_files <- list_expected_files(files, 'train')        
        test_files <- list_expected_files(files, 'test')        
        
        result <- c(train_files, test_files)
        
        dim(result) <- c(length(train_files), 2)
        result
}

##merge train and test data sets into new files in out directory
merge_train_and_test <- function(root){
        train_and_test_files <- list_train_and_test_files(root)
        train_files <- train_and_test_files[,1]
        test_files <- train_and_test_files[,2]
        for(i in 1:length(train_files)){
                train_file <- train_files[i]    
                test_file <- test_files[i]
                
                if(identical(train_file, gsub(pattern="test", x = test_file, replacement <- "train"))){
                        merged_file_lines <- concatenate_2files(train_file, test_file)
                        file_name <- gsub(pattern="train", x = train_file, replacement <- "out")
                        merged_file_conn <- file(open = 'w', file_name)
                        writeLines(merged_file_lines, merged_file_conn)
                        close(merged_file_conn)
                        
                }else{
                        warning("train files and test_files are different ", train_file, test_file)
                }
        }
}


