# This notebook demonstrates a simple linear regression analysis using R to model Salary based on Years of Experience

dataset <- read.csv("regression_data.csv")

plot(dataset$YearsExperience, dataset$Salary, col="red")

model <- lm(Salary ~ YearsExperience, data=dataset)

library(ggplot2)

ggplot() + 
    geom_point(aes(x = dataset$YearsExperience, y = dataset$Salary), colour = 'red') +
    geom_line(aes(x = dataset$YearsExperience, y = predict(model, newdata = dataset)), colour = 'blue') + 
    ggtitle('Salary vs Experience') +
    xlab('Years of Experience') + 
    ylab('Salary')

summary(model)

library(ggplot2)

# Data
df <- read.csv("regression_data.csv")

# Fit model
model <- lm(Salary ~ YearsExperience, data = df)
slope <- coef(model)[2]
intercept <- coef(model)[1]
r <- cor(df$YearsExperience, df$Salary)
pred <- predict(model)
mse <- mean((df$Salary - pred)^2)

# Plot
p <- ggplot(df, aes(x = YearsExperience, y = Salary)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  annotate(
    "text",
    x = min(df$YearsExperience),
    y = max(df$Salary) - 0.25 * (max(df$Salary) - min(df$Salary)),
    label = paste(
      "y =", round(slope, 2), "x +", round(intercept, 2),
      "\nr =", round(r, 2),
      "\nMSE =", round(mse, 2)
    ),
    size = 4,
    hjust = 0
  ) +
  labs(
    title = "Linear Regression: Years Experience vs Salary",
    x = "Years Experience",
    y = "Salary"
  ) +
  theme_minimal()

print(p)
ggsave("linear_regression_r_output.png", plot = p)

# This notebook calculates a linear regression model to predict Salary based on YearsExperience. The slope is 8285.29, which is the expected increase in salary per year. The predicted starting salary is $29,203.52 at year 0. There is a strong positive correlation (r = 0.89) between years of experience and salary. The MSE is high partially due to the high salary values, but also due to the chance of error in the model.


