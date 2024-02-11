# 1. Plotting the airquality dataset
# Create a scatter-plot showing the relationship between temperature, solar radiation, and wind speed. Briefly describe what you see.
library(ggplot2)

airquality <- read.table("~/Desktop/data 2/airquality.txt", sep = ",", dec = ".", header = TRUE)

ggplot(data = airquality, aes(x = Temp, y = Solar, col = Wind)) +
  geom_point()

# Scatter-plot describes that as the temperature rises, solar radiation increases, and winds get more frequent, but not necessarily stronger.

# Create a scatterplot showing the relationship between ozone concentration and temperature for each month. Briefly describe what you see.
ggplot(data = airquality, aes(x = Ozone, y = Temp)) +
  facet_wrap(~Month) +
  geom_point()

# The plot highlights that when temperature increases, mean ozone in parts goes up between May and September.

# 2. Wrangling the airquality data
# Transform the airquality dataset into long-format, with a key column indicating the type of measurement and a value column giving the actual measurements (while keeping the Day, Month, and ID columns).
library(tidyr)

airquality_tidy <- pivot_longer(airquality, values_to = "measurements", names_to = "type_of_measurement", cols = 2:5)
airquality_tidy

# Use the transformed dataset to simultaneously visualize the trend of ozone concentration, temperature, wind speed, and solar radiation over time.
# Hint: The ID column gives you a sequential index of measurement!
ggplot(airquality_tidy, aes(x = ID, y = measurements, col = type_of_measurement)) +
  geom_point()

# 3. Tree rings
# Import the dataset 'treering.csv'.
treering <- read.csv("~/Downloads/data 2/treering.csv", sep = ",", dec = ".", header = TRUE)

# Create a plot that shows the exact same relationships.
treering_gathered <- gather(treering, key = "Plots", value = "Increment", -Year)

treering_plot <- treering_gathered %>%
  mutate(Subplot = case_when(
    endsWith(Plots, "A") ~ "A",
    endsWith(Plots, "B") ~ "B"
  ))

ggplot(treering_plot, aes(x = Year, y = Increment, col = Subplot)) +
  geom_line()

# Calculate the mean and standard deviation of increment for each dendrochronological time series.
treering_summary <- treering_gathered %>%
  group_by(Plots) %>%
  summarise(mean_increment = mean(Increment, na.rm = TRUE),
            sd_increment = sd(Increment, na.rm = TRUE))

# Show the first 5 rows of the summary dataset.
head(treering_summary)

# Which plot has the highest/lowest increment?
treering_gathered %>%
  group_by(Plots) %>%
  summarise(max_increment = max(Increment, na.rm = TRUE),
            min_increment = min(Increment, na.rm = TRUE))
