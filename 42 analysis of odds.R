##Analysis of odds (odds ratio)
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:

##Required package
install.packages("epicalc", repos = "https://medipe.psu.ac.th/epicalc")
library(epicalc)
library(descr)


##Import the data
library(readxl)
data <- read_excel("data_er_los (excel).xlsx", 
                   col_types = c("text", "text", "numeric", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "date", "text", "text", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric"))
View(data)

##Preparing data
data$sex <- factor(data$sex, labels=c("Female", "Male"))
data$insur <-factor(data$insur,labels=c("UC","CS","SSSS","Fullpay"))
data$nation <-factor(data$nation,labels=c("Thai","Nationprob","Burmese","Foreigner"))
data$triage <-factor(data$triage,labels=c("NU","SU","U","E","R"))
data$trauma<-factor(data$trauma,labels=c("Non-trauma","Trauma"))
data$dispose<-factor(data$dispose,labels=c("discharge","admit","refer","reject","death"))
data$weekend<-factor(data$weekend,labels=c("weekday","weekend"))
data$shift<-factor(data$shift,labels=c("morning","afternoon","night"))

##Check structure of the data frame
str(data)

#Check the class of the data
class(data)

##If you want to, you can change tibble to data frame format
data <- as.data.frame(data)
class(data)

#summarize data
summary(data)

#exploring data
head(data)


##Calculate the risk of extended LOS between weekday and weekend
##Creating the extended LOS variable

data$extendedLOS <- ifelse(data$los>240,"1 Extended LOS","0 Non extended LOS")

tab1(data$extendedLOS)

##Cross tabulate (without percentage first)

table(data$weekend, data$extendedLOS)
x <- prop.table(table(data$weekend, data$extendedLOS),1)
x
#Risk of extended LOS on weekend
Risk1 <- x[2,2]
Risk1

#Odds of extended LOS on weekend
Odds1 <- Risk1/(1-Risk1) 
Odds1
#Risk of extended LOS on weekday
Risk0 <- x[1,2]
Risk0
#Odds of extended LOS on weekday
Odds0 <- Risk0/(1-Risk0)
Odds0
#Odds ratio for extended LOS (weekend=numerator/weekday=denominator)
Odds1/Odds0


##All in one command for odds ratio
help(cc)
cc(data$extendedLOS, data$weekend, decimal = 9)


##Chi-square and fisher's exact test P-values
CrossTable(data$weekend, data$extendedLOS
           ,prop.t = FALSE
           ,prop.c = FALSE
           ,prop.chisq = FALSE
           ,chisq = TRUE
           ,fisher = TRUE)

##Calculate P-value from scientific number
options(scipen = 999)
##You can also use the command cc, which would present the results of Chi-sq,Fisher's


##Provide an interpretation following DESCRibe
cc(data$extendedLOS, data$weekend, decimal = 9)


##What if we would like to calculate the odds ratio for shift and extended LOS?
tab1(data$shift)


cc(data$extendedLOS, data$shift, decimal = 9)
##Why there is only one p-value? How many p-values should there be?
##There should be three pairwise tests
##Morning vs afternoon
##Morning vs night
##Afternoon vs night
##One pairwise p-value should be calculated for each pair



##Morning vs afternoon
library(data.table)
class(data)
data <- as.data.table(data)

data.mvsa <- data[data$shift !="night"]

View(data.mvsa)

cc(data.mvsa$extendedLOS, data.mvsa$shift, decimal = 9)

CrossTable(data.mvsa$shift, data.mvsa$extendedLOS
           ,prop.t = FALSE
           ,prop.c = FALSE
           ,prop.chisq = FALSE
           ,chisq = TRUE
           ,fisher = TRUE)


##RR ((m vs  a))  0.385859789 p = 0.0000217 

 


##Morning vs night
data.mvsn <- data[data$shift !="afternoon"]
cc(data.mvsa$extendedLOS, data.mvsa$shift, decimal = 9)
CrossTable(data.mvsa$shift, data.mvsa$extendedLOS
           ,prop.t = FALSE
           ,prop.c = FALSE
           ,prop.chisq = FALSE
           ,chisq = TRUE
           ,fisher = TRUE)


##OR (m vs n) 0.119895204 p = 0.000602 




##Afternoon vs night
data.avsn <- data[data$shift !="morning"]
cc(data.avsn$extendedLOS, data.avsn$shift, decimal = 9)
data.avsn$shift <- as.character(data.avsn$shift)
CrossTable(data.avsn$shift, data.avsn$extendedLOS
           ,prop.t = FALSE
           ,prop.c = FALSE
           ,prop.chisq = FALSE
           ,chisq = TRUE
           ,fisher = TRUE)



