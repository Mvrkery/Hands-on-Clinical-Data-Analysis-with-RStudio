##Testing hypothesis for proportions
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:

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


##If we want to test the difference in male sex between traumatic/non-traumatic presentation
##We might hypothesize that the sex would be different (more male in trauma, probably)
##H0: male in trauma = male in non-trauma
##H1: male in trauma != male in non-trauma

##Create cross-table just to check the data
table(data$sex, data$trauma)
prop.table(table(data$sex, data$trauma),1)
prop.table(table(data$sex, data$trauma),2)


library(epicalc)
help(tabpct)

tabpct(data$sex, data$trauma)

##Performing test
install.packages("descr")
library(descr)
help(CrossTable)

CrossTable(data$sex, data$trauma)

#show only column percentage
CrossTable(data$sex, data$trauma, prop.r = FALSE
           ,prop.t = FALSE
           ,prop.chisq = FALSE
           ,chisq = TRUE
           ,fisher = TRUE
           )


#show only row percentage


##Now, use CrossTable to describe and test the association between extended LOS and triage
##You need to create the variable "extended LOS" first by categorized LOS at 4 hours

##Creating the extended LOS variable
data$extendedLOS <- ifelse(data$los>240,"Extended LOS","Non extended LOS")

CrossTable(data$triage, data$extendedLOS
           ,prop.t=FALSE
           ,prop.chisq = FALSE
           ,prop.r = FALSE
           ,chisq=TRUE
           )












