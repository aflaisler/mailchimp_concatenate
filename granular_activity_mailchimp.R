
#add column with filename
read_csv_filename_granular <- function(filename, type){
      ret <- read.csv(filename, header=F)[-1,c(1,3)]
      colnames(ret)[1:2] <- c("Timestamp", "email")
      ret$Source <- filename #EDIT
      ret$Type <- type
      unique(ret)
      ret
      ret[,c("email", "Timestamp", "Source", "Type")]
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
      setwd("..")
      names(data)[4] <- "Data"
      data
}


#read users.csv from mailchimp folder (added manually)
sanitizeUserfile <- function(filename) {
      ret <- read.csv("users.csv")[,c("id","email","dateCreated")]
      #ret$Data <- "1"
      ret$Type <- "New"
      ret
      ret[,c("email", "dateCreated", "id", "Type")]
}


#Rename colum and sanitize
cleanUserfile <- function(filename){
      setwd("..")
      temp <- sanitizeUserfile(filename)
      colnames(temp)[1:4] <- c("email","Timestamp", "Source", "Data")
      temp 
}


directory <- "C:/Users/Aymeric/Documents/endource/cohort/25307411-6/granular_activity"



#function to run all the commands
Granular_Activity_Data <- function(directory="C:/Users/Aymeric/Documents/endource/cohort/25307411-6/granular_activity"){
      setwd(directory)
      #get clicked email data
      dataClicks <- concatenateCSV_granular(getwd(), "clicks", "Clicks")
      #get opened email data
      dataOpens <- concatenateCSV_granular(getwd(), "opens", "Opens")
      #get new user data
      dataUsers <- cleanUserfile("users.csv")
      #concatenate all data
      allData <- rbind(dataClicks, dataOpens, dataUsers)
      
      #export email data into csv
      extract_Name <- paste("c:/Temp/granular_mailchimp_data",
                            format(Sys.Date(),"%d%m%y"),".csv",sep="_")
      write.csv(allData, extract_Name, row.names=FALSE)
}


#Test1 number of rows need to be sum of all files' rows
Test1_Granular_Activity <- function(directory){ 
      setwd(directory)
      dataClicks <- concatenateCSV_granular(getwd(), "clicks", "Clicks")
      dataOpens <- concatenateCSV_granular(getwd(), "opens", "Opens")
      dataUsers <- cleanUserfile("users.csv")      
      extract_Name <- paste("c:/Temp/granular_mailchimp_data",
                            format(Sys.Date(),"%d%m%y"),".csv",sep="_")
      test1_post <- nrow(read.csv(extract_Name))
      
      test1_pre <- (nrow(dataClicks)+nrow(dataOpens)+nrow(dataUsers))
      
      if(test1_post==test1_pre){
            print("Passed")
      }else{
            print("Failed")
      }
}

#test2  check 1st col only contain emails

#test3 check 3rd col only contains "Clicks", "Opens", "New"



