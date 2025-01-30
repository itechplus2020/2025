# Load libraries
library(dplyr)
library(tidyr)

# Load built-in dataset
mtcars

## The Pipe Operator `%>%`
  
#- The pipe operator `%>%` allows you to pass the result of one function directly into the next function, improving code readability and reducing the need for intermediate variables.
#- Instead of nesting functions, you can chain operations in a logical sequence.
#- Example without pipes:



mtcars %>%
  select(mpg, cyl, hp)

mtcars %>%
  select(starts_with("m"), ends_with("p"))

mtcars %>%
  filter(mpg > 20 & cyl == 4)

head(select(filter(mtcars, mpg > 20), mpg, hp))

mtcars %>%
  filter(mpg > 20) %>%
  select(mpg, hp) %>%
  head()

mtcars %>%  arrange(desc(mpg)) 

mtcars %>%
  arrange(cyl, desc(hp))

mtcars %>%  mutate(weight_kg = wt * 453.592) 


mtcars %>%  
  group_by(cyl) %>%  
  summarize(mean_mpg = mean(mpg, na.rm = TRUE),  count = n()) 

mtcars %>%
  group_by(cyl, gear) %>%
  summarize(mean_hp = mean(hp, na.rm = TRUE))

mtcars %>%
  group_by(cyl) %>%
  summarize(mean_mpg = mean(mpg))


mtcars %>%
  summarize(mean_mpg = mean(mpg, na.rm = TRUE),
            sd_mpg = sd(mpg, na.rm = TRUE))

mtcars %>%
  summarize(mean_mpg = mean(mpg, na.rm = TRUE))





mtcars %>%
  pivot_longer(cols = c(mpg, hp),
               names_to = "variable",
               values_to = "value")

mtcars %>%
  pivot_longer(cols = starts_with("cyl"),
               names_to = "variable",
               values_to = "value")

# Sample wide dataset
wide_data <- data.frame(
  id = 1:3,
  variable1 = c(10, 20, 30),
  variable2 = c(40, 50, 60)
)

# Convert to long format
dataset_long <- wide_data %>%
  pivot_longer(cols = starts_with("variable"), names_to = "variable", values_to = "value")

# Use pivot_wider to revert to wide format
wide_again <- dataset_long %>%
  pivot_wider(names_from = variable, values_from = value)

data <- data.frame(col = c("a_1", "b_2"))
data %>% separate(col, into = c("letter", "number"), sep = "_")

mtcars %>% unite("gear_carb", gear, carb, sep = "-") 

library(dplyr)
library(tidyr)

# Create a dataset with missing values
data_with_nas <- mtcars
set.seed(123)  # For reproducibility
data_with_nas[sample(1:nrow(data_with_nas), 5), "mpg"] <- NA

# Drop rows with missing values
data_without_nas <- data_with_nas %>%
  drop_na()

# Replace missing values with a default
data_replaced_nas <- data_with_nas %>%
  replace_na(list(mpg = mean(data_with_nas$mpg, na.rm = TRUE)))
