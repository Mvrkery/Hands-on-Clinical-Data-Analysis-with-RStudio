##Re-coding values of vector within data frame/data table 

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

##Create datatable with only id and bmi
install.packages("data.table")
library(data.table)
databmi <- as.data.table(data)
databmi[,c("id","bmi")]
databmi <- databmi[,c("id","bmi")]
databmi

##Using data.table package to recode
##BMI 3 groups
##Normal weight min<25
##Overweight 25-29.9
##Obese 30-max (34.9)

##data.table package
install.packages("data.table")
library(data.table)



databmi[bmi<25, bmigr:="nornmal"]
databmi
databmi[bmi>=25 & bmi<30 , bmigr:="overweight"]
databmi
databmi[bmi>=30, bmigr:="obese"]
databmi
databmi$bmiqr <- NULL

databmi[bmi<25, bmicode:=0]
databmi[bmi>=25 & bmi<30, bmicode:=1]
databmi[bmi>=30, bmicode:=2]
databmi

databmi <- NULL

databmi[bmigr=="normal", bmicode:=0]
databmi[bmigr=="overweight", bmicode:=1]
databmi[bmigr=="obese", bmicode:=2]
databmi

databmi$bmigr <- NULL
databmi$bmicode <- NULL
databmi
databmi[bmi<25,`:=` (bmigr="normal", bmicode=0)]
databmi[bmi>=25 & bmi<30,`:=` (bmigr="overweight", bmicode=1)]
databmi[bmi>=30,`:=` (bmigr="obese", bmicode=2)]
databmi


##Using cut function
databmi
databmi$bmicode <- NULL
databmi$bmigr <- NULL
databmi
 
databmi$bmigr <- cut(databmi$bmi, breaks = c(0,24.9,29.9,34.9))
databmi
class(databmi$bmigr)
databmi$bmigr



#assigning label to each factor
databmi$bmigr_lab <- cut(databmi$bmi, breaks=c(0,24.9,29.9,34.9))
databmi$bmigr_lab
levels(databmi$bmigr_lab) <- c("normal","overweight","obese")
databmi$bmigr_lab



##assigning code to each factor
databmi$bmi_code <- databmi$bmigr
databmi
levels(databmi$bmi_code) <- c(0,1,2)
databmi



##Finish it in one line
databmi$bmigr_recode <- cut(
                          databmi$bmi
                          ,c(0,24.9,29.9,34.9)
                          ,labels = c("normal","overweight","obese")
                            
                          )
databmi

##Storing cutpoints and labels within vector
cutpoints <- c(0,24.9,29.9,34.9)
labels <- c("normal","overweight","obese")
databmi$bmigr_recode <- NULL

databmi$bmigr_recode <- cut(databmi$bmi
                            ,cutpoints
                            ,labels)
databmi

##recoding using dplyr
install.packages("dplyr")
library(dplyr)

databmi$bmigr <- NULL
databmi$bmi_code <- NULL
databmi$bmigr_lab <- NULL
databmi$bmigr_recode <- NULL

databmi <- databmi[,1:2]
databmi


databmi <- databmi %>% mutate(bmi_code = case_when(databmi$bmi <24.9~"normal"
                                                   ,databmi$bmi>=25 & databmi$bmi<29.9~"overweight"
                                                   ,databmi$bmi>=30~"obese"))
databmi
