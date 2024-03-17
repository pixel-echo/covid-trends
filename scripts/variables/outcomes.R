library(tidyverse)

data <- read_csv("data/analysis_data/clean_data.csv")
table <- table(data$outcome)
