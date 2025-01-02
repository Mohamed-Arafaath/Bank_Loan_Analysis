--Dashboard 2: Overview Charts Page

--Metrics used for results:
--Total Loan Applicaions
--Total Funded Amount
--Total Amount Received

--1. Monthly Trends by Issue Date
select 
	datename(month, issue_date) as month,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_loan_funded,
	sum(total_payment) as total_loan_repayed
from bank_loan
group by datename(month, issue_date), month(issue_date)
order by month(issue_date)


--2. Regional Analysis by State 
select 
	address_state,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_loan_funded,
	sum(total_payment) as total_loan_repayed
from bank_loan
GROUP by address_state
order by address_state


--3. Loan Term Analysis
select 
	term as loan_tenure_months,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_loan_funded,
	sum(total_payment) as total_loan_repayed
from bank_loan
GROUP by term
order by loan_tenure_months DESC


--4. Customer's Employment Length Analysis 
select 
	emp_length as employment_length,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_loan_funded,
	sum(total_payment) as total_loan_repayed
from bank_loan
GROUP by emp_length
order by 
	cast(left(emp_length, PATINDEX('%[^0-9]%', emp_length + ' ')-1) as int) desc


--5. Loan Purpose Analysis
select 
	purpose as loan_purpose,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_loan_funded,
	sum(total_payment) as total_loan_repayed
from bank_loan
GROUP by purpose
order by purpose


--6. Home Ownership Analysis 
select 
	home_ownership,
	count(id) as total_loan_applications,
	sum(loan_amount) as total_loan_funded,
	sum(total_payment) as total_loan_repayed
from bank_loan
GROUP by home_ownership
order by home_ownership


--Dashboard 3: Grid View Page
select * from bank_loan