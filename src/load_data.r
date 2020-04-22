# Libraries
library(tidyverse)
library(hash)


# Bio-Pathways-Network

bio_pathways_network <- data.frame(read.csv('./data/bio-pathways-network.csv', header = TRUE))
sapply(bio_pathways_network, class)




# Bio-Pathways-Associations

bio_pathways_associations <- data.frame(read.csv('./data/bio-pathways-associations.csv', header = TRUE))
bio_pathways_associations[] <- lapply(bio_pathways_associations, as.character)
sapply(bio_pathways_associations, class)

bpa_nodes <- data.frame(Node = NA, Type = NA)
bpa_edges <- data.frame(Disease.ID = NA, Gene.ID = NA)


for (row in 1:nrow(bio_pathways_associations))
{
  associated_genes <- bio_pathways_associations[row, 'Associated.Gene.IDs']
  disease_id <- bio_pathways_associations[row, 'Disease.ID']
  a_gg <- as.numeric(strsplit(associated_genes, ', ')[[1]])
  

  bpa_nodes[nrow(bpa_nodes) + 1,] = list(disease_id, 'Disease.ID')

  for (ag in a_gg)
  {
    bpa_edges[nrow(bpa_edges) + 1,] = list(disease_id, ag)
    bpa_nodes[nrow(bpa_nodes) + 1,] = list(ag, 'Gene')
  }
}

bpa_nodes <- unique(bpa_nodes)
bpa_nodes <- bpa_nodes[-1,]
rownames(bpa_nodes) <- 1:nrow(bpa_nodes)

bpa_edges <- unique(bpa_edges)
bpa_edges <- bpa_edges[-1,]
rownames(bpa_edges) <- 1:nrow(bpa_edges)




# Bio-Disease-Classes

bio_pathways_diseaseclasses <- data.frame(read.csv('./data/bio-pathways-diseaseclasses.csv', header = TRUE))

bio_pathways_diseaseclasses[] <- lapply(bio_pathways_diseaseclasses, as.character)
sapply(bio_pathways_diseaseclasses, class)

bpdc_nodes <- data.frame(Node = NA, Type = NA)

for (row in 1:nrow(bio_pathways_diseaseclasses))
{
  disease_class <- as.character(bio_pathways_diseaseclasses[row, 'Disease.Class'])
  disease_id <- bio_pathways_diseaseclasses[row, 'Disease.ID']
  bpdc_nodes[nrow(bpdc_nodes) + 1,] = list(disease_id, 'Disease.ID')
  bpdc_nodes[nrow(bpdc_nodes) + 1,] = list(disease_class, 'Disease.Class')
}

bpdc_nodes <- unique(bpdc_nodes)
bpdc_nodes <- bpdc_nodes[-1,]
rownames(bpdc_nodes) <- 1:nrow(bpdc_nodes)

bpdc_edges <- data.frame(Disease.ID = bio_pathways_diseaseclasses$Disease.ID, Diease.Class = bio_pathways_diseaseclasses$Disease.Class)




# Bio-Pathways-Disease-Motifs

bio_pathways_diseasemotifs <- data.frame(read.csv('./data/bio-pathways-diseasemotifs.csv', header = TRUE))




# Bio-Pathways-Features

bio_pathways_features <- data.frame(read.csv('./data/bio-pathways-features.csv', header = TRUE))



# Bio-Pathways-Protein-Motifs

bio_pathways_proteinmotifs <- data.frame(read.csv('./data/bio-pathways-proteinmotifs.csv', header = TRUE))



