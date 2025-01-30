url = "https://github.com/emse6574-gwu/2019-Fall/raw/gh-pages/data/wildlife_impacts.csv"
library(readr)
library(dplyr)
df <- read_csv(url)
# Select only a few columns
select(df, state, damage, time_of_day)

select(df, -state, -damage, -time_of_day)

filter(df, state == 'DC')
filter(df, cost_repairs_infl_adj > 10^6)


dc_impacts <- filter(df, state == 'DC')
dc_impacts_airlineTime <- select(dc_impacts, operator, time, time_of_day)
head(dc_impacts_airlineTime)

df %>%
  filter(state == 'DC') %>%
  select(operator, time, time_of_day) %>%
  head()

dc_impacts <- df %>%
  filter(state == 'DC') %>%
  select(operator, time, time_of_day)
head(dc_impacts)

# Arrange by least expensive accident
df %>%
  arrange(cost_repairs_infl_adj)

# Arrange by most expensive accident
df %>%
  arrange(desc(cost_repairs_infl_adj))

df %>%
  mutate(height_miles = height / 5280) %>%
  select(height, height_miles)

df %>%
  mutate(height_miles = height / 5280,
         height_half_miles = height_miles / 2) %>%
  select(height, height_miles, height_half_miles)

df %>%
  filter(!is.na(height)) %>%
  mutate(height_miles = height / 5280) %>%
  select(height, height_miles)


df %>%
  filter(!is.na(height)) %>%
  group_by(state) %>%          # Here we're grouping by state
  mutate(mean_height = mean(height)) %>%
  select(state, mean_height)

df %>%
  filter(!is.na(height)) %>%
  group_by(state) %>%
  summarise(mean_height = mean(height))

df %>%
  filter(!is.na(height)) %>%
  group_by(state, operator) %>%
  summarise(mean_height = mean(height))

df %>%
  filter(!is.na(height)) %>%
  group_by(state, operator) %>%
  summarise(mean_height = mean(height),
            min_height = min(height),
            max_height = max(height))

df %>%
  group_by(type_eng) %>%
  summarise(count = n())

df %>%
  count(type_eng)

df %>%
  count(type_eng, sort = TRUE)

df %>%
  count(type_eng, num_engs, sort = TRUE)