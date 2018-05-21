
library(ggmap)
library(lubridate)
library(dplyr)

## coordinates of the center of the map
myLocation <- c(-100.27,20.25)

myMap <- get_map(location = myLocation,
                 source="google",
                 maptype = "hybrid",
                 crop=FALSE,
                 zoom = 4 )

###########################################################################################
## data were retrieved from sismologico nacional found here:
## http://www2.ssn.unam.mx:8080/catalogo/

## data processing
data <- read.csv("../data/SSNMX_catalogo_19500101_20180521.csv",skip = 4,stringsAsFactors = FALSE)
data <- mutate(data,Fecha=as.POSIXct(strptime(data$Fecha.UTC, format = "%Y-%m-%d")))

## data slice and processing
data.p <- filter(data,Fecha > '1980-01-01')
data.p <- select(data.p,Fecha:Profundidad)
data.p <- mutate(data.p,Magnitud=as.numeric(Magnitud))
data.p <- mutate(data.p,Profundidad=as.numeric(Profundidad))
data.p <- mutate(data.p, time=as.POSIXct(paste(data.p$Fecha,data.p$Hora),format = "%Y-%m-%d %H:%M:%S"))
data.p <- data.p[complete.cases(data.p),]
data.p <- arrange(data.p,time)
head(data.p)


## plotting tremors data
data.s <- filter(data.p)
jpeg("../figures/tremors.jpg")
g <- ggmap(myMap) 
g <- g + geom_point(aes(x=Longitud,y=Latitud,
                        colour=Magnitud,
                        size=exp(Magnitud),
                        alpha=magnNorm),
                    data=data.s) 
g <- g + scale_color_gradient(low="yellow",high = "red")
g <- g + scale_size_continuous(range = c(0.1,7))
plot(g)
dev.off()

###########################################################################################
## exploratory plots

## magnitud dynamic
plot(data.p$time,
     data.p$Magnitud,
     type="l",lwd=2,col="steelblue",
     xlab = "Time",ylab = "Magnitud",font.lab=2)
head(data.p)



## normalizing Magnitud
data.p <- mutate(data.p,magnNorm=(Magnitud-min(Magnitud))/
                         (max(Magnitud)-min(Magnitud)))
data.p <- mutate(data.p,profundidadNorm=(Profundidad-mean(Profundidad))/sd(Profundidad))
data.p <- mutate(data.p,distancia=(19.390519-Latitud)^2+(99.4238064-Longitud)^2) ## distance to cdmx
data.p <- mutate(data.p,proximidad=1/distancia)



