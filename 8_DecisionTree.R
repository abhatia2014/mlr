#  get the list of parameters for any algorithm
getParamSet("classif.rpart")

# make tree learner
makeatree<- makeLearner("classif.rpart", predict.type = "response")

# set 3 fold cross validation
set_cv<- makeResampleDesc("CV", iters = 3L)

# search for hyperparameters
gs<- makeParamSet(
  makeIntegerParam("minsplit", lower = 10, upper = 50),
  makeIntegerParam("minbucket", lower = 5, upper = 50),
  makeNumericParam("cp", lower = 0.001, upper = 0.2)
)

# minsplit represents the minimum number of observation in a node for a split to take place. 
# minbucket says the minimum number of observation I should keep in terminal nodes. 
# cp is the complexity parameter. 
# The lesser it is, the tree will learn more specific relations in the data which might result in overfitting.

# do a grid search
gscontrol<- makeTuneControlGrid()

# hypertune the parameters
stune<- tuneParams(learner = makeatree, resampling = set_cv, task = trainTask, par.set = gs, 
                   control = gscontrol, measures = acc)

# check the best parameter
stune$x

# check the CV result
stune$y

# using hyperparameters for modeling to set the best parameters as modeling parameters
t.tree<- setHyperPars(makeatree, par.vals = stune$x)

# train the model
t.rpart<- train(t.tree, trainTask)
getLearnerModel(t.rpart)

# make predictions
tpmodel<- predict(t.rpart, testTask)

# create submission file if needed
# submit <- data.frame(Loan_ID = test$Loan_ID, Loan_Status = tpmodel$data$response)
# write.csv(submit, "submit_dt.csv",row.names = F)
