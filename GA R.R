#install dev tool to use GA in R
install.packages("devtools")

install.packages("httpuv")
install.packages("curl")
library(devtools,httpuv,curl)

#install stringi
#install.packages("stringi")
library(stringi)

#install the github repo  to use GA API v3 (made by Googlers)
#install.packages("RGoogleAnalytics")
#install_github("Tatvic/RGoogleAnalytics")
library(RGoogleAnalytics)

#This is another repo with more stars
#install_github("skardhamar/rga")
#library(rga)



save(token,file="./token_file")
load("./token_file")
ValidateToken(token)

#user_id
query.list <- Init(start.date = "2014-03-01",
                   end.date = "2015-08-31",
                   dimensions = "ga:yearWeek, ga:dimension14",
                   metrics = "ga:sessions",
                   max.results = 25000,
                   #sort = "-ga:date",
                   #samplingLevel="HIGHER_PRECISION",
                   table.id = "ga:104115317")

query.list <- Init(start.date = "2015-04-01",
                   end.date = "2015-07-27",
                   dimensions = "ga:date",
                   metrics = "ga:sessions",
                   max.results = 20000,
                   #sort = "-ga:date",
                   #samplingLevel="HIGHER_PRECISION",
                   table.id = "ga:79040929")

# Create the Query Builder object so that the query parameters are validated
ga.query <- QueryBuilder(query.list)

# Extract the data and store it in a data-frame
ga.data <- GetReportData(ga.query, token,  paginate_query = T)


#Convert date (first column)
ga.data[,1] <- as.Date(ga.data[,1], "%Y%m%d")
ga.data[,1] <- format(ga.data[,1], "%d/%m/%Y")


#export email data into csv
extract_name <- paste("c:/Temp/GA_traffic",
                      format(Sys.Date(),"%d%m%y"),".csv",sep="_")
write.csv(ga.data, extract_name, row.names=FALSE)

#effectiveness of campaigns

ValidateToken(token)


query.list <- Init(start.date = "2015-06-01",
                   end.date = "2015-08-04",
                   dimensions = "ga:date",
                   metrics = "ga:goal1Completions",
                   segment = "users::condition::ga:userType==New Visitor;dateOfSession<>2015-06-15_2015-06-30;ga:campaign=@35-44;perSession::ga:goal1Completions>0",
                   max.results = 10000,
                   table.id = "ga:79040929")


# Create the Query Builder object so that the query parameters are validated
ga.query <- QueryBuilder(query.list)

# Extract the data and store it in a data-frame
ga.data <- GetReportData(ga.query, token,  paginate_query = F)

#export email data into csv
extract_name <- paste("c:/Temp/GA_traffics",
                      format(Sys.Date(),"%d%m%y"),".csv",sep="_")
write.csv(ga.data, extract_name, row.names=FALSE)
