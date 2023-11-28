##Categorizing numeric variables
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:

##Import the data
library(readxl)
data <- read_excel("data_er_los_(excel)[1].xlsx", 
                   col_types = c("text", "text", "numeric", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "date", "text", "text", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric"))
View(data)

##Converted to data frame/table
library(data.table)
data <- as.data.table(data)
class(data)

##Basic command that you should always do before analysis
##Check everything about your dataset

##Describe the structure of your data
str(data)

##Change character to factor
data$sex <- factor(data$sex, labels=c("Female", "Male"))
data$insur <-factor(data$insur,labels=c("UC","CS","SSSS","Fullpay"))
data$nation <-factor(data$nation,labels=c("Thai","Nationprob","Burmese","Foreigner"))
data$triage <-factor(data$triage,labels=c("NU","SU","U","E","R"))
data$trauma<-factor(data$trauma,labels=c("Non-trauma","Trauma"))
data$dispose<-factor(data$dispose,labels=c("discharge","admit","refer","reject","death"))
data$weekend<-factor(data$weekend,labels=c("weekday","weekend"))
data$shift<-factor(data$shift,labels=c("morning","afternoon","night"))
str(data)

##Categorizing numeric variables
##Age -> age groups (18-59, >=60) adults vs elderly

##Many approaches can be done
##Using the cut function
data$agegr_cut <- cut(data$age, c(0.,59.9,99.9), labels = c("Adults","Elderly"))
table(data$agegr_cut)




##Check after cut
install.packages("dplyr")
library(dplyr)
data %>% group_by(data$agegr_cut) %>% summarize(n(), mean(age), sd=sd(age))


##Using dplyr
data <- data %>% mutate(agegr_dplyr= case_when(age<60 ~ "Adult", age>= 60 ~ "Elderly"))
table(data$agegr_dplyr)

##Check after mutate
data %>% group_by(data$agegr_dplyr) %>% summarize(n(), mean(age), sd=sd(age))

##Using replace function
data$agegr_replace <- replace(data$agegr_replace, data$age<60 , "Adults")
data$agegr_replace <- replace(data$agegr_replace, data$age>=60 , "Elderly")
table(data$agegr_replace)


##Check after replace
data %>% group_by(data$agegr_replace) %>% summarize(n(), mean(age), sd=sd(age))


##Using ifelse function
data$agegr_ifelse<- ifelse(data$age>=60, "Elderly", "Adults")
table(data$agegr_ifelse)

##Check after ifelse
data %>% group_by(data$agegr_ifelse) %>% summarize(n(), mean(age), sd=sd(age))

##Any many more, pick your favorite approach for yourself!

##Now, choose one approach from above and categorize age into 3 groups
## Age 18-35, 35-59, 60 or more
##labeled as young adults, adults, older adults

##If you're using ifelse, it's probably looks like this:
data$age3gr <- ifelse(data$age>=60, "2 Older adults",ifelse(data$age<35, "0 Young adults","1 Adults"))
table(data$age3gr)

##Check after ifelse

data %>% group_by(data$age3gr) %>% summarize(n(), mean(age), sd=sd(age),
                                             min=min(age),
                                             max=max(age))

