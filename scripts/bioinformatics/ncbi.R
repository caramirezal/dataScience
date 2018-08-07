## NCBI data using using E-utility calls
library(xml2)

baseURL <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"

## data base 

########################################################################################################
## Basic search by keywords

## Basic searching in pubmed
basicSearching <- "esearch.fcgi?db=pubmed&term="
keywords <- "snps+AND+endurance+AND+homo+sapiens[orgn]"
query <- paste0(baseURL,basicSearching,keywords)

## extracting data from XML
qresultXML <- read_xml(query)
qcontent <- xml_contents(qresultXML)
pmids <- xml_text(xml_find_all(qcontent, "//eSearchResult/IdList/Id"))

#######################################################################################################
## Query a list of ids

## query by list of ids
listSearch <- "efetch.fcgi?db=pubmed&id=29561708,28871847,28384286&rettype=abstract"
queryList <- paste0(baseURL,listSearch)

## extracting data
qresultXML <- read_xml(queryList)
qcontent <- xml_contents(qresultXML)
pmids <- xml_text(xml_find_all(qcontent, "//AbstractText"))

queryKey <- "1"
webEnv <- "NCID_1_7667152_130.14.18.34_9002_1533673649_642619957_0MetA0_S_MegaStore"

queryList <- paste0(baseURL,"esearch.fcgi?db=pubmed&query_key",queryKey,"&WebEnv=",webEnv)



