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
  cSplit(
    temporary_dt,
    splitCols = 'SubType',
    sep = '|',
    direction = 'wide',
    drop = F,
    type.convert = F
  )
temporary_dt <-
  cSplit(
    temporary_dt,
    splitCols = 'SubName',
    sep = '|',
    direction = 'wide',
    drop = F,
    type.convert = F
  )

temporary_dt <- temporary_dt[,-c('SubName', 'SubType')]
temporary_dt <-
  temporary_dt[, c('s1', 's2', 's3', 's4', 's5', 's6', 's7', 's8', 's9') := .(
    paste0(SubType_1, '|', SubName_1),
    paste0(SubType_2, '|', SubName_2),
    paste0(SubType_3, '|', SubName_3),
    paste0(SubType_4, '|', SubName_4),
    paste0(SubType_5, '|', SubName_5),
    paste0(SubType_6, '|', SubName_6),
    paste0(SubType_7, '|', SubName_7),
    paste0(SubType_8, '|', SubName_8),
    paste0(SubType_9, '|', SubName_9)
  )][, c('Gi', 's1', 's2', 's3', 's4', 's5', 's6', 's7', 's8', 's9')]

temporary_dt <- melt(temporary_dt, id.vars = 'Gi')
temporary_dt <-
  cSplit(
    temporary_dt,
    splitCols = 'value',
    sep = '|',
    direction = 'wide',
    drop = F,
    type.convert = F
  )

temporary_dt <- dcast(
  temporary_dt,
  Gi ~ value_1,
  fun.aggregate = function(x)
    paste(x, collapse = '_'),
  value.var = 'value_2'
)

p_dt <- merge(p_dt, temporary_dt, by = 'Gi')
p_dt <-
  p_dt[, strain_2 := strain][, -c('SubName', 'SubType', 'NA', 'strain')]
p_dt[p_dt == ''] <- NA

# Save data table ----

write.xlsx(p_dt, file = '../data/database_info.xlsx')