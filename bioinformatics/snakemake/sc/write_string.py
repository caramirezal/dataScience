## Python script for reading a file and writting the 
## content to anotther file


## Reading hola_y_adios.txt
file1 = open(snakemake.input[0]) 
Lines = file1.read() 

## Writting to file
text_file = open(snakemake.output[0], "w")
text_file.write(Lines)
text_file.close()
