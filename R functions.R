
#concatenate csv's 
#add name of the files
#change name to easy solution to pivot

#####New approach


#add column with filename
read_csv_filenameClick <- function(filename){
      ret <- read.csv(filename)[ ,c('Email.Address', 'Clicks')]
      ret$Source <- filename #EDIT
      ret
}

p <- list.files(pattern="*.csv")

#concatenate files with only email and click
concatenateClick <- function(directory){
      p <- list.files(directory, pattern="*.csv")
      data <- c()
      #loop through the file
      for (i in 1:length(p)){
            temp1 <- read.csv(p[i])
            if(nrow(temp1)!=0){
                  #import data and add column with file name
                  temp2 <- read_csv_filenameClick(p[i])
                  #concatenate
                  data <- rbind(data,temp2)
                  next
            }else{
                  next
            }
      }
      data
}

#add column with filename
read_csv_filenameOpens <- function(filename){
      ret <- read.csv(filename)[ ,c('Email.Address', 'Opens')]
      ret$Source <- filename #EDIT
      ret
}

#concatenate files with only email and click
concatenateOpen <- function(directory){
      p <- list.files(directory, pattern="*.csv")
      data <- c()
      #loop through the file
      for (i in 1:length(p)){
            temp1 <- read.csv(p[i])
            if(nrow(temp1)!=0){
                  #import data and add column with file name
                  temp2 <- read_csv_filenameOpens(p[i])
                  #concatenate
                  data <- rbind(data,temp2)
                  next
            }else{
                  next
            }
      }
      data
}



setwd("C:/Users/Aymeric/Documents/endource/cohort/25307411/aggregate_activity/click_activity")
dataClick <- concatenateClick(getwd())

#export into xls
write.csv(dataClick, "c:/Temp/clickData.txt", row.names=FALSE)

setwd("C:/Users/Aymeric/Documents/endource/cohort/25307411/aggregate_activity/opened")
dataOpen <- concatenateOpen(getwd())


#export into xls
write.csv(dataOpen, "c:/Temp/opendata.txt", row.names=FALSE)
