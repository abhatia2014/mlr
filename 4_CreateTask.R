# Create a task

trainTask<- makeClassifTask(data = cd_train, target = "Loan_Status")
testTask<- makeClassifTask(data = cd_test, target = "Loan_Status")

# Look at trainTask and the Positive class = N 

# modify the positive task to Y and not N 
trainTask<- makeClassifTask(data = cd_train, target = "Loan_Status", positive = "Y")

# normalize the variables
trainTask<- normalizeFeatures(trainTask, method = "standardize")
testTask<- normalizeFeatures(testTask, method = "standardize")

# remove not needed variables
trainTask <- dropFeatures(task = trainTask,features = c("Loan_ID","Married.dummy"))

# Feature importance and plot 
im_feat<- generateFilterValuesData(trainTask, method = c("information.gain", "chi.squared"))
plotFilterValues(im_feat, n.show = 20)

# to see some of the available algorithms for classification problem
# listLearners("classif")[c("class","package")]