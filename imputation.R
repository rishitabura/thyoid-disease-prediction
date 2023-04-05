#imputation 

#library(ggplot2)   -- not needed 
#library(cowplot)   -- not needed
library(randomForest)
data <- read.csv("Thyroid_Dataset 5.csv")
print(data)
View(data)
str(data)
table(data$target)
data$age <- as.numeric(data$age)
data$sex <- as.factor(data$sex)
data$on_thyroxine <- as.factor(data$on_thyroxine)
data$query_on_thyroxine <- as.factor(data$query_on_thyroxine)
data$on_antithyroid_meds <- as.factor(data$on_antithyroid_meds)
data$sick <- as.factor(data$sick)
data$pregnant <- as.factor(data$pregnant)
data$thyroid_surgery <- as.factor(data$thyroid_surgery)
data$I131_treatment <- as.factor(data$I131_treatment)
data$query_hypothyroid <- as.factor(data$query_hypothyroid)
data$query_hyperthyroid <- as.factor(data$query_hyperthyroid)
data$lithium <- as.factor(data$lithium)
data$goitre <- as.factor(data$goitre)
data$tumor <- as.factor(data$tumor)
data$hypopituitary <- as.factor(data$hypopituitary)
data$psych <- as.factor(data$psych)
data$TSH_measured <- as.factor(data$TSH_measured)
#data$TSH <- as.factor(data$TSH)
data$T3_measured <- as.factor(data$T3_measured)
#data$T3 <- as.factor(data$T3)
data$TT4_measured <- as.factor(data$TT4_measured)
#data$TT4 <- as.factor(data$TT4)
data$T4U_measured <- as.factor(data$T4U_measured)
#data$T4U <- as.factor(data$T4U)
data$FTI_measured <- as.factor(data$FTI_measured)
#data$FTI <- as.factor(data$FTI)
data$TBG_measured <- as.factor(data$TBG_measured)
data$referral_source <- as.factor(data$referral_source)
data$target <- as.factor(data$target)
data$patient_id <- as.numeric(data$patient_id)

str(data)
set.seed(42)
data <- droplevels(data)
data.na<- data

data.imputed <- rfImpute(target ~ . ,  data=data)
write.csv(data.imputed,"D:\\SY NOTES\\DS\\DS CP\\Datasets\\Imputed_dataset.csv",row.names = FALSE)








