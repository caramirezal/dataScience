## SNPedia data mining

## Programmatic bulk query to SNPedia documentation can be foun here:
## https://www.snpedia.com/index.php/Bulk#Get_all_SNP_names_2

## SNPediaR query tool is available to acces SNPedia info
## https://bioconductor.org/packages/release/bioc/html/SNPediaR.html

library(SNPediaR)

snps <- getCategoryElements(category = "Is_a_snp")

pages <- getPages(titles = "rs53576")
