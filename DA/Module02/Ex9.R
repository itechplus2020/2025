head(iris)
#define Min-Max normalization function
min_max_norm <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

#apply Min-Max normalization to first four columns in iris dataset
iris_norm <- as.data.frame(lapply(iris[1:4], min_max_norm))

#view first six rows of normalized iris dataset
head(iris_norm)

#standardize Sepal.Width

iris$Sepal.Width <- (iris$Sepal.Width - mean(iris$Sepal.Width)) / sd(iris$Sepal.Width)

head(iris)
head(scale(iris$Sepal.Width))

#standardize first four columns of iris dataset
iris_standardize <- as.data.frame(scale(iris[1:4]))

#view first six rows of standardized dataset
head(iris_standardize)