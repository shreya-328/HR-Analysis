# HR Analytics: Employee Attrition & Performance

## 🔍 Project Overview

This project uses the **IBM HR Analytics: Employee Attrition & Performance** dataset from Kaggle to explore, model, and report on factors that lead to employee attrition, understand employee performance patterns, and provide actionable insights for workforce retention and HR decision-making.

---

## 📚 Dataset Details

- **Dataset name**: IBM HR Analytics Employee Attrition & Performance (Kaggle)  
- **Number of records**: ~ 1,470 employees :contentReference[oaicite:0]{index=0}  
- **Number of features**: 35 columns :contentReference[oaicite:1]{index=1}  
- **Target variable**: `Attrition` (“Yes” / “No”) :contentReference[oaicite:2]{index=2}  

---

## 🔑 Features / Variables (Selected)

Here are some key features in the dataset—roughly grouped as categorical vs numerical, demographic vs job/performance related. You’ll want to describe all in your final version; below are examples:

| Category               | Sample features                                                                 |
|------------------------|---------------------------------------------------------------------------------|
| **Demographic**        | Age, Gender, MaritalStatus, DistanceFromHome                                   |
| **Job / Role**         | Department, JobRole, BusinessTravel                                             |
| **Satisfaction / Work Environment** | EnvironmentSatisfaction, JobSatisfaction, WorkLifeBalance, RelationshipSatisfaction |
| **Performance / Career**| PerformanceRating, YearsSinceLastPromotion, YearsWithCurrManager              |
| **Compensation / Income** | MonthlyIncome, PercentSalaryHike                                            |

> **Note**: Some features like `EmployeeCount`, `StandardHours`, `EmployeeNumber`, or `Over18` are either constant or not useful for modeling and can be dropped. :contentReference[oaicite:3]{index=3}

---

## 🔎 Exploratory Data Analysis (EDA)

- Check attrition rate overall, and by department / job role  
- Compare income distributions between those who left vs stayed  
- Examine relationship of satisfaction / work-life balance to attrition  
- Correlation matrix among numeric variables to see multicollinearity / feature importance  
- Identify outliers / missing or constant columns

*(Insert visualizations: histograms, boxplots, heatmap, etc.)*

---

## 🤖 Modeling Approach (in-progress)


- Data cleaning & preprocessing  
  ‣ Drop irrelevant or constant features (e.g. EmployeeNumber, StandardHours, Over18)  
  ‣ Encode categorical variables (one-hot, label encoding, etc.)  
  ‣ Scale numeric variables if needed  

- Feature selection  
  ‣ Use correlation, statistical tests (ANOVA, Chi-square) to pick the most meaningful features  

- Modeling / Algorithms tried / to try  
  ‣ Logistic Regression  
  ‣ Random Forest  
  ‣ Gradient Boosting (XGBoost / LightGBM)  
  ‣ Perhaps even things like KNN, SVM for comparison  

- Evaluation Metrics  
  ‣ Accuracy, Precision, Recall, F1-score  
  ‣ ROC-AUC  
  ‣ Confusion matrix  
  ‣ Cross-validation to avoid overfitting  

- Model interpretability (feature Importance, SHAP, etc.)  

---

## 📈 Sample Results / Insights


- “Employees who work **OverTime** are X times more likely to attrite”  
- “Satisfaction ratings (job, environment, relationship) show strong negative correlation with attrition”  
- “YearsSinceLastPromotion” & “YearsWithCurrManager” are important predictors  


---

## ⚙️ How to Run

1. Clone the repository  
   ```bash
   git clone https://github.com/your-username/HR-Analysis.git
   cd HR-Analysis
