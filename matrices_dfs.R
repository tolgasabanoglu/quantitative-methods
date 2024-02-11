---
title: "Assignment Lab Session 2"
author: "Tolga Şabanoğlu"
date: "01.11.2021"
output: html_document
---

### Steps to complete your assignment:

1. Complete the tasks. Write your R code in the designated areas (you can send the code to the console to test your code).
2. Create an HTML file in R-Studio: | Menu | File | Knit Document (alternatively: little Knit button in script header)
3. RENAME your html file to "Assignment_Lab02_YourLastName.html" (replace your last name)
4. Upload your assignment (.html file) to Moodle


### 1. Matrices (2 Points)

Convert vector x into a matrix m with 5 rows und 8 columns.

```{r}
x <- c(2,2,2,2,2,2,2,2,2,2,2,8,8,8,8,1,2,3,4,5,6,7,8,9,10,6,5,4,3,2,1,56,56,56,56,8,8,8,8,8)

length(x)

m <- matrix(1:40, nrow=5, ncol=8)
m

```

Extract the third column from matrix m.

```{r}

m[ ,3]

```

From matrix m, extract the element from the fourth row and second column.

```{r}

m[4,2]

```

From matrix m, extract the 7ths and 8ths column.

```{r}

m[ ,7:8]

```

Convert matrix m into a data.frame names 'mm' and extract the 3rd column

```{r}

mm <- as.data.frame(m)

mm$V3

```

### 2. Data frames (2 Points)

Download the airquality data set from Moodle and import it into R.

```{r}

df <- read.table("~/Desktop/quantitative methods/data/airquality.txt", sep = ",", dec = ".", header = TRUE)

df

```

Answer the following questions:

- What is the concentration of ozone on May 20th?
- What is the mean temperature on July 16th?
- How many days had an ozone concentration greater than 50 ppm?

```{r}

ozonemay20 <- df[df$Month == 5 & airquality$Day == 20, "Ozone"]
ozonemay20

mean_temp <- df[df$Month == 7 & df$Day==16, "Temp"]
mean_temp


ozonecontdays <- df[df$Ozone > 50, ]
nrow(ozonecontdays)

```

### 3. Manipulate data (3 Points)

Convert column `Month` (numeric) to a factor using the months names as factor labels ("May", "June", ...).

```{r}

df$Month <-  factor(df$Month)
levels(df$Month)
levels(df$Month) <- c("May", "June", "July", "August", "September")
df


```

Use the function `paste()` to create a new column called 'Date' of the following format: 'Month-Day', 'May-1', 'May-2', 'May-3', ...

```{r}

df$Data <-paste(df$Month, df$Day, sep="-")

df
```

Create two new variables ('Temp.C' and 'Wind.ms') that show temperature in Celsius and wind speed in m/s (instead of Fahrenheit und mph). Show the first five records for each new variable.

```{r}

df$Temp.C <- (df$Temp - 30) / 2 

df$Wind.ms <- df$Wind * 0.447

df

```

Write the data to a file called 'airquality2.csv' using csv format.

```{r}

write.csv(df, "~/Desktop/quantitative methods/data/airquality2.csv")


```

### 4. Loading new data (3 points)

Download the dataset 'treering.csv' from Moodle. Inspect it in either Excel or a text editor (Notepad++ for Windows or TextWrangler for Mac). Try loading the dataset into a data frame.

The dataset contains the width of treerings measures at several plots.

```{r}

treering <- read.csv("~/Desktop/quantitative methods/data/treering.csv")
treering

```

Drop all rows containing at least one `NA` value.

```{r}

treering_no_na <- na.omit(treering) 

```

What is the mean tree-ring width for plot X40B?

```{r}

mean(treering_no_na$X_40_B)

```

