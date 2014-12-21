## just to run run_analysis.R


working_directory <- '/Users/pascalauregan/workspace/r/coursera/03_getting_data/datasciencecoursera/getting_data'
setwd(working_directory)

source('run_analysis.R')


#write data

write.table(x = tidy_data_set, file = 'tidy_data_set.txt', row.names=FALSE)
write.table(x = tidy_data_set, file = 'tidy_data_set.csv', row.names=FALSE, sep = ',')

