colSums(is.na(airquality))
# Remove rows with any missing value
airquality_complete_cases <- na.omit(airquality)
# See the missing value now
colSums(is.na(airquality_complete_cases))
# Get the dimensions of the dataset (rows and columns)
dim(airquality_complete_cases)

# For a single column
# Create a copy of the original dataframe
airquality_imputed_one <- airquality
colSums(is.na(airquality_imputed_one))
airquality_imputed_one$Ozone[is.na(airquality$Ozone)] <- mean(airquality$Ozone, na.rm = TRUE)

# Count missing values in each column
colSums(is.na(airquality_imputed_one))


# For all columns in a dataset
airquality_imputed <- airquality
colSums(is.na(airquality_imputed))
for(i in 1:ncol(airquality_imputed)) {
  if(is.numeric(airquality_imputed[[i]])) {
    airquality_imputed[[i]][is.na(airquality_imputed[[i]])] <- mean(airquality_imputed[[i]], na.rm = TRUE)
  }
}

# Count missing values in each column
colSums(is.na(airquality_imputed))


# Install packages if they are not already installed
install.packages(c("mice", "ggplot2", "naniar"))

# Load the packages
library(mice)
library(ggplot2)
library(naniar)

# Visualize missing data
vis_miss(airquality)

# Set the seed for reproducibility
set.seed(12345)

# Perform Multiple Imputation
imputed_data <- mice(airquality, m=5, method='pmm', print=FALSE)