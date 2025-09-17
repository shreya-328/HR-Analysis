
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler, LabelEncoder

data = pd.read_csv('data/consolidated_hr_data.csv')

# Fill missing numeric values without inplace to avoid warning
for col in data.select_dtypes(include=['int64', 'float64']).columns:
    data[col] = data[col].fillna(data[col].median())

# Encode categorical columns
for col in data.select_dtypes(include=['object']).columns:
    le = LabelEncoder()
    data[col] = data[col].astype(str)
    data[col] = le.fit_transform(data[col])

# Prepare features and target
target_col = 'AttritionInt'
X = data.drop([target_col, 'EmployeeID', 'FirstName', 'LastName'], axis=1, errors='ignore')
y = data[target_col]

# Scale numeric features in X only
numeric_cols = X.select_dtypes(include=['int64', 'float64']).columns
scaler = StandardScaler()
X[numeric_cols] = scaler.fit_transform(X[numeric_cols])

# Split the dataset
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42, stratify=y
)

print(f'Train shape: {X_train.shape}')
print(f'Test shape: {X_test.shape}')
print('Train class distribution:')
print(y_train.value_counts(normalize=True))
print('Test class distribution:')
print(y_test.value_counts(normalize=True))
