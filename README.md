# Data-Cleaning-Project
Project to generate clean and tidy data from the Human Activity Recognition Using Smartphones dataset.    
See CodeBook.md for information on source data, data files read in, and output file.   

##Samsung data set
Per the instructions for the course project, the source code assumes that the Samsung data is in the working directory.     
See the CodeBook for a list of the files used.  

## Source code   

The source code    

1. loads in the library `dplyr`
2. lists the eight unzipped data text files to be read in, and makes sure that they are all in the working directory 
3. reads in the eight files to similarly named tables   
a. some of the numbers being read have scientific notations (for example -2.6050420e-002)        
The `read.table` function could read these and interpret them correctly, but the data.table `fread` function could not.    
b. to shorten the time to read in all the data files by more than 50%, nrows and colClasses were specified for each file in the each read.table function.
4. attaches activity and subject ids to the X_test and X_train data files
5. merges the two data files
6. identifies columns in `features` with mean() and std()
7. drops columns not needed in the merged file
8. prepares headings for the reduced merged file (see CodeBook for naming convention followed)
9. adds heading names to first 66 columns of reduced merged file
10. moves activity and subject ids to first two columns
11. groups the columns by activity.id and subject, and computes grouped means for all columns using the `dplyr` function `summarise_each`
12. prepares acivity names in the `variable.name` format
13. attaches activity names to the activity.ids 
14. removes the activity id column
15. adds the column name “activity” to the activity labels
16. rearranges the columns
17. sorts the table by subject then activity
18. writes resulting table to the text file `tidyData.txt`
