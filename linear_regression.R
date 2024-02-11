# 1. Import and prepare the dataset
tetr <- read.table("~/Desktop/data 2/tetrahymena_zellen.txt", header = TRUE)

# 2. Visualize the data
library(ggplot2)

# Scatterplot before transformation
ggplot(data = tetr, aes(x = concentration, y = diameter, col = glucose)) +
  geom_point()

# Transforming predictor to make the relationship more linear
tetr$concentrationLog <- log(tetr$concentration)

# Scatterplot after transformation
ggplot(data = tetr, aes(x = concentrationLog, y = diameter, col = glucose)) +
  geom_point()

# 3. Build a simple linear model
fit <- lm(diameter ~ concentrationLog, data = tetr)
summary(fit)

# Visualize the linear model
prediction.diameter <- fit %>%
  predict(., interval = 'confidence', level = 0.99) %>%
  as.data.frame() %>%
  mutate(concentrationLog = tetr$concentrationLog, diameter = tetr$diameter)

ggplot(prediction.diameter, aes(x = concentrationLog, y = diameter)) +
  geom_point() +
  geom_line(data = prediction.diameter, aes(x = concentrationLog, y = fit)) +
  geom_line(data = prediction.diameter, aes(x = concentrationLog, y = upr), linetype = "dashed") +
  geom_line(data = prediction.diameter, aes(x = concentrationLog, y = lwr), linetype = "dashed")

# 4. Multiple linear model
fitGlu <- lm(diameter ~ concentrationLog + glucose, data = tetr)
AIC(fit, fitGlu)
c(summary(fit)$r.squared, summary(fitGlu)$r.squared)

# 5. Plot the regression lines of the multiple linear model
tetr$glucose <- factor(tetr$glucose, levels = c("no", "yes"),
                        labels = c("without glucose", "glucose"))

pred <- predict(fitGlu, interval = "confidence", level = 0.99) %>%
  as.data.frame() %>%
  cbind(concentrationLog = tetr$concentrationLog, glucose = tetr$glucose, .)

ggplot(tetr) +
  geom_point(aes(x = concentrationLog, y = diameter, col = glucose)) +
  geom_ribbon(data = pred, aes(x = concentrationLog, ymin = lwr, ymax = upr, fill = glucose), alpha = 0.2) +
  geom_line(data = pred, aes(x = concentrationLog, y = fit, col = glucose)) +
  scale_color_manual(values = c("#E41A1C", "#377EB8")) +
  scale_fill_manual(values = c("#E41A1C", "#377EB8"))
