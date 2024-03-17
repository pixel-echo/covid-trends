library(tidyverse)
library(ggthemes)

data <- read_csv("data/analysis_data/clean_data.csv")

plot <- data |>
  na.omit() |>
  ggplot(aes(x = age_group)) +
  geom_bar(fill = "lightblue" ) +
  theme_light() +
  theme(
    axis.title = element_text(size = 10),
    axis.text.x = element_text(margin = margin(0, 0, 10, 0)),
    axis.text.y = element_text(margin = margin(0, 0, 0, 10)),
    plot.margin = margin(1.3, 1.3, 0.3, 0.3, "cm") 
  ) +
  labs(x = "Age Group", y = "Count")

ggsave("./other/figures/age_group.png", plot, width = 10, height = 6)