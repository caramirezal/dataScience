## This file contains my top 20 bash commands

## Double hash (##) indicates a comment,
## comments are lines which are ignored 
## by the computer

## Commands are executed line by line
## Commands are case sensitive

## 1. Change, create, copy, and remove directories
mkdir my_first_dir                   ## create a directory
cd my_first_dir                      ## change directory
cp my_first_dir my_first_dir_copy    ## make a copy of a file or folder
cd ..
rm -r my_first_dir

## You can check the manual for every bash command
## using the parameter --help

## 2. List files in a directory
ls -lh 

## 3. Downloading file from the web
wget ftp://ftp.ncbi.nlm.nih.gov/refseq/release/mitochondrion/mitochondrion.1.1.genomic.fna.gz -P my_first_directory


## 4. Show the content in a file
cat my_first_file.txt

## 5. Count the number fo lines in a text file
wc -l my_first_file

## 6. Inspecting a file
head my_first_file
tail my_first_file
less my_first_file

## 7. Find a line matching a string pattern
grep accct


