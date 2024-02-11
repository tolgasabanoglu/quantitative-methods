# 1. Import and explore the dataset
library(ggplot2)

df <- read.table("~/Desktop/data 2/Deforestation.txt", sep=";", dec=" ", header=T)

# Number of deforested and not deforested samples 
table(df$Deforestation)

# Structure of the dataframe
str(df)

# Convert column types from character to numeric
cols.num <- c("Slope","Dist_River","Dist_Road")
df[cols.num] <- sapply(df[cols.num], as.numeric)

# Value range
summary(df)

# 2. Estimate the effect of the highway on deforestation.

## 2.1 Build a model that predicts probability of deforestation from distance to road (Dist_Road)
fitglm <- glm(Deforestation ~ Dist_Road, data = df, family = binomial(link = "logit"))
summary(fitglm)

prediction <- data.frame(Dist_Road = seq(0, 125, length.out = 100))
prediction$fitted <- predict(object = fitglm, newdata = prediction, type = "response")

ggplot() +
  geom_point(data = df, aes(x = Dist_Road, y = Deforestation)) +
  geom_line(data = prediction, aes(x = Dist_Road, y = fitted))

# Estimating the goodness of fit using the pseudo-Rsquared
pseudo_r2 <- 1 - fitglm$deviance / fitglm$null.deviance
pseudo_r2

# 2.3 Plot deforestation against distance to road and overlay your fitted model with the confidence band.
pred <- predict(object = fitglm , newdata = df, 
                type = "link", se.fit = TRUE)

df$fitted_link <- pred$fit
df$lower_link <- df$fitted_link - 2 * pred$se.fit
df$upper_link <- df$fitted_link + 2 * pred$se.fit

df$link <- plogis(df$fitted_link)
df$lower <- plogis(df$lower_link)
df$upper <- plogis(df$upper_link)

ggplot() +
  geom_point(data = df, aes(x = Dist_Road, y = Deforestation)) +
  geom_ribbon(data = df, aes(x = Dist_Road, ymin = lower, ymax = upper), alpha = 0.3) +
  geom_line(data = prediction, aes(x = Dist_Road, y = fitted))

# 2.4 What is the deforestation probability 1 km away from the road according to your model?
summary(fitglm)

# 2.5 How does an increase in 1km distance to the road effect the chance of deforestation? Use the odds-ratio to answer that question.
summary(fitglm)
exp(coef(fitglm))

# 3. Model selection

## 3.1 Build a model that predicts probability of deforestation from all terrain and distance variables.
m1 <- glm(Deforestation ~ Dist_Road + Elevation, data = df, family = binomial(link = "logit"))
m2 <- glm(Deforestation ~ Elevation + Dist_River, data = df, family = binomial(link = "logit"))
m3 <- glm(Deforestation ~ Slope + Dist_Road, data = df, family = binomial(link = "logit"))
m4 <- glm(Deforestation ~ Dist_Road + Dist_River, data = df, family = binomial(link = "logit"))

model <- model.avg(m1, m2, m3, m4)
summary(model)

AICctab(m1, m2, m3, m4, base = TRUE, weights = TRUE, nobs = nrow(df))
