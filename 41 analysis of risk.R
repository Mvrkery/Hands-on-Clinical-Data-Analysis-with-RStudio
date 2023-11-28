##Analysis of risk 
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:
setwd("C:/Course/basic R/practical 4")

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
prop.table(table(data$weekend, data$extendedLOS),1)
prop.table(table(data$weekend, data$extendedLOS),2)

#Risk of extended LOS on weekend
prop.table(table(data$weekend, data$extendedLOS),1)

Risk1 <- prop.table(table(data$weekend, data$extendedLOS),1)[2,2]
Risk1

#Risk of extended LOS on weekday
Risk0 <- prop.table(table(data$weekend, data$extendedLOS),1)[1,2]
Risk0

#Risk ratio for extended LOS (weekend=numerator/weekday=denominator)
Risk1/Risk0

#Risk difference for extended LOS (weekend=numerator/weekday=denominator)
Risk1-Risk0


##Tablepct command
tabpct(data$weekend,data$extendedLOS)


##All in one command for risk ratio/risk difference
help(cs)

cs(data$extendedLOS,data$weekend)

##Chi-square and fisher's exact test P-values
help(CrossTable)
CrossTable(data$weekend,data$extendedLOS,
           prop.t=FALSE,
           prop.c=FALSE,
           prop.chisq=FALSE,
           chisq=TRUE,
           fisher=TRUE)
options(scipen=999)


##Calculate P-value from scientific number
#p = 1.56e-05 
pvalues <- 1.56e-05 
format(pvalues,scientific=FALSE)

##You can also use the command cc, which would present the results of Chi-sq,Fisher's
help(cc)
cc(data$extendedLOS,data$weekend, decimal=9)

##Provide an interpretation following DESCRibe
##Direction
##Effectsize
##Statistical significance
##Clinical significance
##Reasonable biological plausibility
cs(data$extendedLOS,data$weekend)

##What if we would like to calculate the risk ratio for shift and extended LOS?
tab1(data$shift)

##Cross tabulate (without percentage first)
table(data$shift,data$extendedLOS)
x <- prop.table(table(data$shift,data$extendedLOS),1)
x
risk_morning <- x[1,2]
risk_afternoon <- x[2,2]
risk_night <- x[3,2]

risk_morning
risk_afternoon
risk_night
##Calculate the RR and RD if risk_morning is the base reference
risk_morning/risk_morning
risk_afternoon/risk_morning
risk_night/risk_morning
01-0.4385702
1-0.1446712
##Chi-square test and Fisher's exact p-values?
CrossTable(data$shift,data$extendedLOS,
           prop.t=FALSE,
           prop.c=FALSE,
           prop.chisq=FALSE,
           chisq=TRUE,
           fisher=TRUE)


##Calculate P-value from scientific number




##Why there is only one p-value? How many p-values should there be?
##There should be three pairwise tests
##Morning vs afternoon
##Morning vs night
##Afternoon vs night
##One pairwise p-value should be calculated for each pair
cs(data$extendedLOS,data$shift,decimal=6)


##Morning vs afternoon
library(dplyr)
data.mvsa <- data %>% filter(shift!="night")
cs(data.mvsa$extendedLOS,data.mvsa$shift)
CrossTable(data.mvsa$shift,data.mvsa$extendedLOS,
           prop.t=FALSE,
           prop.c=FALSE,
           prop.chisq=FALSE,
           chisq=TRUE,
           fisher=TRUE)

##RR (m vs a) 0.44 (0.3,0.65) p = 0.0000217 


##Morning vs night
data.mvsn <- data %>% filter(shift!="afternoon")
cs(data.mvsn$extendedLOS,data.mvsn$shift)
CrossTable(data.mvsn$shift,data.mvsn$extendedLOS,
           prop.t=FALSE,
           prop.c=FALSE,
           prop.chisq=FALSE,
           chisq=TRUE,
           fisher=TRUE)

##RR (m vs n) 0.14 (0.05,0.46) p = 0.000602 

##Afternoon vs night
data.avsn <- data %>% filter(shift!="morning")
cs(data.avsn$extendedLOS,data.avsn$shift)
data.avsn$shift <- as.character(data.avsn$shift )
CrossTable(data.avsn$shift,data.avsn$extendedLOS,
           prop.t=FALSE,
           prop.c=FALSE,
           prop.chisq=FALSE,
           chisq=TRUE,
           fisher=TRUE)

##RR 0.33 (a vs n)  (0.07 1.52   ) p = 0.0953 
class(data)

