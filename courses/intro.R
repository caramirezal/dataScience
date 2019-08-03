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
class(l)                   ## shows variable class

## Variables operations
x3 + x4                      ## Sum
x3*x4                        ## Multiplication
x3**10; x3^10                ## Exponentiation
sqrt(x3)                     ## squaring
log10(x3)                    ## Logarithm base 10
log(x3, base = 15)                  ## Logarithm base 15

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

## Vector operations
vec5 + vec5                           ## Vector sum
vec5 * vec5                           ## vector multiplication
sum(vec5)                             ## sum of all vector elements
prod(vec5)                            ## multiplication of all vector elements

## lists can contain different kinds of values
ls1 <- list(1, TRUE, c('Hola, mundo', 'Adios'))                         ## List definition
names(ls1) <- c('Xutos n Putapes', 'Voo Voo', 'Radio Futura')           ## Naming list

## list manipulation
ls1[1] <- 'string to replace'                        ## Assigning values
class(ls1[3])                                        ## extracting 3rd element as list
class(ls1[[3]])                                      ## extracting 3rd element as vector
ls1[c(1,3)]                                          ## subsetting

## Factors
fact1 <- factor(c('low', 'high', 'low', 'medium', 'low'))               ## Factors definition
levels(fact1)                                                           ## showing factor levels
fact.ord.lev <- factor(fact1, levels = c('low', 'medium', 'high'))      ## setting levels order
fact.ord <- ordered(fact1, levels= c('low', 'medium', 'high'))          ## setting factor order

## funtion definition
my_first_function <- function(n1, n2){
        res <- n1 + n2
        return(res)
}

## Indentation is important for making codes human readable
## NOTE: 8 spaces indenting and maximum of 80 is recommended for lines

## Calling or invoking function
my_first_function(3.1416, 10)


## For Loop
## Example: Summing up integers from 1 to 100
s <- 0                                     ## initialize sum
for (i in 1:100) {                         ## summing up
        s <- s + i
}
s

## While Loop - Same example
n = 1                                     ## initialize iteration
s = 0
while (n <= 100) {
        s = s + n                         ## update sum
        n = n + 1                         ## increase integer
}
s
