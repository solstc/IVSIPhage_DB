# Initialization ----
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
source('00_INITIALIZATION.R')

# Search in NCBI Nucleotide Database ----
ndb_search <-
  entrez_search(
    db = 'nuccore',
    term = paste0(
      '((',
      my_organism,
      ' phage[All Fields]) OR (',
      my_organism,
      ' [Title] AND virus[Title])) AND Viruses[Organism] AND Complete Genome [Title]'
    ),
    use_history = T
  )

ndb_search_web_history <- ndb_search$web_history

p_dt <- as.data.table(t(
  extract_from_esummary(
    entrez_summary(
      db = 'nuccore',
      web_history = ndb_search_web_history,
      retmode = 'xml'
    ),
    elements = my_search_elements
  )
))

is.na(p_dt) <- p_dt == "NULL"
p_dt <- as.data.table(lapply(p_dt, unlist))

# Apply filters ----
# (1) Organism == my_organism/phage/virus
# (2) Genome non-plasmid

p_dt <-
  p_dt[str_detect(Organism, my_organism) &
         (str_detect(Organism, 'phage') |
            str_detect(Organism, 'virus')) &
         (Genome != 'plasmid' | is.na(Genome))]

# Modificate data table ----
# SubType & SubName columns

temporary_dt <- p_dt[, .(Gi, SubType, SubName)]
temporary_dt <-
  temporary_dt[, c('Gi', 'SubType', 'SubName') := lapply(.SD, as.factor), .SDcols = c('Gi', 'SubType', 'SubName')]

temporary_dt <-
  temporary_dt %>% separate_rows(SubType, SubName, sep = "\\|")
temporary_dt <-
  dcast(as.data.table(temporary_dt), Gi~SubType, value.var = 'SubName')

p_dt <- merge(p_dt, temporary_dt, by = 'Gi')
p_dt <-
  p_dt[, strain_2 := strain][, -c('SubName', 'SubType', 'NA')]
p_dt[p_dt == ''] <- NA

# Save data table ----

write.xlsx(p_dt, file = '../data/database_info.xlsx')
