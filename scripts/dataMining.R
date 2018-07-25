## Data mining notes

## Read html to text
con <- url("https://opensnp.org/search?utf8=%E2%9C%93&search=adipocyte") ## open conexion
html <- readLines(con)  ## readlines as text                                   
grep('href="http://www.mendeley.com/',html,value = TRUE) ## perform a pattern search
close(con)    ## close conexion

#########################################################################################

## read html to tree parsed structure
library(httr)
html2 <- GET(url)    # open conexion
cont <- content(html2,as = "text")    ## read content
parsedHtml <- htmlParse(cont,asText = TRUE)  ## parse content to tree
## looks for a <td class='table-cell vertical-centered'> tags
xpathSApply(parsedHtml,"//td[@class='table-cell vertical-centered']",xmlValue)  