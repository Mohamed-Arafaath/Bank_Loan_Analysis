### 📂 SQL Analysis

The `SQL` folder contains two query files that form the backbone of the analysis performed on the bank loan dataset. These SQL queries directly complement the insights provided in the Power BI dashboard, ensuring the analytical logic and results are consistent across platforms. The queries were executed for the time period **January 1, 2021, to December 31, 2021**, matching the period analyzed in Power BI.

---

### 📋 Dashboard Overview

1. **1.Summary_Page.sql**:
   - **Purpose**: This query file provides data aggregation and key performance indicators (KPIs) that align with the **Summary Page** of the Power BI dashboard.
   - **Key Insights**:
     - Total Loan Applications, Funded Amount, and Repaid Amounts.
     - Segmentation of Good Loans vs. Bad Loans, along with their respective counts and financial metrics.
     - Loan status breakdown into Charged Off, Fully Paid, and Current loans.
   - **How It Maps to Power BI**:
     - The SQL logic here is directly used to calculate **YTD metrics** for Total Loan Applications (TLA), Total Funded Amount (TFA), Total Repaid Amount (TRA), and other key metrics seen at the top of the **Summary Page**.
     - These metrics also serve as a basis for the dynamic slicers used in the Power BI model for Month-to-Date (MTD), Previous Month-to-Date (PMTD), and Month-over-Month (MoM) comparisons.

2. **2.Overview_3.GridView.sql**:
   - **Purpose**: This query file focuses on granular and trend-based data analysis for the **Overview** and **Details Pages** of the Power BI dashboard.
   - **Key Insights**:
     - Time-series analysis of loan applications across months.
     - Geographic distribution of loans by state.
     - Breakdown of loans by purpose, employment length, and home ownership.
     - Tabular data including Customer ID, Purpose, Loan Grade, Term, Funded and Repaid Amounts, Interest Rates, and Installments.
   - **How It Maps to Power BI**:
     - The SQL results for loan application trends, state-wise distributions, and purpose-based analysis directly translate to the visualizations on the **Overview Page**.
     - The detailed SQL logic for tabular data populates the granular details shown on the **Details Page** of the dashboard.

---

### 📌 SQL Correlation and Insights

The SQL queries were carefully designed to match the analytical scope of the Power BI dashboard. Together, they ensure:
- **Consistency Across Platforms**: The same dataset and time period (January 1, 2021, to December 31, 2021) are analyzed using SQL and Power BI, resulting in consistent insights.
- **Dynamic Filtering Logic**: SQL queries compute aggregated results, which Power BI extends dynamically using **DAX measures** for filters like Month, Day, Loan Grade, Purpose, and Ownership Status.
- **Reproducibility**: SQL provides a foundational, static analysis, while Power BI builds on it with dynamic interactivity.

---

### 📖 How to Use the SQL Files

1. **Run the Queries**:
   - Execute the SQL files against the bank loan dataset in your preferred SQL environment.
   - Ensure the dataset schema matches the one described in the Power BI project (e.g., columns for loan applications, amounts, dates, etc.).

2. **Interpret the Results**:
   - Use the outputs of `1.Summary_Page.sql` to validate the KPIs and distributions on the **Summary Page**.
   - Cross-check the outputs of `2.Overview_3.GridView.sql` with the trends, geographic insights, and tabular details on the **Overview** and **Details Pages**.

3. **Compare and Correlate**:
   - Match the SQL results with the YTD metrics and visual trends in Power BI to ensure analytical integrity.

---

### 🌟 Conclusion

The SQL queries serve as a robust analytical foundation for the Power BI dashboard. By ensuring consistency and reproducibility, they allow stakeholders to validate the insights derived in Power BI. For further details on the DAX measures and dynamic slicer logic in Power BI, refer to the [DAX_Measures.md](../BI/DAX_Measures.md) file.


---

## 📧 Contact

**Author**: [Mohamed Arafaath]([[https://github.com/YourGitHubUsername](https://github.com/Mohamed-Arafaath)](https://www.linkedin.com/in/mohamed-arafaath/))  
**Email**: [mohamed_arafaath@outlook.com]
