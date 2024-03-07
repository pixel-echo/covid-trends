library(tidyverse)
library(ggthemes)

data <- read_csv('data/analysis_data/clean_data.csv')

plot <- data |>
  ggplot(aes(x = month)) +
  geom_bar(stat = "count") +
  facet_wrap(~year, nrow = 2) +
  labs(x = "Month", y = "")

ggsave("./other/figures/seasonal_trends.png", plot)