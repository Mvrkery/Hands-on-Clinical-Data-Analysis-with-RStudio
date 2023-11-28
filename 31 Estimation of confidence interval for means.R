##Estimation of confidence interval for means
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:
setwd("D:\desktop[D]\FILE\จับมือวิเคราะห์ข้อมูลคลินิกด้วยRstudio\Practice dataset")


##Import the data
library(readxl)
data <- read_excel("data_er_los (excel).xlsx", 
                   col_types = c("text", "text", "numeric", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "date", "text", "text", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric"))

##Check structure of the data frame
str(data)

#Check the class of the data
class(data)

##If you want to, you can change tibble to data frame format
#data <- as.data.frame(data)
#class(data)
data <- as.data.frame(data)
#summarize data
summary(data)

#Describing numerical data require justification of its distribution
#histogram
hist(data$age)
boxplot(data$age)

#Another way with dplyr
library(dplyr)
summarystat1 <- data %>% summarize(n(),mean=mean(age),
                                   sd=sd(age),
                                   median=median(age),
                                   p25=quantile(age,prob=0.25),
                                   p75=quantile(age,prob=0.75),
                                   min=min(age),
                                   max=max(age))
summarystat1


##What if we want to calculate the confidence interval for the mean age
##Manual calculation
##Mean +/- 1.96SE

##Calculate the standard error (SE) first
18.49182/sqrt(770)

n_age <- data %>% select(age) %>% summarize(n())
sd_age <- sd(data$age)

se_age <- sd_age/sqrt(n_age)
se_age

##Calculate the confidence intervals
mean_age <- mean(data$age)
UCI <- mean_age +1.96*se_age
LCI <- mean_age -1.96*se_age

mean_age
UCI
LCI 

##One command for CI estimation
install.packages("epicalc", repos = "https://medipe.psu.ac.th/epicalc")
library(epicalc)
help(ci)

ci(data$age)
ci.numeric(data$age)



##CI for separate group of people by sex
data$age
ci(data$age)

sum_age <- data %>% summarize(n=n()
                              ,mean=mean(age)
                              ,sd=sd(age)
)

str(sum_age)
ci(n=sum_age$n, x=sum_age$mean, sd=sum_age$sd)
ci(sum_age$n,sum_age$mean, sum_age$sd)

sum_agebysex <- data %>% group_by(sex) %>% summarize(n=n(), mean=mean(age), sd=sd(age))
sum_agebysex
ci(sum_agebysex$mean, sum_agebysex$n,sum_agebysex$sd)


## or use the data.table
library(data.table)

str(data)

data <- data.table(data)
data.male <- data[data$sex==1]
data.female <- data[data$sex==0]

ci(data.male$age)
ci(data.female$age)
