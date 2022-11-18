setwd(dirname(rstudioapi::getSourceEditorContext()$path))

# Packages ----
## If a package is installed, it will be loaded. If not the missing package(s)
## will be installed from CRAN and then loaded.

for (pkg in c('data.table',
              'stringr',
              'xlsx',
              'rentrez',
              'splitstackshape')) {
  if (!suppressMessages(require(pkg, character.only = T))) {
    install.packages(pkg, dependencies = T)
    suppressMessages(library(pkg, character.only = T))
  }
}
remove(pkg
)

# Data load ----

my_organism <-
  as.character(read.csv(
    '../data/Organism_of_interest.csv',
    header = T,
    sep = ','
  )[1])

my_search_elements <- c('Gi',
                        'AccessionVersion',
                        'Title',
                        'Organism',
                        'Extra',
                        'CreateDate',
                        'UpdateDate',
                        'TaxId',
                        'Slen',
                        'Biomol',
                        'MolType',
                        'Topology',
                        'SourceDb',
                        'ProjectId',
                        'Genome',
                        'SubType',
                        'SubName',
                        'AssemblyGi',
                        'Strand',
                        'Strain'
)