## This file contains my top 20 bash commands

## Double hash (##) indicates a comment,
## comments are lines which are ignored 
## by the computer

## Commands are executed line by line
## Commands are case sensitive

## You can check the manual for every bash command
## using the parameter --help

#######################################################
##                                                   ##                 
##              Directories operations               ##
##                                                   ##
#######################################################

## 1. Create directories
mkdir my_first_dir                   ## create a directory

## 2. Change current directory
cd my_first_dir                      ## change directory
cd ..                                ## change to parent directory
cd ~                                 ## move to home directory
cd /                                 ## move to root directory

## 3. List files in a directory
ls -lh 

## 4. Copy a directory
cp -r my_first_dir dir_copy

## 5. Remove a directory
rm -r my_first_dir; rm -r dir_copy


################################################################
##                                                            ##		
##            Operations with text files                     ##
##                                                            ##
################################################################

## 6. Creates a file with a string
echo 'Hola Mundo' > my_first_file.txt          ## '>' directs output to a text file
echo 'Adiós, Mundo' >> my_first_file.txt       ## '>>' directs outputs without overwritting
touch empty_file.txt                           ## creates an empty file

## 7. Display the content in a text file
cat my_first_file 

## 8. Downloading file from the web
mkdir data                           ## create a folder call dir
wget ftp://ftp.ncbi.nlm.nih.gov/refseq/release/mitochondrion/mitochondrion.1.1.genomic.fna.gz -P data

## 9. Uncompressing data
gunzip -d data/mitochondrion.1.1.genomic.fna.gz > data/mitochondrion.1.1.genomic.fna

## 10. Counting lines in file
wc -l data/mitochondrion.1.1.genomic.fna         ## count lines
ls -lh                                           ## list files info

## 11. Display text file slides
head -10 data/mitochondrion.1.1.genomic.fna       ## display first 10 lines in file
tail -6 data/mitochondrion.1.1.genomic.fna        ## display final 6 lines in file
less data/mitochondrion.1.1.genomic.fna           ## display a slide of the file

## 12. find patterns in text file
grep AAATT data/mitochondrion.1.1.genomic.fna     ## find lines having 'AAATT' 
grep -v AAATT data/mitochondrion.1.1.genomic.fna  ## find lines not having 'AAATT'
grep AAA*TT data/mitochondrion.1.1.genomic.fna    ## find 'AAATT(any)TAC'

## 13. Replace patterns
sed 's/AAATT//g' data/mitochondrion.1.1.genomic.fna   ## Replace AAA*TT with '*'

## 14. Sort
## First, downloading table file example
wget https://raw.githubusercontent.com/caramirezal/dataScience/master/data/gwas.tsv -P data
less data/gwas.tsv                                   ## inspecting tsv file
sort -k8nr data/gwas.tsv > gwas_sorted.tsv           ## sorting by column 8 in ascending order

## 15. Cut - Extract columns
## get example tab separated file
wget https://raw.githubusercontent.com/caramirezal/dataScience/master/data/1000genomes_ann.tsv -P data
cut -f2,3 data/1000genomes_ann.tsv                ## extracts column 2 and 3

## 16. Uniq - outputs only non repeated values
cut -f3 data/1000genomes_ann.tsv | sort | unique

#################################################################
##                                                             ##
##                 Extra useful commands                       ##
##                                                             ##
#################################################################

## 17. Untar files
wget https://github.com/caramirezal/dataScience/blob/master/data/alignments.log.out.tar.gz -P data
tar -xvzf alignements.log.out.tar.gz -C data/

## 18. chmod - Change file permissions
chmod +x scripts/script_example.sh

## 19. Variable definition
x='hola Mundo'; echo $x
y=13;           echo $y
files=data/alignment/*

## 20. Iteration
for i in files; do
        echo $i
        grep 'Uniquely mapped'
done

############################################################################
##                                                                        ##
##               Additional useful commands                               ##
##                                                                        ##
############################################################################

## 21. history - display commands history log
history 

## 22. htop - list system resources
htop





