---
title: "Assignment 4"
author: "Tolga Şabanoğlu"
date: "15.11.2021"
output: html_document
---

### Steps to complete your assignment:

1. Complete the tasks. Write your R code in the designated areas (you can send the code to the console to test your code).
2. Create an HTML file in R-Studio: | Menu | File | Knit Document (alternatively: little Knit button in script header)
3. RENAME your html file to "Assignment_Lab04_YourLastName.html" (replace your last name)
4. Upload your assignment (.html file) to Moodle


### 1. Build a hypothesis for the airquality data (1 points)

Suppose you are tasked to analyze how the variability in near-surface ozone concentrations in New York is associated with local variations in weather conditions. With the airquality data set, plot ozone concentration (ppb) versus temperature (degrees F). Based on the observed relationship, phrase a plausible (!) research hypothesis. Think about which variable to plot on the x- and y-axes.

```{r}

df <-  read.table("~/Desktop/data 2/airquality.txt", sep = ",", dec = ".", check.names = FALSE, header = TRUE)
df <- na.omit(df)
plot(df$Temp, df$Ozone)


#research hypothesis can explore the relationship between ozone and temperature. according to this, while the response variable is ozone concentrations, temperature can be the predictor variable. 


```


### 2. Fit a linear model to the airquality data (3 points)

Fit a simple linear regression model using ordinary-least-squares regression between ozone concentration and temperature to analyze the effect of temperature on ozone. Briefly answer the following questions: (1) How does ozone concentration change with Temperature? (2) Is the effect of temperature on ozone concentration significant? (3) How much of the variance in ozone concentration is explained by temperature alone? Show how you obtained the results with R?

```{r}

library(dplyr)
library(ggplot2)

# fit linear model to data
fit <- lm(Ozone ~ Temp, data = df)
fit
# extract information about parameter estimates
coef(summary(fit))
anova(fit)


# How does ozone concentration change with Temperature?
plot(df$Temp, df$Ozone)
#Ozone concentration increases as temperature degree (F) goes up. 

# Is the effect of temperature on ozone concentration significant?
anova(fit)
#when we look at the temperature's p-value and significance code, it is *** (which means p-value is very close to 0), so it would indicate a significant result. 


# How much of the variance in ozone concentration is explained by temperature alone? Show how you obtained the results with R?
#anova(fit) gives us analysis of variance table, which includes Sum sq, Mean sq, F-value, P-value variances


```


### 3. Plot the regression (2 Points)

Create a plot showing the fitted relationship between temperature and ozone concentration. Also show uncertainties in the regression line caused by uncertainty in the parameter estimates (confidence interval).

```{r}

library(ggplot2)

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
p + geom_line(aes(y = lwr), color = "red", linetype = "dashed")+
    geom_line(aes(y = upr), color = "red", linetype = "dashed")

```

### 4. Model diagnostics (3 Points)

Create two residual plots for the model: 1) a qq-plot and 2) a scatter-plot of fitted values versus residuals. Do the residuals look normal and properly distributed? Answer the question in 2-3 sentences.

```{r}
#1- qqplot
plot(fit, which=2, col=c("blue"))  #qqplot
#2- scatter-plot of fitted versus residuals
plot(fit, which=1, col=c("blue")) # Residuals vs Fitted Plot

#in general, residuals look normal but there is outliers on top of the graph. the relationship is approximately linear with the exception of some data points. we could proceed with the assumption that the error terms are properly distributed upon removing the outliers from the dataset.

```


### 5. Transforming the response (3 Points in total, each part 1 point)

5.1 Create a new column 'logOzone' in the airquality dataset by calculating the natural logarithm of Ozone concentration. Following, fit a model explaining the logarithm of ozone concentration by temperature.

```{r}

df$logOzone = log(df$Ozone)

fitlog <- lm(logOzone ~ Temp, data = df)
coef(summary(fitlog))
anova(fitlog)


```

5.2 Check the residuals of the model. Do they look different/better/worse than for the previous model?

```{r}

anova(fit) #first model
anova(fitlog) #second model 
plot(fitlog, which=2, col=c("blue"))  #qqplot

#Second model's residuals value is less than second, this is why they look better than the first model. 

```


5.3 Plot the regression line of the logged model (without confidence intervals). You can either plot it in log-space (using the logged ozone concentrations) or back-transform the logged ozone concentrations into linear space using the exp() function (recall: exp(log(x)) = x).

```{r}

library(ggplot2)


p <- ggplot(df, aes(Temp, logOzone)) + geom_point()
coef(lm(logOzone ~ Temp, data = df))
p + geom_smooth(method = "lm", se = FALSE)


```
