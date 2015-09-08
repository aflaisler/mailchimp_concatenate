#Concatenate in line

filename <- "C:/Users/Aymeric/Downloads/Sizing Machine Learning Chart - Sheet1.csv"

#Number of column
findColumnNumber <- function(filename){
      ret <- read.csv(filename, header=F)[-1,c(16:36)]
      n <- length(ret)
      for(i in 1:n){
            #transpose size information
            temp1 <- as.data.frame(!is.null(ret[2,]))
            data <- rbind(data,temp1)            
      }
   
}

i=1
j=16

readFilenameGranular <- function(filename, type){
      ret <- read.csv(filename, header=F)[-1,c(1,3)]
      colnames(ret)[1:2] <- c("Timestamp", "email")
      ret$Source <- filename #EDIT
      ret$Type <- type
      unique(ret)
      ret
      ret[,c("email", "Timestamp", "Source", "Type")]
}


transposeSize <- function(filename){
      ret1 <- read.csv(filename, header=T)[,c(1:15)]
      ret2 <- read.csv(filename, header=F)[,c(16:32)]
      
      n <- length(ret1)
      data1 <- c()
      data2 <- c()
      #loop by row
      for(i in 1:n){
            #number of column non null by row
            m <- rowSums(ret2[i,] != "")
            #loop in the size
            for(j in 1:m){
                  ret <- ret1[i,]
                  ret$Size <- ret2[i,j]
                  data1 <- rbind(data1, ret)
                  next
            }
            next
      }
      data2 <- rbind (data2, data1)
      data2
}

lineSize <- function(line){
      #number of column non null by row
      m <- rowSums(line[1,] != "")
      #loop in the size
      for(j in 16:m){
            ret <- ret1[i,]
            ret$Size <- ret2[i,j]
            data1 <- rbind(data1, ret)
            next
      }
}

readFilenameGranular <- function(filename, type){
      ret <- read.csv(filename, header=F)[-1,c(1,3)]
      colnames(ret)[1:2] <- c("Timestamp", "email")
      ret$Source <- filename #EDIT
      ret$Type <- type
      unique(ret)
      ret
      ret[,c("email", "Timestamp", "Source", "Type")]
}

as.data.frame(t(ret[1,]))

d <- d[!is.na(d)]
              
ret2 <- apply(ret2, 2, function(x) gsub("^$|^ $", NA, x))