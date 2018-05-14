## Machine learning techniques on Victoria Moignard data 
## https://www.sciencedirect.com/science/article/pii/S1079979613001587?via%3Dihub

library(MASS)     ## performs LDA

data <- read.csv("../data/NIHMS53736-supplement-9.csv")

input <- as.data.frame(data) 
input[,1] <- sapply(as.character(input[,"Cell"]),
                 function(x) substr(x,1,nchar(x)-3))
input[,1] <- as.factor(input[,1])



## Hierarchical clustering heatmap
heatmap(as.matrix(data.df),Colv = NA)

#############################################################################
n_train <- 0.8*nrow(input)

train <- sample(1:nrow(input),n_train)

lin.dis <- lda(Cell~.,data=input,subset=train)
ld.predict <- predict(lin.dis,newdata = input[-train,])

## Observed
clps <- rep("non CLP",nrow(input[-train,]))
clps[input[-train,"Cell"]=="CLP"] <- "CLP"
clps[1:10]

## Predicted
pred_class <- rep("non CLP",nrow(input[-train,]))
pred_class[ld.predict$class[-train]=="CLP"] <- "CLP"
table(pred_class,clps)


## predicted with threshold
pred_class_t <- rep("non CLP",nrow(input[-train,]))
pred_class_t[ld.predict$posterior[,1]>=0.45] <- "CLP" 
table(pred_class_t,clps)

## binarize an array
ifelse(abs(cor_data[1:nrow(cor_data),]) == 1,1,0)


