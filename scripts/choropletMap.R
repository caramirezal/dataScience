
library(mxmaps)
library(dplyr)

## Data was downloaded from the following INE link
## https://computos2018.ine.mx/#/descargaBase

##############################################################################
## Data preprocessing

## Preliminary reading
data <- read.table("../data/presidencia.csv",skip = 7,nrows = 10,sep="|")
head(data)

## number of columns
colNames <- readLines("../data/presidencia.csv",n = 7)

## headers and column names differ
length(strsplit(colNames[7],fixed = TRUE,split = "|")[[1]])

## Removing last extra column
colNames <- strsplit(colNames[7],fixed = TRUE,split = "|")[[1]]
colNames <- colNames[1:(length(colNames)-1)]
length(colNames)

#############################################################################

## Reading data
data <- read.table("../data/presidencia.csv",skip = 7,sep="|")
colnames(data) <- colNames
head(data)

## calculating % of voters
data.p <- data[,c("ID_ESTADO",
                "TOTAL_VOTOS_CALCULADOS",
                "LISTA_NOMINAL_CASILLA")]
data.p <- data.p %>% group_by(ID_ESTADO) 
data.p <- data.p %>% summarise(
        TOTAL_VOTOS_CALCULADOS = sum(TOTAL_VOTOS_CALCULADOS,
                                     na.rm = TRUE),
        LISTA_NOMINAL_CASILLA = sum(LISTA_NOMINAL_CASILLA,
                                    na.rm = TRUE)
)
data.p <- mutate(data.p, value=100*(
        TOTAL_VOTOS_CALCULADOS/LISTA_NOMINAL_CASILLA))
data.p <- mutate(data.p,region=ID_ESTADO)
data.p <- select(data.p,value:region)

## Plotting data
mxstate_choropleth(data.p,legend = "% Lista Nominal")
