---
title: "Asignment Week 1"
author: "Tolga Şabanoğlu"
date: "25.10.2021"
output: html_document
---

### 1. Create a vector from a series of numbers:

2;2;2;2;2;2;2;2;2;2;2;8;8;8;8;1;2;3;4;5;6;7;8;9;10;6;5;4;3;2;1;56;56;56;56;8;8;8;8;8

From the above number series construct a vector `x` using the functions `c()`, `rep()` and `seq()`. Note, you MUST use all three functions! Read the slides from the lecture carefully to answer the questions.

```{r}

x1 <- rep(c(2,8),c(11,4))
x2 <- seq(from= 1, to=10)
x3 <- c(6:1)
x4 <- rep(c(56,8),c(4,5))

x <-  c(x1, x2, x3, x4)
x

```

### 2. How many elements has vector `x`?

```{r}
x <- c(2,2,2,2,2,2,2,2,2,2,2,8,8,8,8,1,2,3,4,5,6,7,8,9,10,6,5,4,3,2,1,56,56,56,56,8,8,8,8,8)

length(x)

```

### 3. Extract the 12th element from vector `x`.

```{r}

x[12]
```

### 4. Extract the elements 20-27 from vector `x`.

```{r}

x[seq(from= 20, to=27)]
```

### 5. Extract the 12th and 20-27th element from vector `x`.

```{r}

x[c(12, 20:27)]

```

### 6. Extract all but the 5th element from vector `x` and assign the new vector to a variable `y`. Print the content of `y`.

```{r}

y = x[-5]
y 

```

### 7. Write a logical expression that assesses for each element `i` in vector `x` whether `i` is equal to `56`. The result should be a logical vector of `TRUE`s and `FALSE`s that has the same number of elements as `x`.

```{r}

x==56

```

### 8. Use the logical expression to replace all values `56` in vector `x` with the value `52`. Print the content of `x`.

```{r}

x[(x==56)] = 52
x

```

### 9. Replace all elements in vector `x` that are less than `5` or greater than `50` with the value `NA`. Use a logical expression, and print the result.

```{r}

x[x < 5 | x > 50] <-  NA
x

```

### 10. Add `5` to each element in vector `x`.

```{r}

x <-  x + c(5)
x

```

