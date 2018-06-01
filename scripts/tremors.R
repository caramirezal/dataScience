
library(ggmap)
library(lubridate)
library(dplyr)
library(gridExtra)

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
data <- read.csv("../data/tremors.csv",skip = 4,stringsAsFactors = FALSE)
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
data.s <- filter(data.p, time > '2018-05-01' & Magnitud > 4 )
jpeg("../figures/tremors.jpg")

## Map of tremors
g <- ggmap(myMap) 
g <- g + geom_point(aes(x=Longitud,y=Latitud,
                        colour=Magnitud,
                        size=exp(Magnitud)),
                    data=data.s) 
g <- g + scale_color_gradient(low="yellow",high = "red")
g <- g + scale_size_continuous(range = c(0.1,7))
g <- g + xlab("Longitud") + ylab("Latitud")
g <- g + theme(legend.position = "none")
g <- g + theme(axis.title.x = element_text(face="bold"),
                 axis.title.y = element_text(face="bold"))
plot(g)

###########################################################################################
# Trends in tremors magnitud
theme_set(theme_bw())
g1 <- ggplot(data=data.p, aes(x=time,y=Magnitud,colour=Magnitud))
g1 <- g1 + geom_point()
g1 <- g1 + geom_smooth()
g1 <- g1 + annotate("text", color="brown",
                    fontface=2,                            ## bold
                    x=as.POSIXct("2015-01-16"),y=8.2,label="sept 2017")
g1 <- g1 + annotate("text",color="brown",
                    fontface=2,                            ## bold
                    x=as.POSIXct("1988-03-16"),y=8.2,label="sept 1985")
g1 <- g1 + theme(axis.title.x = element_text(face="bold"),
                 axis.title.y = element_text(face="bold"))
g1 <- g1 + theme(legend.position = "none")                  ## remove color code
plot(g1)






