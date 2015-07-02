
#concatenate csv's 
#add name of the files
#change name to easy solution to pivot

#####New approach


#add column with filename
read_csv_filename <- function(filename, type){
      ret <- read.csv(filename)[ ,c("Email.Address", type)]
      ret$Source <- filename #EDIT
      ret$Type <- type
      ret
}

#List all email (to be added to the email/date file)
p <- list.files(directory, pattern="*.csv")

#concatenate files with only email and click
concatenateCSV <- function(directory, folder="click_activity", type="Clicks"){
      dir <- paste(directory, folder, sep = "/")
      setwd(dir)
      p <- list.files(dir, pattern="*.csv")
      data <- c()
      #loop through the file
      for (i in 1:length(p)){
            temp1 <- read.csv(p[i])
            if(nrow(temp1)!=0){
                  #import data and add column with file name
                  temp2 <- read_csv_filename(p[i], type)
                  #concatenate
                  data <- rbind(data,temp2)
                  next
            }else{
                  next
            }
      }
      names(data)[2] <- "Data"
      data
}

#read users.csv from mailchimp folder (added manually)
sanitizeUserfile <- function(filename) {
      ret <- read.csv("users.csv")[,c("id","email")]
      ret$Data <- "1"
      ret$Type <- "New"
      ret
      ret[,c("email","Data","id","Type")]
}

#Rename colum and sanitize
cleanUserfile <- function(filename){
      temp <- sanitizeUserfile(filename)
      colnames(temp)[1:4] <- c("Email.Address", "Data", "Source", "Type")
      temp 
}
    



#remove useless column
#add unique count "1" column && "Type" column

directory <- "C:/Users/Aymeric/Documents/endource/Open rate pb since 25 of may/25307411-2/aggregate_activity"
setwd(directory)
dataClicks <- concatenateCSV(getwd(), "click_activity", "Clicks")
setwd(directory)
dataOpens <- concatenateCSV(getwd(), "opened", "Opens")
setwd(directory)
dataUsers <- cleanUserfile("users.csv")

allData <- rbind(dataClicks, dataOpens, dataUsers)

#export email data into csv
write.csv(allData, "c:/Temp/0107.csv", row.names=FALSE)

#export list email
p <- list.files(paste(directory,"click_activity", sep="/"), pattern="*.csv")
write.csv(p, "c:/Temp/listallnewsletters.csv", row.names=FALSE)
