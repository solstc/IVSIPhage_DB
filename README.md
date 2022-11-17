# IVSIPhage_DB

We present a pipeline for the creation of a local database of bacteriophages of a specific organism with the information of the database hosted at the National Center for Biotechnology Information (NCBI).  The use requires no programming experience, making it ideal for investigators of all skill levels. IVSIPhage_DB allows the user to: i) create a local database in an excel sheet with the information of phages of the selected organism and ii) retrieve GenBank flatfiles of that genomes. 

### Introduction

IVSIPhage_DB is a free and open source tool implemented in R created as part of a doctoral thesis :scientist: for the Laboratorio de Mircobiología Molecular, Facultad de Ciencias Médicas, Universidad Nacional de Rosario, Rosario, Argentina. Originally it was planned for active phages against *Staphylococcus* but it also runs for other organisms. The job was intended as an R project so that the user can generate the database without necessarily downloading the gbf files.
This pipeline generate two kind of outputs: an excel sheet with the information of the phages and the gbf of that phages. 

### Prerequisites

To use this pipeline you need to have R >= 4.2.1 and RStudio 2022.07.1+554. This code was tasted on :computer: Ubuntu 22.04.1 LTS.

## Running IVSIPhage_DB 
1. Download ZIP file from Github and unzip it. 
2. Go to data directory and open the file ‘Organism_of_interest.csv’. Edit the second line typing the name of the organism you want to create a database from; i.e,  ‘Staphylococcus’ means a database for *Staphylococcus* phages. Save changes.
3. Go back to root folder, find ‘IVSIPhage_DB.Rproj’, double click to open it with R Studio Software.
4. Go to `File > Open File…` and browse the script named ‘01_DATABASE.R’ (located in ‘scr’ folder).
5.  Run it by clicking on `Code > Source`. Now you will find a new file named ‘database_info.xlsx’ in the ‘data’ folder. Here is a list of all the genomes to work with, the Excel sheet is modifiable in order to add or delete genomes.
6. Open the file ‘EXTRACT_GBF.R’ (`File > Open File…`) and run it. Now you could find all the GenBank flatfiles in the ‘gbk’ directory under ‘data’ folder.

## Authors

🧬 Soledad T. Carrasco [link](https://www.researchgate.net/profile/Soledad-Carrasco).<br />
🧬 Hector R. Morbidoni [link](https://www.researchgate.net/profile/Hector-Morbidoni).
