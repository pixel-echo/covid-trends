library(tidyverse)
library(janitor)
library(fastDummies)

data <- read_csv("data/raw_data/covid_raw.csv")
data <- clean_names(data)

data <- data |>
  mutate(year = substr(episode_date, 1, 4)) |>
  filter(classification == "CONFIRMED") |>
  select(age_group, neighbourhood_name,
         outcome, ever_hospitalized, ever_in_icu, ever_intubated,
         year) |>
  filter(year < 2024) |>
  mutate(
    age_group = case_when(
      age_group == '50 to 59 Years' ~ "50_59",
      age_group == '20 to 29 Years' ~ "20_29",
      age_group == '60 to 69 Years' ~ "60_69",
      age_group == '80 to 89 Years' ~ "80_89",
      age_group == '70 to 79 Years' ~ "70_79",
      age_group == '30 to 39 Years' ~ "30_39",
      age_group == '40 to 49 Years' ~ "40_49",
      age_group == '19 and younger' ~ "0_19",
      age_group == '90 and older' ~ "90_above",
      TRUE ~ age_group
    )
  ) |>
  mutate(
    neighbourhood_name = gsub("\\(.*?\\)", "", neighbourhood_name)
  ) |>
  mutate(neighbourhood_name = trimws(neighbourhood_name, "right")) |>
  mutate(neighbourhood_name = gsub("[^[:alnum:]]+", "_", neighbourhood_name)) |>
  mutate(neighbourhood_name = tolower(neighbourhood_name)) |>
  mutate(
    neighbourhood_name = ifelse(neighbourhood_name == "weston_pellam_park", "weston_pelham_park", neighbourhood_name)
  ) 


data <- na.omit(data)

data <- data |>
  filter(outcome != "ACTIVE") |>
  mutate(ever_in_icu = case_when(
    ever_in_icu == "Yes" ~ 1,
    ever_in_icu == "No" ~ 0
  )) |>
  mutate(ever_intubated = case_when(
    ever_intubated == "Yes" ~ 1,
    ever_intubated == "No" ~ 0
  )) |>
  mutate(ever_hospitalized = case_when(
    ever_hospitalized == "Yes" ~ 1,
    ever_hospitalized == "No" ~ 0
  )) |>
  mutate(
    outcome = case_when(
      outcome == "FATAL" ~ 1,
      outcome == "RESOLVED" ~ 0
    )
  )

data <- dummy_cols(data, select_columns = c("age_group", "neighbourhood_name", "outcome", "year"))

data <- data |>
  select(!c("age_group", "neighbourhood_name", "year")) |>
  rename("hospitalized" = "ever_hospitalized", "icu" = "ever_in_icu", "intubated" = "ever_intubated") |>
  mutate_all(as.factor)

write_csv(data, "data/analysis_data/logistic_data.csv")

