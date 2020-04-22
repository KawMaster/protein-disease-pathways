# Feature Analysis


# Libraries
library(tidyverse)
library(hash)
library(ggplot2)




# Dimensionality Reduction on the bio-pathways-features.csv (bio_pathways_features .RData)
# Label each point with a color for it's disease Class (30 total classes)


## PCA 


## UMAP


## TSNE


### Use K-Means Clustering for all 3 projections to create 2 plots for each. 
### Use K-Means for n = 30 Unique Disease Classes

### We could see which projection + clustering gives us better accuracy where we define 
### that (# diseases classified with it) / (total # diseases in that class) or something else if you think of anything




# Multi-Class SVM for predicting disease classes based on a disease's features in bio_pathways_features
## Use all of the features + another model that uses the features based on the 'best projection'




# Multi-Class SVM for predicting disease classes based on a disease's proteins and their orbit signatures (diseasemotifs)
## Use all of the features + another model that uses the features based on the 'best projection'


# In addition we could do Gaussian Mixture Models on any of those dimensionality reduction techniques. If we have time.

