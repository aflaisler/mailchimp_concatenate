
#add column with filename
read_csv_filename_granular <- function(filename, type){
      ret <- read.csv(filename, header=F)[-1,c(1,3)]
      colnames(ret)[1:2] <- c("Timestamp", "email")
      ret$Source <- filename #EDIT
      ret$Type <- type
      unique(ret)
      ret
}


#concatenate files with only email and click
concatenateCSV_granular <- function(directory, folder="clicks", type="Clicks"){
      dir <- paste(directory, folder, sep = "/")
      setwd(dir)
      p <- list.files(dir, pattern="*.csv")
      data <- c()
      #loop through the file
      for (i in 1:length(p)){
            temp1 <- read.csv(p[i], header=F)[,c(1,2)]
            if(nrow(temp1)!=1){
                  #import data and add column with file name
                  temp2 <- read_csv_filename_granular(p[i], type)
                  #concatenate
                  data <- rbind(data,temp2)
                  next
            }else{
                  next
            }
      }
      names(data)[4] <- "Data"
      data
}


#read users.csv from mailchimp folder (added manually)
sanitizeUserfile <- function(filename) {
      ret <- read.csv("users.csv")[,c("id","email","dateCreated")]
      #ret$Data <- "1"
      ret$Type <- "New"
      ret
      ret[,c("dateCreated", "email","id","Type")]
}

#Rename colum and sanitize
cleanUserfile <- function(filename){
      temp <- sanitizeUserfile(filename)
      colnames(temp)[1:4] <- c("Timestamp","email", "Source", "Data")
      temp 
}

#remove useless column
#add unique count "1" column && "Type" column

directory <- "C:/Users/Aymeric/Documents/endource/Open rate pb since 25 of may/25307411-2/granular_activity"
setwd(directory)
dataClicks <- concatenateCSV_granular(getwd(), "clicks", "Clicks")
setwd(directory)
dataOpens <- concatenateCSV_granular(getwd(), "opens", "Opens")
setwd(directory)
dataUsers <- cleanUserfile("users.csv")

allData <- rbind(dataClicks, dataOpens, dataUsers)

#export email data into csv
write.csv(allData, "c:/Temp/granular_mailchimp_data.csv", row.names=FALSE)

#export list email
p <- list.files(paste(directory,"clicks", sep="/"), pattern="*.csv")
write.csv(p, "c:/Temp/listallnewsletters.csv", row.names=FALSE)
