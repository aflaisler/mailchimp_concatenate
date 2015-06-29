
#concatenate csv's 
#add name of the files
#change name to easy solution to pivot

#####New approach


#add column with filename
read_csv_filename <- function(filename, type){
      ret <- read.csv(filename)[ ,c("Email.Address", type)]
      ret$Source <- filename #EDIT
      ret$DataType <- type
      ret
}

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
      data
}

#concatenate to dataframe
concatenate <- function(set1, set2){
      for (i in length(set1)){
            
      }
}

directory <- "C:/Users/Aymeric/Documents/endource/cohort/25307411/aggregate_activity"
setwd(directory)
dataClicks <- concatenateCSV(getwd(), "click_activity", "Clicks")
setwd(directory)
dataOpens <- concatenateCSV(getwd(), "opened", "Opens")

allData <- rbind(dataClicks, dataOpens)

#export into xls
write.csv(dataClicks, "c:/Temp/emailData.csv", row.names=FALSE)
