library(tidyverse)
library(ggthemes)

data <- read_csv('data/analysis_data/clean_data.csv')
vals <- c("#4A86E8", "#4A86E8", "#4A86E8", "#4A86E8")
data$year <- factor(data$year)

plot <- data |>
  ggplot(aes(x = year, fill = year)) +
  geom_bar() +
  theme_fivethirtyeight() +
  scale_fill_manual(values = vals) +
  guides(fill = FALSE)

ggsave("./other/figures/yearly_cases.png", plot)