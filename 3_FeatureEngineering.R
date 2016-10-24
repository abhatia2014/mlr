#################### Feature Engineering

#cap data for train data set
cd<- capLargeValues(imp_train, target = "Loan_Status",cols = c("ApplicantIncome"), threshold = 40000)
cd<- capLargeValues(cd, target = "Loan_Status", cols = c("CoapplicantIncome"), threshold = 21000)
cd<- capLargeValues(cd, target = "Loan_Status", cols = c("LoanAmount"), threshold = 520)

cd_train<- cd

# add a dummy Loan_Status column in test data
imp_test$Loan_Status<- sample(0:1, size = 367, replace = T)

# cap data for test data set
cde<- capLargeValues(imp_test, target = "Loan_Status", cols = c("ApplicantIncome"), threshold = 33000)
cde<- capLargeValues(cde, target = "Loan_Status", cols = c("CoapplicantIncome"), threshold = 16000)
cde<- capLargeValues(cde, target = "Loan_Status", cols = c("LoanAmount"), threshold = 470)

cd_test<- cde

# convert numeric to factor - train
for (f in names(cd_train[, c(14:20)])){
  if(class(cd_train[, c(14:20)] [[f]]) == "numeric"){
    levels<- unique(cd_train[, c(14:20)][[f]])
    cd_train[, c(14:20)][[f]]<- as.factor(factor(cd_train[, c(14:20)][[f]], levels = levels))
  }
}

# convert numeric to factor - test
for (f in names(cd_test[, c(13:18)])){
  if(class(cd_test[, c(13:18)] [[f]]) == "numeric"){
    levels<- unique(cd_test[, c(13:18)][[f]])
    cd_test[, c(13:18)][[f]]<- as.factor(factor(cd_test[, c(13:18)][[f]], levels = levels))
  }
}

# Total_Income
cd_train$Total_Income<- cd_train$ApplicantIncome + cd_train$CoapplicantIncome
cd_test$Total_Income<- cd_test$ApplicantIncome + cd_test$CoapplicantIncome

# Income by loan
cd_train$Income_by_loan<- cd_train$Total_Income/cd_train$LoanAmount
cd_test$Income_by_loan<- cd_test$Total_Income/cd_test$LoanAmount

# change variable class
# not really needed because the variable is already numeric, but the tuto had it
cd_train$Loan_Amount_Term<- as.numeric(cd_train$Loan_Amount_Term)
cd_test$Loan_Amount_Term<- as.numeric(cd_test$Loan_Amount_Term)

#Loan amount by term
cd_train$Loan_amount_by_term<- cd_train$LoanAmount/cd_train$Loan_Amount_Term
cd_test$Loan_amount_by_term<- cd_test$LoanAmount/cd_test$Loan_Amount_Term

#splitting the data based on class, to check if new variables are correlated
az<- split(names(cd_train), sapply(cd_train, function(x){ class(x)}))

#creating a data frame of numeric variables
xs<- cd_train[az$numeric]

#check correlation
cor(xs)

# there exists a very high correlation of Total_Income with ApplicantIncome. 
# It means that the new variable isn't providing any new information. 
# Thus, this variable is not helpful for modeling data.

cd_train$Total_Income<- NULL
cd_test$Total_Income<- NULL


