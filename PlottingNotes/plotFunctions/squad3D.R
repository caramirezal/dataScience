library(plot3D)
library(BoolNet)
library(deSolve)
library(animation)


partition<-seq(0,1,length.out =8 )
#net<-loadNetwork("cartoonNetwork.R")

partition3D<-function(partition1D){
  numberOfPoints<-(length(partition1D))**3
  x0<-rep(0,numberOfPoints)
  for (i in 1:(numberOfPoints-1) ){
    index<-i%%(length(partition1D)) + 1
    x0[i+1]<-partition1D[index]
  }
  # definition of x1
  x1<-rep(0,numberOfPoints)
  for (j in 1:(numberOfPoints-1) ){
    index<- ( floor(j/(length(partition1D)) )  %% length(partition1D) ) + 1
    x1[j+1]<-partition1D[index]
  }
  # definition of x3
  x2<-rep(0,numberOfPoints)
  for (k in 1:(numberOfPoints-1 )){
    index<- ( floor(k/(length(partition1D)**2))  %% length(partition1D) ) + 1
    x2[k+1]<-partition1D[index]
  }
  return(list(x0,x1,x2))
}

# define parameters
parameters <- c(h = 50,gamma = 1)
h<-parameters[1]
gamma<-parameters[2]

# define ODEs
squadInteractions<-function(times,state,parameters) {
  with(as.list(c(state,parameters)),{
    w_A <- A
    w_B <- min(A,1-C)
    w_C <- 1 - max(A,B)
    A <- ((-exp(0.5*h) + exp(-h*(w_A-0.5))) / ((1-exp(0.5*h)) * (1+exp(-h*(w_A-0.5))))) - (gamma*A)
    B <- ((-exp(0.5*h) + exp(-h*(w_B-0.5))) / ((1-exp(0.5*h)) * (1+exp(-h*(w_B-0.5))))) - (gamma*B)
    C <- ((-exp(0.5*h) + exp(-h*(w_C-0.5))) / ((1-exp(0.5*h)) * (1+exp(-h*(w_C-0.5))))) - (gamma*C)
    return(list(c(A,B,C)))
  })
}


patterns<-list("attractor1"=c(0,0,1),"attractor2"=c(1,1,0))
genes<-c("A","B","C")
P<-partition3D(partition)
times<-seq(0,50,by=0.1)
defaultVal<-0
state<-rep(defaultVal,length(genes))
names(state)<-genes
Q<-P
colores<-rep("black",length(P[[1]]) )
for (i in 1:length(P[[1]])){
  state[genes[1]]<-P[[1]][i]
  state[genes[2]]<-P[[2]][i]
  state[genes[3]]<-P[[3]][i]
  #cat(names(state),"\n")
  #cat(state,"\n")
  result<-ode(y=state,times=times,func=squadInteractions,parms = parameters,atol=10e-6, rtol=10e-6)
  #cat( "Result: ",result[length(result[,1]),], "\n")
  Q[[1]][i]<-result[2,genes[1]]
  Q[[2]][i]<-result[2,genes[2]]
  Q[[3]][i]<-result[2,genes[3]]
  stationaryPoint<-rep(0,3)
  stationaryPoint[1]<-result[length(result[,1]),genes[1]]
  stationaryPoint[2]<-result[length(result[,1]),genes[2]]
  stationaryPoint[3]<-result[length(result[,1]),genes[3]]
  #cat(stationaryPoint,"\n")
  for (j in 1:length(stationaryPoint)){
    if (stationaryPoint[j]<0.05) {
      stationaryPoint[j]<-0
    }
    if (0.95<stationaryPoint[j]){
      stationaryPoint[j]<-1
    }
  }
  if (all(patterns[[1]]==stationaryPoint)){
    colores[i]<-"red"
  }
  if (all(patterns[[2]]==stationaryPoint)){
    colores[i]<-"green"
  }
}
#cat(colores,"\n")

tiff("phaseSpaceContinuous.tiff")
arrows3D(P[[1]],P[[2]],P[[3]],Q[[1]],Q[[2]],Q[[3]],theta = -7,length=0.2,col = colores)
points3D(0, 0, 1, add = TRUE, col="red", 
        colkey = FALSE, pch = 19, cex = 2.5)
        points3D(1, 1, 0, add = TRUE, col="green", 
        colkey = FALSE, pch = 19, cex = 2.5)
dev.off()

#saveGIF({
#  theta<-seq(0,360,by=10)
#  for (i in 1:length(theta)){
#    arrows3D(P[[1]],P[[2]],P[[3]],Q[[1]],Q[[2]],Q[[3]],theta = theta[i],length=0.2,col = colores)
#    points3D(0, 0, 1, add = TRUE, col="red", 
#             colkey = FALSE, pch = 19, cex = 2.5)
#    points3D(1, 1, 0, add = TRUE, col="green", 
#             colkey = FALSE, pch = 19, cex = 2.5)
#  }
#})
