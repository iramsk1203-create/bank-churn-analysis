# Bank Customer Churn Analysis

**Tools:** Power BI (Power Query, DAX), MySQL, SQL (joins, window functions), Excel

## Business question
A bank wants to understand which customers are leaving (churning), so it can target retention efforts. This project cleans a 10,000-customer dataset, analyses churn with SQL, and presents the results in a Power BI dashboard.

![Dashboard](dashboard.png)

## Dataset
- `BankChurn.csv`: 10,000 customers, 14 columns (credit score, country, gender, age, tenure, balance, number of products, credit card, active member, estimated salary, and `Exited`, where 1 means the customer left).
- Source: public bank customer churn dataset.

## What I did
1. **Cleaned the data in Power Query:** renamed columns, checked for duplicates, blanks and impossible values (none found), set data types, removed unneeded columns (`row_number`, `surname`), and created helper columns (`age_band`, `balance_band`, `credit_band`, `status`, `active_label`).
2. **Lookups:** merged three small lookup tables into the main table (region groups, credit-band risk notes, illustrative churn targets by country).
3. **Measures in DAX:** Customers, Churned Customers, Churn Rate, Avg Balance, Balance at Risk, Avg Target, Vs Target.
4. **SQL analysis in MySQL Workbench** (`analysis.sql`): data quality checks, churn rate by country, gender, age band, number of products and activity, balance at risk, a window function (`RANK() OVER`) and a `JOIN` to a targets table.
5. **Dashboard in Power BI** with KPI cards, four charts, slicers (country, gender, age band) and a target comparison table.

## Key findings
- **Overall churn is 20.37%** (2,037 of 10,000 customers), and those customers held about **185.6 million** in balances.
- **Germany churns at 32.4%**, about double France (16.2%) and Spain (16.7%).
- **Churn rises sharply after age 40** and peaks at **56.0% for ages 50 to 59**. Ages 18 to 29 churn at only 7.6%.
- **Inactive members churn at 26.9%** against 14.3% for active members.
- **Women churn more than men** (25.1% against 16.5%).
- **Customers with 1 product churn at 33.2%**, compared with 10.2% for 2 products and 6.9% for 4 products.
- Against illustrative targets (France 15%, Spain 15%, Germany 20%), Germany is 12.4 percentage points above target.

## Recommendations
1. Run a retention programme in Germany, where churn is highest and furthest above target.
2. Target customers aged 40 and over with retention offers and relationship contact.
3. Re-engage inactive members, for example with reminders, rewards or product reviews.
4. Encourage single-product customers to take a second product, since 2-product customers churn far less.

## Limitations
- The data is a sample and has no dates, so trends over time cannot be analysed.
- Customers with 5 or 6 products are very few (117 and 22), so their churn rates are unreliable.
- Churn targets are illustrative values created for this exercise, not company data.
- This analysis shows associations, not causes.

## Files
| File | Description |
|---|---|
| `BankChurn.csv` | Raw dataset |
| `bank_churn.pbix` | Power BI report |
| `analysis.sql` | SQL queries |
| `dashboard.png` | Dashboard screenshot |
