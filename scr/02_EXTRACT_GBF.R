setwd(dirname(rstudioapi::getSourceEditorContext()$path))
# source('00_INITIALIZATION.R')

# Phage selection by id ----
# my_ids = Gi of phages
my_ids <- read.xlsx2('../data/database_info.xlsx', 1, header = T)[, 2] 

# Set wd ----
setwd('../data')
dir.create('gbk')
setwd('../data/gbk')

# Search and retrieve GBK ----

for (seq_start in my_ids) {
  all_recs <-
    entrez_fetch(db = 'nuccore', id = seq_start, rettype = 'gb')
  write.table(
    all_recs,
    file = paste0(seq_start, '.gbf'),
    sep = ",",
    row.names = F,
    col.names = F,
    qmethod = "double",
    quote = F
  )
}
print('COMPLETED!')