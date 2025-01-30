# Load the tidyverse package
library(tidyverse)

# Create the dataset
data <- data.frame(
  Patient_ID = c('P1', 'P2', 'P3', 'P4', 'P5', 'P6'),
  Age_Group = c('18-30', '31-50', '51-65', '18-30', '31-50', '51-65'),
  Treatment = c('Drug A', 'Drug B', 'Drug A', 'Drug C', 'Drug B', 'Drug C'),
  Response = c('Positive', 'Negative', 'Positive', 'Negative', 'Positive', 'Positive')
)

# Pivot and count the positive/negative responses for each treatment and age group
pivoted_data <- data %>%
  # Create a new variable with 1 for each row to count occurrences
  mutate(count = 1) %>%
  # Pivot the data wider, creating columns for each Treatment and Response combination
  pivot_wider(names_from = c(Treatment, Response), 
              values_from = count, 
              values_fill = list(count = 0)) %>%
  # Group by Age Group and summarize the results by summing up counts
  group_by(Age_Group) %>%
  summarize(across(-Patient_ID, sum)) # Exclude Patient_ID from the sum operation

# Display the final pivoted data
print(pivoted_data)
