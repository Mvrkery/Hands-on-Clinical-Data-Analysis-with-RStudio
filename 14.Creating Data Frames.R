##Data frame 

##Data frame may seem like dataset but is not
##One dataset can have more than one data frame

##For clinical researchers, think of each vector as each variable within dataset

id <- c(1:5)
age <- c(30,25,40,60,30)
sex <- c("male","male","female","female","male")
diabete <- c("yes","no","no","yes","no")
height <- c(170,173,168,165,172)
weight <- c(80,64,67,80,70)

##List

list <- list(id, age, sex, diabete, height, weight)
list
class(list)

data.frame(id,age,sex,diabete,height,weight)

##Data frame

data <- data.frame(id,age,sex,diabete,height,weight)
data
class(data)

##Basic command for data frame

dim(data)
str(data)
View(data)

height
data$height
height==data$height

bmi <- weight/(height/100)^2
bmi
data$bmi <- weight/(height/100)^2
data$bmi
data$bmi==bmi

class(bmi)

##Selecting data from a dataframe based on location
bmi[4]

##data frame? position
data

##data[row,column]
data[3] #this assummed as you select column
data[3,] #rows
data[,3]
data[3,3]

data[1:5,1:5]
data[1:5,c(1,2,3,4,7)]

##Selecting data based on logical condition
##show only data of people with BMI higher than 25
data

data[data$bmi >=25,c(1,7)]

#show only female with BMI > 25
data[data$sex=="female" & data$bmi>25,]


data
data[,c(1,2,3,4,7)]
data1 <- data[,c(1,2,3,4,7)]
data1


data
data[diabete=="no",c(1,2,3,4,5,6,7)]
data2 <- data[diabete=="no",c(1,2,3,4,5,6,7)]
data2

##show only female with BMI>25



