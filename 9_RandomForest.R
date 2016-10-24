# in this one parameter is random search instead of grid search because it is faster

# list of parameters
getParamSet("classif.randomForest")

# create a learner
rf <- makeLearner("classif.randomForest", predict.type = "response", par.vals = list(ntree = 200, mtry = 3))
rf$par.vals <- list(
  importance = TRUE
)

# set tunable parameters
# grid search to find parameters
rf_param<- makeParamSet(
  makeIntegerParam("ntree",lower = 50, upper = 500),
  makeIntegerParam("mtry", lower = 3, upper = 10),
  makeIntegerParam("nodesize", lower = 10, upper = 50)
)

# random search for 50 iterations
rancontrol <- makeTuneControlRandom(maxit = 50L)

# Though, random search is faster than grid search, but sometimes it turns out to be less efficient. 
# In grid search, the algorithm tunes over every possible combination of parameters provided. 
# In a random search, we specify the number of iterations and it randomly passes over the parameter combinations. 
# In this process, it might miss out some important combination of parameters which could have returned maximum accuracy, who knows.

# set 3 fold cross validation
set_cv<- makeResampleDesc("CV", iters = 3L)

# hypertuning
rf_tune <- tuneParams(learner = rf, resampling = set_cv, task = trainTask, par.set = rf_param, 
                      control = rancontrol, measures = acc)

# cv accuracy
rf_tune$y

# best parameters
rf_tune$x

# using hyperparameters for modeling
rf.tree <- setHyperPars(rf, par.vals = rf_tune$x)

# rain a model
rforest <- train(rf.tree, trainTask)
getLearnerModel(t.rpart)

# make predictions
rfmodel <- predict(rforest, testTask)

# create submission file if needed
# submit <- data.frame(Loan_ID = test$Loan_ID, Loan_Status = rfmodel$data$response)
# write.csv(submit, "submit_rf.csv",row.names = F)

