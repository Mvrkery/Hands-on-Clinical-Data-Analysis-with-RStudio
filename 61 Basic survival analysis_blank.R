##Basic survival analysis
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
options(scipen=999)
##Mine is the following:
setwd("D:/desktop[D]/โฟลเดอร์ใหม่")
##Required packages
install.packages("epicalc", repos = "https://medipe.psu.ac.th/epicalc")
library(epicalc)
install.packages("fmsb")
library(fmsb)
library(data.table)
install.packages(c("survival", "survminer"))
library(survival)
library(survminer)

#survival for computing survival analyses
#survminer for summarizing and visualizing the results of survival analysis

##Import the data
library(readxl)
data <- read_excel("data_aml_rate (excel).xlsx", 
                   col_types = c("text", "text", "numeric", 
                                 "numeric", "numeric", "numeric"))
View(data)

##Convert the data to datatable
data <- data.table(data)

##Check structure of the data frame
str(data)

##Preparing data
data$intervention <- factor(data$intervention, labels=c("BSC", "MTC"))

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

#Explore distribution of follow-up time
hist(data$followup)
summary(data$followup)
sd(data$followup)



#Survival time setting
#Creating a survival object, which would be used as a response variable
#for further survival analysis
help(Surv)
surv <- Surv(data$followup, data$dead==1)
class(surv)
surv




##Create survival curves via KM methods
help(survfit)

##For a single survival curve the right hand side should be ~ 1.
survall <- survfit(surv ~ 1)



#Estimate the survival probabilities for each time point
summary(survall)

#Summary the survival probabilities
summary(survall, times = 6)


#Print the median survival time (MST) and confidence interval
print(survall)

#Plot the survival probabilities to form the curves
plot(survall)

#Plot using ggsurvplot
help(ggsurvplot)
ggsurvplot(survall, data=data)
ggsurvplot(survall, data=data, fun="pct")
ggsurvplot(survall, data=data, fun="event")
ggsurvplot(survall, data=data, fun="cumhaz")

#Estimate the survival probabilities for each time point
#Separately for each treatment group
survbbyinter <- survfit(surv ~ data$intervention)


#Summary the survival probabilities
summary(survbbyinter)
summary(survbbyinter, times = 6)

#Plot the survival probabilities to form the curves
plot(survbbyinter)

plot(survbbyinter, lwd = 3, col = c("navy","red"))
     legend("bottomleft", legend = c("BSC","MTC")
            ,col = c("navy","red")
            ,lty = c(1,1)
            ,pch = c(19,19)
            ,lwd=4)
     title("LM estimated survival finction by treatment group"
     ,ylab="Survival probabilitty"
     ,xlab="Follow-up time (days)")
     
     
     
#Plot using ggsurvplot
help(ggsurvplot)
ggsurvplot(survbbyinter, data=data)
ggsurvplot(survbbyinter, data=data, fun= "event")

ggsurvplot(survbbyinter, data=data
           ,pval = TRUE
           ,conf.int=TRUE
           ,risk.table = TRUE
           ,risk.table.col="strata"
           ,linetype = "strata"
           ,surv.median.line = "hv"
           )


#Performing log-rank test for equality of survivals
help(survdiff)
survdiff(surv ~ data$intervention)

# Fit Cox's regression model
cox.results <- coxph(surv ~ intervention, data=data)
cox.results
summary(cox.results)
