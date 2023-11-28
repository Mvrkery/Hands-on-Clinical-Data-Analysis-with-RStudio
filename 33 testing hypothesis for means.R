##Testing hypothesis for means
##Set working directory
##Session > Set Working Directory > Choose Directory...
setwd("The path to your directory")
##Mine is the following:
setwd("C:/Course/basic R/practical 3")

##Import the data
library(readxl)
data <- read_excel("data_er_los (excel).xlsx", 
                   col_types = c("text", "text", "numeric", 
                                 "text", "text", "text", "text", "text", 
                                 "text", "date", "text", "text", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric", "numeric", "numeric", 
                                 "numeric"))
View(data)

##Preparing data
data$sex <- factor(data$sex, labels=c("Female", "Male"))
data$insur <-factor(data$insur,labels=c("UC","CS","SSSS","Fullpay"))
data$nation <-factor(data$nation,labels=c("Thai","Nationprob","Burmese","Foreigner"))
data$triage <-factor(data$triage,labels=c("NU","SU","U","E","R"))
data$trauma<-factor(data$trauma,labels=c("Non-trauma","Trauma"))
data$dispose<-factor(data$dispose,labels=c("discharge","admit","refer","reject","death"))
data$weekend<-factor(data$weekend,labels=c("weekday","weekend"))
data$shift<-factor(data$shift,labels=c("morning","afternoon","night"))

##Check structure of the data frame
str(data)

#Check the class of the data
class(data)

##If you want to, you can change tibble to data frame format
data <- as.data.frame(data)
class(data)

##If we want to test the difference in age between traumatic and non-traumatic presentation
##We might hypothesize that the age would be different (younger in trauma, probably)
##H0: age in trauma = age in non-trauma
##H1: age in trauma != age in non-trauma

##First, we should describe the summary statistics for each group.
library(data.table)
data <- data.table(data)
data.trauma <- data[data$trauma=="Trauma"]
data.nontrauma <- data[data$trauma=="Non-trauma"]

summary(data.trauma$age)
sd(data.trauma$age)
summary(data.nontrauma)
sd(data.nontrauma$age)


##Boxplot sometimes help
boxplot(data$age ~ data$trauma)

##Second, we check for the distribution of the data and choose the appropriate
##statistics accordingly.
hist(data.trauma$age)
hist(data.nontrauma$age)



##using dplyr
library(dplyr)
data %>% group_by(trauma) %>% summarize(n(),
                                        mean=mean(age)
                                        ,sd=sd(age)
                                        ,median= median(age))





##using data.table
data[,.(n=length(age)
        ,mean=mean(age)
        ,sd=sd(age)
        ,median=median(age)),by=trauma]

##Then, we performed the test
#Independent t-test
help("t.test")
t.test(data$age ~ data$trauma)



##Equal variance
t.test(data$age ~ data$trauma, var.equal=TRUE)

##Unequal variance (Welch)
t.test(data$age ~ data$trauma, var.equal=FALSE)


#calculate the mean difference
50.45514 -44.72611 


#Man-Whitney U test (for skewed distribution)
hist(data.trauma$age)
wilcox.test(data$age ~ data$trauma)

##If we want to test the difference in LOS between trauma and non-trauma, 
##how should we do it?




##Describe it first
summary(data.trauma$los)
sd(data.trauma$los)


summary(data.trauma$los)
sd(data.nontrauma$los)

##Boxplot 
boxplot(data$los~data$trauma, horizontal = TRUE, outline=FALSE)

##Check for distribution
hist(data.trauma$los)
hist(data.nontrauma$los)

#Man-Whitney U test (for skewed distribution)
wilcox.test(data$los~data$trauma)

#If scientific number do not fully show
options(scipen = 999)


##If we want to test the difference in age among different levels of triage
table(data$triage)


##Describe
data %>% group_by(triage) %>% summarize(n()
                                        ,mean=mean(age)
                                        ,sd=sd(age)
                                        ,median=median(age)
                                        ,p25=quantile(age,probs=0.25)
                                        ,p75=quantile(age, probs = 0.75))

##Boxplot
boxplot(data$age ~data$triage, horizontal = TRUE, outline=FALSE)

##One way ANOVA (analysis of variance)
res.aov <- aov(data$age ~ data$triage)
summary(res.aov)


##Pairwise comparisons using t tests with pooled 
##P value adjustment method: bonferroni 
pairwise.t.test(data$age, data$triage, p.adjust.method = "bonferroni")




##Tukey multiple comparisons of means
TukeyHSD(res.aov)



##If we want to test the difference in LOS among different levels of triage
##Describe
data %>% group_by(triage) %>% summarize(n()
                                        ,mean=mean(los)
                                        ,sd=sd(los)
                                        ,median=median(los)
                                        ,p25=quantile(los,probs=0.25)
                                        ,p75=quantile(los, probs = 0.75))
##Boxplot
boxplot(data$los ~ data$triage, horizontal = TRUE, outline= FALSE)


##Kruskal-Wallis rank test
help("kruskal.test")
kruskal.test(data$los~data$triage)



##Pairwise comparisons using wilcoxon's test
##P value adjustment method: bonferroni 
pairwise.wilcox.test(data$los, data$triage, p.adjust.method = "bonferroni", exact = F)




