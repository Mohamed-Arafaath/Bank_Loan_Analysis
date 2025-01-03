# 🏦 Bank Loan Analysis - Power BI Dashboard

An in-depth [`Power BI dashboard`](./Dashboard/BI_file.pbix) designed to analyze bank loan data from January 1, 2021, to December 31, 2021. This project utilizes advanced **DAX (Data Analysis Expressions)** measures to dynamically compute and present key metrics. The dashboard provides actionable insights into total loan applications, funded amounts, repaid amounts, average interest rates, and debt-to-income ratios (DTI), enabling stakeholders to make data-driven decisions.

---

## 📊 Dashboard Overview

### Features:
1. **Dynamic Filters**:
   - Filters for **Measure**, **Month**, **Day**, **State**, **Loan Grade**, **Loan Purpose**, **Home Ownership**, and **Good vs Bad Loans**.
   - Current screenshots depict all months and days selected, meaning all calculations represent the **Year-to-Date (YTD)** range from January 1, 2021, to December 31, 2021.

2. **Summary Page**:
   - Overview of **Good Loans vs Bad Loans**:
     - Key metrics for **Good Loan Count**, **Funded Amount**, and **Repaid Amount**.
     - Insights into **Bad Loan Count**, **Funded Amount**, and **Repaid Amount**.
   - Loan Status Breakdown: **Charged Off**, **Fully Paid**, and **Current** loans.
   - Dynamic calculations for **Year-to-Date (YTD)**, **Month-to-Date (MTD)**, **Previous Month-to-Date (PMTD)**, and **Month-over-Month (MoM)** growth.

3. **Overview Page**:
   - Visual trends of **Total Loan Applications by Month**, showcasing growth throughout the year.
   - Heatmap analysis of loan applications by **State**.
   - Loan Applications grouped by **Purpose**, **Employment Length**, and **Home Ownership**.
   - Pie chart of term-wise loan distribution (36 months vs. 60 months).

4. **Details Page**:
   - Granular loan-level data, including:
     - **Customer ID**, **Loan Purpose**, **Loan Grade**, **Term**, and **Home Ownership**.
     - **Funded Amount**, **Repaid Amount**, **Average Interest Rates**, and **Number of Installments**.
   - Filter options for in-depth analysis.

---

## 📋 Key Metrics and DAX Measures

The following measures dynamically compute **YTD**, **MTD**, **PMTD**, and **MoM** values based on selected filters:

### **Major KPIs**:
1. **Total Loan Applications (TLA)**:
   - **YTD_TLA**: Total applications from start of the year till date.
   - **MTD_TLA**: Applications from start of the current month till date.
   - **PMTD_TLA**: Applications from start of the previous month till previous month's current date.
   - **MoM_TLA**: Month-over-Month growth rate.

2. **Total Funded Amount (TFA)**:
   - **YTD_TFA**: Total amount funded for the year.
   - **MTD_TFA**, **PMTD_TFA**, **MoM_TFA**: Monthly metrics for detailed tracking.

3. **Total Repaid Amount (TRA)**:
   - **YTD_TRA**: Total amount repaid during the year.
   - Breakdown of **Good Loans Repaid** and **Bad Loans Repaid**.

4. **Average Interest Rate (AIR)**:
   - **YTD_AIR**: Average interest rate for loans issued during 2021.
   - **MTD_AIR**, **PMTD_AIR**, **MoM_AIR**: Derived metrics.

5. **Debt-to-Income Ratio (DTI)**:
   - **YTD_DTI**: Average DTI across all loans for the year.
   - **MTD_DTI**, **PMTD_DTI**, **MoM_DTI**: Derived monthly metrics.

For detailed DAX formulas used in this dashboard, refer to the [`DAX_Measures.md`](./DAX_Measures.md) file in this repository.

---

## 📊 Dashboard Analysis

### **Filters and Dynamic Metrics**:
- The dashboard's interactivity allows users to slice and dice data based on various parameters:
  - **Month** and **Day** filters enable analysis for specific periods.
  - **State**, **Loan Grade**, **Purpose**, and **Home Ownership** filters provide targeted insights.
  - **Measure Selector** dynamically updates KPIs to focus on TLA, TFA, TRA, AIR, or DTI.

