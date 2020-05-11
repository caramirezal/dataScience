library(ggplot2)
library(dplyr)

caco <- read.table('~/sc/sars-cov2/analysis/caco/deg.tsv',
                   sep = '\t', header = T)

caco$'gene_labs' <- ''
caco$gene_labs[1:15] <- as.character(caco$gene[1:15])
caco$'color' <- 'black'
caco$color[1:15] <- 'red'

caco %>%
        ggplot(aes(x = log10(baseMean), y = log2FoldChange,
                   colour = color)) + 
        geom_point() +
        geom_text(aes(label=gene_labs), hjust=0, vjust=0, show.legend = F, 
                  family = 'PT Sans', size = 5) +
        scale_shape_identity() + theme_classic() + 
        scale_x_continuous(sec.axis = dup_axis(name = NULL, labels = NULL)) +
        scale_y_continuous(sec.axis = dup_axis(name = NULL, labels = NULL)) +
        theme(legend.title = element_blank(),
              legend.text = element_text(family = 'PT Sans', size = 16),
              axis.text.x = element_text(size = 14),
              axis.text.y = element_text(size = 14),
              axis.title = element_text(size = 18, family = 'PT Sans')) +
        xlab(expression(paste(" " ~Log[10]~"(mean expression", ")"))) + 
        ylab(expression(paste(" " ~Log[2]~ "(FC", ")")))


## deg must be the output of DESeq2 and most have a column named genes
## with the gene names
ma_plot <- function(deg) {
        deg <- as.data.frame(deg)
        deg <- arrange(deg, pvalue)
        deg$'gene_labs' <- ''
        deg$gene_labs[1:15] <- as.character(deg$gene[1:15])
        deg$'color' <- 'black'
        deg$color[1:15] <- 'red'
        ggplot(deg, aes(x = log10(baseMean), y = log2FoldChange,
                   colour = color)) + 
                geom_point() +
                geom_text(aes(label=gene_labs), hjust=0, vjust=0, show.legend = F, 
                          family = 'PT Sans', size = 5) +
                scale_shape_identity() + theme_classic() + 
                scale_x_continuous(sec.axis = dup_axis(name = NULL, labels = NULL)) +
                scale_y_continuous(sec.axis = dup_axis(name = NULL, labels = NULL)) +
                theme(legend.title = element_blank(),
                      legend.text = element_text(family = 'PT Sans', size = 16),
                      axis.text.x = element_text(size = 14),
                      axis.text.y = element_text(size = 14),
                      axis.title = element_text(size = 18, family = 'PT Sans')) +
                xlab(expression(paste(" " ~Log[10]~"(mean expression", ")"))) + 
                ylab(expression(paste(" " ~Log[2]~ "(FC", ")"))) + NoLegend()
}


