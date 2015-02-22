# Read data from 3 text files in "train" folder
x_train = read.csv("./train/X_train.txt", sep="", header=FALSE)
y_train = read.csv("./train/Y_train.txt", sep="", header=FALSE)
s_train = read.csv("./train/subject_train.txt", sep="", header=FALSE)

# Read data from 3 text files in "train" folder
x_test = read.csv("./test/X_test.txt", sep="", header=FALSE)
y_test = read.csv("./test/Y_test.txt", sep="", header=FALSE)
s_test = read.csv("./test/subject_test.txt", sep="", header=FALSE)

# Read 2nd column from "features.txt" in "UCI HAR Dataset" folder
features <- read.table("./features.txt")[,2]

# Read 2nd column from "activity_labels.txt" in "UCI HAR Dataset" folder
activity_labels <- read.table("./activity_labels.txt")[,2]

# Assign header to x_train, y_train, s_train data frames
colnames(x_train) = features
colnames(y_train) = c("Activity")
colnames(s_train) = c("Subject")

# Merge x_train, y_train, s_train into train 
train = cbind(x_train, y_train, s_train)

# Assign header to x_test, y_test, s_test data frames
colnames(x_test) = features
colnames(y_test) = c("Activity")
colnames(s_test) = c("Subject")

# Merge x_test, y_test, s_test into test 
test = cbind(x_test, y_test, s_test)

# Merge train and test into test_train_data
test_train_data = rbind(train, test)

# Generate mean and std features from features
std_mean_features <- grepl("mean|std|Mean|Std", features)

# Generate final data set consisting of std & mean features only
test_train_data_Final <- test_train_data[,std_mean_features]

# Generate tidy_data which is mean of each column in "test_train_data_final" group by Activity & Subject
tidy_data = aggregate(test_train_data_Final, by=list(test_train_data_Final$Activity, test_train_data_Final$Subject), mean)

# Drop columns Activity & Subject from tidy_data
tidy_data$Group.1 = NULL
tidy_data$Group.2 = NULL
tidy_data$Activity = NULL
tidy_data$Subject = NULL
write.table(tidy_data, file = "./tidy_data.txt",col.names=FALSE,row.names=FALSE)