#################### Missing value Imputation

# impute missing values by mean and mode 
imp<- impute(train, classes = list(factor = imputeMode(), integer = imputeMean()),
             dummy.classes = c('integer', 'factor'), dummy.type = 'numeric')
imp1<- impute(test, classes = list(factor = imputeMode(), integer = imputeMean()), 
              dummy.classes = c('integer', 'factor'), dummy.type = 'numeric')

imp_train<- imp$data
imp_test<- imp1$data

# Married.dummy variable exists only in imp_train and not in imp_test. 
# Therefore, we'll have to remove it before modeling stage.