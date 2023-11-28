##Analysis of rates
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:
setwd("C:/Course/basic R/practical 4")

##Required packages
install.packages("epicalc", repos = "https://medipe.psu.ac.th/epicalc")
library(epicalc)
install.packages("fmsb")
library(fmsb)
library(data.table)


##Import the data
library(readxl)
data <- read_excel("data_aml (excel).xlsx", 
                   col_types = c("text", "text", "numeric", 
                                 "numeric", "numeric", "numeric"))
View(data)

##Convert the data to datatable
data <- data.table(data)

##Check structure of the data frame
str(data)

##Preparing data
data$intervention <- factor(data$intervention, labels=c("BSC", "MTC"))
data$dead01 <- data$dead
data$dead <- factor(data$dead, labels=c("Alive/censored", "Dead"))

##Check structure of the data frame
str(data)

#Check the class of the data
class(data)

##If you want to, you can change tibble to data frame format
#data <- as.data.frame(data)
#class(data)

#summarize data
summary(data)

#exploring data
head(data)

#Intervention group
tab1(data$intervention)

#Dead event
tab1(data$dead)

#Cross tabulation
table(data$dead,data$intervention)
prop.table(table(data$dead,data$intervention),2)

x <- prop.table(table(data$dead,data$intervention),2)
x

risk.mtc <- x[2,2]
risk.bsc <- x[2,1]

risk.mtc
risk.bsc 

risk.mtc/risk.bsc 

odds.mtc <- risk.mtc/(1-risk.mtc)
odds.bsc <- risk.bsc/(1-risk.bsc)

odds.mtc/odds.bsc
#Calculate risk ratio/difference of MTC (BSC as reference)
cs(data$dead,data$intervention)

cc(data$dead,data$intervention)


#Calculate the incidence rate of event

#Calculate the total number of event
totalevent <- sum(data$dead01)
totalevent


#Calculate the total number of person-time 
totalpersontime <- sum(data$followupday)
totalpersontime

#Calculate the incidence rate
overall.ir <- totalevent/totalpersontime
overall.ir*100*365.25

#Confidence interval for incidence rate
help("ci.poisson")
ci.poisson(totalevent, totalpersontime)
ci.poisson(67,95526)


#Calculate the incidence rate for different levels of intervention
data.mtc <- data[data$intervention=="MTC"]
data.bsc <- data[data$intervention=="BSC"]

totalevent.mtc <- sum(data.mtc$dead01)
totalevent.bsc <- sum(data.bsc$dead01)

totalpersontime.mtc <- sum(data.mtc$followupday)
totalpersontime.bsc <- sum(data.bsc$followupday)

rate.mtc <- totalevent.mtc/totalpersontime.mtc
rate.bsc <- totalevent.bsc/totalpersontime.bsc

rate.mtc
rate.bsc

##Incidence rate with CI in MTC
ci.poisson(totalevent.mtc, totalpersontime.mtc)

##Incidence rate with CI in BSC
ci.poisson(totalevent.bsc, totalpersontime.bsc)


##Incidence rate ratio (MTC/BSC)
rate.mtc/rate.bsc

rateratio(totalevent.mtc, totalevent.bsc, totalpersontime.mtc, totalpersontime.bsc)
ratedifference(totalevent.mtc, totalevent.bsc, totalpersontime.mtc, totalpersontime.bsc)

##Incidence rate difference (MTC-BSC)
rate.mtc-rate.bsc

