#random forest ---- 

library(class)
library(stats)
library(dplyr)
library(randomForest)
rf1<- read.csv("Imputed_dataset1.csv")
View(rf1)
ncol(rf1)

library(caTools)
split = sample.split(rf1$target, SplitRatio = 0.8)
train_rf1 = subset(rf1, split == TRUE)
test_rf1 = subset(rf1, split == FALSE)

write.csv(train_rf1, "D:\\SEM 3\\DS\\DS CP\\Datasets\\train_dataset1.csv",row.names = FALSE)
write.csv(test_rf1, "D:\\SEM 3\\DS\\DS CP\\Datasets\\test_dataset1.csv",row.names = FALSE)
str(train_rf1)
train_rf1$target = as.factor(train_rf1$target)
test_rf1$target = as.factor(test_rf1$target)

#random forset model
rfm1 = randomForest(target~.,data = train_rf1)

#caret
library(caret)

#train data
p1 = predict(rfm1,train_rf1)
cfm1 = confusionMatrix(p1,train_rf1$target)
cfml
ctrl = trainControl(method = "cv", number =10)

#rf

fit.cv = train(target~., data = train_rf1, method ="rf",trControl = ctrl, tuneLength = 50)

pred = predict(fit.cv,test_rf1)
cfm2 = confusionMatrix(pred,test_rf1$target)
View(pred)
cfm2
