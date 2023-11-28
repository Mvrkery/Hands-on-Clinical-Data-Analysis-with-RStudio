##Basic diagnostic research analysis
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
options(scipen=999)
##Mine is the following:
setwd("C:/Course/basic R/practical 7")

library(data.table)
library(dplyr)
library(epicalc)
install.packages("pROC", repos = "http://cran.us.r-project.org")
library(pROC)
#Import the data
library(readxl)
data <- read_excel("data ca125 (excel).xlsx", 
                   col_types = c("text", "numeric", "numeric", 
                                 "numeric", "text"))
View(data)

#Explore the data
str(data)

#Prepare the data
data$cancer <- factor(data$cancer,labels = c("benign","cancer"))

#Head of the data
head(data)

#Explore the outcome (cancer vs benign)
#Using table function
table(data$cancer)

#Using tab1 function
tab1(data$cancer)

#Categorize CA125 into 2 groups at cutoff point >=35 U/ml
data$ca125gr <- ifelse(data$ca125>=35,"positive","negative")

#Explore ca125 gr
tab1(data$ca125gr)

#Create a contingency table (2x2) index test and reference test
table(data$ca125gr, data$cancer)
x <- table(data$ca125gr, data$cancer)

#True positive (TP)
TP <- x[2,2]
TP
#False positive (FP)
FP <- x[2,1] 
FP
#True negative (TN)
TN <- x[1,1]
TN
#False negative (FN)
FN <- x[1,2] 
FN
#Diseased (cases)
diseased <- TP+FN
diseased
#Non-diseased (non-cases)
nondiseased <- TN+FP
nondiseased
#All index test positive
index_pos <- TP+FP
index_pos
#All index test negative
index_neg <- TN+FN
index_neg
#Sensitivity 
sens <- TP/diseased
sens
#sens with 95% confidence interval
ci.binomial(TP, diseased, alpha = 0.05)  

#Specificity 
spec <- TN/nondiseased 
spec

#spec with 95% confidence interval
ci.binomial(TN, nondiseased, alpha = 0.05)  

#Positive predictive value (PPV)
ppv <- TP/index_pos 
ppv
  
#ppv with 95% confidence interval  
ci.binomial(TP, index_pos, alpha = 0.05)

#Negative predictive value (NPV)
npv <- TN/index_neg
npv

#npv with 95% confidence interval
ci.binomial(TN, index_neg, alpha = 0.05)

sens
spec
ppv
npv

#Receiver operating characteristics curve (ROC curve)
help(roc)
roc <- roc(cancer ~ ca125, data= data)
roc.coord <- coords(roc)
roc.coord

plot(roc)
print(roc)
##ROC cammands
auc <- auc(roc)
ci <- ci.auc(roc)
ci_l <- round(ci[1],2)
ci_u <- round(ci[3],2)

plot(roc, type="S")
legend_text <- paste0 ("AUC", round(auc,2),"(95%CI=",ci_l,"to",ci_u,")")
legend("bottomright",legend = legend_text,pch=15)
