##Replacing values of vector within data frame/data table 

##Create data frame first 
id <- c(1:5)
age <-c(30,25,40,60,30)
sex <-c("male","male",NA,NA,"male")
diabetes <-c("Yes","No","No","Yes","No")
height <-c(170,173,168,165,172)
weight <-c(80,64,67,80,72)
bmi <- weight/(height/100)^2

data <- data.frame(id,age,sex,diabetes,height,weight,bmi)
data

##Check data frame
class(data)
str(data)

##Replacing bmi with grouping label
##Use replace function
data
data$bmigr <- replace(data$bmigr, data$bmi<25, "normal")
data$bmigr <- replace(data$bmigr, data$bmi>=25 & data$bmi<=29.9, "overweight")
data$bmigr <- replace(data$bmigr, data$bmi>=30, "obese")
data
help(replace)



##Replacing missing sex with females
data
data$sex <- replace(data$sex, data$sex==NA,"female") ##not function
data
is.na(data$sex)
data$sex <- replace(data$sex, is.na(data$sex), "female")
data

##Replacing using data.table function
data$bmigr <- NULL
data$bmigr
install.packages("data.table")
library("data.table")
data
datab <- as.data.table(data)
datab
class(datab)
datab[bmi<25, bmigr:="normal"]
datab[bmi>25 & bmi<30, bmigr:="overweight"]
datab[bmi>30, bmigr:="obese"]
datab


##Replacing using ifelse
datab
datab[,1:7]
datab <- datab[,1:7]
datab

datab$bmigr <- ifelse(data$bmi<25 , "normal"
                      ,ifelse(data$bmi>=30, "obese","overweight"))

datab
