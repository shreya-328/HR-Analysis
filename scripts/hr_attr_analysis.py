# HR Attrition Data Analysis
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

# Load data
data = pd.read_csv('/Users/shreya/Desktop/HR_ATTR_Python/data/consolidated_hr_data.csv')

# Quick profiling with pandas profiling (optional, install with: pip install pandas-profiling)
# from pandas_profiling import ProfileReport
# profile = ProfileReport(data, title="HR Attrition Profiling Report")
# profile.to_file("hr_attrition_profile.html")

# 1. Distribution of numeric features
numeric_cols = data.select_dtypes(include=['int64', 'float64']).columns
n = len(numeric_cols)
cols = 3
rows = (n + cols - 1) // cols

fig, axes = plt.subplots(rows, cols, figsize=(9, 3.5 * rows))
axes = axes.flatten()

for i, col in enumerate(numeric_cols):
    sns.histplot(data[col], kde=True, bins=15, ax=axes[i])
    axes[i].set_title(col, fontsize=9)
    axes[i].tick_params(axis='x', rotation=45, labelsize=7)
    axes[i].tick_params(axis='y', labelsize=7)

for j in range(i + 1, len(axes)):
    axes[j].axis('off')

plt.tight_layout()
plt.subplots_adjust(hspace=1)  # increase space between rows here
plt.show()

# numeric_cols = data.select_dtypes(include=['int64', 'float64']).columns
# data[numeric_cols].hist(figsize=(10,8))
# plt.suptitle('Numeric Feature Distributions')
# plt.show()

# 2. Count plots for categorical variables
# Exclude columns with too many unique values
categorical_cols = [col for col in data.select_dtypes(include=['object']).columns if data[col].nunique() < 20]
for col in categorical_cols:
    plt.figure(figsize=(10,4))
    sns.countplot(data[col])
    plt.title(f'Distribution of {col}')
    plt.xticks(rotation=45)
    plt.show()


# 3. Boxplots to check for outliers, grouped by Attrition
for col in numeric_cols:
    plt.figure(figsize=(10,4))
    sns.boxplot(x='AttritionInt', y=col, data=data)
    plt.title(f'{col} by Attrition')
    plt.show()

# 4. Correlation heatmap for numeric features
plt.figure(figsize=(12,10))
sns.heatmap(data[numeric_cols].corr(), annot=True, fmt='.2f', cmap='coolwarm')
plt.title('Correlation Heatmap')
plt.show()
