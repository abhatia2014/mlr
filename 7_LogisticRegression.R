# make learner
logistic.learner<- makeLearner("classif.logreg", predict.type = "response")

# cross validation (cv) accuracy
cv.logistic<- crossval(learner = logistic.learner, task = trainTask, iters = 3, 
                       stratify = TRUE, measures = acc, show.info = F)

#cross validation accuracy
cv.logistic$aggr

# to see CV accuracy on each fold
cv.logistic$measures.test

# train model
fmodel<- train(logistic.learner, trainTask)
getLearnerModel(fmodel)

# predict on test data
fpmodel<- predict(fmodel,testTask)

# create submission file
# submit <- data.frame(Loan_ID = test$Loan_ID, Loan_Status = fpmodel$data$response)
# write.csv(submit, "submit_lr.csv",row.names = F)
