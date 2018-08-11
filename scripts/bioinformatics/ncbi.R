## NCBI data using using E-utility calls
## See https://www.ncbi.nlm.nih.gov/books/NBK25500/

library(xml2)

baseURL <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"

## data base 

########################################################################################################
## Basic search by keywords

## Basic searching in pubmed
basicSearching <- "esearch.fcgi?db=pubmed&term="
keywords <- "snps+AND+endurance+AND+human"
query <- paste0(baseURL,basicSearching,keywords)

## extracting PMIDS from XML
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


############################################################################################
## Using NCBI memory to store query results

queryKey <- "1"
webEnv <- "NCID_1_7667152_130.14.18.34_9002_1533673649_642619957_0MetA0_S_MegaStore"

queryList <- paste0(baseURL,"esearch.fcgi?db=pubmed&query_key",queryKey,"&WebEnv=",webEnv)

#########################################################################################
## bacth iteration
## Basic searching in pubmed
baseURL <- "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/"
basicSearching <- "esearch.fcgi?db=pubmed&retmax=10000&term="
specs <- '+AND+snps+AND+human'
submit <- "autism"
keywords <- gsub(" ","+",submit)
query <- paste0(baseURL,basicSearching,keywords,specs)

## Preading
## extracting number of Items 
qresultXML <- read_xml(query)
qcontent <- xml_contents(qresultXML)
noItems <- xml_text(xml_find_all(qcontent, "//eSearchResult/Count"))
noItems <- as.integer(noItems)
pmids <- xml_text(xml_find_all(qcontent, "//eSearchResult/IdList/Id"))

## iteration over all results
batch <- seq(0, noItems, by=200)
for (b in batch[1:2]){
        ## query definition
        basicSearching <- "esearch.fcgi?db=pubmed&retmax=200"
        iterator <- paste("&retstart=",as.character(b),"&term=+AND+",sep="")
        specs <- "+AND+snps+AND+human"
        keywords <- gsub(" ","+",submit)
        query <- paste0(baseURL,basicSearching,iterator,keywords,specs)
        print(query)
}

