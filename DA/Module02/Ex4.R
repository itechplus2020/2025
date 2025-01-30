# Load the tidyverse package
library(tidyverse)

# Create the dataset
data <- data.frame(
  Patient_ID = c('P1', 'P2', 'P3'),
  Address = c('123 Main St, Stony Brook, NY, 11790', 
              '123 Main St, Setauket-East Setauket, NY, 11733', 
              '123 Main St, Port Jefferson, NY, 11777')
)

# Split the address column

data <- data %>%
  separate(Address, into = c("Street_Address", "City", "State", "ZIP"), sep = ", ")  

# Display the result
print(data) 

# Combine the columns back into a single Full_Address column
data <- data %>%
  unite(Full_Address, Street_Address, City, State, ZIP, sep = ", ", remove = TRUE) # Use FALSE if you want to keep the split columns

# Display the result
print(data) 