Xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
Ytrain<-read.table("./UCI HAR Dataset/train/Y_train.txt")
features<-"./UCI HAR Dataset/features.txt"

analysis <- rbind(Ytrain, Xtrain, subtrain)
analysis <- cbind(analysis, train.or.test = "train")
colnames(analysis)<-read.table(features)

Xtest<-read.table("./UCI HAR Dataset/test/X_test.txt")
subtest<-read.table("./UCI HAR Dataset/test/subject_test.txt")
Ytest<-read.table("./UCI HAR Dataset/test/Y_test.txt")
colnames(analysis)<-read.table(features)

analysis2 <- rbind(Ytest, Xtest, subtest)
analysis2 <- cbind(analysis, train.or.test = "test")

combanalysis <- rbind(analysis, analysis2)
combanalysis2 <- combanalysis[,grepl( "-mean|-std" , names( combanalysis ))]

write.table(combanalysis2, file = "run_analysis.csv", sep=",", row.name=FALSE)