## listing files in 1000 genomes repository in vcf format 
#curl ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ 

## download vcf files of 1000 genomes project
#wget -r -c --tries=75 ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/*.genotypes.vcf.gz


## getting basic statistics of the vcf files
#./inst/vcftools_0.1.13/bin/vcftools --gzvcf data/1000genomes/ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz 

## Get a list of mexican population "MXL" sample ids from: http://www.internationalgenome.org/data-portal/sample
## and then process the igsr_samples.tsv file (2018-11-06)
#cat data/1000genomes/igsr_samples.tsv | grep MXL | cut -f 1 > data/1000genomes/mxn_1000_genomes_list.txt

## Then filter vcf file by sample id using the next command
## As shown here: https://www.biostars.org/p/54641/
#./inst/vcftools_0.1.13/bin/vcftools --gzvcf data/1000genomes/ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz --chr 6 --from-bp 1000000 --to-bp 2000000 --keep data/1000genomes/mxn_1000_genomes_list.txt --out mxn_genomes --plink

## iteration of the process of converting vcf to ped files
#for i in {1..22}; do
#    .././inst/vcftools_0.1.13/bin/vcftools --gzvcf ../data/1000genomes/ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz --chr $i --keep ../data/1000genomes/mxn_1000_genomes_list.txt --out mxn_genomes_$i --plink
#done

## calculation of allele frequencies
#./inst/plink --file data/1000genomes/ped/mxn_genomes_1 --freq --out chr_freq

## calculate the frequencies in all the chromosomes
for i in {1..22}; do
      ./inst/plink --file data/1000genomes/ped/mxn_genomes_$i --freq --out chr_$i
done

## subset the variants found in the biopanel
grep -wFf data/Biopanel_depurado.csv data/1000genomes/frequencies/chr_*.frq > biopanel_frequencies.txt

## Get rsids of biopaneles present in 23nMe
grep -wFf data/biopanel_depurado/Biopanel_depurado_rsids.txt data/microarrays/CTR0100075_genome_Adrian_Melendez_Full_20150609073944.txt | cut -f1 > data/biopanel_depurado/rsids_biopanel_in_23nMe.txt

## Get rsids of biopaneles present in MEGAN
grep -wFf data/biopanel_depurado/Biopanel_depurado_rsids.txt data/microarrays/Multi-EthnicGlobal_D2_b150_rsids.txt | cut -f2 > data/biopanel_depurado/rsids_biopanel_in_megan.txt

## extract global frequencies from 1000genomes vcf files
zgrep -wFf data/biopanel_db_rsids.txt ../snpsDataMining/data/1000genomes/ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr*.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz > global_freqs.txt 
