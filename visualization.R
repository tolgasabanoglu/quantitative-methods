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

### 3. Tree rings (4 points)

Import the dataset 'treering.csv'. Columns  1 to 56 contain dendrochronological time series of 56 tree cores (annual growth = tree ring widths in mm). Column 57 contains the year associated with the annual tree rings. The dendrochronological time series are of different length, e.g. not all years are observed in each tree core. The column names are the names (ids) of the tree cores.

In Moodle, you'll find an example plot 'treering_example.pdf' showing time series of tree ring widths for each tree core. Create a plot that shows the exact same relationships. Hint: Use the `gather()` function to convert the dataset into the appropriate format!

**NOTE:** In markdown it might be necessary to index the namespace of some functions. In prticular, `dplyr::select()` and `dplyr::filter()` might fail knitting if the namespace is not defined.

```{r}

library(dplyr)

treering <- read.csv("~/Downloads/data 2/treering.csv", sep = ",", dec = ".", header = TRUE)

treering_gat <- gather(treering,  na.rm = T, key = "Plots", "Increment", c(-Year))

treering_plot <- treering_gat %>%
  mutate(Subplot = case_when(
    endsWith(Plots, "A") ~ "A",
    endsWith(Plots, "B") ~ "B"
    ))

ggplot(treering_plot, aes(x=Year, y=Increment, col= Subplot)) +
  geom_line()


```

Following, calculate the mean and standard deviation of increment for each dendrochronological time series. Hint: Use a combination of `group_by()` and `summarize()` available through the **dplyr** package. Prove your solution by showing the first 5 rows of the summary dataset!

```{r}

treering_group <- treering_gat %>% group_by(Increment, Year)
treering_summarise <- treering_group %>% summarise(
  Inc_mean = mean(Increment, na.rm = TRUE),
  Inc_sd = sd(Increment, na.rm = TRUE),
)
  
treering_summarise[1:5, ]        

```

Which plot has the highest/lowest increment?

```{r}

treering_gat %>% group_by(Plots) %>% 
  summarise(max = max(Increment),
            min = min(Increment)
  )
                                                
```


```
