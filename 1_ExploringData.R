#################### Exploring data using mlr package

library(mlr)

train <- read.csv("train.csv", na.strings = c(""," ",NA))
test <- read.csv("test.csv", na.strings = c(""," ",NA))

summary(train)
str(train)
summarizeColumns(train)

hist(train$ApplicantIncome, breaks = 300, main = "Applicant Income Chart", xlab = "ApplicantIncome")
hist(train$CoapplicantIncome, breaks = 100, main = "Coapplicant Income Chart", xlab = "CoapplicantIncome")

boxplot(train$ApplicantIncome)
boxplot(train$CoapplicantIncome)
boxplot(train$LoanAmount)

train$Credit_History<- as.factor(train$Credit_History)
test$Credit_History<- as.factor(test$Credit_History)

#rename level of Dependents, it has a level "3+" as a factor
levels(train$Dependents)[4]<- '3'
levels(test$Dependents)[4]<- '3'