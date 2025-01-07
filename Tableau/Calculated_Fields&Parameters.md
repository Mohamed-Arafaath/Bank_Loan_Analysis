
# Calculated Fields

## Table of Contents
- [Total Loan Applications](#total-loan-applications)
  - [TLA](#tla)
  - [MTD_TLA](#mtd_tla)
  - [PMTD_TLA](#pmtd_tla)
  - [MoM_TLA](#mom_tla)
  - [Good Loan Count](#good-loan-count)
  - [Good Loan%](good-loan%)
  - [Bad Loan Count](#bad-loan-count)
  - [Bad Loan%](bad-loan%)

- [Total Funded Amount](#total-funded-amount)
  - [TFA](#tfa)
  - [MTD_TFA](#mtd_tfa)
  - [PMTD_TFA](#pmtd_tfa)
  - [MoM_TFA](#mom_tfa)

- [Total Repayed Amount](#total-repayed-amount)
  - [TRA](#tra)
  - [MTD_TRA](#mtd_tra)
  - [PMTD_TRA](#pmtd_tra)
  - [MoM_TRA](#mom_tra)
  - [good_loan_repayed](#good_loan_repayed)
  - [bad_loan_repayed](#bad_loan_repayed)

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

---

# Calculated Parameters
## Table of Contents

- [Dynamic Titles](#dynamic-titles)
  - [DynamicTitle_term](#dynamictitle_term)
  - [DynamicTitle_state](#dynamictitle_state)
  - [DynamicTitle_purpose](#dynamictitle_purpose)
  - [DynamicTitle_month](#dynamictitle_month)
  - [DynamicTitle_home_own](#dynamictitle_home_own)
  - [DynamicTitle_employment_len](#dynamictitle_employment_len)

- [Dates Table](#dates-table)
  - [dates](#dates)
  - [month](#month)
  - [day](#day)
  - [month_no](#month_no)
  - [title](#title)

- [Select Measure](#select-measure)
  - [Select Measure](#select_measure)
  - [Select Measure Total](#select_measure_total)

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

### Good Loan%
```
Good Loan% = [Good Loan Count] / [TLA]
```

### Bad Loan Count
```
Bad Loan Count = count(if [Good vs Bad Loan] ="Bad Loan" then 1 end)
```

### Bad Loan%
```
Bad Loan% = [Bad Loan Count]/[TLA]
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
AIR = AVERAGE(financial_loan[int_rate])
```

### MTD_AIR
```
MTD_AIR = 
COALESCE(
    SWITCH(
        TRUE(),
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [AIR],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 12, 1),
                    DATE(2021, 12, 31)
                )
            ),
        ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD([AIR], dates[Date]),
        ISFILTERED(dates[Month]) && ISFILTERED(dates[Day]),
            TOTALMTD([AIR], dates[Date])
    ),
    0
)
```

### PMTD_AIR
```
PMTD_AIR = 
COALESCE(
    SWITCH(
        TRUE(),
        ISFILTERED(dates[Day]) && NOT ISFILTERED(dates[Month]), "N/A",
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [AIR],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 11, 1),
                    DATE(2021, 11, 30)
                )
            ),
        SELECTEDVALUE(dates[Month]) = "Jan", "N/A",
        ISFILTERED(dates[Month]),
            CALCULATE(
                [AIR],
                FILTER(
                    PREVIOUSMONTH(dates[Date]),
                    NOT ISFILTERED(dates[Day]) || DAY(dates[Date]) <= DAY(MAX(dates[Date]))
                )
            )
    ),
    0
)
```

### MoM_AIR
```
MoM_AIR = 
IF(
    [PMTD_AIR] = "N/A" || [PMTD_AIR] = 0,
    "N/A",
    ([MTD_AIR] - [PMTD_AIR]) / [PMTD_AIR]
)
```

---

## Average DTI

### DTI (Measure)
```
DTI = AVERAGE(financial_loan[dti])
```

### YTD_DTI
```
YTD_DTI = 
SWITCH(
    TRUE(),
    NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
        TOTALYTD(
            [DTI],
            DATESBETWEEN(
                dates[Date],
                DATE(2021, 1, 1),
                DATE(2021, 12, 31)
            )
        ),
    TOTALYTD([DTI], dates[Date])
)
```

### MTD_DTI
```
MTD_DTI = 
COALESCE(
    SWITCH(
        TRUE(),
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [DTI],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 12, 1),
                    DATE(2021, 12, 31)
                )
            ),
        ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD([DTI], dates[Date]),
        ISFILTERED(dates[Month]) && ISFILTERED(dates[Day]),
            TOTALMTD([DTI], dates[Date])
    ),
    0
)
```

### PMTD_DTI
```
PMTD_DTI = 
COALESCE(
    SWITCH(
        TRUE(),
        ISFILTERED(dates[Day]) && NOT ISFILTERED(dates[Month]), "N/A",
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [DTI],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 11, 1),
                    DATE(2021, 11, 30)
                )
            ),
        SELECTEDVALUE(dates[Month]) = "Jan", "N/A",
        ISFILTERED(dates[Month]),
            CALCULATE(
                [DTI],
                FILTER(
                    PREVIOUSMONTH(dates[Date]),
                    NOT ISFILTERED(dates[Day]) || DAY(dates[Date]) <= DAY(MAX(dates[Date]))
                )
            )
    ),
    0
)
```

### MoM_DTI
```
MoM_DTI = 
IF(
    [PMTD_DTI] = "N/A" || [PMTD_DTI] = 0,
    "N/A",
    ([MTD_DTI] - [PMTD_DTI]) / [PMTD_DTI]
)
```

---

## Dynamic Titles

### DynamicTitle_term
```
DynamicTitle_term = 
SWITCH(
    SELECTEDVALUE('Select Measure'[Select Measure Fields]),
    "'Total Funded Amount' [YTD_TFA]", "Total Funded Amount by Term",
    "'Total Loan Applications'[YTD_TLA]", "Total Loan Applications by Term",
    "'Total Repayed Amount'[YTD_TRA]", "Total Repaid Amount by Term",
    "Select a Measure"
)
```

### DynamicTitle_state
```
DynamicTitle_state = 
SWITCH(
    SELECTEDVALUE('Select Measure'[Select Measure Fields]),
    "'Total Funded Amount' [YTD_TFA]", "Total Funded Amount by State",
    "'Total Loan Applications'[YTD_TLA]", "Total Loan Applications by State",
    "'Total Repayed Amount'[YTD_TRA]", "Total Repaid Amount by State",
    "Select a Measure"
)
```

### DynamicTitle_purpose
```
DynamicTitle_purpose = 
SWITCH(
    SELECTEDVALUE('Select Measure'[Select Measure Fields]),
    "'Total Funded Amount' [YTD_TFA]", "Total Funded Amount by Purpose",
    "'Total Loan Applications'[YTD_TLA]", "Total Loan Applications by Purpose",
    "'Total Repayed Amount'[YTD_TRA]", "Total Repaid Amount by Purpose",
    "Select a Measure"
)
```

### DynamicTitle_month
```
DynamicTitle_month = 
SWITCH(
    SELECTEDVALUE('Select Measure'[Select Measure Fields]),
    "'Total Funded Amount' [YTD_TFA]", "Total Funded Amount by Month",
    "'Total Loan Applications'[YTD_TLA]", "Total Loan Applications by Month",
    "'Total Repayed Amount'[YTD_TRA]", "Total Repaid Amount by Month",
    "Select a Measure"
)
```

### DynamicTitle_home_own
```
DynamicTitle_home_own = 
SWITCH(
    SELECTEDVALUE('Select Measure'[Select Measure Fields]),
    "'Total Funded Amount' [YTD_TFA]", "Total Funded Amount by Home Ownership",
    "'Total Loan Applications'[YTD_TLA]", "Total Loan Applications by Home Ownership",
    "'Total Repayed Amount'[YTD_TRA]", "Total Repaid Amount by Home Ownership",
    "Select a Measure"
)
```

### DynamicTitle_employment_len
```
DynamicTitle_employment_len = 
SWITCH(
    SELECTEDVALUE('Select Measure'[Select Measure Fields]),
    "'Total Funded Amount' [YTD_TFA]", "Total Funded Amount by Employment Length",
    "'Total Loan Applications'[YTD_TLA]", "Total Loan Applications by Employment Length",
    "'Total Repayed Amount'[YTD_TRA]", "Total Repaid Amount by Employment Length",
    "Select a Measure"
)
```

---

## Dates Table

### dates
```
dates = CALENDAR(MIN(financial_loan[issue_date]), MAX(financial_loan[issue_date]))
```

### month
```
month = FORMAT(dates[Date], "mmm")
```

### day
```
day = DAY(dates[Date])
```

### month_no
```
month_no = MONTH(dates[Date])
```

### title
```
title = SELECTEDVALUE(dates[month])
```

---

## Select Measure

### Select Measure
```
Select Measure = {
    ("TFA", NAMEOF('Total Funded Amount'[YTD_TFA]), 0),
    ("TLA", NAMEOF('Total Loan Applications'[YTD_TLA]), 1),
    ("TRA", NAMEOF('Total Repayed Amount'[YTD_TRA]), 2)
}
```

### Select Measure Total
```
Select Measure Total = 
SWITCH(
    SELECTEDVALUE('Select Measure'[Select Measure Fields]),
    "'Total Funded Amount'[YTD_TFA]", [TFA],
    "'Total Loan Applications'[YTD_TLA]", [TLA],
    "'Total Repayed Amount'[YTD_TRA]", [TRA],
    BLANK()
)
```
