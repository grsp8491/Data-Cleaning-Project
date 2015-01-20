#Data Code Book

##Coursera Getting and Cleaning Data Project
- The purpose of the project was to collect, work with, and clean a data set.
- The data was obtained from the  Human Activity Recognition database built from the recordings of 30 subjects performing 6 activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.
- 21 subjects generated training data and 9 generated test data.
- A description of the project and data can be found at (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
- The data was downloaded from (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- 18 files containing raw inertial data were not used in this exercise
-  the remaining 8 data files are described below.

##Data files
The data files were space-delimited text files.  They were downloaded into the sub-directory “./Data” of the working directory.

The tables were then read into R, using the file names as the table names, after removing the “.txt” extensions.

|Table            |Rows |Columns|Variables|Brief description                    |
|:----------------|----:|------:|:--------|:------------------------------------|
| X_test          | 2947|    561| all num | Data for 9 test subjects            |
| X_train         | 7352|    561| all num | Data for 21 training subjects       |
| activity_labels |    6|      2| int, chr| Codes for six activities            |
| features        |  561|      2| int, chr| Column headings for data tables     |
| subject_test    | 2947|      1| int     | Mapping of 9 subjects to test data  |
| subject_train   | 7352|      1| int     | Mapping of 21 subjects to train data|
| y_test          | 2947|      1| int     | Mapping of 6 activities to test data|
| y_train         | 7352|      1| int     | Mapping of 21 activities train data |
      
The numerical variables included numbers with scientific notations (for example -2.6050420e-002).  The `read.table` function could read these and interpret them correctly, but the data.table `fread` function could not. 
