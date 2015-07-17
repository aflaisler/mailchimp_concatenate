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

token <- Auth("759932251705-1nbssfv67nbgs04lb5lnonpo535bh928.apps.googleusercontent.com",
              "RD2tu63SwZF2jrCab3QUVkIJ")

token2 <- Auth("535373914577-eslikeemn0snd94rn3tt2708movf9e9b.apps.googleusercontent.com",
               "WiZHQvgWjQHegsfCyEwmOm4z")


save(token2,file="./token_file")
load("./token_file")
ValidateToken(token2)


query.list <- Init(start.date = "2014-04-01",
                   end.date = "2015-07-17",
                   dimensions = "ga:dimension14, ga:country",
                   metrics = "ga:goal3completions",
                   max.results = 20000,
                   #sort = "-ga:date",
                   #samplingLevel="HIGHER_PRECISION",
                   table.id = "ga:79040929")

# Create the Query Builder object so that the query parameters are validated
ga.query <- QueryBuilder(query.list)

# Extract the data and store it in a data-frame
ga.data <- GetReportData(ga.query, token2, paginate_query = F)

#export email data into csv
extract_Name <- paste("c:/Temp/GA_data_country",
                      format(Sys.Date(),"%d%m%y"),".csv",sep="_")
write.csv(ga.data, extract_Name, row.names=FALSE)