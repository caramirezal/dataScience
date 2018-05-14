## Machine learning techniques on Victoria Moignard data 
## https://www.sciencedirect.com/science/article/pii/S1079979613001587?via%3Dihub

library(MASS)     ## performs LDA

data <- read.csv("../data/NIHMS53736-supplement-9.csv")

input <- as.data.frame(data) 
input[,1] <- sapply(as.character(input[,"Cell"]),
                 function(x) substr(x,1,nchar(x)-3))



## Hierarchical clustering heatmap
heatmap(as.matrix(data.df),Colv = NA)

#############################################################################
n_train <- 0.8*nrow(input)

train <- sample(1:nrow(input),n_train)

lin.dis <- lda(Cell~.,data=input,subset=train)
ld.predict <- predict(lin.dis,newdata = input[-train,])

names(ld.predict)
clps <- rep("non CLP",nrow(input))
clps[ld.predict$posterior[,"CLP"] >= 0.5] <- "CLP"

ld.predict$class
pred_class <- rep("non CLP",nrow(input))
pred_class[ld.predict$class=="CLP"] <- "CLP"
table(pred_class,clps)
