# make learner
logistic.learner<- makeLearner("classif.logreg", predict.type = "response")

# cross validation (cv) accuracy
cv.logistic<- crossval(learner = logistic.learner, task = trainTask, iters = 3, 
                       stratify = TRUE, measures = acc, show.info = F)

#cross validation accuracy
cv.logistic$aggr

# to see CV accuracy on each fold
cv.logistic$measures.test
