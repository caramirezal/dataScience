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
initialTime <- Sys.time()
forest <- cforest(Cell~.,data=data)
forest.pred <- predict(forest,newdata=data)
onfusionMatrix(forest.pred,data$Cell)$overall[1]
finalTime <- Sys.time() - initialTime
finalTime

######################################################################
## performing parameter variation

## number of simulations
nsims <- 2
## parameter to vary
parameter <- seq(0.8,1,0.2)
results <- matrix(0,nsims*length(parameter),2)
colnames(results) <- c("accuracy","parameter")


for (i in 1:length(parameter)){
        for (j in 1:nsims) {
                train <- createDataPartition(data$Cell,p=parameter,list=FALSE)
                forest <- cforest(Cell~.,data=data,subset = train)
                forest.pred <- predict(forest,newdata=data[-train,])
                
                ## index to store simulation data
                index <- (nsims*(i-1)) + j
                
                ## storing results
                results[index,1] <- confusionMatrix(forest.pred,
                                                    data$Cell[-train])$overall[1]
                results[index,2] <- parameter[i]
        } 
}
results
