library(dplyr)

#  Per the instructions for the course project, the Samsung data must be in your working directory.
#  Please check your working directory and change it if needed to the directory where the Samsung files are.
#  See the accompanying code book for the list of the eight unzipped data text files used in this project. 

#  Create list of the eight files needed

FilesNeeded <- list("X_test.txt", "X_train.txt",  "y_test.txt", "y_train.txt",
"subject_test.txt", "subject_train.txt", "activity_labels.txt", "features.txt")

#  Create list of text files in the working directory

DirFiles = list.files(pattern="*.txt")


#  Check that all FilesNeeded are in DirFile and, if so, read in.
#  For faster reading, nrows and colClasses have been specified.

msg <- "One or more Samsung data files does not appear to be in your working directory.\n
Please check to make sure all eight files are there."

if(!all(FilesNeeded %in% DirFiles)) {
  stop(msg)
} else {  
  X_test <- read.table("X_test.txt", stringsAsFactors=FALSE, nrows=2950, colClasses="numeric")
  X_train <- read.table("X_train.txt", stringsAsFactors=FALSE, nrows=7360, colClasses="numeric")
  y_test <- read.table("y_test.txt", stringsAsFactors=FALSE, nrows=2950, colClasses="integer")
  y_train <- read.table("y_train.txt", stringsAsFactors=FALSE, nrows=7360, colClasses="integer")
  subject_test <- read.table("subject_test.txt", stringsAsFactors=FALSE, nrows=2950, colClasses="integer")
  subject_train <- read.table("subject_train.txt", stringsAsFactors=FALSE, nrows=7360, colClasses="integer")
  activity_labels <- read.table("activity_labels.txt", stringsAsFactors=FALSE, nrows=6, colClasses=c("integer", "character"))
  features <- read.table("features.txt", stringsAsFactors=FALSE, nrows=561, colClasses=c("integer", "character"))  
}


#  add activity and subject codes to data files

X_test$activity.id <- y_test$V1
X_test$subject  <- subject_test$V1

X_train$activity.id <- y_train$V1
X_train$subject <- subject_train$V1


#  merge data files

merged.file <-tbl_df(rbind(X_test, X_train))


#  identify columns with mean() and std()

mean.stdev.cols <- grep("(mean|std)\\(\\)", features$V2)

# check number of columns to be retained

length(mean.stdev.cols)

# drop columns not needed

merged.file.reduced <- merged.file[, c(mean.stdev.cols, 562, 563)]

#  prepare headings for merged.file.reduced

new.features <- features[mean.stdev.cols,]

#  make names more R friendly (see accompanying CodeBook and README for explanation of naming convention)

new.features$V2 <- gsub("-", ".", new.features$V2)
new.features$V2 <- sub("\\(\\)", "", new.features$V2)
new.features$V2 <- sub("^t", "t.", new.features$V2)
new.features$V2 <- sub("^f", "f.", new.features$V2)

#  add heading to first 66 columns of reduced merged file

colnames(merged.file.reduced)[1:66] <- new.features$V2

#  move activity.id and subject IDs to first two columns

merged.file.reduced <- merged.file.reduced[, c(67, 68, 1:66)]

#  compute means for all columns using dplyr

tidy.data <- merged.file.reduced %>%
  group_by(activity.id, subject) %>%
  summarise_each(funs(mean))  

#  prepare activity names

activity_labels$V2 <- tolower(gsub("_", ".", activity_labels$V2))

#  attach activity names to activity.ids, rearrange columns, and sort by subject and activity

tidy.data <- merge(tidy.data, activity_labels, by.x="activity.id", by.y="V1", all=FALSE)
tidy.data$activity.id <- NULL
colnames(tidy.data)[68] <- "activity"
tidy.data <- arrange(tidy.data[, c(1, 68, 2:67)], subject, activity)

# write data to text file

write.table(tidy.data, file="tidyData.txt", row.names=FALSE)



