
mkHist <- function(vectorVar){
        
        hist(vectorVar,col = "green")
        rug(vectorVar)
        abline(v=mean(vectorVar),col="red",lwd=3)
        text(mean(vectorVar),15,"mean")
        
        
}