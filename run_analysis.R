library(dplyr)

#download the files
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "zipdata.zip")
unzip("zipdata.zip")

#read the files
subject_test = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subjects")
X_test = read.table("UCI HAR Dataset/test/X_test.txt")
Y_test = read.table("UCI HAR Dataset/test/Y_test.txt", col.names = "activities")

subject_train = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subjects")
X_train = read.table("UCI HAR Dataset/train/X_train.txt")
Y_train = read.table("UCI HAR Dataset/train/Y_train.txt", col.names = "activities")

features = read.table("UCI HAR Dataset/features.txt")
(X_test) = features[, 2]
colnames(X_train) = features[, 2]

#combine data together
labeltest = cbind(subject_test, Y_test)
labeltrain = cbind(subject_train, Y_train)
test = cbind(labeltest, X_test)
train = cbind(labeltrain, X_train)#

#all the data with labels
dataset = rbind(train, test)

#extract the means and stds
means = dataset[, grep("mean", colnames(dataset))]
stds = dataset[, grep("std", colnames(dataset))]
meansandstds = cbind(dataset[, 1:2], means) %>% cbind(stds)

#rename the activities
meansandstds$activities = gsub("1", "walking", meansandstds$activities)
meansandstds$activities = gsub("2", "walking_upstairs", meansandstds$activities)
meansandstds$activities = gsub("3", "walking_downstairs", meansandstds$activities)
meansandstds$activities = gsub("4", "sitting", meansandstds$activities)
meansandstds$activities = gsub("5", "standing", meansandstds$activities)
meansandstds$activities = gsub("6", "laying", meansandstds$activities)

#creates a second, independent tidy data set with the average of each variable for each activity and each subject.
averages = meansandstds %>% group_by(subjects, activities) %>% summarize_all(mean)

#write the new dataset to a new file
write.table(averages, file = "averages_for_subjects_activities.txt", row.names = F)