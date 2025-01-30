# Creating Dataset 1: Order Data
order_data <- data.frame(
  order_id = c(101, 102, 103, 104, 105),
  customer_id = c(1, 2, 3, 1, 4),
  order_date = as.Date(c("2023-10-26", "2023-10-27", "2023-10-28", "2023-10-29", "2023-10-30")),
  total_amount = c(100, 50, 75, 120, 80)
)

# Creating Dataset 2: Customer Data
customer_data <- data.frame(
  customer_id = c(1, 2, 3, 5),
  customer_name = c("Alice", "Bob", "Charlie", "David"),
  city = c("New York", "Los Angeles", "Chicago", "San Francisco")
)

# Printing the dataframes
print("Dataset 1: Order Data")
print(order_data)

print("Dataset 2: Customer Data")
print(customer_data)

library(tidyverse)
inner_join <- inner_join(order_data, customer_data, by = "customer_id")
print(inner_join)


left_join <- left_join(order_data, customer_data, by = "customer_id")
print(left_join)

right_join <- right_join(order_data, customer_data, by = "customer_id")
print(right_join)


outer_join <- full_join(order_data, customer_data, by = "customer_id")
print(outer_join)