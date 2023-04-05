library(gbm)
library(caret)
library(mltools)
library(data.table)

set.seed(100)
imp=read.csv("Imputed_dataset1.csv")
imp$referral_source=as.factor(imp$referral_source)

sample_imp=sample(c(TRUE,FALSE),nrow(imp),replace=TRUE,prob=c(0.8,0.2))
train=imp[sample_imp,1:29]
test=imp[!sample_imp,1:29]
model_gbm = gbm(target ~.,
                data = train,
                distribution = "multinomial",
                cv.folds = 10,
                shrinkage = .01,
                n.minobsinnode = 10,
                n.trees = 500) 
summary(model_gbm)
pred_test = predict.gbm(object = model_gbm,
                        newdata = test,
                        n.trees = 500,           
                        type = "response")
pred_test
class_names = colnames(pred_test)[apply(pred_test, 1, which.max)]
result = data.frame(test$target, class_names)
print(result)
test$target=as.factor(test$target)
conf_mat = confusionMatrix(test$target, as.factor(class_names))
print(conf_mat)


