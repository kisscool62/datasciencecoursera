
# file1 is the file to be concatenated to
# file2 is the file to concatenate
# result is a file = file1 + file2
concatenate_2files <- function(file1, file2){
        dataset1 <- readLines(f1<-file(file1));close(f1)
        dataset2 <- readLines(f2<-file(file2));close(f2)
        c(dataset1, dataset2)  
}