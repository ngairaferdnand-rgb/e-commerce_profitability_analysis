#!/usr/bin/env python
# coding: utf-8

# In[ ]:


E-Commerce Profitability Analysis


# In[ ]:


DATA PROCESSING, CLEANING, AND MANIPULATION


# In[ ]:


DATA PROCESSING


# In[ ]:


# 1. Importing the dataset


# In[1]:


import pandas as pd

orders = pd.read_csv(r"G:\My Drive\Data Analysis Projects\E-Commerce\Dataset\orders.csv")

print(orders.head())


# In[ ]:





# In[ ]:


# 2. Checking and addressing missing and NaN values


# In[2]:


# a. Checking for missing values
orders.isna().sum()


# In[ ]:





# In[ ]:


# 3. Checking and converting data types:


# In[3]:


#. Checking data types
orders.info()


# In[ ]:





# In[4]:


# a. Converting Date columns
date_cols = ['order_date']
for col in date_cols:
    orders[col] = pd.to_datetime(orders[col], format='%Y-%m-%d')


# In[ ]:





# In[9]:


# b. Converting to Categorical to save memory and improve speed
cat_cols = [ 'customer_id', 'channel', 'payment_method', 'region', 'primary_category']
for col in cat_cols:
    orders[col] = orders[col].astype('category')


# In[ ]:





# In[8]:


# c. Converting the return column to Boolean type
orders['returned'] = orders['returned'].astype('bool')


# In[ ]:





# In[10]:


# d. Downcasting integer Columns to memory-efficient types
# Specific smaller-range integers
int_cols = ['items_ordered', 'discount_pct']
orders[int_cols] = orders[int_cols].astype('int8') 


# In[ ]:





# In[11]:


# e. Downcasting operational financial columns to float32
float_cols = ['gross_revenue', 'discount_amount', 'shipping_cost', 
              'product_cost', 'platform_fee', 'transaction_fee', 'refund_amount'
             ]

for col in float_cols:
    orders[col] = orders[col].astype('float32')


# In[ ]:





# In[12]:


# e. Ensuring target financial metrics are float64 for aggregation precision
float64_cols = ['net_revenue', 'total_costs', 'profit']
for col in float64_cols:
    orders[col] = orders[col].astype('float64')

print(orders.dtypes)


# In[ ]:





# In[ ]:


# 4. Checking for duplicates


# In[13]:


duplicate_rows = orders.duplicated()
print(f"Number of duplicate rows: {duplicate_rows.sum()}")

duplicates = orders[orders.duplicated()]
print(duplicates)


# In[ ]:





# In[ ]:


# 5. Data transformation (trimming)


# In[14]:


import re

# Identify object columns
obj_cols = orders.select_dtypes(include=['object']).columns

for col in obj_cols:
# Trimming Whitespaces
    orders[col] = orders[col].str.strip()


# In[ ]:





# In[ ]:


# 6. Resetting the table's index column


# In[16]:


orders = orders.reset_index(drop=True)

print(orders.head())
print("Cleaning Process Complete!")
print(f"Total Rows: {len(orders)}")
print(f"Null Values Remaining: {orders.isnull().sum().sum()}")


# In[ ]:





# In[ ]:


# CREATING AND SAVING A CLEAN CSV FILE


# In[17]:


orders.to_csv(r"G:\My Drive\Data Analysis Projects\E-Commerce\Cleaned\orders.csv", index=False)

import os
file_path = r"G:\My Drive\Data Analysis Projects\E-Commerce\Cleaned\orders.csv"
if os.path.exists(file_path):
    print("File successfully created!")


# In[ ]:





# In[ ]:


CREATING AND SAVING DATABASE


# In[35]:


import pandas as pd
import sqlite3


# 1. Establishing a connection
# This creates the file 'orders.db' in the working directory
with sqlite3.connect('orders.db') as conn:

# 2. Writing the data to a table
# 'name' is the table name for the db
# 'if_exists' replaces the table if it already exists
    orders.to_sql(name='orders', con=conn, if_exists='replace', index=False)

# 3. To make sure the database is correctly built before downloading it
import os
file_stats = os.stat('orders.db')
print(f"Database size: {file_stats.st_size / (1024 * 1024):.2f} MB")


# In[ ]:




