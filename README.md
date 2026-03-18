# PG Rent Price Analysis — Bangalore

## Problem Statement
What factors significantly drive PG rental prices across 
different localities in Bangalore, and by how much?

## Data Collection
- Method: Primary data via structured Google Forms survey
- Sample size: 30 responses
- Collection period: 1 week
- Dependent variable: Monthly Rent (INR)
- Independent variables: Location, Area of Room (sqft), 
  Number of Room Sharing

## Methodology

### Step 1 — Data Preprocessing
- Cleaned raw survey responses
- Handled inconsistencies and missing entries

### Step 2 — Multiple Linear Regression (MLR)
- Built initial MLR model in R
- Identified significant and insignificant variables 
  using p-values (threshold: 0.05)

### Step 3 — Multicollinearity Detection
- Room Sharing showed perfect multicollinearity with 
  other variables — R dropped it automatically (NA values
  in regression summary)
- Area of Room was statistically significant (p < 0.05)
- Location had mixed significance across localities

### Step 4 — Regularisation (Ridge Regression)
- Location as a categorical variable caused overfitting 
  due to high number of dummy variables
- Applied Ridge Regression to penalise complexity 
  and improve model generalisation
- Compared Ridge, Lasso, and Elastic Net — 
  selected Ridge as most appropriate

## Results

| Metric | Value |
|---|---|
| Multiple R² | 0.9944 |
| Adjusted R² | 0.9461 |
| F-Statistic | 20.59 (26 and 3 df) |
| Model p-value | 0.01449 |

Model is a good fit — R² close to 1 indicates independent 
variables explain 99.44% of variance in monthly rent.

## Key Findings
- **Location** is the dominant pricing factor — positive 
  coefficients indicate rent premium in that locality
  (e.g. Mahadevpura, Koramangala, Whitefield)
- **Area of Room** has significant positive impact — 
  larger rooms command higher rent
- **Room Sharing** could not be independently assessed 
  due to perfect multicollinearity with other variables

## Hypothesis Testing
- H₀: Location, Area, Room Sharing have no significant 
  impact on Monthly Rent
- H₁: At least one variable significantly impacts rent
- **Result: Reject H₀** — p-value (0.01449) < 0.05; 
  Area of Room and several Location coefficients 
  are statistically significant

## Challenges & How They Were Handled
1. **Dirty data** — resolved through preprocessing
2. **Insignificant location variables** — retained 
   Location due to domain importance; used 
   Regularisation instead of dropping
3. **Overfitting risk** — addressed using Ridge 
   Regression after evaluating Ridge vs Lasso 
   vs Elastic Net

## Tools & Technologies
R | Multiple Linear Regression | Ridge Regression | 
ggplot2 | Google Forms

## Files
| File | Description |
|------|-------------|
| `PG_Rent_Analysis-R.R` | R script — MLR, diagnostics, Ridge regression |
| `PG_Rent_Analysis_data.xlsx` | Primary survey data (n=30) |
