
#concatenate csv's 
#add name of the files
#change name to easy solution to pivot

#####New approach


#add column with filename
read_csv_filename <- function(filename, type){
      ret <- read.csv(filename)[ ,c("Email.Address", type)]
      ret$Source <- filename #EDIT
      ret$Data <- type
      ret
}

p <- list.files(pattern="*.csv")

#concatenate files with only email and click
concatenate <- function(directory, folder="click_activity", type="Clicks"){
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
      setwd(directory)
}


setwd("C:/Users/Aymeric/Documents/endource/cohort/25307411/aggregate_activity")
dataClicks <- concatenate(getwd(), "click_activity", "Clicks")
dataOpens <- concatenate(getwd(), "opened", "Opens")

#export into xls
write.csv(dataClick, "c:/Temp/clickData.csv", row.names=FALSE)

setwd("C:/Users/Aymeric/Documents/endource/cohort/25307411/aggregate_activity/opened")
dataOpen <- concatenateOpen(getwd())


#export into xls
write.csv(dataOpen, "c:/Temp/opendata.csv", row.names=FALSE)
