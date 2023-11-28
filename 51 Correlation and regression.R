##Correlation and regression
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
options(scipen=999)
##Mine is the following:
install.packages("tidyr")
library(tidyr)
install.packages("ggpubr")
library("ggpubr")

##Import the data
library(readxl)
data <- read_excel("data hb albumin (excel).xlsx", 
                              col_types = c("text", "numeric", "numeric", 
                                            "numeric"))
View(data)


##Check structure of the data frame
str(data)

#exploring data
head(data)

#summarize data
summary(data$albumin)
sd(data$albumin, na.rm = TRUE) #ignore na
summary(data$hb)
sd(data$hb, na.rm = TRUE)


#check distribution of the data
hist(data$albumin)
boxplot(data$albumin)
hist(data$hb)
boxplot(data$hb)

#Plot two-way scatter plot to examine correlation pattern
## x -> albumin (surrogate of nutrition status)
## Y -> hb
help(plot)
plot(data$albumin, data$hb)

#Add linear prediction line
abline(lm(data$hb ~ data$albumin), col ="red") #lm( y ~ x )


#Add LOWESS line (x,y)
plot(data$albumin, data$hb)
line(lowess(data$albumin, data$hb))
##LOWESS line won't run with missing data
##Drop records with missing data out
data.complete <- data%>% drop_na()

#Add LOWESS line (x,y)
plot(data.complete$albumin, data.complete$hb)
lines(lowess(data.complete$albumin, data.complete$hb), col="blue")

##Correlation analysis
##cor.test(x, y, method=c("pearson", "kendall", "spearman"))
cor.test(data$albumin, data$hb, method = "pearson")
cor.test(data$albumin, data$hb, method = "spearman")

options(scipen = 999)


#Scatter plot with ggpubr
help("ggpubr")
ggscatter(data, x="albumin", y="hb", add="reg.line", conf.int = TRUE
          ,cor.coef = TRUE
          ,cor.method = "pearson"
          ,xlab="albumin level"
          ,ylab = "Hemoglobin")
