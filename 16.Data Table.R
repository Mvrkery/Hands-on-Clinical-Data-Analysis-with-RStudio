##Data.table package 

##Create data frame first 
id <- c(1:5)
age <-c(30,25,40,60,30)
sex <-c("male","male","female","female","male")
diabetes <-c("Yes","No","No","Yes","No")
height <-c(170,173,168,165,172)
weight <-c(80,64,67,80,72)
bmi <- weight/(height/100)^2

data <- data.frame(id,age,sex,diabetes,height,weight,bmi)
data

##Check data frame
class(data)
str(data)

##data.table package
install.packages("data.table")
library(data.table)

class(data)
data
data[1:3]
data[1:3,]

datab <- as.data.table(data)
class(datab)
datab



##i,j,by data.table operation




##i operations (row)
data
data[1:2]
datab[1:2]
datab[!1:2]
data[sex=="male"]
data[sex=="male",]
datab[sex=="male"]
datab[sex=="male",malesexcode:=1]
datab
datab[sex=="female",malesexcode:=0]
datab
datab$malesexcode <- NULL
datab


##j operations (column)
data[1:3,]
datab[1:3,]
datab[,c(1:5)]
datab[,c("id","age","sex","diabetes")]
datab[,.(id,age,sex,diabetes)]
datab[,.(meanage=mean(age),sdage=sd(age))]
datab[,age_sq:=age*age]
datab

datab$age_sq <- NULL
datab
datab[,`:=`(age_sq=age*age, height_sq=height*height)]
datab


##by operations 
datab
datab[,.(n=.N
         ,meanage=mean(age)
         ,sdage=sd(age)
         ,p50=median(age,p=50)
         ,p75=quantile(age,p=0.75)
         ,mib=min(age)
         ,max=max(age)
        )]

datab[,.(n=.N
         ,meanage=mean(age)
         ,sdage=sd(age)
         ,p50=median(age,p=50)
         ,p75=quantile(age,p=0.75)
         ,mib=min(age)
         ,max=max(age)
         ),by=diabetes]






##Combining brackets
datab
datab[,1:5]
datab[,1:5][age>25]
datab[,1:5][age>25][diabetes=="Yes"]
datab[,1:5][age>25][diabetes=="Yes"][,.(sex)]

            
