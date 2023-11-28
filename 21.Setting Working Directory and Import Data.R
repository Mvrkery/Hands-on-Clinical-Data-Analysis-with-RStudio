##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("/cloud/project/setting")
##Mine is the following:

##Check working directory(current)
getwd()

##Importing prepared excel datasheet
##File > Import Dataset > From Excel
install.packages("readxl")
library(readxl)
data_er_los_excel_1_ <- read_excel("data_er_los_(excel)[1].xlsx", 
                                        col_types = c("text", "text", "numeric", 
                                                                "text", "text", "text", "text", "text", 
                                                                "text", "date", "text", "text", "numeric", 
                                                                "numeric", "numeric", "numeric", 
                                                                "numeric", "numeric", "numeric", 
                                                                "numeric"))
    

##If you want to view the imported spreadsheet data
View(data_er_los_excel_1_)       

##You can select only some columns to be shown by using the subsetting table
View(data_er_los_excel_1_[,c("id", "sex", "age", "insur", "triage", "trauma")])       


##or by using select in dplyr
install.packages("dplyr")
library(dplyr)
data_er_los_excel_1_  %>% select(id, sex, age, insur, triage, trauma) %>% View() 

##If you want to view the data on console
data_er_los_excel_1_
class(data_er_los_excel_1_)


##Importing prepared csv datasheet
##File > Import Dataset > From Text (readr)
library(readr)
data_er_los_csv_1_ <- read_csv("data_er_los_(csv)[1].csv", 
                               col_types = cols(id = col_character(), 
                                                sex = col_character(), age = col_character(), 
                                                insur = col_character(), nation = col_character(), 
                                                triage = col_character(), trauma = col_character(), 
                                                illness = col_character(), dispose = col_character(), 
                                                date = col_date(format = "%m/%d/%Y"), 
                                                weekend = col_character(), shift = col_character()))
View(data_er_los_csv_1_)


##If you want to view the imported spreadsheet data
View(data_er_los_csv_1_)



##If you want to view the data on console
data_er_los_csv_1_



##Checking class of imported data
class(data_er_los_csv_1_)
class(data_er_los_excel_1_)



#They were imported as tibble not data frame

#You can change to data frame if you want to by using as.data.frame()
dataframe <- as.data.frame(data_er_los_excel_1_)
dataframe

datatibble <- data_er_los_csv_1_
datatibble

##Recheck the class of imported data
class(dataframe)
class(datatibble)


#Difference in presenting datatable, tibble, and dataframe

##Removing imported data from environment
##Clear all in environment
rm(list=ls())

##Now we're going to work with imported excel datasheet
library(readxl)
data <- read_excel("data_er_los_(excel)[1].xlsx", 
                                   col_types = c("text", "text", "numeric", 
                                                 "text", "text", "text", "text", "text", 
                                                 "text", "date", "text", "text", "numeric", 
                                                 "numeric", "numeric", "numeric", 
                                                 "numeric", "numeric", "numeric", 
                                                 "numeric"))
data_er_los_excel_1_ <- NULL

##Converted to data frame
data <- as.data.frame(data)
data


##Basic command that you should always do before analysis
##Check everything about your dataset

##Describe the structure of your data
str(data)

##Describe the dimension of your data
dim(data)

##View the datasheet
View(data)

#Want to see the head of the data
head(data)

#Want to see the tail of the data
tail(data)

##Now you're ready to go!


