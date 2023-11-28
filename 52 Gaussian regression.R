##Gaussian regression (linear model)
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
options(scipen=999)
##Mine is the following:
setwd("C:/Course/basic R/practical 5")

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

##Plot correlation between age and los
plot(data$age,data$los)


#Checking the linearity assumption
plot(data$age,data$los) #plot(x,y)
#Add LOWESS line
lines(lowess(data$age,data$los), col="blue") # LOWESS line (x,y)
#Add linear prediction line
abline(lm(data$los ~ data$age),col="red") #lm(y~x)


#Fit the Gaussian regression with glm
help(glm) #Syntax regression Y ~ X
glm.result <- glm(data$los ~ data$age, family = "gaussian")
summary(glm.result)

## y = a + bx -> los = a + b(age)
## los = 82.9806 + 0.6876(age)
confint(glm.result)
cbind(coef(glm.result), confint(glm.result))

#Show the log-likelihood of the model
help("logLik")
logLik(glm.result)


#Fit the Gaussian regression with lm
lm.result <- lm(data$los ~ data$age)
summary(lm.result)
logLik(lm.result)
cbind(coef(lm.result), confint(lm.result))

#Multivariable Gaussian regression 
#X=age adjusted by sex and triage level
# los = age + triage

adjusted.glm <- glm(los ~ age + sex + triage, family = "gaussian", data = data)
summary(adjusted.glm)
cbind(coef(adjusted.glm), confint(adjusted.glm))
