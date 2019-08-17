## Dependencies
library(readxl)                             ## manage xlsx files
library(dplyr)                              ## Handle dataframes

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