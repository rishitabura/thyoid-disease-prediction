library(rpart)
library(rpart.plot)
data <- read.csv("Thyroid_Dataset 5.csv")
View(data)

tree<- rpart(TSH ~ TSH_measured + T3_measured,data)
a <- data.frame(TSH_measured = c("f") , T3_measured = c("t"))
result <- predict(tree,a)
print(result)

tree<- rpart()
a <- data.frame()
result <- predict()
print(result)

rpart.plot(tree)
