
#add column with filename
read_csv_filename_granular <- function(filename, type="clicks"){
      ret <- read.csv(filename, header=F)[ ,c(1,3)]
      colnames(ret)[1:2] <- c("Timestamp", "email")
      ret$Source <- filename #EDIT
      ret$Type <- type
      ret
}


#concatenate files with only email and click
concatenateCSV <- function(directory, folder, type="clicks"){
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