##Handling data frame

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
View(data)

##Dplyr package for handling data frame
install.packages("dplyr")
library(dplyr)

##5 Common verbs of dplyr
##Select, Filter, Arrange, Mutate, Summarize

##Select (selecting columns/variables)
help(select)
data

select(data, id, age, sex, diabetes)
data[,c(1,2,3,4)]

data_selected <- select(data, id, age, sex, diabetes)
data_selected


##Filter (filtering only some rows on some conditions)
help(filter)
filter(data, age>30)
data[age>30,]

data_filter <- filter(data, age>30)
data_filter

##Arrange
data
arrange(data, age)
arrange(data, desc(age))

##Mutate (creating new variable)
data
data$bmi<- NULL
data$bmi
mutate(data, bmi=weight/(height/100)^2
data <- mutate(data,bmi=weight/(height/100)^2)

##Summarize
help(summarize)
data
summarize(data, n(), mean(bmi), sd(bmi))
summarize(data, 
          n(), 
          mean(bmi), 
          median(bmi), 
          quantile(bmi,p=0.25), 
          quantile(bmi,p=0.75),
          min(bmi),
          max(bmi)
          )

##Piping (%>%) in dplyr
data
class (data)

data %>% class()

str(data)

data %>% str()



##Piping with dplyr verbs
data
data %>% select(id, age , sex , bmi)
data %>% select(id , age , sex , bmi) %>% filter(sex=="male")


##Create new data frame with only male aged>=30
data %>%filter(sex=="male" & age >=30)
data_male30 <- data %>% filter(sex=="male" & age >= 30)
data_male30
data_male30 <- NULL
data[sex=="male" & age >= 30,]
data_male30 <- data[sex=="male" & age >=30,]
data_male30
##Summarize mean weight of this specific dataset 
data_male30

data_male30 %>% filter(sex=="male") %>% summarise(n(),
                                          mean(weight),
                                          sd(weight),
                                          median(weight),
                                          quantile(weight,p=0.25),
                                          quantile(weight, p=0.75),
                                          min(bmi),
                                          max(bmi)
                                          )

data_male30 %>% filter(sex=="female") %>% summarise(n(),
                                                  mean(weight),
                                                  sd(weight),
                                                  median(weight),
                                                  quantile(weight,p=0.25),
                                                  quantile(weight, p=0.75),
                                                  min(bmi),
                                                  max(bmi)
                                                  )

data %>% group_by(sex) %>% summarize(
                                    n(),
                                    mean(weight),
                                    sd(weight),
                                    median(weight),
                                    quantile(weight,p=0.25),
                                    quantile(weight, p=0.75),
                                    min(bmi),
                                    max(bmi)
                                    )
##Summarize bmi overall, by sex



