
#to be run in parent directory as workspace
library('RUnit')

source('concatenate_2files.R')

should_merge_two_files_test <- function(){
        f1 <- file('test/dataset1.test')
        f2 <- file('test/dataset2.test')
        file1 <- readLines(f1)
        file2 <- readLines(f2)
        close(f1)
        close(f2)
        
        merged_file <- concatenate_2files('test/dataset1.test', 'test/dataset2.test')
        
        checkEquals(length(file1) + length(file2), length(merged_file))
}



