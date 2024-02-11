---
title: "Assignment Lab Session 3"
author: "Tolga Şabanoğlu"
date: "09.11.2021"
output: html_document
---

### Steps to complete your assignment:

1. Complete the tasks. Write your R code in the designated areas (you can send the code to the console to test your code).
2. Create an HTML file in R-Studio: | Menu | File | Knit Document (alternatively: little Knit button in script header)
3. RENAME your html file to "Assignment_Lab03_YourLastName.html" (replace your last name)
4. Upload your assignment (.html file) to Moodle


### 1. Plotting the airquality dataset (2 points)

Create a scatter-plot showing the relationship between temperature, solar radiation and wind speed. Briefly describe what you see.

```{r}

library(ggplot2)

airquality <- read.table("~/Desktop/data 2/airquality.txt", sep = ",", dec = ".", header = TRUE)

ggplot(data= airquality, aes(x= Temp, y = Solar, col= Wind)) +
  geom_point()

#scatter-plot describes as the temperature rises, solar radiation increases and winds get more frequent, but not necessarily stronger

```

Create a scatterplot showing the relationship between ozone concentration and temperature for each month. Briefly describe what you see.

```{r}

ggplot(data= airquality, aes(x= Ozone, y = Temp)) +
  facet_wrap(~Month) + 
  geom_point()

# The plot highlights when temperature increases, mean ozone in parts goes up between may and september 
```

### 2. Wrangel the airquality data (4 points)

Transform the airquality dataset into long-format, with a key column indicating the type of measurement and a value column giving the actual measurements (while keeping the Day, Month, and ID columns).

```{r}

library(tidyr)

airquality_tidy <- pivot_longer(airquality, values_to ="measurements", names_to = "type_of_measurement", cols= 2:5)
airquality_tidy


```

Use the transformed dataset to simultaneously visualize the trend of ozone concentration, temperature, wind speed, and solar radiation over time. Hint: The ID column gives you a sequential index of measurement!

```{r}

ggplot(airquality_tidy, aes(x = ID, y = measurements, col= type_of_measurement)) +
         geom_point()


```


                                                
```


```
