# Power BI DAX Measures

## Table of Contents
- [Total Loan Applications](#total-loan-applications)
  - [TLA](#tla)
  - [YTD_TLA](#ytd_tla)
  - [MTD_TLA](#mtd_tla)
  - [PMTD_TLA](#pmtd_tla)
  - [MoM_TLA](#mom_tla)

- [Total Funded Amount](#total-funded-amount)
  - [TFA](#tfa)
  - [YTD_TFA](#ytd_tfa)
  - [MTD_TFA](#mtd_tfa)
  - [PMTD_TFA](#pmtd_tfa)
  - [MoM_TFA](#mom_tfa)

- [Total Repayed Amount](#total-repayed-amount)
  - [TRA](#tra)
  - [YTD_TRA](#ytd_tra)
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
  - [YTD_DTI](#ytd_dti)
  - [MTD_DTI](#mtd_dti)
  - [PMTD_DTI](#pmtd_dti)
  - [MoM_DTI](#mom_dti)

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
```vbnet
TLA = COUNT(financial_loan[id])
```

### YTD_TLA
```csharp
YTD_TLA = 
SWITCH(
    TRUE(),
    -- Case 1: Both Month and Day slicers are "All" or not selected
    NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
        TOTALYTD(
            [TLA],
            DATESBETWEEN(
                dates[Date],
                DATE(2021, 1, 1),
                DATE(2021, 12, 31)
            )
        ),
    -- Case 2: Month is selected, Day is not selected
    ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
        TOTALYTD([TLA], dates[Date]),
    -- Case 3: Month is selected, Day is selected
    ISFILTERED(dates[Month]) && ISFILTERED(dates[Day]),
        TOTALYTD([TLA], dates[Date]),
    TOTALYTD([TLA], dates[Date])
)
```

### MTD_TLA
```sql
MTD_TLA = 
COALESCE(
    SWITCH(
        TRUE(),
        -- Case 1: Both Month and Day slicers are "All" or not selected
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [TLA],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 12, 1),
                    DATE(2021, 12, 31)
                )
            ),
        -- Case 2: Month is selected, Day is not selected
        ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD([TLA], dates[Date]),
        -- Case 3: Month is selected, Day is selected
        ISFILTERED(dates[Month]) && ISFILTERED(dates[Day]),
            TOTALMTD([TLA], dates[Date])
    ),
    0
)
```

### PMTD_TLA
```sql
PMTD_TLA = 
COALESCE(
    SWITCH(
        TRUE(),
        -- Case 1: Day is filtered but Month is not filtered
        ISFILTERED(dates[Day]) && NOT ISFILTERED(dates[Month]), 
            "N/A",
        -- Case 2: Both Month and Day are not filtered
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]), 
            TOTALMTD(
                [TLA],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 11, 1),
                    DATE(2021, 11, 30)
                )
            ),
        -- Case 3: Selected Month is January
        SELECTEDVALUE(dates[Month]) = "Jan", 
            "N/A",
        -- Case 4: Month is selected
        ISFILTERED(dates[Month]),
            CALCULATE(
                [TLA],
                FILTER(
                    PREVIOUSMONTH(dates[Date]),
                    NOT ISFILTERED(dates[Day]) || DAY(dates[Date]) <= DAY(MAX(dates[Date]))
                )
            )
    ),
    0
)
```

### MoM_TLA
```sql
MoM_TLA = 
IF(
    [PMTD_TLA] = "N/A" || [PMTD_TLA] = 0,
    "N/A",
    ([MTD_TLA] - [PMTD_TLA]) / [PMTD_TLA]
)
```

---

## Total Funded Amount

### TFA
```sql
TFA = SUM(financial_loan[loan_amount])
```

### YTD_TFA
```sql
YTD_TFA = 
SWITCH(
    TRUE(),
    NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
        TOTALYTD(
            [TFA],
            DATESBETWEEN(
                dates[Date],
                DATE(2021, 1, 1),
                DATE(2021, 12, 31)
            )
        ),
    TOTALYTD([TFA], dates[Date])
)
```

### MTD_TFA
```sql
MTD_TFA = 
COALESCE(
    SWITCH(
        TRUE(),
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [TFA],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 12, 1),
                    DATE(2021, 12, 31)
                )
            ),
        ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD([TFA], dates[Date]),
        ISFILTERED(dates[Month]) && ISFILTERED(dates[Day]),
            TOTALMTD([TFA], dates[Date])
    ),
    0
)
```

### PMTD_TFA
```sql
PMTD_TFA = 
COALESCE(
    SWITCH(
        TRUE(),
        ISFILTERED(dates[Day]) && NOT ISFILTERED(dates[Month]), "N/A",
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [TFA],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 11, 1),
                    DATE(2021, 11, 30)
                )
            ),
        SELECTEDVALUE(dates[Month]) = "Jan", "N/A",
        ISFILTERED(dates[Month]),
            CALCULATE(
                [TFA],
                FILTER(
                    PREVIOUSMONTH(dates[Date]),
                    NOT ISFILTERED(dates[Day]) || DAY(dates[Date]) <= DAY(MAX(dates[Date]))
                )
            )
    ),
    0
)
```

### MoM_TFA
```sql
MoM_TFA = 
IF(
    [PMTD_TFA] = "N/A" || [PMTD_TFA] = 0,
    "N/A",
    ([MTD_TFA] - [PMTD_TFA]) / [PMTD_TFA]
)
```

---

## Total Repayed Amount

### TRA
```sql
TRA = SUM(financial_loan[total_payment])
```

### YTD_TRA
```sql
YTD_TRA = 
SWITCH(
    TRUE(),
    NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
        TOTALYTD(
            [TRA],
            DATESBETWEEN(
                dates[Date],
                DATE(2021, 1, 1),
                DATE(2021, 12, 31)
            )
        ),
    TOTALYTD([TRA], dates[Date])
)
```

### MTD_TRA
```sql
MTD_TRA = 
COALESCE(
    SWITCH(
        TRUE(),
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [TRA],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 12, 1),
                    DATE(2021, 12, 31)
                )
            ),
        ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD([TRA], dates[Date]),
        ISFILTERED(dates[Month]) && ISFILTERED(dates[Day]),
            TOTALMTD([TRA], dates[Date])
    ),
    0
)
```

### PMTD_TRA
```sql
PMTD_TRA = 
COALESCE(
    SWITCH(
        TRUE(),
        ISFILTERED(dates[Day]) && NOT ISFILTERED(dates[Month]), "N/A",
        NOT ISFILTERED(dates[Month]) && NOT ISFILTERED(dates[Day]),
            TOTALMTD(
                [TRA],
                DATESBETWEEN(
                    dates[Date],
                    DATE(2021, 11, 1),
                    DATE(2021, 11, 30)
                )
            ),
        SELECTEDVALUE(dates[Month]) = "Jan", "N/A",
        ISFILTERED(dates[Month]),
            CALCULATE(
                [TRA],
                FILTER(
                    PREVIOUSMONTH(dates[Date]),
                    NOT ISFILTERED(dates[Day]) || DAY(dates[Date]) <= DAY(MAX(dates[Date]))
                )
            )
    ),
    0
)
```

### MoM_TRA
```sql
MoM_TRA = 
IF(
    [PMTD_TRA] = "N/A" || [PMTD_TRA] = 0,
    "N/A",
    ([MTD_TRA] - [PMTD_TRA]) / [PMTD_TRA]
)
```

### good_loan_repayed
```sql
good_loan_repayed = CALCULATE([YTD_TRA], financial_loan[Good vs Bad Loan] = "Good Loan")
```

### bad_loan_repayed
```sql
bad_loan_repayed = CALCULATE([YTD_TRA], financial_loan[Good vs Bad Loan] = "Bad Loan")
```

---

## Average Interest Rate

### AIR
```sql
AIR = AVERAGE(financial_loan[int_rate])
```

### MTD_AIR
```sql
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
```sql
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
```sql
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
```sql
DTI = AVERAGE(financial_loan[dti])
```

### YTD_DTI
```sql
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
```sql
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
```sql
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
```sql
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
```sql
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
```sql
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
```sql
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
```sql
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
```sql
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
```sql
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
```sql
dates = CALENDAR(MIN(financial_loan[issue_date]), MAX(financial_loan[issue_date]))
```

### month
```sql
month = FORMAT(dates[Date], "mmm")
```

### day
```sql
day = DAY(dates[Date])
```

### month_no
```sql
month_no = MONTH(dates[Date])
```

### title
```sql
title = SELECTEDVALUE(dates[month])
```

---

## Select Measure

### Select Measure
```sql
Select Measure = {
    ("TFA", NAMEOF('Total Funded Amount'[YTD_TFA]), 0),
    ("TLA", NAMEOF('Total Loan Applications'[YTD_TLA]), 1),
    ("TRA", NAMEOF('Total Repayed Amount'[YTD_TRA]), 2)
}
```

### Select Measure Total
```sql
Select Measure Total = 
SWITCH(
    SELECTEDVALUE('Select Measure'[Select Measure Fields]),
    "'Total Funded Amount'[YTD_TFA]", [TFA],
    "'Total Loan Applications'[YTD_TLA]", [TLA],
    "'Total Repayed Amount'[YTD_TRA]", [TRA],
    BLANK()
)
```
