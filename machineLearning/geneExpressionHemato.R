## Machine learning techniques on Victoria Moignard data 
## https://www.sciencedirect.com/science/article/pii/S1079979613001587?via%3Dihub

library(MASS)     ## performs LDA
library(caret)
library(dplyr)
library(e1071)    ## necessary to load caret lda
library(ggplot2)

data <- read.csv("../data/NIHMS53736-supplement-9.csv")

input <- data
input[,1] <- sapply(as.character(input[,"Cell"]),
                 function(x) substr(x,1,nchar(x)-3))
input[,1] <- as.factor(input[,1])


## Hierarchical clustering heatmap
heatmap(as.matrix(input[,-1]),Colv = NA)

#############################################################################
## performing lda using caret

## Create data partition
train <- createDataPartition(input[,"Cell"],p = 0.8,list = FALSE)

## Using caret to perform lda and to get confusion matrix
## perform lad
lda.fit <- train(Cell~.,data=input,subset=train,method="lda")

## perform prediction
lda.prediction <- predict(lda.fit,newdata = input[-train,])

## calculate confusion matrix
confusion.m <- confusionMatrix(lda.prediction,input$Cell[-train])

############################################################################
## performing iteration over technique using trainControl
## 10 repeats and nfold = 5
fitControl <- trainControl(method = "repeatedcv",repeats = 10,number = 5)
lda.fit <- train(Cell~.,data=input,subset=train,
                 method="lda",
                 trControl=fitControl) ## definition of the iteration
                 
head(lda.fit$resample)  ## accuracy results for every simulation
lda.fit$results    ## mean and sd values for accuracy and kappa

###########################################################################
## PCA preprocessing using caret
lda.fit <- train(Cell~.,data=input,subset=train,method="lda",preProcess="pca")
lda.prediction <- predict(lda.fit,newdata = input[-train,])
confusion.m <- confusionMatrix(lda.prediction,input$Cell[-train])
confusion.m


############################################################################
## PCA rotation
rotated <- prcomp(input[,-1])

## plotting two principal components
plot(rotated$x[,1],rotated$x[,2],col=input[,"Cell"],pch=20)
