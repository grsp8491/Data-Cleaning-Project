#Data Code Book

##Coursera Getting and Cleaning Data Project

- The purpose of the project was to collect, work with, and clean a data set.
- The data was obtained from the  Human Activity Recognition database built from the recordings of 30 subjects performing 6 activities of daily living while carrying a waist-mounted smartphone with embedded inertial sensors.
- 21 subjects generated training data and 9 generated test data.
- A description of the project and data can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- The data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
- 18 files containing raw inertial data were not used in this exercise
-  the remaining 8 data files are described below.

##Data files

The data files were space-delimited text files.  They were downloaded into the working directory.

The tables were then read into R, using the file names as the table names, after removing the “.txt” extensions.

|Table            |Rows |Columns|Variables|Brief description                    |
|:----------------|----:|------:|:--------|:------------------------------------|
| X_test          | 2947|    561| all num | Data for 9 test subjects            |
| X_train         | 7352|    561| all num | Data for 21 training subjects       |
| y_test          | 2947|      1| int     | Mapping of 6 activities to test data|
| y_train         | 7352|      1| int     | Mapping of 6 activities train data |
| subject_test    | 2947|      1| int     | Mapping of 9 subjects to test data  |
| subject_train   | 7352|      1| int     | Mapping of 21 subjects to train data|
| activity_labels |    6|      2| int, chr| Avtivity names          |
| features        |  561|      2| int, chr| Column headings for data tables     |

      
The numerical variables included numbers with scientific notations (for example -2.6050420e-002).
The `read.table` function could read these and interpret them correctly, but the data.table `fread` function could not. 

##Naming convention

Where possible, the R source code, activity, and column names follow [Google’s R Style Guide]( https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml)
Google prefers names to be in the style `variable.name`, though accepts camel case `variableName` as an alternative. 
Where names consist of many components, for example the column names in the output file, a mixture of the two styles was used, as one style alone would be more difficult to read.
For example, the column name `fBodyAcc-mean()-X` has five components.  In the tidy data set this was changed to `f.BodyAcc.mean.X`, using a mixture of the two styles.

##Output file

Name	       tidyData.txt    
Space delimited    
Rows           180 (30 subjects x 6 activities each)    
Columns     68    

|Column    |Name| Variable type|Description|
|----------:|:------|:----------------|:------------|
|1                 |subject|integer  | 1 to 30 subjects, each with 6 activities|
| 2         |activity  |character   |six activity names repeated for each subject|
|3 to 68|various mean and std  headings|numerical|means of the mean and std numbers|

