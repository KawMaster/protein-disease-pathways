# Network Analysis


# Libraries
library(tidyverse)
library(igraph)
library(multinet)
library(hash)
library(ggplot2)
library(scales)
library(emdbook)
# Gene - Gene Network 


## Network Density: The proportion of present edges from all possible edges in the network.
edge_density(gene_gene_network, loops = F)


## Degree Distribution

gg_degree <- data.frame(deg = degree(gene_gene_network, mode = 'all'))
gg_dist <- data.frame(deg = degree_distribution(gene_gene_network, cumulative = TRUE, mode = 'all'))


ggplot(gg_degree, aes(x = deg)) +
  stat_density(aes(y = ..count..), color = "black", fill = "blue", alpha = 0.3) +
  theme_minimal() + xlab('Degree') + ylab('Frequency') + scale_x_log10() + scale_y_log10() +
  ggtitle('Gene-Gene Network: Frequency of Degrees')

ggplot(gg_dist, aes(x = deg)) +
  geom_point(x) +
  theme_minimal() + xlab('Degree') + ylab('Frequency') + scale_x_log10() + scale_y_log10() +
  ggtitle('Gene-Gene Network: Frequency of Degrees')

