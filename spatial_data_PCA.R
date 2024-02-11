# 1. Draw 10,000 random samples from the bioclim dataset (bioclim.tif).

library(raster)
library(rasterVis)

clim <- stack("~/Downloads/data 2/bioclim.tif")
clim

plot(clim, y = 1)

set.seed(42)
clim_samp <- sampleRandom(clim, size = 10000)
clim_samp <- as.data.frame(clim_samp)

head(clim_samp)

# 2. Conduct a principal component analysis on the bioclim samples in order to reduce the 19 climate variables to the most important principal components. Answer the following question (show your results).

## a) How much variance (in percent) explain the first three components? How many components, do you think, are needed to describe (the majority of the variance of) the dataset and why?

library(GGally)
library(ggplot2)

pca <- prcomp(clim_samp, scale. = TRUE)

summary(pca)

## a) Proportion of variance for first three components are 0.5173, 0.2565 and 0.05641

# 3. What information do the first three components (mainly) represent with respect to the input variables? Use the loadings/rotation coefficients of the first three components to answer this question.

biplot(pca, scale = 0, cex = 0.6)

biplot(pca, choices=c(1,3))

# 4. Inspect the spatial predictions of the important principal components visually.

clim_pca <- raster::predict(clim, pca, index = 1:4)

plot(subset(clim_pca, 1))
plot(subset(clim_pca, 2))
plot(subset(clim_pca, 3))
