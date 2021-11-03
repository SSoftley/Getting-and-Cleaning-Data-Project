##### INSTRUCTIONS
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##### CODE

library(dplyr)

##1.
X_1<-read.table("UCI HAR Dataset/train/X_train.txt")
X_2<-read.table("UCI HAR Dataset/test/X_test.txt")
X<-add_row(X_1,X_2)

## 2.
features<-read.table("UCI HAR Dataset/features.txt")
features_selected<-filter(features, grepl('mean',V2) | grepl('std',V2))
DF<-select(X, features_selected[,1])

##3.and 4.
features_clean<-gsub("[()]","",features_selected[,2]) #Remove ()
names(DF)<-features_clean

##5.
#Add subject
S_1<-read.table("UCI HAR Dataset/train/subject_train.txt")
S_2<-read.table("UCI HAR Dataset/test/subject_test.txt")
subject<-add_row(S_1,S_2)
names(subject)<-"Subject"

#Add activities
y_1<-read.table("UCI HAR Dataset/train/y_train.txt")
y_2<-read.table("UCI HAR Dataset/test/y_test.txt")
y<-add_row(y_1,y_2)
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")

#Add both to data
DF<-mutate(subject,"Activity"=activity_labels[y[,1],2], DF)

#Summarise mean by activity and subject
DF_group<-group_by(DF, Subject, Activity)
summary<-summarise_all(DF_group, mean)
write.table(summary, "output.txt",row.name=FALSE)
