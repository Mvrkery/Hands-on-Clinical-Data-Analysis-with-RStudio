##Logistic regression
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
options(scipen=999)
##Mine is the following:
setwd("C:/Course/basic R/practical 5")

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

##Calculate the OR of extended LOS between older and younger age
##Creating the extended LOS variable
data$extendedLOS <- ifelse(data$los>240,"1 Extended LOS","0 Non extended LOS")
data$extendedLOS <- ifelse(data$los>240,1,0)


##Creating older adults variable
data$olderadults <- ifelse(data$age>=60,"1 Older adults","0 Younger adults")
class(data$olderadults) 

data$olderadults <- factor(data$olderadults)

table(data$extendedLOS)

table(data$olderadults)

##Simple cross-tabulation
table(data$olderadults,data$extendedLOS)

OR <- (39/59)/(223/449)
OR

##Calculating the odds ratio (crude)
cc(data$extendedLOS,data$olderadults)


##Estimating the OR using univariable logistic regression
logiresult <- glm(extendedLOS ~ olderadults, data = data, family = "binomial")
summary(logiresult)



#select only coefficients
coef(logiresult)
exp(coef(logiresult))

#select only confidence intervals
confint(logiresult)
exp(confint(logiresult))

#Combining both coefficients and confidence intervals
exp(cbind(OR=coef(logiresult), confint(logiresult)))

##Estimating the adjusted OR using multivariable logistic regression
##Adjusting for sex and triage
adlogiresult <- glm(extendedLOS ~ olderadults + sex + triage, data = data, family = "binomial")
summary(adlogiresult)

exp(cbind(OR=coef(adlogiresult), confint(adlogiresult)))
