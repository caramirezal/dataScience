## Bash script example

## store file names in variable
files=data/alignment/*

## show the content of the variable
echo $files

## traversing a vector variable
for i in $files; do 
    echo $i
done


