library(party)   ## for cforest
library(caret)

## preprocessing
data <- read.csv("../data/NIHMS53736-supplement-9.csv")
str(data)
data$Cell <- sapply(as.character(data$Cell), 
                    function(x) substr(x,1,nchar(x)-3))
data$Cell <- as.factor(data$Cell)

#######################################################################
## cforest implementation of random forest
## One simple simulation with default values
forest <- cforest(Cell~.,data=data)
forest.pred <- predict(forest,newdata=data)
confusionMatrix(forest.pred,data$Cell)

