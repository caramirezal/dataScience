## Introduction to R Language

## '##' As in bash corresponds to comments

## Installing R packages
install.packages('dplyr')

## Loading libraries
library(dplyr)

## Set the current working environment or directory
setwd('~/sc/dataScience/courses/')

## Variable definition
x1 <- 3.1416               ## '<-' assigns a value to a variable
x1
x2 = 0.999999              ## '=' is equivalent to '<-'
print(x2)

## Types of variables
x3 <- 1.5                  ## numerical value
x4 <- 10                   ## integer
str1 <- "Hola, mundo"      ## character
z <- 1 + 1i                ## complex numbers
l <- TRUE                  ## logic

## vector definition
vec1 <- c(1, 2, 3)         ## concatenation of variables
vec2  <- 1:3               ## vector of consecutive integers
vec3 <- c(vec1, 4)         ## concatenation of two vectors
vec4 <- c(TRUE, TRUE, FALSE)  ## logic vector concatenation

## Vector manipulation
vec5 <- vector('numeric', 3)          ## Definition of a vector with 3 entries
names(vec5) <- c('x', 'y', 'z')       ## Giving names to entries
vec5[1]                               ## Extracting vector first value
vec5[2] <- 1                          ## Assigning values to a given entry
vec5[2:3] <- c(1,1)                   ## Multiple assignments
vec5[c(1,3)] <- c(0,0)                ## Multiple assignements
vec5[c('z', 'x')]                     ## Subsetting


## lists can contain different kinds of values
ls1 <- list(1, TRUE, c('Hola, mundo', 'Adios'))      ## List definition
names(ls1) <- c('Timon', 'Pumba', 'Simba')           ## Naming list

## list manipulation
ls1[1] <- 'string to replace'                        ## Assigning values
class(ls1[3])                                        ## extracting 3rd element as list
class(ls1[[3]])                                      ## extracting 3rd element as vector
ls1[c(1,3)]                                          ## subsetting


