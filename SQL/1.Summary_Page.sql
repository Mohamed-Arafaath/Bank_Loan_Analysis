--Dashboard 1: Summary Page

--KPI
--1. Total Loan Applications
select count(id) as total_loan_applications 
from bank_loan

--1a. MTD (Dec 1st-Dec 31st, 2021) i.e. MTD cheked on Dec 31st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT COUNT(id) AS total_loan_applications 
FROM bank_loan
WHERE issue_date <= '2021-12-31' --GETDATE()
	and issue_date >=  dateadd(month, datediff(month, 0, '2021-12-31'), 0) --getdate()
	--and issue_date >= dateadd(day, (-day(GETDATE())+1), GETDATE()) simple

--1b. PMTD (Nov 1st-Nov 30st, 2021) i.e. MTD cheked on Nov 30st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT COUNT(id) AS total_loan_applications 
FROM bank_loan
WHERE issue_date <= dateadd(month, -1, '2021-12-25')  --GETDATE()
	and issue_date >=  dateadd(month, -1, dateadd(month, datediff(month, 0, '2021-12-31'), 0)) --getdate()


--2. Total Funded Amount
select sum(loan_amount) as total_loan_funded
from bank_loan

--2a. MTD (Dec 1st-Dec 31st, 2021) i.e. MTD cheked on Dec 31st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT sum(loan_amount) as total_loan_funded 
FROM bank_loan
WHERE issue_date <= '2021-12-31' --GETDATE()
	and issue_date >=  dateadd(month, datediff(month, 0, '2021-12-31'), 0) --getdate()

--2b. PMTD (Nov 1st-Nov 30st, 2021) i.e. MTD cheked on Nov 30st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT sum(loan_amount) as total_loan_funded
FROM bank_loan
WHERE issue_date <= dateadd(month, -1, '2021-12-25')  --GETDATE()
	and issue_date >=  dateadd(month, -1, dateadd(month, datediff(month, 0, '2021-12-31'), 0)) --getdate()


--3. Total Loan Repayed
select sum(total_payment) as total_loan_repayed
from bank_loan

--3a. MTD (Dec 1st-Dec 31st, 2021) i.e. MTD cheked on Dec 31st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT sum(total_payment) as total_loan_repayed 
FROM bank_loan
WHERE issue_date <= '2021-12-31' --GETDATE()
	and issue_date >=  dateadd(month, datediff(month, 0, '2021-12-31'), 0) --getdate()

--3b. PMTD (Nov 1st-Nov 30st, 2021) i.e. MTD cheked on Nov 30st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT sum(total_payment) as total_loan_repayed
FROM bank_loan
WHERE issue_date <= dateadd(month, -1, '2021-12-25')  --GETDATE()
	and issue_date >=  dateadd(month, -1, dateadd(month, datediff(month, 0, '2021-12-31'), 0)) --getdate()


--4. Average Interest Rate
select round(avg(int_rate)*100,4) as avg_interest_rate
from bank_loan

--4a. MTD (Dec 1st-Dec 31st, 2021) i.e. MTD cheked on Dec 31st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT round(avg(int_rate)*100,4) as avg_interest_rate
FROM bank_loan
WHERE issue_date <= '2021-12-31' --GETDATE()
	and issue_date >=  dateadd(month, datediff(month, 0, '2021-12-31'), 0) --getdate()

--4b. PMTD (Nov 1st-Nov 30st, 2021) i.e. MTD cheked on Nov 30st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT round(avg(int_rate)*100,4) as avg_interest_rate
FROM bank_loan
WHERE issue_date <= dateadd(month, -1, '2021-12-25')  --GETDATE()
	and issue_date >=  dateadd(month, -1, dateadd(month, datediff(month, 0, '2021-12-31'), 0)) --getdate()


--5. Average Debt to Interest Ratio(DTI)
select round(avg(dti)*100,4) as avg_dti
from bank_loan

--5a. MTD (Dec 1st-Dec 31st, 2021) i.e. MTD cheked on Dec 31st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT round(avg(dti)*100,4) as avg_dti 
FROM bank_loan
WHERE issue_date <= '2021-12-31' --GETDATE()
	and issue_date >=  dateadd(month, datediff(month, 0, '2021-12-31'), 0) --getdate()

--5b. PMTD (Nov 1st-Nov 30st, 2021) i.e. MTD cheked on Nov 30st, 2021
--generalized dynamic query (replace date with GETDATE())
SELECT round(avg(dti)*100,4) as avg_dti
FROM bank_loan
WHERE issue_date <= dateadd(month, -1, '2021-12-25')  --GETDATE()
	and issue_date >=  dateadd(month, -1, dateadd(month, datediff(month, 0, '2021-12-31'), 0)) --getdate()


--Good Loan vs Bad Loan KPI
--Good Loan KPI
--1. Good Loan Applications Percentage
select
	round(cast(count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id else null end) *100 as float)
	/ count(id),2) good_loan_percentage
from bank_loan

--2. Total number of Good Loan Applications
select
	count(id) as total_good_loan_applications
from bank_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'

--3. Total Good Loan Funded Amount
select
	sum(loan_amount) as total_good_loan_fundedAmt
from bank_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'

--4. Total Good Loan Repayed Amount
select
	sum(total_payment) as total_good_loan_repayedAmt
from bank_loan
where loan_status = 'Fully Paid' or loan_status = 'Current'


--Bad Loan KPI
--1. Bad Loan Applications Percentage
select
	round(cast(count(case when loan_status = 'Charged Off' then id else null end) *100 as float)
	/ count(id),2) bad_loan_percentage
from bank_loan

--2. Total number of Bad Loan Applications
select
	count(id) as total_bad_loan_applications
from bank_loan
where loan_status = 'Charged Off'

--3. Total Bad Loan Funded Amount
select
	sum(loan_amount) as total_bad_loan_fundedAmt
from bank_loan
where loan_status = 'Charged Off'

--4. Total Bad Loan Repayed Amount
select
	sum(total_payment) as total_bad_loan_repayedAmt
from bank_loan
where loan_status = 'Charged Off'


--Loan Status Grid View
--1. Overall Summary
select COALESCE(loan_status, 'Overall') AS loan_status,
	count(id) as total_loan_applications,
	round(cast(count(id)*100 as float) / 
	sum(case when grouping(loan_status)=1 then 0 else count(id) end) over(),2) as loan_ratio,
	sum(loan_amount) as total_loan_funded,
	sum(total_payment) as total_loan_repayed,
	sum(case when issue_date <= '2021-12-31' 
		and issue_date >=  dateadd(month, datediff(month, 0, '2021-12-31'), 0)
		then loan_amount end) as MTD_total_loan_funded,
	sum(case when issue_date <= '2021-12-31'
		and issue_date >=  dateadd(month, datediff(month, 0, '2021-12-31'), 0)
		then total_payment end) as MTD_total_loan_repayed,
	round(avg(int_rate)*100,4) as avg_interest_rate,
	round(avg(dti)*100,4) as avg_dti
FROM bank_loan
group by rollup(loan_status)


