# Vaccination Coverage Analysis among Pregnant Women

## Project Overview
This project analyzes vaccination coverage rates among pregnant women using SAS. The dataset contains **4,798 records**, with key variables including `Vaccine` (Influenza, Tdap), `Geography` (State), `Dimension` (Age / Race-Ethnicity), and `Estimate (%)` coverage rates. 

The goal was to explore coverage patterns, visualize trends, and conduct statistical tests to identify differences across vaccines, demographic subgroups, and states.

---

## Dataset
- **Source:** https://data.cdc.gov/Pregnancy-Vaccination/Vaccination-Coverage-among-Pregnant-Women/h7pm-wmjc/about_data
- **Variables:**  
  - `Vaccine`: Influenza or Tdap  
  - `Geography`: State  
  - `Dimension`: Age or Race-Ethnicity subgroup  
  - `Estimate (%)`: Coverage percentage  

---

## Methods and Analysis

### Data Import & Cleaning
- Imported dataset using `PROC IMPORT`  
- Converted `Estimate (%)` from character to numeric (`data` step with `input` function)  

### Descriptive Statistics
- Summary statistics (`PROC MEANS`) for coverage rates by `Vaccine`, `Dimension`, and `Geography`  
- Frequency tables for categorical variables (`PROC FREQ`)  

### Visualizations
- **Histograms** of coverage rates by Vaccine (`PROC SGPLOT`)  
- **Boxplots**:  
  - Coverage by Vaccine  
  - Coverage by Dimension grouped by Vaccine  
  - Coverage by Geography grouped by Vaccine  
- **Bar Charts**: Average coverage by Geography and Vaccine  
- **Line Plots**: Coverage trends over years by Vaccine  
- **Interaction Plot**: Vaccine × Dimension effects on mean coverage  

### Summary Tables
- Average coverage by Vaccine and Year (`PROC SQL`)  
- Average coverage by Dimension and Vaccine (`PROC SQL`)  

### Statistical Analysis
- **T-test** comparing coverage between Influenza and Tdap (`PROC TTEST`)  
  - Result: Tdap coverage higher (Mean = 68.78%) than Influenza (Mean = 59.39%), **p < 0.0001**  
- **One-way ANOVA**: Coverage differences across Dimensions (`PROC GLM`)  
  - Tukey HSD post-hoc tests to identify significant subgroup differences  
- **Two-way ANOVA**: Interaction between Vaccine and Dimension (`PROC GLM`)  
  - Significant main effects and interaction (**p < 0.0001**)  

---

## Key Findings
- **Tdap coverage consistently higher than Influenza** across most subgroups.  
- **Significant variation in coverage by age/race subgroups** (e.g., Black, Non-Hispanic had lower coverage).  
- **Vaccine × Dimension interaction** indicates that coverage differences vary by subgroup.  
- Statistical results validated using T-test and ANOVA with Tukey post-hoc comparisons.  

---

## Technologies & Skills
- **Programming / Statistical Tools:** SAS Studio (PROC IMPORT, PROC MEANS, PROC FREQ, PROC SQL, PROC GLM, PROC TTEST, PROC SGPLOT)  
- **Data Wrangling:** Data cleaning, type conversion, summary tables  
- **Data Visualization:** Histograms, Boxplots, Bar charts, Line plots, Interaction plots  
- **Statistical Analysis:** T-tests, One-way ANOVA, Two-way ANOVA, Tukey HSD  

---

## Files in this Repository
- `Vaccination_Coverage_Analysis.sas` – Full SAS code for data import, cleaning, analysis, and visualization  
- `Vaccination_Results.pdf` – PDF export of SAS output including tables, plots, and statistical results  

---

## Notes
- All analysis was performed using SAS Studio online.  
- Only cleaned numeric records were used for statistical analysis.  

## Contact

For questions or feedback, feel free to reach out via LinkedIn: [Yashaswi Bastakoti (https://www.linkedin.com/in/yashaswib/)]
