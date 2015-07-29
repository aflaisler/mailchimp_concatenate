

install.packages("XML")
library("XML", lib.loc="~/R/win-library/3.1")
library("XMLSchema", lib.loc="~/R/win-library/3.1")
library("SSOAP", lib.loc="~/R/win-library/3.1")
library("RCurl", lib.loc="~/R/win-library/3.1")


xml_request = '<?xml version="1.0" encoding="UTF-8"?>
      <SOAP-ENV:Envelope
xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:xsd="http://www.w3.org/2001/XMLSchema"
xmlns:ns1="http://api.affiliatewindow.com/">
      <SOAP-ENV:Header>
      <ns1:UserAuthentication
SOAP-ENV:mustUnderstand="1"
SOAP-ENV:actor="http://api.affiliatewindow.com">
      <ns1:iId>215843</ns1:iId>
      <ns1:sPassword>e2201327e22b7e76b8061dede7462bef395fb86c4a87a12e</ns1:sPassword>
      <ns1:sType>affiliate</ ns1:sType>
      </ns1:UserAuthentication>
      <ns1:getQuota SOAP-ENV:mustUnderstand="1" SOAPENV:actor="http://api.affiliatewindow.com">true</ns1:getQuota>
      </SOAP-ENV:Header>
      <SOAP-ENV:Body>
      <ns1:getTransactionList>
      <ns1:dStartDate>2015-06-04T00:00:00</ns1:dStartDate>
      <ns1:dEndDate>2015-07-14T23:59:59</ns1:dEndDate>
      <ns1:sDateType>transaction</ns1:sDateType>
      </ns1:getTransactionList>
      </SOAP-ENV:Body>
      </SOAP-ENV:Envelope>'

xml <- curlPerform(url = "http://api.affiliatewindow.com/v4/AffiliateService",
            httpheader = headerFields,
            postfields = SampleSOAPrequest
)

url <- 'http://api.affiliatewindow.com/v4/AffiliateService'

myheader=c(Connection="open", 
           'Content-Type' = "application/xml",
           'Content-length' = nchar(xml_request),
           'iId'= "215843", 'sPassword'= "e2201327e22b7e76b8061dede7462bef395fb86c4a87a12e")

data =  getURL(url = url,
               postfields=xml_request,
               httpheader=myheader,
               verbose=TRUE)