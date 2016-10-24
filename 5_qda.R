# Quadratic Discrimmination Analysis (QDA)

# load qda, make learner
qda.learner<- makeLearner("classif.qda", predict.type = "response")

# train model
qmodel<- train(qda.learner, trainTask)

#predict on test data
qpredict<- predict(qmodel, testTask)

# create submission file if needed
# submit <- data.frame(Loan_ID = test$Loan_ID, Loan_Status = qpredict$data$response)
# write.csv(submit, "submit_qda.csv",row.names = F)