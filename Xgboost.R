library(xgboost)
library(magrittr)
library(dplyr)
library(Matrix)
library(caret)

set.seed(100)
imp=read.csv("Imputed_dataset1.csv")
imp$referral_source=as.factor(imp$referral_source)
sample_imp=sample(c(TRUE,FALSE),nrow(imp),replace=TRUE,prob=c(0.8,0.2))

train_imp=imp[sample_imp,1:29]
test_imp=imp[!sample_imp,1:29]

trainlabel_imp=train_imp[,"target"]
testlabel_imp=test_imp[,"target"]

trainm=sparse.model.matrix(target~.-1,data=train_imp)
train_label=train_imp[,"target"]
train_matrix=xgb.DMatrix(data=as.matrix(trainm),label=train_label)

testm=sparse.model.matrix(target~.-1 ,data = test_imp)
test_label=test_imp[,"target"]
test_matrix=xgb.DMatrix(data=as.matrix(testm),label=test_label)

nc=length(unique(train_label))
nc

xgb_params=list("objective"="multi:softprob","eval_metric"="mlogloss","num_class"=nc)
watchlist=list(train=train_matrix,test=test_matrix)

bst_model=xgb.train(params = xgb_params,data=train_matrix,nround=200,watchlist = watchlist,eta=0.05,max.depth=6,gamma=0,subsample=1,colsample_bytree=1,missing =NA,seed=100)
bst_model

e=data.frame(bst_model$evaluation_log)
plot(e$iter,e$train_mlogloss,col='blue')
lines(e$iter,e$test_mlogloss, col='red')

imp=xgb.importance(colnames(train_matrix),model = bst_model)
print(imp)
xgb.plot.importance(imp)

pr=predict(bst_model,newdata = test_matrix)
head(pr)

pred=matrix(pr,nrow=nc,ncol=length(pr)/nc) %>% t() %>% data.frame() %>% mutate(label=test_label,max_prob=max.col(.,"last")-1)
head(pred)

pred$max_prob=as.factor(pred$max_prob)
pred$label=as.factor(pred$label)

cfm1=confusionMatrix(pred$max_prob,pred$label)
cfm1
