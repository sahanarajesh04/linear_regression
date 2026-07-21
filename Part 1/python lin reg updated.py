#!/usr/bin/env python
# coding: utf-8

# In[ ]:


# This notebook demonstrates a simple linear regression analysis using Python to model Salary based on Years of Experience


# In[4]:


import pandas as pd
dataset = pd.read_csv("regression_data.csv")


# In[3]:


import os
print (os.getcwd())
print (os.listdir())


# In[5]:


import pandas as pd
dataset = pd.read_csv("regression_data.csv")


# In[7]:


import matplotlib.pyplot as plt
plt.scatter(dataset["YearsExperience"], dataset["Salary"], color="red")


# In[9]:


from sklearn.linear_model import LinearRegression
model = LinearRegression()
model.fit(dataset[["YearsExperience"]], dataset[["Salary"]])


# In[12]:


plt.plot(dataset["YearsExperience"], model.predict(dataset[["YearsExperience"]]), color="blue")
plt.title("Salary vs Experience")
plt.xlabel("Years of Experience")
plt.ylabel("Salary")
plt.show()


# In[13]:


model.score(dataset[["YearsExperience"]], dataset[["Salary"]])
# R-squared


# In[9]:


import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import linregress
from sklearn.metrics import mean_squared_error

# Data
dataset = pd.read_csv("regression_data.csv")

x = dataset["YearsExperience"]
y = dataset["Salary"]

# Linear regression
slope, intercept, r_value, p_value, std_err = linregress(x, y)
y_pred = slope * x + intercept
mse = mean_squared_error(y, y_pred)

# Plot
plt.scatter(x, y, label="Actual Data")
plt.plot(x, y_pred, label="Fitted Line")

plt.text(
    min(x),
    max(y) - 0.15 * (max(y) - min(y)),
    f"y = {slope:.2f}x + {intercept:.2f}\n"
    f"r = {r_value:.2f}\n"
    f"MSE = {mse:.2f}",
    fontsize=10
)

plt.xlabel("Years Experience")
plt.ylabel("Salary")
plt.title("Linear Regression: Years Experience vs Salary")
plt.legend()
plt.savefig("linear_regression_python_output.png")
plt.show()


# In[ ]:


# This notebook calculates a linear regression model to predict Salary based on YearsExperience. The slope is 8285.29, which is the expected increase in salary per year. The predicted starting salary is $29,203.52 at year 0. There is a strong positive correlation (r = 0.89) between years of experience and salary. The MSE is high partially due to the high salary values, but also due to the chance of error in the model.

