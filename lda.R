# Load necessary libraries
library(MASS)
library(caret)

# Load iris dataset
data("iris")

# Display the first few rows of the iris dataset and count the number of samples for each species
head(iris)
table(iris$Species)

# Build a linear discriminant analysis model
lda_model <- lda(Species ~ ., data=iris)

# Display the model summary and priors
lda_model
lda_model$prior

# Plot the linear discriminant functions
plot(lda_model)

# Use leave-one-out cross-validation to predict species
lda_prediction <- predict(lda_model)
conf_training <- table(list(predicted=lda_prediction$class, observed=iris$Species))
confusionMatrix(conf_training)

# Use cross-validation for test error estimation
lda_model_cv <- lda(Species ~ ., data=iris, CV=TRUE)
conf_cv <- table(list(predicted=lda_model_cv$class, observed=iris$Species))
confusionMatrix(conf_cv)
