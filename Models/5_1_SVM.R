# install kernlab package
# load SVM
getParamSet("classif.ksvm") 
ksvm<- makeLearner("classif.ksvm", predict.type = "response")

# set parameters
pssvm<- makeParamSet(
  makeDiscreteParam('C', values = 2^c(-8, -4, -2, 0)), # cost parameters
  makeDiscreteParam('sigma', values = 2^c(-8, -4, 0, 4)) # RBF Kernel Parameter
)

# specify search function
ctrl<- makeTuneControlGrid()

# tune model
res<- tuneParams(ksvm, task = trainTask, resampling = set_cv, par.set = pssvm, 
                 control = ctrl, measures = acc)

# CV accuracy
res$y

# set the model with best params
t.svm <- setHyperPars(ksvm, par.vals = res$x)

# train
par.svm <- train(ksvm, trainTask)

# test
predict.svm <- predict(par.svm, testTask)

# create submission file if needed
# submit <- data.frame(Loan_ID = test$Loan_ID, Loan_Status = predict.svm$data$response)
# write.csv(submit, "submit_svm.csv",row.names = F)
