#Self-exercise: Descriptive analysis
#Instruction
#1) Set working directory to your working path
#2) Import the excel data: data_er_los (excel).xlsx
#3) Prepare the data by converting character variables to factor variables
#4) Recode variable age into 3 groups (age<35, 35-59, >59)
#5) Recode variable los into 2 groups (<4 hours, >=4 hours): extended LOS in ED
#6) Tabulate 2x2 table to contrast the difference in the proportion of extended LOS between trauma/non-trauma
#7) Describe the summary statistics for LOS in different triage categories for trauma/non-trauma
#8) Create a separate boxplot (horizontal) to describe values in #7

#1) Set working directory to your working path
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:
setwd("C:/Course/basic R/practical 2")

#2) Import the excel data: data_er_los (excel).xlsx
##Import the data
install.packages("readxl")
library(readxl)
data <- read_excel("data_er_los (excel).xlsx", 
                   col_types = c("text", "text", "numeric", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "date", "text", "text", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric"))
View(data)

#3) Prepare the data by converting character variables to factor variables
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
class(data)

##Convert to data.table
install.packages("data.table")
library(data.table)
data <- as.data.table(data)
class(data)

#4) Recode variable age into 3 groups (age<35, 35-59, >59)

data$age3gr <- ifelse(data$age<35,"0 Young adults",
                      ifelse(data$age>=35 & data$age<=59, "1 Adults", "2 Older adults"))
str(data$age3gr)
data$age3gr <- as.factor(data$age3gr)
class(data$age3gr)
str(data$age3gr)

##Check after ifelse
install.packages("dplyr")
library(dplyr)
data %>% group_by(age3gr) %>% summarize(n(), mean=mean(age),
                                        sd=sd(age),
                                        min=min(age),
                                        max=max(age))
table(data$age3gr)
prop.table(table(data$age3gr))
install.packages("kableExtra")
update.packages("epicalc")
library(epicalc)
tab1(data$age3gr)
#5) Recode variable los into 2 groups (<4 hours, >=4 hours): extended LOS in ED

data$los
data$los_hr <- data$los/60
data$los_hr

data <- data %>% mutate(extendendlos = case_when(los_hr<4 ~ "0 Not extended",
                                                 los_hr>=4 ~ "1 Extended LOS"))

table(data$extendendlos)
class(data$extendendlos)
data$extendendlos <- as.factor(data$extendendlos)

##Check after mutate
data %>% group_by(extendendlos) %>% summarize(n(), mean=mean(los_hr),
                                              sd=sd(los_hr),
                                              min=min(los_hr),
                                              max=max(los_hr))

tab1(data$extendendlos)

#6) Tabulate 2x2 table to contrast the difference in the proportion of extended LOS between trauma/non-trauma
table(data$extendendlos)
table(data$trauma)

table(data$trauma, data$extendendlos)
prop.table(table(data$trauma, data$extendendlos))

prop.table(table(data$trauma, data$extendendlos),1) # 1 = row , 2 = column

prop_extend_nontrauma <- prop.table(table(data$trauma, data$extendendlos),1)[1,2]
prop_extend_trauma <- prop.table(table(data$trauma, data$extendendlos),1)[2,2]


prop_extend_nontrauma
prop_extend_trauma

prop_extend_nontrauma-prop_extend_trauma

#7) Describe the summary statistics for LOS in different triage categories for trauma/non-trauma
table(data$trauma)

#In trauma
summarytrauma <- data %>% filter(trauma=="Trauma") %>% group_by(triage) %>% summarize(n(),
                                                                                      mean=mean(los),
                                                                                      sd=sd(los),
                                                                                      median=median(los),
                                                                                      p25=quantile(los,prob=0.25),
                                                                                      p75=quantile(los,prob=0.75))

#In non-trauma
summarynontrauma <- data %>% filter(trauma=="Non-trauma") %>% group_by(triage) %>% summarize(n(),
                                                                                             mean=mean(los),
                                                                                             sd=sd(los),
                                                                                             median=median(los),
                                                                                             p25=quantile(los,prob=0.25),
                                                                                             p75=quantile(los,prob=0.75))
summarytrauma
summarynontrauma
#8) Create a separate boxplot (horizontal) to describe values in #7

#Overall
boxplot(data$los ~ data$triage, horizontal=TRUE)

#Trauma
data.trauma <- data %>% filter(trauma=="Trauma")
boxplot(data.trauma$los ~ data.trauma$triage, horizontal=TRUE)

#Nontrauma
data.nontrauma <- data %>% filter(trauma=="Non-trauma")
boxplot(data.nontrauma$los ~ data.nontrauma$triage, horizontal=TRUE)







