# Calculated Fields and Parameters

## Table of Contents
- [Total Loan Applications](#total-loan-applications)
  - [TLA](#tla)
  - [MTD_TLA](#mtd_tla)
  - [PMTD_TLA](#pmtd_tla)
  - [MoM_TLA](#mom_tla)
  - [Good Loan Count](#good-loan-count)
  - [Good Loan Percentage](#good-loan-percentage)
  - [Bad Loan Count](#bad-loan-count)
  - [Bad Loan Percentage](#bad-loan-percentage)

- [Total Funded Amount](#total-funded-amount)
  - [TFA](#tfa)
  - [MTD_TFA](#mtd_tfa)
  - [PMTD_TFA](#pmtd_tfa)
  - [MoM_TFA](#mom_tfa)
  - [good_loan_funded](#good_loan_funded)
  - [bad_loan_funded](#bad_loan_funded)

- [Total Repayed Amount](#total-repayed-amount)
  - [TRA](#tra)
  - [MTD_TRA](#mtd_tra)
  - [PMTD_TRA](#pmtd_tra)
  - [MoM_TRA](#mom_tra)
  - [good_loan_repaid](#good_loan_repaid)
  - [bad_loan_repaid](#bad_loan_repaid)

- [Average Interest Rate](#average-interest-rate)
  - [AIR](#air)
  - [MTD_AIR](#mtd_air)
  - [PMTD_AIR](#pmtd_air)
  - [MoM_AIR](#mom_air)

- [Average DTI](#average-dti)
  - [DTI (Measure)](#dti-measure)
  - [MTD_DTI](#mtd_dti)
  - [PMTD_DTI](#pmtd_dti)
  - [MoM_DTI](#mom_dti)

- [Calculated Parameter](#dynamic-measure-for-calculated-parameter-(select-Measure))
  - [Dynamic Measure](#dynamic-measure)

---

## Total Loan Applications

### TLA
```
TLA = COUNT([Id])
```

### MTD_TLA
```
MTD_TLA = 
COUNT(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 0
THEN
[Id]
end)
```

### PMTD_TLA
```
PMTD_TLA = 
COUNT(IF 
DATEDIFF('month', [Issue Date], {max([Issue Date])}) = 1
then
[Id]
end)
```

### MoM_TLA
```
MoM_TLA = 
([MTD_TLA]-[PMTD_TLA])/[PMTD_TLA]
```

### Good Loan Count
```
Good Loan Count = count(if [Good vs Bad Loan] ="Good Loan" then 1 end)
```

### Good Loan Percentage
```
Good Loan Percentage = [Good Loan Count] / [TLA]
```

### Bad Loan Count
```
Bad Loan Count = count(if [Good vs Bad Loan] ="Bad Loan" then 1 end)
```

### Bad Loan Percentage
```
Bad Loan Percentage = [Bad Loan Count]/[TLA]
```

---

## Total Funded Amount

### TFA
```
TFA = Sum([Loan Amount])
```

### MTD_TFA
```
MTD_TFA = 
SUM(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 0
THEN
[Loan Amount]
end)
```

### PMTD_TFA
```
PMTD_TFA = 
SUM(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 1
THEN
[Loan Amount]
end)
```

### MoM_TFA
```
MoM_TFA = ([MTD_TFA]-[PMTD_TFA])/[PMTD_TFA]
```

### good_loan_funded
```
good_loan_funded = sum(if [Good vs Bad Loan] ="Good Loan" then [Loan Amount] end)
```

### bad_loan_funded
```
bad_loan_funded = sum(if [Good vs Bad Loan] ="Bad Loan" then [Loan Amount] end)
```

---

## Total Repaid Amount

### TRA
```
TRA = SUM([Total Payment])
```

### MTD_TRA
```
MTD_TRA = 
SUM(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 0
THEN
[Total Payment]
end)
```

### PMTD_TRA
```
PMTD_TRA = 
SUM(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 1
THEN
[Total Payment]
end)
```

### MoM_TRA
```
MoM_TRA = ([MTD_TRA]-[PMTD_TRA])/[PMTD_TRA]
```

### good_loan_repaid
```
good_loan_repayed = sum(if [Good vs Bad Loan] ="Good Loan" then [Total Payment] end)
```

### bad_loan_repaid
```
bad_loan_repayed = sum(if [Good vs Bad Loan] ="Bad Loan" then [Total Payment] end)
```

---

## Average Interest Rate

### AIR
```
AIR = AVG([Int Rate])
```

### MTD_AIR
```
MTD_AIR = 
AVG(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 0
THEN
[Int Rate]
end)
```

### PMTD_AIR
```
PMTD_AIR = 
AVG(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 1
THEN
[Int Rate]
end)
```

### MoM_AIR
```
MoM_AIR = ([MTD_AIR]-[PMTD_AIR])/[PMTD_AIR]
```

---

## Average DTI

### DTI (Measure)
```
DTI = AVG([Dti])
```

### MTD_DTI
```
MTD_DTI = 
AVG(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 0
THEN
[Dti]
end)
```

### PMTD_DTI
```
PMTD_DTI = 
AVG(IF 
DATEDIFF('month',[Issue Date], {max([Issue Date])}) = 1
THEN
[Dti]
end)
```

### MoM_DTI
```
MoM_DTI = ([MTD_DTI]-[PMTD_DTI])/[PMTD_DTI]
```

---

## Dynamic Measure for Calculated Parameter (Select Measure)

### Dynamic Measure
```
Dynamic Measure =
if [Select Measure] = "Total Loan Applications" then [TLA]
ELSEIF [Select Measure] = "Total Funded Amount" then [TFA]
else [TRA]
end
```
---
