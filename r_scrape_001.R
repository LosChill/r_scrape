library("httr")
library("rvest")
library("tibble")
library("dplyr")

# Set query information
cup_url <- "https://www.driveraverages.com/nascar/race.php?sked_id=1995011"
user_agent_string <- "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Safari/537.36"


# Extract
response <- GET(url = cup_url, add_headers(
  `User-Agent` = user_agent_string,
  Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
  `Accept-Language` = "en-US,en;q=0.5",
  `Accept-Encoding` = "gzip, deflate, br",
  Connection = "keep-alive",
  `Upgrade-Insecure-Requests` = "1",
  `Cache-Control` = "max-age=0"
))

print(response)

# Transform
cup_html <- read_html(response)
cup_df <- cup_html %>%
  html_element(".tb") %>%
  html_table(header = TRUE)

print(cup_df)
