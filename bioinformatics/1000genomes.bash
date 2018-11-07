## listing files in 1000 genomes repository in vcf format 
curl ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ 

## download vcf files of 1000 genomes project
wget -r -c --tries=75 ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/*.genotypes.vcf.gz


## getting basic statistics from 
./inst/vcftools_0.1.13/bin/vcftools --gzvcf data/1000genomes/ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 

## Get a list of mexican population "MXL" sample ids 
## As shown here: https://www.biostars.org/p/54641/
cat data/1000genomes/igsr_samples.tsv | grep MXL | cut -f 1 > data/1000genomes/mxn_1000_genomes_list.txt

