# 1. Matrices
# Convert vector x into a matrix m with 5 rows und 8 columns.
x <- c(2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 8, 8, 8, 8, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 6, 5, 4, 3, 2, 1, 56, 56, 56, 56, 8, 8, 8, 8, 8)
length(x)
m <- matrix(1:40, nrow = 5, ncol = 8)
m

# Extract the third column from matrix m.
m[, 3]

# From matrix m, extract the element from the fourth row and second column.
m[4, 2]

# From matrix m, extract the 7ths and 8ths column.
m[, 7:8]

# Convert matrix m into a data.frame names 'mm' and extract the 3rd column.
mm <- as.data.frame(m)
mm$V3

# 2. Data frames
# Download the airquality data set from Moodle and import it into R.
df <- read.table("~/Desktop/quantitative methods/data/airquality.txt", sep = ",", dec = ".", header = TRUE)
df

# Answer the following questions:
# What is the concentration of ozone on May 20th?
ozonemay20 <- df[df$Month == 5 & df$Day == 20, "Ozone"]
ozonemay20

# What is the mean temperature on July 16th?
mean_temp <- df[df$Month == 7 & df$Day == 16, "Temp"]
mean_temp

# How many days had an ozone concentration greater than 50 ppm?
ozonecontdays <- df[df$Ozone > 50, ]
nrow(ozonecontdays)

# 3. Manipulate data
# Convert column `Month` (numeric) to a factor using the months names as factor labels ("May", "June", ...).
df$Month <- factor(df$Month)
levels(df$Month)
levels(df$Month) <- c("May", "June", "July", "August", "September")
df

# Use the function `paste()` to create a new column called 'Date' of the following format: 'Month-Day', 'May-1', 'May-2', 'May-3', ...
df$Data <- paste(df$Month, df$Day, sep = "-")
df

# Create two new variables ('Temp.C' and 'Wind.ms') that show temperature in Celsius and wind speed in m/s.
df$Temp.C <- (df$Temp - 30) / 2
df$Wind.ms <- df$Wind * 0.447
head(df$Temp.C)
head(df$Wind.ms)

# Write the data to a file called 'airquality2.csv' using csv format.
write.csv(df, "~/Desktop/quantitative methods/data/airquality2.csv")

# 4. Loading new data
# Download the dataset 'treering.csv' from Moodle.
treering <- read.csv("~/Desktop/quantitative methods/data/treering.csv")
treering

# Drop all rows containing at least one `NA` value.
treering_no_na <- na.omit(treering)

# What is the mean tree-ring width for plot X40B?
mean(treering_no_na$X_40_B)
