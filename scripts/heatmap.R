library(dplyr)

## hierarchical clustering on data taken from V Moignard et al, 2013. 
## Data can be downloaded here:
## https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3796878/

## Loading the data
data <- read.csv("../data/NIHMS53736-supplement-9.csv")
str(data)

## Dropping sample tags
data.n <- select(data, -Cell) 

## Processing cell cathegories
cellTypes <- gsub("[[:digit:]]","",data$Cell)

## color assignment
colors <- cellTypes
colors <- ifelse(colors=="CLP","purple",colors)
colors <- ifelse(colors=="GMP","orange",colors)
colors <- ifelse(colors=="HSC","green",colors)
colors <- ifelse(colors=="LMPP","blue",colors)
colors <- ifelse(colors=="PreMegE","yellow",colors)

## Performing hierarchical clustering and ploting
## heatmap
heatmap(1/(log(as.matrix(data.n+1))),Colv = NA,
        RowSideColors = colors,labRow = FALSE)
