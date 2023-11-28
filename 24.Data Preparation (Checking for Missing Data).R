##Data preparation (checking for missing data and replacing missing data)
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:

##Import the data
library(readxl)
data <- read_excel("data_er_los_with_missing_data_(excel)[1].xlsx", 
                   col_types = c("text", "text", "numeric", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "date", "text", "text", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric"))
View(data)

##Converted to data frame/table
install.packages("data.table")
library(data.table)
data <- as.data.table(data)
class(data)

##Check for missing data
##Are there any missing data within the data frame?
any(is.na(data))

##How many cells with missing data?
sum(is.na(data))

##missing data are found in which variables?
colSums(is.na(data))

##replace missing data with 999 code
data <- replace(data, is.na(data), 999)

##Are there any missing data within the data frame?
any(is.na(data))

##On the other hand, if the imported data has been coded 999 for missing,
##What should we do?
str(data)

##Are there any missing data within the data frame?


##If you know that code '999' refers to missing data, replace it then!
data1 <- data.frame(data)
data2 <- data.frame(data)


#(1) Replace a value across the entire Data frame:df[df == "Old Value"] <- "New Value"
data1[data1==999]
data1[data1==999]<-NA
View(data1)
any(is.na(data1))

#(2)Replace a value under a single Data frame column:
#df["Column Name"][df["Column Name"] == "Old Value"] <- "New Value"
data2[,1:3]
data2[,1:3][data2[,1:3]==999]
data2[,1:3][data2[,1:3]==999]<-NA
View(data2)
##Are there any missing data within the data frame?
any(is.na(data1))
any(is.na(data2))


##If you want to remove all rows with missing data
##Create complete case analysis data set
install.packages("tidyr")
library(tidyr)
colSums(is.na(data1))
data1 <-data1 %>% drop_na()


##Are there any missing data within the data frame?
any(is.na(data1))
str(data1)
colSums(is.na(data1))
