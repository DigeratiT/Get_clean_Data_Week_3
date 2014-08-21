#Creates one R script called run_analysis.R that does the following. 

#Reads the data into R and merges the training and the test sets to create one data set. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 

setwd("D://Classes/03 Getting and Cleaning Data/UCI HAR Dataset")
library(data.table)

activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")

x_train <- read.table("train/X_train.txt")
x_test <- read.table("test/X_test.txt")
x <- rbind(x_train, x_test)
names(x)<-features$V2
str(x)

y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")
y <- rbind(y_train, y_test)
y_merged<-merge(y, activity_labels, by.y="V1", by.activity_lables="V1", all=FALSE)
names(y_merged) = c("Activity_ID", "Activity_Label")

subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
subject <- rbind(subject_train, subject_test)
names(subject)="Subject_ID"

#Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_std <- grep(".*mean().*|.*std().*", features[,2])
features_select <- features[mean_std,]
x_select <- x[,mean_std]

#Merges selected mean/std features, activity and subject datasets into one dataset
combined_mean_std<-cbind(subject,y_merged,x_select)

 
#Creates a second, independent tidy data set with the average of each variable for each 
#activity and each subject. 


combined_tbl<- data.table(combined_mean_std)
final_mean<- combined_tbl[, lapply(.SD, mean), by=c("Subject_ID", "Activity_ID")]


#Exports data into a comma-separated txt file.
write.table(final_mean, "final_mean.txt", sep=",", row.name=FALSE)
