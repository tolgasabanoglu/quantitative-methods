# 1. Build a hypothesis for the airquality data
df <- read.table("~/Desktop/data 2/airquality.txt", sep = ",", dec = ".", check.names = FALSE, header = TRUE)
df <- na.omit(df)
plot(df$Temp, df$Ozone)

# Research hypothesis
# Hypothesis: There is a positive association between temperature and ozone concentration in New York. As temperature increases, ozone concentration is expected to rise.

# 2. Fit a linear model to the airquality data
library(dplyr)
library(ggplot2)

# Fit linear model to data
fit <- lm(Ozone ~ Temp, data = df)
fit

# Extract information about parameter estimates
coef(summary(fit))

# Analysis of variance
anova(fit)

# 3. Plot the regression
# Build linear model
data("df", package = "datasets")
model <- lm(Ozone ~ Temp, data = df)
# Add predictions
pred.int <- predict(model, interval = "prediction")
mydata <- cbind(df, pred.int)
# Regression line + confidence intervals
library("ggplot2")
p <- ggplot(mydata, aes(Temp, Ozone)) +
  geom_point() +
  stat_smooth(method = lm)
# Add prediction intervals
p + geom_line(aes(y = lwr), color = "red", linetype = "dashed") +
  geom_line(aes(y = upr), color = "red", linetype = "dashed")

# 4. Model diagnostics
# 1- QQplot
plot(fit, which = 2, col = c("blue"))
# 2- Scatter-plot of fitted versus residuals
plot(fit, which = 1, col = c("blue"))

# In general, residuals look normal, but there are outliers on the top of the graph. The relationship is approximately linear, with the exception of some data points. Proceed with the assumption that the error terms are properly distributed upon removing the outliers from the dataset.

# 5. Transforming the response
# 5.1 Create a new column 'logOzone' in the airquality dataset by calculating the natural logarithm of Ozone concentration.
df$logOzone = log(df$Ozone)

fitlog <- lm(logOzone ~ Temp, data = df)
coef(summary(fitlog))
anova(fitlog)

# 5.2 Check the residuals of the model. Do they look different/better/worse than for the previous model?
anova(fit)  # First model
anova(fitlog)  # Second model
plot(fitlog, which = 2, col = c("blue"))  # QQplot

# Second model's residuals value is less than the first; they look better than the first model.

# 5.3 Plot the regression line of the logged model (without confidence intervals).
p <- ggplot(df, aes(Temp, logOzone)) + geom_point()
coef(lm(logOzone ~ Temp, data = df))
p + geom_smooth(method = "lm", se = FALSE)
