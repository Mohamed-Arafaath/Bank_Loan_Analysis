# Bank Loan Analysis
![World Bank Logo](Dataset/BankOfAmerica_logo.png)

## Overview
This repository provides a detailed and structured approach to analyzing bank loan data for the year 2021. The objective of this project is to evaluate the performance of the bank's lending activities and generate actionable insights using four analytical tools: **SQL**, **Excel**, **Power BI**, and **Tableau**. The same dataset and problem statement are used across all tools to ensure consistency, allowing a comparative view of each tool's capabilities.

## Problem Statement
The core objective is to create a comprehensive Bank Loan Report that provides insights into key metrics and trends, helping the bank make data-driven decisions and monitor its loan portfolio's health. 

Key focus areas include:

1. **Total Loan Applications**: Track the number of loan applications received within a specified period, including Month-to-Date (MTD), Previous-Month-to-Date (PMTD) and Month-over-Month (MoM) changes.
2. **Total Funded Amount**: Understand the total funds disbursed, along with MTD, PMTD and MoM trends.
3. **Total Amount Received**: Assess borrower repayments and track cash flow performance.
4. **Average Interest Rate**: Monitor average interest rates across loans and their monthly variations.
5. **Average Debt-to-Income Ratio (DTI)**: Analyze borrowers' financial health using average DTI values.

### Good Loans vs. Bad Loans
To evaluate loan portfolio quality, the data is categorized into:
- **Good Loans**: Loans with statuses 'Fully Paid' and 'Current.'
  - Metrics include percentage, applications, funded amounts, and total received amounts.
- **Bad Loans**: Loans with the status 'Charged Off.'
  - Metrics include percentage, applications, funded amounts, and total received amounts.

Additionally, a **Loan Status Grid View** is created to provide a breakdown of metrics such as total applications, funded amounts, received amounts, interest rates, and DTI ratios by loan status.

## Project Structure
The repository is organized into the following folders:

1. **`SQL`**, **`Excel`**, **`Power BI`** , **`Tableau`**:
   - Each folder contains the same analysis structure divided into three dashboards:
     1. **Summary Dashboard**:
        - Includes metrics like total loan applications, funded amounts, amounts received, average interest rates, and DTI ratios AS Year-to-Date (YTD).
        - Provides MTD, PMTD and MoM trends for these metrics.
     2. **Overview Dashboard**:
        - Visualizes trends and segmentation using various chart types:
          - Monthly trends (line charts).
          - Regional analysis (filled maps).
          - Loan term distribution (donut charts).
          - Borrower demographics like employment length and loan purpose (bar charts).
     3. **Details Dashboard**:
        - Offers a comprehensive grid view of all loan metrics categorized by loan status (Fully Paid, Current, Charged Off).
        - Designed for detailed insights into borrower profiles and loan performance.

2. **`Dataset`**:
   - Includes the primary dataset `Bank_loan(2021).csv`.
   - Provides raw data and terminologies required for all analyses.

Each analytical tool implements these three dashboards, ensuring consistency across SQL, Excel, Power BI, and Tableau, while leveraging the strengths of each tool.

## Analysis and Insights
### Summary Dashboards:
- **Applications, Funding, and Repayments**:
  - Track total applications, funded amounts, and received amounts with MTD, PMTD and MoM trends.

- **Borrower Profiles**:
  - Analyze how employment length, home ownership, and loan purpose affect lending metrics.

### Detailed Analysis:
- **Good Loan vs. Bad Loan**:
  - Classification of loans and their associated metrics.

- **Loan Status Grid View**:
  - A detailed breakdown of KPIs by loan status.

### Trends and Segments:
- **Monthly Trends**: Track trends in applications, funding, and repayments over time.
- **Regional Analysis**: Explore metrics by state.
- **Loan Term and Purpose**: Visualize distributions by loan term and purpose categories.

### Comparative View:
By maintaining the same analysis structure across tools, this repository demonstrates the versatility of SQL, Excel, Power BI, and Tableau for solving real-world data problems.

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/Mohamed-Arafaath/Bank_Loan_Analysis.git
   ```

2. Navigate to the relevant folder (`SQL`, `Excel`, `Power BI`, or `Tableau`) to view the analysis and dashboards created for that tool.

3. Refer to the `Dataset` folder for the raw data file (`Bank_loan(2021).csv`).

4. View insights for each analytical tool in its respective folder.
   
