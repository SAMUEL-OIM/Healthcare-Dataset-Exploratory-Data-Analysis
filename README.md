# 🏥 Healthcare Dataset — Exploratory Data Analysis (SQL)

## 📌 Project Overview

This project performs an **Exploratory Data Analysis (EDA)** on a healthcare dataset using **MySQL**.
The purpose of the analysis is to **understand the structure, quality, and characteristics of the data** through systematic cleaning, transformation, and exploratory querying.

The focus of this project is **data understanding and preparation**, not prediction or recommendation.

---

## 📂 Dataset Description

The dataset contains individual healthcare records with the following attributes:

* ID
* Name
* Age
* Gender
* City
* Blood Type
* Education Level
* Employer
* Salary
* Health Condition
* Credit Score
* Date of Admission

---

## 🛠️ Tools & Technologies

* **Database:** MySQL 8.0
* **Language:** SQL
* **Data Source:** CSV file
* **Environment:** Local MySQL Server

---

## 🗄️ Database Structure

### `healthcare`

Raw table created directly from the imported CSV file.

### `clone_healthcare`

A cleaned and deduplicated version of the dataset used for all exploratory analysis.

---

## Data Import

* Data was imported using `LOAD DATA INFILE`
* Fields were properly enclosed and delimited
* Header row was excluded during import
* Raw data was preserved before transformation

---

## Data Cleaning & Preparation

The dataset required extensive preprocessing due to inconsistencies and mixed formats.

### Duplicate Handling

* Duplicate records were removed using `SELECT DISTINCT`
* A working table (`clone_healthcare`) was created for analysis

---

### Data Type Corrections

Columns were converted from `TEXT` to appropriate data types to enable analysis:

* `ID` → `INT`
* `Age` → `INT`
* `Salary` → `INT`
* `Date_of_admission` → `DATE`
* Categorical fields → `VARCHAR`

---

### Name Formatting

* Names were reformatted into **proper case**
* Irregular punctuation and spacing were handled to improve consistency

---

### Age Cleaning

* `"Unknown"` values were converted to `NULL`
* Enabled numerical aggregation and filtering

---

### Gender Standardization

* Standardized values:

  * `M` → Male
  * `F` → Female
  * Blank values → Unknown

---

### City Normalization

* Converted city names to proper case
* Expanded abbreviated city names:

  * `Atl` → Atlanta
  * `Balti` → Baltimore
  * `Albuque` → Albuquerque

---

### Education Level Standardization

* Normalized inconsistent labels:

  * `"Master's"` → Masters
  * `"Bachelor's"` → Bachelor
* Missing values replaced with `"Unknown"`

---

### Salary Cleaning

* Removed currency symbols and commas
* Corrected negative values represented with parentheses
* Separated descriptive salary information into a new column (`Salary_Description`)
* Converted salary values to integers

---

### Health Condition Cleaning

* Blank values replaced with `"Unknown"`
* Corrected malformed entries (e.g., `"Excellent (?!)"`)

---

### Credit Score Cleaning

* Corrected typo-based numeric entries
* Standardized missing values to `"Not Available"`

---

### Date of Admission Standardization

Handled multiple date formats:

* Excel serial dates
* ISO-formatted dates
* Full textual dates

All formats were converted into a unified `DATE` type.

---

## Exploratory Data Analysis

### Dataset Overview

* Verified record count and column completeness
* Identified missing and unknown values across attributes

---

### Demographic Exploration

* Examined distributions of:

  * Age
  * Gender
  * Education level
  * City

---

### Health Condition Exploration

* Reviewed frequency of different health condition categories
* Identified records classified as **Poor** or **Average**

---

###  Temporal Exploration

* Reviewed admission dates to understand time coverage
* Identified recent and historical admission patterns

---

###  City-Level Exploration

* Examined health condition occurrences across cities
* Identified cities with higher counts of poor or average health records

---

## 🔍 Key Observations

* The dataset contained multiple inconsistent formats across columns
* Missing values were present in age, salary, and education level fields
* Health condition classifications varied in consistency
* Admission dates originated from multiple source systems

---

## ⚠️ Data Limitations

* Health condition categories are broad and non-clinical
* Missing demographic data may affect completeness
* No severity scale or diagnosis codes are available
* Salary and credit score data may not reflect current values

---

## Scope of This Analysis

* This project focuses strictly on **exploration and preparation**
* No predictive modeling or business recommendations were made
* The cleaned dataset is suitable for:

  * Advanced analytics
  * Visualization
  * Machine learning
  * Policy or operational analysis (future work)

---

## 🚀 How to Run the Project

1. Install **MySQL Server 8.0**
2. Place the CSV file in:

   ```
   C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
   ```
3. Execute the SQL script in this order:

   * Table creation
   * Data import
   * Data cleaning
   * Exploratory queries

---

## 👤 Author

**Olusesan Samuel**
Data Analyst
