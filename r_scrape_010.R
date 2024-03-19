library(tidyverse)
library(readr)

# Import csv to df
year_races_df <- read_csv('all_cup_seasons.csv', col_types = cols(
  Year = col_integer(),
  Races = col_integer()
))

# Set initial url
url_start <- "https://www.driveraverages.com/nascar/race.php?sked_id="

# Operate
url_df <- year_races_df %>%
  rowwise() %>%
  mutate(Race_ID = list(sprintf("%d%03d", Year, seq_len(Races)))) %>%
  unnest(Race_ID) %>%
  mutate(URL = paste0(url_start, Race_ID)) %>%
  select(Year, Race_ID, URL)

print(url_df)