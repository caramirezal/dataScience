#!/bin/bash

## remove files
rm file.txt

## decompress zip files
unzip file.zip

## unzip tar files
tar -xvzf file.tar.gz

## less with zip files
zless file.fa.gz

## variable definition in bash
var1=10
echo $var1

## Basic loop in bash
for i in 1 2 3; do
	echo i=${i};
done

## loop over files in a dir
for filename in ~/scripts/single-Cell_RNA-Seq_pipeline/data/fastq/*1.fastq.gz; do
    echo "$filename"
    ## substitute pattern in string file name
    echo "${filename/1.fastq.gz/2.fastq.gz}"
done
