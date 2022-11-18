# IVSIPhage_DB

We herein describe a pipeline for the generation of a local database (**OLD**, **O**ur **L**ocal **D**atabase) of genomes of bacteriophages infecting a specific organism, using the information of the public database hosted at the National Center for Biotechnology Information (NCBI). Its use requires no programming experience, making it ideal for investigators of all skill levels. IVSIPhage_DB allows the user to: i) create a local database in an excel sheet with the information of phages of the selected organism and ii) retrieve GenBank flat files of that genomes. 

### Introduction

IVSIPhage_DB is a free and open source tool implemented in R, created as part of a Ph. D Thesis :scientist: (Laboratorio de Mircobiología Molecular, Facultad de Ciencias Médicas, Universidad Nacional de Rosario, Rosario, Argentina). The program was designed as an R Proyect, so that the user could generate OLD  without necessarily downloading the *.gbf* files. Although originally planned for phages active on *Staphylococcus spp.*, it also works for other bacterial species. This pipeline generates two kind of outputs: 1- an excel sheet with the information of the phages; 2- the *.gbf* of those phages. 

### Prerequisites

To use this pipeline, you need to have intalled R >= 4.2.1 and RStudio 2022.07.1+554. This code was tasted on :computer: Ubuntu 22.04.1 LTS.

## Running IVSIPhage_DB 

1. Download ZIP file from Github and unzip it. 
2. Go to data directory and open the file ‘Organism_of_interest.csv’. Edit the second line typing the name of the organism you want to create a database from; i.e., ‘*Staphylococcus*’ means a database for *Staphylococcus* phages. Save changes.
3. Go back to the root folder, find ‘IVSIPhage_DB.Rproj’, double click it to open with R Studio Software.
4. Go to `File > Open File…` and browse the script named ‘01_DATABASE.R’ (located in ‘scr’ folder).
5.  Run it by clicking on `Code > Source`. Now you will find a new file named ‘database_info.xlsx’ in the ‘data’ folder. Here is a list of all the genomes to work with, the Excel sheet is modifiable in order to add or delete genomes.
6. Open the file ‘EXTRACT_GBF.R’ (`File > Open File…`) and run it. Now you could find all the GenBank flat files in the ‘gbk’ directory under ‘data’ folder.

## Authors

🧬 Soledad T. Carrasco [link](https://www.researchgate.net/profile/Soledad-Carrasco).<br />
🧬 Hector R. Morbidoni [link](https://www.researchgate.net/profile/Hector-Morbidoni).
