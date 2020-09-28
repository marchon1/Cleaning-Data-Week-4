Xtrain<-read.table("./UCI HAR Dataset/train/X_train.txt")
subtrain<-read.table("./UCI HAR Dataset/train/subject_train.txt")
Ytrain<-read.table("./UCI HAR Dataset/train/Y_train.txt")
#Xtrainbacc<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
#Ytrainbacc<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
#Ztrainbacc<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
#Xtrainbgyr<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
#Ytrainbgyr<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
#Ztrainbgyr<-read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
#Xtraintacc<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
#Ytraintacc<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
#Ztraintacc<-read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")
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

write.table(combanalysis2, row.name=FALSE)