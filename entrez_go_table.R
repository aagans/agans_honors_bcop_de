library(tidyverse)
library(org.Bcoprophila.eg.db)
library(DBI)

bcop_entrez <- dbReadTable(org.Bcoprophila.eg_dbconn(), "entrez_genes")
bcop_go_all <- dbReadTable(org.Bcoprophila.eg_dbconn(), "go_all")

entrez_go_tbl <- inner_join(bcop_go_all, bcop_entrez) |> 
  select(ENTREZID, GOALL) |>
  group_by(ENTREZID) |> 
  chop(GOALL) |> 
  mutate(ENTREZID = str_c("LOC", ENTREZID)) |> 
  column_to_rownames("ENTREZID")

go_assign_vec <- entrez_go_tbl$GOALL
names(go_assign_vec) <- row.names(entrez_go_tbl)
