## Data Science Course 
## Lecture 6. Dataframes and matrices

setwd('~/sc/dataScience/courses/')

## Dependencies
library(readxl)                             ## manage xlsx files
library(dplyr)                              ## Handle dataframes

######################################################################
##                                                                  ##
##                           Data frames                            ##
##                                                                  ##
######################################################################

## Reading dataframe example into R
## See next chapter - Reading files into R
sueldos <- read_excel('../data/8 LGT_Art_70_Fr_VIII_1er semestre_229363.xlsx',
                      sheet = 'Información', 
                      skip = 5)

## Show structure of the dataframe
str(sueldos)

## df table dimensions
dim(sueldos)

## df column names
names(sueldos)

## df head
head(sueldos)

## Extracting df columns
gender <- sueldos$'SEXO (CATÁLOGO)'

## Extracting columns by index
sueldos[,10]                       ## extracting 10th column
sueldos[,1:10]                     ## extracting first 10 columns
sueldos[, c(2, 5, 10)]             ## extracting column 2, 5, 10

## Extracting df rows
sueldos[1:10, ]                    ## extracting first 10 rows

## Filter df by conditions
sueldos[sueldos$'SEXO (CATÁLOGO)' == 'Femenino', ]

## Extracting df slides
class(sueldos)

## Casting values
bruto <- sueldos$`MONTO DE LA REMUNERACIÓN BRUTA  DE CONFORMIDAD AL TABULADOR DE SUELDOS Y SALARIOS QUE CORRESPONDA`
bruto.num <- as.numeric(bruto)

## NA values
is.na(sueldos$`PRIMER APELLIDO`)      ## Non assigned values
sum(is.na(sueldos$`PRIMER APELLIDO`))

## Complete cases
complete.cases(sueldos)

## Operations with columns
max(as.numeric(bruto))                         ## Maximum value in a column vector

## Summary informations
## Frequency table
table(gender)

## Sorting tables
order(bruto.num)                                              ## sort increasing
indexes <- order(bruto.num, decreasing = TRUE)                ## sort decreasing
sueldos[indexes, ]$`NOMBRE (S)`                               ## extract sorted column

#############################################################################
##                                                                         ##
##                             loop functions                              ##
##                                                                         ##
#############################################################################

## apply by columns
apply(sueldos, 2, class)                                     ## apply function by column
apply(sueldos, 2, function(x) class(x))                      ## apply function by column

## extracting numerical values
casted <- apply(sueldos, 2, 
                function(x) as.numeric(x))                    ## casting columns as numeric
num.cols <- apply(casted, 2, function(x) sum(is.na(x)) == 0)  ## get columns with no NA values
                                                              ## probably, numerical cols
sueldos.num <- sueldos[, num.cols]                            ## geeting numerical data
sueldos.num <- apply(sueldos.num, 2, as.numeric)
sueldos.n.df <- as.data.frame(sueldos.num)

## apply by rows 
apply(sueldos.n.df, 1, min)

## sapply
sapply(sueldos.n.df, mean)

## lapply
lapply(sueldos.n.df, mean)

## tapply
tapply(bruto.num, sueldos$`SEXO (CATÁLOGO)`, mean)

## mapply

#######################################################################
##                                                                   ##
##                                  dplyr                            ##
##                                                                   ##
#######################################################################


## select - sliding columns

## filter - sliding rows

## arrange







