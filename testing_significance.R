# Step 1: Import and visualize the data
library(ggplot2)
library(tidyr)
library(dplyr)

cormorant <- read.table("~/Desktop/data 2/cormorant.txt", sep = ",", dec = ".", header = TRUE)

# Boxplot of diving times by season
boxplot(divingtime ~ season, data = cormorant, col = "red")

# Boxplot of diving times by subspecies
boxplot(divingtime ~ subspecies, data = cormorant, col = "blue")

# Step 2: Test for variance homogeneity
var.test(cormorant$divingtime ~ cormorant$subspecies, alternative = "two.sided")
var.test(x = cormorant$divingtime, y = cormorant$season, alternative = "two.sided")

# Step 3: Test the significance of the effects of season and sub-species on diving time
subspe <- aov(divingtime ~ subspecies, data = cormorant)
summary(subspe)
TukeyHSD(subspe)

cormorant$season <- factor(cormorant$season, levels = 1:4, labels = c('Spring', 'Summer', 'Autumn', 'Winter'))
season <- aov(divingtime ~ season, data = cormorant)
summary(season)
TukeyHSD(season)

# Step 4: Visually check the model assumptions
cormorant_nona <- na.omit(cormorant)
lm.sub <- lm(divingtime ~ subspecies, data = cormorant_nona)

cormorant_nona$resid_std <- rstandard(lm.sub)
cormorant_nona$fitted <- fitted(lm.sub)

# QQ-Plot - diving time / subspecies
ggplot(cormorant_nona, aes(sample = resid_std)) +
  stat_qq() +
  geom_abline(intercept = 0, slope = 1)

# Fitted versus residuals - diving time / subspecies
ggplot(cormorant_nona, aes(x = fitted, y = resid_std)) +
  geom_point() +
  geom_hline(yintercept = 0)

lm.season <- lm(divingtime ~ season, data = cormorant_nona)
cormorant_nona$resid_std2 <- rstandard(lm.season)
cormorant_nona$fitted2 <- fitted(lm.season)

# QQ-Plot - diving time / season
ggplot(cormorant_nona, aes(sample = resid_std2)) +
  stat_qq() +
  geom_abline(intercept = 0, slope = 1)

# Fitted versus residuals - diving time / season
ggplot(cormorant_nona, aes(x = fitted, y = resid_std2)) +
  geom_point() +
  geom_hline(yintercept = 0)

# Step 5: Identify which seasons differ with respect to diving time
summary(season)
TukeyHSD(season)

# Step 6: Estimate the effect of season and subspecies
# Effect of season
model.tables(season, type = "effects", se = TRUE)

# Effect of subspecies
model.tables(subspe, type = "effects", se = TRUE)
