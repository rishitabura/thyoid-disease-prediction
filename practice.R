library(randomForest)
data <- read.csv("Thyroid_Dataset 5.csv")
print(data)
View(data)
str(data)
table(data$target)

set.seed(42)
data <- droplevels(data)
data.na<- data
data.imputed <- rfImpute(target ~ . ,  data=data)
