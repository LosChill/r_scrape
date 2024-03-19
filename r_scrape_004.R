library("httr")
library("rvest")
library("tibble")
library("dplyr")
library("readr")

# Import csv to df
year_races_df <- read_csv('all_cup_seasons.csv', col_types = cols(
  Year = col_integer(),
  Races = col_integer()
))

# Set year range
years <- seq(1949, 2023)

# Set url_start
url_start <- "https://www.driveraverages.com/nascar/race.php?sked_id="


# Function: Create races vector from year range
get_races_vector <- function(years, data_frame) {
  data_frame$Races[match(years, data_frame$Year)]
}

## Call: Get races_vector
races_vector <- get_races_vector(years, year_races_df)
print(races_vector)


# Function: Combine url parts with race_year_str
concat_url <- function(url_start, race_year_str) {
  paste0(url_start, race_year_str)
}

# Function: Combine year and num_races into string
build_race_year_str <- function(year, num_races, url_start) {
  sapply(num_races, function(x) {
    race_year_str <- sprintf("%d%03d", year, x)
    concat_url(url_start, race_year_str)
    })
}

# Function: Generate vector of individual races
build_races_seq_vector <- function(year, num_races, url_start) {
  lapply(seq_along(year), function(i) {
  race_seq <- seq(1, num_races[i])
  build_race_year_str(year[i], race_seq, url_start)
  })
}

# Call: build races_seq_vector
races_seq_vector <- build_races_seq_vector(years, races_vector, url_start)
print(races_seq_vector)
