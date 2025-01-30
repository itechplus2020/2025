library(tidyverse)

lang_wide <- read_csv(file.choose())#region_lang_top5_cities_wide.csv
lang_wide

lang_mother_tidy <- pivot_longer(lang_wide,
                                 cols = Toronto:Edmonton,
                                 names_to = "region",
                                 values_to = "mother_tongue"
)

lang_mother_tidy

lang_long <- read.csv(file.choose()) #region_lang_top5_cities_long.csv
lang_long

lang_home_tidy <- pivot_wider(lang_long,
                              names_from = type,
                              values_from = count)
lang_home_tidy