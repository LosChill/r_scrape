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
## Test df
print(year_races_df)

# Set year range
years <- seq(1949, 1952)
## Test year range
print(years)

# Set url_start
url_start <- "https://www.driveraverages.com/nascar/race.php?sked_id="
## Test url start
print(url_start)


# Function: Create races vector from year range
get_races_vector <- function(years, data_frame) {
  data_frame$Races[match(years, data_frame$Year)]
}
## Test get_races_vector
races_vector <- get_races_vector(years, year_races_df)
print(races_vector)


# Function: Combine year and num_races into string
build_race_year_str <- function(year, num_races, url_start) {
  sapply(num_races, function(x) {
    race_year_str <- sprintf("%d%03d", year, x)
    concat_url(url_start, race_year_str)
    })
}
## Test build_race_year_str
race_year_str <- build_race_year_str(1987, 32)
print(race_year_str)


# Function: Combine url parts with race_year_str
concat_url <- function(url_start, race_year_str) {
  paste(url_start, race_year_str)
}
## Test concat_url
url <- concat_url(url_start, race_year_str)
print(url)


# Function: Generate vector of individual races
build_races_seq_vector <- function(year, num_races) {
  lapply(seq_along(year), function(i) {
  race_seq <- seq(1, num_races[i])
  build_race_year_str(year[i], race_seq)
  })
}
## Test build_races_seq_vector
races_seq_vector <- build_races_seq_vector(years, races_vector)
print(races_seq_vector)





# Function: Combine url parts with race_year_str
concat_url <- function(url_start, race_year_str) {
  paste(url_start, race_year_str)
}
## Test concat_url
url <- concat_url(url_start, race_year_str)
print(url)
