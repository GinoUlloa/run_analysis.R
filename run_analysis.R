features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Z <- rbind(subject_train, subject_test)
data <- cbind(Z,Y,X)

tidydata <- data %>% select(subject, code, contains("mean"), contains("std"))
tidydata$code <- activities[tidydata$code, 2]
names(tidydata)[2] = "activity"
final-data <- tidydata %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(final-data, "final-data.txt", row.name=FALSE)
