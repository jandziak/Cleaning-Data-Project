#The used for assignment represent data collected from the accelerometersfrom the Samsung Galaxy S smartphone. 
#Description of the data availiable is in File README.md and at the site where the data was obtained: 
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#loading url to set, subject and activity labels index files
url.train <- "./UCI HAR Dataset/train/subject_train.txt"
url.test <- "./UCI HAR Dataset/test/subject_test.txt"
url.train.set <- "./UCI HAR Dataset/train/X_train.txt"
url.test.set <- "./UCI HAR Dataset/test/X_test.txt"
url.train.labels <- "./UCI HAR Dataset/train/y_train.txt"
url.test.labels <- "./UCI HAR Dataset/test/y_test.txt"

#raeding data for set subject and activity label index
data.train.subject <- read.table(url.train)
data.test.subject <- read.table(url.test)

data.train.set <- read.table(url.train.set)
data.test.set <- read.table(url.test.set)

data.train.labels <- read.table(url.train.labels)
data.test.labels <- read.table(url.test.labels) 

#binding the data with the subject and activity label index
data.test <- cbind(data.test.subject,data.test.labels,data.test.set)
data.train <- cbind(data.train.subject,data.train.labels,data.train.set)

#merging test and train data (Course project 1st excercise)
data <- rbind(data.test,data.train)

#Attaching descriptive activity names to name the activities in the data set(Course project 3th excercise)
url.features <- "./features.txt"
data.features <- read.table(url.features)
temp.features <- data.frame(V1 = c(0,0), V2 = c("Subject","Activity"))
data.features <- rbind(temp.features,data.features)
names(data) <- data.features[,2]

#Data labeling with descriptive variable names. (Course project 4th excercise)
url.activity.names <- "./activity_labels.txt"
activity.names <- read.table(url.activity.names)
data$Activity <- activity.names[data$Activity,2]

#extracting index of columns with mean and standard deviation (Course project 2nd excercise)
mean.index <- which(sapply(strsplit(as.character(names(data)), "\\-"), "[", 2)=="mean()")
std.index <- which(sapply(strsplit(as.character(names(data)), "\\-"), "[", 2)=="std()")
data <- data[,c(1,2,mean.index,std.index)]

#Function evalFun is used to evaluate basic functions for each variable for each activity and each subject. 
#Helpful function to obtain set mentioned in Course project 5th excercise
evalFun <- function(data, fun = mean, ...){
   data.partition <- split(data[,c(-1,-2)],interaction(data$Activity, data$Subject))
   results <- numeric(length(data)-2)
   for (i in names(data.partition)){
      data.observation <- eval(parse(text = paste("data.partition",i ,sep = "$")))
      temp.eval.fun <- lapply(data.observation, fun)
      results <- rbind(results, temp.eval.fun)
   
   }
   results <- results[-1,]
   row.names(results) <- NULL
   Activity <- sapply(strsplit(as.character(names(data.partition)), "\\."), "[", 1)
   Subject <- sapply(strsplit(as.character(names(data.partition)), "\\."), "[", 2)
   results <- cbind(Activity,Subject,results)
   #results <- data.frame(results)
   return(results)
}

#Exemple uses of function evalFun.
sd.eval.data <- evalFun(data, sd)
var.eval.data <- evalFun(data, function(x) sum(x^3)/sum(x)^3)

#Preparation of tidy data for 5th exercise
mean.eval.data <- evalFun(data)
#saving tidy data set to file tidydata_mean.txt
write.table(mean.eval.data,"tidydata_mean.txt.txt",row.name=FALSE)
