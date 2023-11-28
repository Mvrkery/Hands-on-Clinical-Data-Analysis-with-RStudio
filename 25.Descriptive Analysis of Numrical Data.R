##Descriptive analysis of numerical data
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:

##Import the data
install.packages("readxl")
library(readxl)
data <- read_excel("data_er_los_(excel)[1].xlsx", 
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
#class(data)

#summarize data
summary(data)

#exploring data
head(data)
tail(data)

#Describing numerical data require justification of its distribution
#histogram
hist(data$age)

#boxplot
boxplot(data$age)

#summary statistics 
mean(data$age)
sd(data$age)
median(data$age)
quantile(data$age, probs = c(0.25,0.75))
quantile(data$age, probs = c(0.01,0.10,0.25,0.50,0.75,0.90,0.99))


#all-in-one command (except for SD)
summary(data)
summary(data$age)


#Another way with dplyr
install.packages("dplyr")
library(dplyr)
summarizedstat1 <- data %>% summarize(n(),
                   mean=mean(age),
                   sd=sd(age),
                   median=median(age),
                   p25=quantile(age, probs = 0.25),
                   p75=quantile(age, probs = 0.75),
                   min=min(age),
                   max=max(age))
summarizedstat1
summarizedstat1[3]
summarizedstat1[5]



#What if we want to describe numerical variables for each subgroup?
sumstat2 <- data %>% group_by(sex) %>% summarize(n(),
                                    mean=mean(age),
                                    sd=sd(age),
                                    median=median(age),
                                    p25=quantile(age, probs = 0.25),
                                    p75=quantile(age, probs = 0.75),
                                    min=min(age),
                                    max=max(age))

sumstat2[3]
meanfemale <- sumstat2[1,3]
meanmale <- sumstat2[2,3]
meanfemale - meanmale 


#Boxplot for different subgroups
boxplot(data$age)
boxplot(data$age ~ data$sex)

#Now it's your turn try to describe length of stay by triage


#summary statistics
sumstat3 <- data %>% group_by(triage) %>% summarize(n(),
                                                 mean=mean(los),
                                                 sd=sd(los),
                                                 median=median(los),
                                                 p25=quantile(los, probs = 0.25),
                                                 p75=quantile(los, probs = 0.75),
                                                 min=min(los),
                                                 max=max(los))
sumstat3

#boxplot
boxplot(data$los)
boxplot(data$los~data$triage)
boxplot(data$los~data$triage,horizontal = TRUE,outline=FALSE)
boxplot(data$los~data$triage
        ,horizontal = TRUE
        ,outline=FALSE
        ,xlab = "LOS (minutes)"
        ,ylab = "Triage category"
        )


