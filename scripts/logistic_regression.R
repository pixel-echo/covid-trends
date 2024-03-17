library(tidyverse)
data <- read_csv("data/analysis_data/logistic_data.csv")
head(data)

data <- data |>
  select(hospitalized, age_group_90_above , outcome, icu, intubated, 
         age_group_70_79, age_group_80_89)

set.seed(25)
index <- sample(nrow(data), 0.7 * nrow(data))
training_data <- data[index, ]
testing_data <- data[-index, ]

model <- glm(outcome ~ ., data = training_data, family = binomial)
predicted_probabilities <- predict(model, newdata = testing_data, type = "response")


predicted_classes <- ifelse(predicted_probabilities > 0.5, 1, 0)
accuracy <- mean(predicted_classes == testing_data$outcome)

saveRDS(model, "models/model.rds")

