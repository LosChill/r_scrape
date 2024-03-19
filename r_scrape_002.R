library("httr")
library("rvest")
library("tibble")
library("dplyr")

# Set query information
cup_url <- "https://www.racing-reference.info/nascar-cup-series-stats/"
credential <- "Data science student project (tpendras@gmail.com)"

# Extract
response <- GET(url = cup_url, user_agent(credential))
print(response)

# Transform
cup_html <- read_html(response)
cup_df <- cup_html %>%
  html_element(".tb") %>%
  html_table(header = TRUE)

# Set constants
# First url: https://www.racing-reference.info/race-results/1949-01/W/
url_start <- "https://www.racing-reference.info/race-results/"
url_end <- "/W/"

# Set iterators
years_vctr <- seq(1949, 2023)

race_url <- function(year) {
  races_int <- cup_df %>%
    filter(Year == year) %>%
    pull(Races) %>%
    as.integer()
  seq(1, races_int)
}

race_num_url <- function(year, race) {
  sprintf("%s%s-%02d%s", url_start, year, race, url_end)
}

test <- race_url(1989)
print(test)

test2 <- race_num_url(1989, test)
print(test2)

