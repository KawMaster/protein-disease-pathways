# Network Analysis


# Libraries
library(tidyverse)
library(igraph)
library(multinet)
library(hash)
library(ggplot2)
library(scales)
library(emdbook)
library(poweRlaw)



# Gene - Gene Network 


## Network Density: The proportion of present edges from all possible edges in the network.
edge_density(gene_gene_network, loops = F)


## Degree Distribution

gg_degree <- data.frame(deg = degree(gene_gene_network, mode = 'all'))

gg_dist <- data.frame(k = 0:max(gg_degree[gg_degree > 0]), 
                      p_k = degree_distribution(gene_gene_network, cumulative = TRUE, mode = 'all'))

ggplot(gg_dist, aes(x = k, y = p_k)) +
  geom_point(size = .3) + geom_smooth() + 
  theme_minimal() + xlab(bquote('Degree' ~ q)) + ylab(bquote('Fraction of Nodes with Degree' ~ q)) +
  scale_x_log10() + scale_y_log10() +
  ggtitle(bquote('Gene-Gene Network: CCDF of' ~ P(K < k)))



## Estimating gamma for the ccdf

m_pl <- displ$new(gg_degree[gg_degree > 0])
est_pl <- estimate_xmin(m_pl)

est_pl$xmin #k_min

est_pl$pars #gamma

est_pl$gof #D


## Scanning many values of k_min

gg_degree.s <- unique(gg_degree[gg_degree > 0])

d_est <- data.frame(K_min=sort(gg_degree.s)[1:(length(gg_degree.s)-2)], 
                    gamma=rep(0,length(gg_degree.s)-2), D=rep(0,length(gg_degree.s)-2))

for (i in d_est$K_min){
  d_est[which(d_est$K_min == i),2] <- estimate_xmin(m_pl, xmins = i)$pars
  d_est[which(d_est$K_min == i),3] <- estimate_xmin(m_pl, xmins = i)$gof
}

K.min_D.min <- d_est[which.min(d_est$D), 1]


ggplot(data=d_est, aes(x=K_min, y=D)) + geom_line() + theme_bw() + 
  geom_vline(xintercept=K.min_D.min, colour="red") + 
  annotate("text", x=K.min_D.min, y=max(d_est$D)/3*2, label=K.min_D.min)


ggplot(data=d_est, aes(x=K_min, y=gamma)) + geom_line() + theme_bw() + 
  geom_vline(xintercept=K.min_D.min, colour="red") + 
  annotate("text", x=K.min_D.min, y=max(d_est$gamma)/3*2, label=K.min_D.min)



m_pl$setXmin(est_pl)
plot.data <- plot(m_pl, draw = F)
fit.data <- lines(m_pl, draw = F)



ggplot(plot.data) + geom_point(aes(x=log(x), y=log(y))) + labs(x="log(k)", y="log(CDF)") + theme_bw() + 
  geom_line(data=fit.data, aes(x=log(x), y=log(y)), colour="red") 


bs_pl <- bootstrap_p(m_pl, no_of_sims=1000, threads=11, seed = 123)

bs_pl$bootstraps
plot(bs_pl)


## Mapping diseases with genes to get subgraphs from the gene_gene_network

diseases <- unique(bpa_edges$Disease.ID)



disease_genes_graphs <- list()

gg_vert <- V(gene_gene_network)
diseasegenes_in_gg <- c()

for (disease in diseases)
{
  genes <- as.character(bpa_edges$Gene.ID[bpa_edges$Disease.ID == disease])
  
  g_in <- genes %in% gg_vert

  # Ratio of of the disesae genes in the gene-gene network
  diseasegenes_in_gg <- c(diseasegenes_in_gg, sum(g_in) / length(genes))
  
  
  
  isg <- make_ego_graph(gene_gene_network, order = 2, nodes = as.integer(genes[g_in]))
  # isg2 <- simplify(isg, remove.multiple = TRUE, remove.loops = TRUE)
  # plot(isg[1], layout = layout_with_fr(isg))
  disease_genes_graphs <- c(disease_genes_graphs, isg)
  # plot(isg2, layout = layout_with_fr(isg2))
  
  # plot(isg)
}

disease_gg <- data.frame(frac = diseasegenes_in_gg)

ggplot(disease_gg, aes(x=frac)) + 
  geom_histogram(binwidth=0.05) + theme_minimal() +
  xlab('Percentage of Disease Associated Genes') +
  ylab('Frequency') + ggtitle('Distribution of Disease Associated Genes in Gene - Gene Network')



netm <- get.adjacency(gene_gene_network, sparse=F)
# 
# colnames(netm) <- V(net)$media
# 
# rownames(netm) <- V(net)$media



palf <- colorRampPalette(c("gold", "dark orange")) 

heatmap(netm, Rowv = NA, Colv = NA, col = palf(100), 
        
        scale="none", margins=c(10,10) )







