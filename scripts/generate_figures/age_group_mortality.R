library(tidyverse)
library(ggthemes)

plot <- data |>
  mutate(
    age_group = case_when(
      age_group == "19 and younger" ~ "0 - 19",
      age_group == "20 to 29 Years" ~ "20 - 29",
      age_group == "30 to 39 Years" ~ "30 - 39",
      age_group == "40 to 49 Years" ~ "40 - 49",
      age_group == "50 to 59 Years" ~ "50 - 59",
      age_group == "60 to 69 Years" ~ "60 - 69",
      age_group == "70 to 79 Years" ~ "70 - 79",
      age_group == "80 to 89 Years" ~ "80 - 89",
      age_group == "90 and older" ~ "90 +"
      
    )
  ) |>
  filter(outcome == "FATAL") |>
  ggplot(aes(x = age_group, fill = outcome)) +
  geom_bar(position = "dodge") +
  labs(x = "Age Group", y = "Mortality") +
  theme(legend.position = "none")

ggsave("./other/figures/age_mortality.png", plot)