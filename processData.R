freTrack <- read.table("out1.txt",header=FALSE,sep=" ")
freTrack <- freTrack[,2:5]

MaritalStatus <- c()
MaritalStatus <- sample(1:3,size=nrow(freTrack),replace=TRUE)
MaritalStatus[MaritalStatus==1] <- "single"
MaritalStatus[MaritalStatus==2] <- "married"
MaritalStatus[MaritalStatus==3] <- "divorced"
MaritalStatus <- data.frame(MaritalStatus)
freTrack <- cbind(MaritalStatus,freTrack)

Age <- randgen(106,32)
Age <- Age[,1]
Age <- data.frame(Age)
freTrack <- cbind(Age,freTrack)

Gender <- sample(1:2,size=nrow(freTrack),replace=TRUE)
Gender[Gender==1] <- "male"
Gender[Gender==2] <- "female"
Gender <- data.frame(Gender)
freTrack <- cbind(Gender,freTrack)
names(freTrack)[4:7] <- c("lat1","lon2","lat2","lon2")
