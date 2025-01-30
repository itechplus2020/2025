# 1. Load Necessary Library
# install.packages("dplyr")  # If not installed
library(dplyr)

# 2. Download and Load Titanic Data
titanic_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"
titanic <- read.csv(titanic_url, stringsAsFactors = FALSE)
titanic$Embarked[titanic$Embarked == ""] <- NA
colSums(is.na(titanic))
# 3. Inspect the Dataset
head(titanic)        # Preview first few rows
str(titanic)         # Structure (data types)
summary(titanic)     # Summary statistics

# 4. Check for Duplicates
sum(duplicated(titanic))               # Number of duplicated rows
titanic_unique <- titanic %>% distinct()  
sum(duplicated(titanic_unique))        # Should be 0 if no duplicates

# Convert Relevant Categorical Variables to Factors

titanic_unique$Survived <- as.factor(titanic_unique$Survived)
titanic_unique$Pclass   <- as.factor(titanic_unique$Pclass)
titanic_unique$Sex      <- as.factor(titanic_unique$Sex)
titanic_unique$Embarked <- as.factor(titanic_unique$Embarked)
titanic_unique$SibSp <- as.factor(titanic_unique$SibSp)
titanic_unique$Parch <- as.factor(titanic_unique$Parch)


# 6. Final Check of Structure
str(titanic_unique)

##################################################
# Imputing Missing Values 
##################################################
# 1. Check Missing Values
colSums(is.na(titanic_unique))
# 2. Simple Imputation
# Median for Age
median_age <- median(titanic_unique$Age, na.rm = TRUE)
titanic_unique$Age[is.na(titanic_unique$Age)] <- median_age
# Mode Function
get_mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}
# Mode for Embarked
mode_embarked <- get_mode(titanic_unique$Embarked[!is.na(titanic_unique$Embarked)])
titanic_unique$Embarked[is.na(titanic_unique$Embarked)] <- mode_embarked
# Verify no missing in Age or Embarked
colSums(is.na(titanic_unique))
# 3. Advanced Imputation with 'mice'
# install.packages("mice")  # if needed
library(mice)
# Create a subset with some columns
data_subset <- titanic_unique[, c("Age", "Fare", "Embarked")]
# Introduce artificial NAs in 'Fare' for demonstration
set.seed(123)
data_subset[sample(1:nrow(data_subset), 30), "Fare"] <- NA
# Perform multiple imputation
imputed <- mice(data_subset, m = 5, maxit = 5, method = 'pmm', seed = 500)
completed_data <- complete(imputed, 1)
# Check missingness in completed data
colSums(is.na(completed_data))

##################################################
# Scaling & Normalization
##################################################

# 1. Min-Max Normalization
min_max_norm <- function(x) {
  (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
}

age_minmax  <- min_max_norm(titanic_unique$Age)
fare_minmax <- min_max_norm(titanic_unique$Fare)
summary(age_minmax)
summary(fare_minmax)

# 2. Z-score Standardization
age_z  <- scale(titanic_unique$Age)
fare_z <- scale(titanic_unique$Fare)
summary(age_z)
summary(fare_z)

##################################################
# Encoding Categorical Data
##################################################

# 1. Label Encoding for 'Sex'
sex_map <- c("female" = 0, "male" = 1)
titanic_unique$Sex_Label <- sex_map[titanic_unique$Sex]
head(titanic_unique[, c("Sex", "Sex_Label")], 10)

# 2. One-Hot Encoding with model.matrix()
# 'Embarked' is already factor, so we can do:
embarked_dummies <- model.matrix(~ Embarked - 1, data = titanic_unique)
head(embarked_dummies)

# 3. One-Hot Encoding with dummies package
# install.packages("dummies")  # If needed
install.packages("https://cran.r-project.org/src/contrib/Archive/dummies/dummies_1.5.6.tar.gz", repos = NULL, type = "source")
library(dummies)

cat_data <- titanic_unique[, c("Sex", "Embarked")]
dummy_encoded <- dummy.data.frame(cat_data, names = c("Sex", "Embarked"), sep = "_")
head(dummy_encoded)
