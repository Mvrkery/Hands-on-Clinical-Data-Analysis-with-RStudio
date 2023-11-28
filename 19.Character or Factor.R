##Characters or Factors?

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

class(data$sex)
class(data$diabetes)

##Converting sex from characters to factors
data$sex_factor <- data$sex
data$sex_factor <- as.factor(data$sex_factor)
class(data$sex_factor)

data$sex_factor
data$sex


data$sex == data$sex_factor

data$sex <- replace(data$sex, data$sex=="male","mle")
data$sex

data$sex_factor <- replace(data$sex_factor, data$sex_factor=="male", "mle")
data$sex_factor # didnt work cuz they didt match factor levels

data$sex_factor <- replace(data$sex_factor, is.na(data$sex_factor),"male")
data$sex_factor


##Coverting sex_factor back to character
data$sex_factor <- as.character(data$sex_factor)
class(data$sex_factor)


