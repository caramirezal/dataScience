## Data Science Course 
## Lecture 6. Dataframes and matrices

## Dependencies
library(readxl)                             ## manage xlsx files

######################################################################
##                                                                  ##
##                           Data frames                            ##
##                                                                  ##
######################################################################

## Pre-reading check
sueldos <- read_excel('../data/8 LGT_Art_70_Fr_VIII_1er semestre_229363.xlsx',
                      sheet = 'Información', 
                      skip = 5, 
                      n_max = 10)

## Show structure of the dataframe
str(sueldos)

## Reading the whole table into R 
sueldos <- read_excel('../data/8 LGT_Art_70_Fr_VIII_1er semestre_229363.xlsx',
                      sheet = 'Información', 
                      skip = 5)
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

## Frequency table
table(gender)

## Extracting df rows

## Extracting df slides

## Casting values
## NA values
## Complete cases

## Operations with columns
max(as.numeric(bruto))                         ## Maximun value in a column vector

## Summary informations

##



