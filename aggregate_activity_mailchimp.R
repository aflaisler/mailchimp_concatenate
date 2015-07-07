
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
      setwd("..")
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
      setwd("..")
      temp <- sanitizeUserfile(filename)
      colnames(temp)[1:4] <- c("Email.Address", "Data", "Source", "Type")
      temp 
}
    



#remove useless column
#add unique count "1" column && "Type" column

directory <- "C:/Users/Aymeric/Documents/endource/cohort/25307411-2/aggregate_activity"
setwd(directory)
#get clicked email data
dataClicks <- concatenateCSV(getwd(), "click_activity", "Clicks")
#get opened email data
dataOpens <- concatenateCSV(getwd(), "opened", "Opens")
#get new user data
dataUsers <- cleanUserfile("users.csv")

allData <- rbind(dataClicks, dataOpens, dataUsers)

#export email data into csv
extract_Name <- paste("c:/Temp/aggregate_mailchimp_data",
                      format(Sys.Date(),"%d%m%y"),".csv",sep="_")
write.csv(allData, extract_Name, row.names=FALSE)

#export list email
p <- list.files(paste(directory,"click_activity", sep="/"), pattern="*.csv")
write.csv(p, "c:/Temp/listallnewsletters.csv", row.names=FALSE)
