#Concatenate in line

filename <- "C:/Users/Aymeric/Downloads/Sizing Machine Learning Chart - Sheet1.csv"


transposeSize <- function(filename){
      ret1 <- read.csv(filename, header=T)[,c(1:15)]
      ret2 <- read.csv(filename, header=F)[-1,c(16:52)]
      #size of the final table
      n <- nrow(ret1)
      data1 <- c()
      data2 <- c()
      #loop by row
      for(i in 1:n){

            if(ret2[i,1] != ""){
                  data1 <- lineSize(ret1, ret2, i)
                  data2 <- rbind (data2, data1)
                  next
            }else{
                  next
            }
      }
      data2
}


lineSize <- function(tableProduct, tableSize, row){
      data <- c()
      #number of column non null by row
      m <- rowSums(tableSize[row,] != "")
      #loop in the size
      for(j in 1:m){
            ret <- tableProduct[row,]
            ret$Size <- tableSize[row,j]
            data <- rbind(data, ret)
      }
      data
}

write.csv(final1, "c:/temp/SizeByProduct.csv", row.names=FALSE)
