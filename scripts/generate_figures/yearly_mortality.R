library(tidyverse)
library(ggthemes)

data <- read_csv('data/analysis_data/clean_data.csv')
data$year <- factor(data$year)

plot <- data |>
  filter(outcome == "FATAL" & (client_gender == "MALE" | client_gender == "FEMALE")) |>
  ggplot(aes(x = year, fill = client_gender)) +
  geom_bar(position = "dodge") +
  theme_fivethirtyeight() +
  scale_fill_manual(values = c("pink", "#4169E1", "purple")) +
  labs(fill = "")

ggsave("./other/figures/mortality.png", plot)