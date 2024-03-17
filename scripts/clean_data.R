library(tidyverse)
library(janitor)
data <- read_csv("data/raw_data/covid_raw.csv")
data <- clean_names(data)

data <- data |>
  mutate(year = substr(episode_date, 1, 4)) |>
  filter(classification == "CONFIRMED") |>
  select(age_group, neighbourhood_name, source_of_infection,
         outcome, ever_hospitalized, ever_in_icu, ever_intubated,
         year) |>
  filter(year < 2024) |>
  mutate(
    age_group = case_when(
      age_group == '50 to 59 Years' ~ "50 - 59",
      age_group == '20 to 29 Years' ~ "20 - 29",
      age_group == '60 to 69 Years' ~ "20 - 29",
      age_group == '80 to 89 Years' ~ "80 - 89",
      age_group == '70 to 79 Years' ~ "70 - 79",
      age_group == '30 to 39 Years' ~ "30 - 39",
      age_group == '40 to 49 Years' ~ "40 - 49",
      age_group == '19 and younger' ~ "0 - 19",
      age_group == '90 and older' ~ "90 +",
      TRUE ~ age_group
    )
  )

write_csv(data, "./data/analysis_data/clean_data.csv")