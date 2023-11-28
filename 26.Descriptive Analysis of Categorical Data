##Descriptive analysis of categorical data
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("")
##Mine is the following:
getwd()

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

##If you want to, you can change tibble to data frame/data table format
install.packages("data.table")
library(data.table)
data <- as.data.table(data)

#class(data)

#summarize data
summary(data)
any(is.na(data))

#exploring data
head(data)

##Descriptive analysis of categorical variables (characters/factors)
##We will focus on describing first binary variables: traumatic/non-traumatic presentation
class(data$trauma)
str(data$trauma)
data$trauma


#Install epicalc package for simplified analysis
install.packages("epicalc", repos = "https://medipe.psu.ac.th/epicalc")
install.packages("kableExtra")
update.packages("epicalc")
library(epicalc)
help(epicalc)
codebook(data)

#Frequency and percentage table
tab1(data$trauma)
table(data$trauma)

#Now, try describing insurance type
tab1(data$insur)

#Cross tabulation 2x2 wtih tabpct function
help(tabpct)
tabpct(data$sex, data$trauma)
tabpct(data$sex, data$trauma, percent = "col")
tabpct(data$sex, data$trauma, percent = "row")
tabpct(data$sex, data$trauma, percent = "both")


#Using table function (able to locate and store value to be used)
#For single column table
table(data$sex)
prop.table(table(data$sex))




#locating value within table
prop.table(table(data$sex))[1]
prop.table(table(data$sex))[2]
pct.male <- prop.table(table(data$sex))[1]
pct.female <- prop.table(table(data$sex))[2]
pct.female + pct.male

#For 2x2 table
table(data$sex, data$trauma)
prop.table(table(data$sex, data$trauma))
prop.table(table(data$sex, data$trauma),1) #rowws percent
prop.table(table(data$sex, data$trauma),2) #column percent




#Keep value of percent trauma in male/female
prop.table(table(data$sex, data$trauma),1)[2,2]
prop.table(table(data$sex, data$trauma),1)[1,2]

#locating value within table
pct_trauma_male <- prop.table(table(data$sex, data$trauma),1)[2,2]
pct_trauma_female <- prop.table(table(data$sex, data$trauma),1)[1,2]
pct_trauma_male
pct_trauma_female
pct_trauma_male/pct_trauma_female
pct_trauma_male-pct_trauma_female
