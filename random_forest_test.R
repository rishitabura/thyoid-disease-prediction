#random forest ---- 

library(class)
library(stats)
library(dplyr)
library(randomForest)
set.seed(100)
imp=read.csv("Imputed_dataset1.csv")
imp$referral_source=as.factor(imp$referral_source)

sample_imp=sample(c(TRUE,FALSE),nrow(imp),replace=TRUE,prob=c(0.8,0.2))
train_rf1=imp[sample_imp,1:29]
test_rf1=imp[!sample_imp,1:29]


write.csv(train_rf1, "D:\\SEM 3\\DS\\DS CP\\Datasets\\train_dataset1.csv",row.names = FALSE)
write.csv(test_rf1, "D:\\SEM 3\\DS\\DS CP\\Datasets\\test_dataset1.csv",row.names = FALSE)
str(train_rf1)
train_rf1$target = as.factor(train_rf1$target)
test_rf1$target = as.factor(test_rf1$target)
#rfm1 = randomForest(target~.,data = train_rf1)

library(caret)

ctrl = trainControl(method = "cv", number =10)

#rf

fit.cv = train(target~., data = train_rf1, method ="rf",trControl = ctrl, tuneLength = 50)
pred = predict(fit.cv,test_rf1)
cfm2 = confusionMatrix(pred,test_rf1$target)
cfm2
