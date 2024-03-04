library(tidyverse)
library(janitor)
data <- read_csv("data/raw_data/covid_raw.csv")
data <- clean_names(data)

data <- data |>
  mutate(year = substr(episode_date, 1, 4), month = substr(episode_date, 6, 7), reporting_delay = reported_date - episode_date) |>
  select(outbreak_associated, age_group, neighbourhood_name, source_of_infection,
         client_gender, outcome, ever_hospitalized, ever_in_icu, ever_intubated,
         year, month, reporting_delay) |>
  filter(year < 2024)

write_csv(data, "./data/analysis_data/clean_data.csv")