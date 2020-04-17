
# This script generates all of the graphs needed for this analysis


# Libraries
library(tidyverse)
library(igraph)
library(multinet)
library(hash)


# External Files to Source
# source("src/misc_functions.r")


# install.packages("igraph") 
# install.packages("network") 
# install.packages("sna")
# install.packages("ggraph")
# install.packages("visNetwork")
# install.packages("threejs")
# install.packages("networkD3")
# install.packages("ndtv")




# Gene - Gene Network 

gene_gene_network <- graph_from_data_frame(d = bio_pathways_network, directed = F) 


# Gene - Disease Network

gene_disease_network <- graph_from_data_frame(d = bpa_edges, vertices = bpa_nodes, directed = F) 


# Disease - Disease Class Network

disease_disease_class_network <- graph_from_data_frame(d = bpdc_edges , vertices = bpdc_nodes, directed = F)


