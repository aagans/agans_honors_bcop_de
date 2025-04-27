library(GOplot)
library(tidyverse)

el_go_results |>  
  top_n(10, wt=-over_represented_pvalue)  |>  
  mutate(hitsPerc=numDEInCat*100/numInCat)  |>  
  ggplot(aes(x=hitsPerc, 
             y=term, 
             colour=over_represented_pvalue, 
             size=numDEInCat)) +
  geom_point() +
  expand_limits(x=0) +
  labs(x="Hits (%)", y="GO term", colour="p value", size="Count")

emef_go_results |>  
  top_n(10, wt=-over_represented_pvalue)  |>  
  mutate(hitsPerc=numDEInCat*100/numInCat)  |>  
  ggplot(aes(x=hitsPerc, 
             y=term, 
             colour=over_represented_pvalue, 
             size=numDEInCat)) +
  geom_point() +
  expand_limits(x=0) +
  labs(x="Hits (%)", y="GO term", colour="p value", size="Count")

lmlf_go_results |>  
  top_n(10, wt=-over_represented_pvalue)  |>  
  mutate(hitsPerc=numDEInCat*100/numInCat)  |>  
  ggplot(aes(x=hitsPerc, 
             y=term, 
             colour=over_represented_pvalue, 
             size=numDEInCat)) +
  geom_point() +
  expand_limits(x=0) +
  labs(x="Hits (%)", y="GO term", colour="p value", size="Count")


el_volcano_tbl <- el_de_results_tbl |> 
  dplyr::select(gene_id, logFC, PValue) |> 
  left_join(entrez_alias_tbl, by = join_by(gene_id == ENTREZID))

EnhancedVolcano(el_volcano_tbl,
                lab = el_volcano_tbl$ALIAS,
                x = 'logFC',
                y = 'PValue')

emef_volcano_tbl <- emef_de_results_tbl |> 
  dplyr::select(gene_id, logFC, PValue) |> 
  left_join(entrez_alias_tbl, by = join_by(gene_id == ENTREZID))

EnhancedVolcano(emef_volcano_tbl,
                lab = emef_volcano_tbl$ALIAS,
                x = 'logFC',
                y = 'PValue')

lmlf_volcano_tbl <- lmlf_de_results_tbl |> 
  dplyr::select(gene_id, logFC, PValue) |> 
  left_join(entrez_alias_tbl, by = join_by(gene_id == ENTREZID))

EnhancedVolcano(lmlf_volcano_tbl,
                lab = lmlf_volcano_tbl$ALIAS,
                x = 'logFC',
                y = 'PValue')
