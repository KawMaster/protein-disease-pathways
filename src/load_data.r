# Libraries
library(tidyverse)


# Loading the CSVs
bio_pathways_associations <- data.frame(read.csv('./data/bio-pathways-associations.csv', header = TRUE))
bio_pathways_diseaseclasses <- data.frame(read.csv('./data/bio-pathways-diseaseclasses.csv', header = TRUE))
bio_pathways_diseasemotifs <- data.frame(read.csv('./data/bio-pathways-diseasemotifs.csv', header = TRUE))
bio_pathways_features <- data.frame(read.csv('./data/bio-pathways-network.csv', header = TRUE))
bio_pathways_proteinmotifs <- data.frame(read.csv('./data/bio-pathways-proteinmotifs.csv', header = TRUE))