- The screenshots represent all months and days selected, showing **YTD metrics** for 2021. Adjusting the filters dynamically recalculates the metrics, enabling real-time insights.

### **Summary Page Insights**:
- **Good Loans** account for **86.18%**, with a total funded amount of **$370.22M** and a repaid amount of **$435.79M**.
- **Bad Loans** constitute **13.82%**, with a funded amount of **$65.53M** and a repaid amount of **$37.28M**.
- **Loan Status Breakdown**:
  - **Charged Off**: $65.53M funded.
  - **Fully Paid**: $351.36M funded.
  - **Current**: $18.87M funded.

### **Overview Page Insights**:
- **Loan Applications by Month**:
  - Steady growth throughout the year, peaking in December 2021.
- **State-Wise Insights**:
  - **California** leads with the highest loan applications.
- **Purpose Analysis**:
  - **Debt Consolidation** dominates as the primary loan purpose.
- **Employment and Ownership**:
  - Majority of loans issued to individuals with **10+ years of employment**.
  - **Renters** account for a higher share of loan applications compared to homeowners.

### **Details Page Insights**:
- Granular data helps analyze:
  - Individual loan performance.
  - Funding, repayment, and interest rates per loan.
- Filters enable drilling down into specific customer demographics or loan types.

---

## 📊 Screenshots of the Dashboard

### **Summary Page**
This page provides a comprehensive overview of loan statuses, trends, and Good vs Bad Loans.

![Summary Page](Dashboard/Summary.png)

### **Overview Page**
Visualizes loan trends across time, geography, purpose, and other dimensions.

![Overview Page](Dashboard/Overview.png)

### **Details Page**
Tabular view of loan-level data with advanced filtering options.

![Details Page](Dashboard/Details.png)

---

## ⚙️ Technologies Used

- **Power BI**: Visualization and dashboard development.
- **DAX (Data Analysis Expressions)**: Advanced calculations for real-time data analysis.
- **Power Query**: Data transformation and preparation.

---

## 📁 File Structure

```plaintext
├── Dashboard/
│   ├── Summary.png      # Screenshot of the Summary page
│   ├── Overview.png     # Screenshot of the Overview page
│   ├── Details.png      # Screenshot of the Details page
├── README.md            # Project documentation
├── DAX_Measures.md      # Full list of DAX measures with formulas
├── Dataset/             # Original dataset (if applicable)
```
---

##  📌 SQL Correlation and Insights
This Power BI dashboard mirrors the insights derived from SQL analysis conducted earlier in [`\SQL`](../SQL) folder. The following alignments are observed:

- **Loan Distribution**:
   - SQL insights on Good vs Bad Loans match the 86.18% vs 13.82% split shown here.

- **Geographical Trends**:
   - SQL queries highlighted California as the top state for loan applications, consistent with this dashboard.

- **Debt Consolidation Dominance**:
   - Both SQL and Power BI analyses reveal Debt Consolidation as the primary loan purpose.

- **Monthly Trends**:
   - Steady growth observed in SQL aligns with the Power BI time-series trend.

---

## 🛠️ How to Use

1. Clone the repository:
   ```bash
   git clone (https://github.com/Mohamed-Arafaath/Bank_Loan_Analysis)
   ```
2. Open the `.pbix` file in Power BI Desktop.
3. Interact with slicers and filters to explore the data dynamically.
4. View the **DAX Measures** in the Power BI model or refer to the `DAX_Measures.md` file.

---

## 🌟 Conclusion

The **Bank Loan Analysis Dashboard** is a powerful analytical tool for understanding loan data. Its dynamic filters and detailed insights enable financial institutions to identify trends, optimize strategies, and make data-driven decisions.

For further details or questions, feel free to raise an issue or contact me.

---

## 📧 Contact

**Author**: [Mohamed Arafaath](https://www.linkedin.com/in/mohamed-arafaath/)
**Email**: [mohamed_arafaath@outlook.com]

