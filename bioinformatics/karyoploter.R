## karyoploteR R package

########################################################################################
library(karyoploteR)
library(biomaRt)
library(googlesheets)
library(dplyr)

## Getting data
## Update rsids from biopanels
invisible(gs_ls())
ss <- gs_title("Base de datos MiADNMéxico041218")
macronutrientes <- gs_read(ss, ws = "Macronutrientes")
macronutrientes <- dplyr::select(macronutrientes, Macrouniverso:Ancestria)
micronutrientes <- gs_read(ss, ws = "Micronutrientes")
micronutrientes <- dplyr::select(micronutrientes, Macrouniverso:Ancestria)
compuestos <- gs_read(ss, ws = "Compuestos bioactivos")
compuestos <- dplyr::select(compuestos, Macrouniverso:Ancestria)

biopaneles <- rbind(macronutrientes, 
                    micronutrientes,
                    compuestos)


## depuration criteria
pvals <- biopaneles[, grepl("Valor_P", names(biopaneles))]
pvals <- sapply(1:nrow(pvals), function(x) sum(!is.na(pvals[x,])))
criteria_pval <- pvals > 0
pmids <- biopaneles[, grepl("PMID_", names(biopaneles))]
pmids <- sapply(1:nrow(pmids), function(x) sum(!is.na(pmids[x,])))
criteria_pmids <- pmids > 0

## data filtering
biopaneles <- filter(biopaneles, criteria_pmids | criteria_pval )
rsids <- biopaneles$RSID
rsids <- gsub("\n", "", rsids)
rsids <- rsids[!is.na(rsids)]
rsids <- unique(rsids)
#rsids

## loading ensembl database for annotation
ensembl_snp <- useMart("ENSEMBL_MART_SNP", dataset="hsapiens_snp",
                       host = "www.ensembl.org")
biomart <- getBM(attributes=c('refsnp_id',
                              "chr_name", 
                              "chrom_start"), 
                 filters = 'snp_filter', 
                 values = unique(rsids), 
                 mart = ensembl_snp)


################################################################################
## Basic plot
## regions for plotting
regs <- data.frame(chr = biomart$chr_name,
                   start = biomart$chrom_start - 5000000,
                   end = biomart$chrom_start + 5000000)
regs$chr <- paste("chr", regs$chr, sep = "")
kp <-plotKaryotype(genome = "hg19", plot.type = 1, chromosomes = unique(regs$chr))

## plot regions
kpPlotRegions(kp, regs, col="skyblue")


################################################################################

kp <- plotKaryotype(genome="mm10", plot.type=5, main="The mm10 genome")
