# install pasckage gbm
# load GBM 
getParamSet("classif.gbm")
g.gbm <- makeLearner("classif.gbm", predict.type = "response")

# specify tuning method
rancontrol <- makeTuneControlRandom(maxit = 50L)

# 3 fold cross validation
set_cv <- makeResampleDesc("CV",iters = 3L)

# parameters
gbm_par<- makeParamSet(
  makeDiscreteParam("distribution", values = "bernoulli"),
  makeIntegerParam("n.trees", lower = 100, upper = 1000), #number of trees
  makeIntegerParam("interaction.depth", lower = 2, upper = 10), #depth of tree
  makeIntegerParam("n.minobsinnode", lower = 10, upper = 80),
  makeNumericParam("shrinkage",lower = 0.01, upper = 1)
)

# n.minobsinnode refers to the minimum number of observations in a tree node. 
# shrinkage is the regulation parameter which dictates how fast / slow the algorithm should move.

# tune parameters
tune_gbm <- tuneParams(learner = g.gbm, task = trainTask,resampling = set_cv,measures = acc,par.set = gbm_par,control = rancontrol)

# check CV accuracy
tune_gbm$y

# set parameters
final_gbm <- setHyperPars(learner = g.gbm, par.vals = tune_gbm$x)

# train
to.gbm <- train(final_gbm, trainTask)

# test
pr.gbm <- predict(to.gbm, testTask)

# create submission file if needed
# submit <- data.frame(Loan_ID = test$Loan_ID, Loan_Status = pr.gbm$data$response)
# write.csv(submit, "submit_gbm.csv",row.names = F)

