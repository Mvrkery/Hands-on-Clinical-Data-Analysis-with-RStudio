##Data preparation (changing character to factor and labeling)
##Set working directory

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
class(data)
data

##Converted to data frame/datatable
install.packages("data.table")
library(data.table)
data <- as.data.table(data)
data
class(data)


##Basic command that you should always do before analysis
##Check everything about your dataset

##Describe the structure of your data
str(data)

##Change the character vectors with a finite number of levels into factors
#Change one at a time
data1 <- data
str(data1)

data1$sex <- factor(data1$sex, labels = c("Female","Male"))
data1$sex
View(data1)

data1$insur <- factor(data1$insur, labels = c("UC","CS","SSSS","Fullpay"))
data1$nation <- factor(data1$nation, labels = c("Thai", "Nationprob","Burmese","Foreigner"))
data1$triage <- factor(data1$triage, labels = c("NU","SU","U","E","R"))
data1$trauma <- factor(data1$trauma, labels = c("Non-trauma","Trauma"))
data1$dispose <- factor(data1$dispose, labels = c("discharge","admit","refer","reject","death"))
data1$weekend <- factor(data1$weekend, labels = c("weekday","weekend"))
data1$shift <- factor(data1$shift, labels = c("morning","afternoon","night"))
data1


#Change all characters to factor using mutate_if in dplyr
install.packages("dplyr")
library(dplyr)
data2 <- data
str(data2)
class(data2)
data2 <- data2 %>% mutate_if(is.character, as.factor)



#So, what is the difference?
compare <- data.frame(data$sex, data1$sex, data2$sex)
compare
str(compare)


#You will see that the data of the factor vectors are ranked from 1,2,...
#This is done regardless of the original data which starts from 0,1,...
table(compare$data1.sex)
table(compare$data.sex)
compare$data1.sex == compare$data.sex






#The character levels of data.sex are different from those of data1.sex
#Thus, they are not the same thing ("0" and "1" vs "Female" and "male")


#However, for data.sex and data2.sex they are the same (Both are "0" and "1")
table(compare$data2.sex)
table(compare$data.sex)
compare$data2.sex == compare$data.sex

####


#If you want to label data2
data2
data2$sex <- factor(data2$sex, labels = c("Female","Male"))
data2$insur <- factor(data2$insur, labels = c("UC","CS","SSSS","Fullpay"))
data2$nation <- factor(data2$nation, labels = c("Thai", "Nationprob","Burmese","Foreigner"))
data2$triage <- factor(data2$triage, labels = c("NU","SU","U","E","R"))
data2$trauma <- factor(data2$trauma, labels = c("Non-trauma","Trauma"))
data2$dispose <- factor(data2$dispose, labels = c("discharge","admit","refer","reject","death"))
data2$weekend <- factor(data2$weekend, labels = c("weekday","weekend"))
data2$shift <- factor(data2$shift, labels = c("morning","afternoon","night"))

str(compare)
table(data$sex)
table(data1$sex)

data1$sex <- factor(data1$sex, labels = c("1 Female","1 Male"))
table(data1$sex)
