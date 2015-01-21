library(dplyr)

#  check working directory and change if needed to directory where files are
#  see code book for list of unzipped text files used in this project 

#  create list of files in the working directory

tempfiles = list.files(pattern="*.txt")

#  load in all data files, using file names for the table names after removing the ".txt" extensions

for (i in 1:length(tempfiles)) {
  assign(sub(".txt", "", tempfiles[i]), 
         read.table(tempfiles[i], stringsAsFactors=FALSE))
}

#  add subject and activity codes to data files

X_test$subject  <- subject_test$V1
X_test$activity <- y_test$V1

X_train$subject <- subject_train$V1
X_train$activity <- y_train$V1

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

#  make names more R friendly

new.features$V2 <- gsub("-", ".", new.features$V2)
new.features$V2 <- sub("\\(\\)", "", new.features$V2)
new.features$V2 <- sub("^t", "t.", new.features$V2)
new.features$V2 <- sub("^f", "f.", new.features$V2)

#  add heading to first 66 columns of reduced merged file

colnames(merged.file.reduced)[1:66] <- new.features$V2

#  move subject and activity IDs to first two columns

merged.file.reduced <- merged.file.reduced[, c(67, 68, 1:66)]

#  compute means for all columns using dplyr

tidy.data <- merged.file.reduced %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean)) %>%
  arrange(subject, activity)

#  prepare activity names

activity_labels$V2 <- tolower(gsub("_", ".", activity_labels$V2))

#  attach activity names to activities, rearrange columns, and sort by subject and activity

tidy.data <- merge(tidy.data, activity_labels, by.x="activity", by.y="V1", all=TRUE)
tidy.data$activity <- NULL
colnames(tidy.data)[68] <- "activity"
tidy.data <- arrange(tidy.data[, c(1, 68, 2:67)], subject, activity)

# write data to text file

write.table(tidy.data, file="tidyData.txt", row.names=FALSE)



