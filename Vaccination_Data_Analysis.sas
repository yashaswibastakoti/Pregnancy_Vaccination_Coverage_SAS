
* Import Data;
proc import datafile="/home/u64017783/Vaccination_Coverage_among_Pregnant_Women_20250813.csv"
            out=VaccinationData
            dbms=csv
            replace;
    getnames=yes;
run;


* Explore Dataset;
proc contents data=VaccinationData varnum; 
run;

proc print data=VaccinationData(obs=20);
    var Vaccine Geography "Estimate (%)"n;
run;


* Convert Estimate (%) to Numeric;
data VaccinationDataNum;
    set VaccinationData;
    Estimate_Num = input("Estimate (%)"n, 8.);
run;

proc print data=VaccinationDataNum(obs=20);
    var Vaccine Geography "Estimate (%)"n Estimate_Num;
run;


*Summary Statistics;
proc means data=VaccinationDataNum n mean median min max std maxdec=1;
    class Vaccine Dimension Geography;
    var Estimate_Num;
run;


*Eplore Categorical Variables;
proc freq data=VaccinationDataNum;
    tables Vaccine*Dimension / nocol norow nopercent;
run;

*Visualizations;
*Histogram of coverage by Vaccine;
proc sgplot data=VaccinationDataNum;
    histogram Estimate_Num / group=Vaccine transparency=0.5;
    density Estimate_Num / group=Vaccine;
    xaxis label="Coverage Rate (%)";
    yaxis label="Frequency";
    title "Distribution of Vaccine Coverage Rates by Vaccine";
run;

*Boxplot: Vaccine;
proc sgplot data=VaccinationDataNum;
    vbox Estimate_Num / category=Vaccine;
    yaxis label="Coverage Rate (%)";
    title "Boxplot of Vaccine Coverage Rates by Vaccine";
run;

*Boxplot: Dimension grouped by Vaccine;
proc sgplot data=VaccinationDataNum;
    vbox Estimate_Num / category=Dimension group=Vaccine;
    xaxis label="Subgroups (Age / Race-Ethnicity)";
    yaxis label="Coverage Rate (%)";
    title "Vaccine Coverage by Subgroup";
run;

*Boxplot: Geography grouped by Vaccine;
proc sgplot data=VaccinationDataNum;
    vbox Estimate_Num / category=Geography group=Vaccine;
    xaxis label="State";
    yaxis label="Coverage Rate (%)";
    title "Distribution of Vaccine Coverage Rates by State and Vaccine";
run;

*Bar chart: Average coverage by Geography and Vaccine;
proc sgplot data=VaccinationDataNum;
    vbar Geography / response=Estimate_Num group=Vaccine groupdisplay=cluster
                    stat=mean datalabel datalabelattrs=(size=8);
    xaxis label="State";
    yaxis label="Average Coverage Rate (%)";
    title "Average Vaccine Coverage Rate by State";
run;

*Line plot: Trend over years by Vaccine;
proc sgplot data=VaccinationDataNum;
    series x="Survey Year/Influenza Season"n y=Estimate_Num / group=Vaccine markers lineattrs=(thickness=2);
    xaxis label="Survey Year / Influenza Season";
    yaxis label="Coverage Rate (%)";
    title "Trend of Vaccine Coverage Over Years by Vaccine";
run;

*Summary Tables;
* Average coverage by Vaccine and Year;
proc sql;
    create table VaccinationSummary as
    select Vaccine,
           "Survey Year/Influenza Season"n as Year,
           mean(Estimate_Num) as AvgCoverage
    from VaccinationDataNum
    where Estimate_Num is not missing
    group by Vaccine, "Survey Year/Influenza Season"n;
quit;

*Average coverage by Dimension and Vaccine;
proc sql;
    create table VaccinationByDimension as
    select Vaccine,
           "Dimension"n as Dimension,
           mean(Estimate_Num) as AvgCoverage
    from VaccinationDataNum
    where Estimate_Num is not missing
    group by Vaccine, "Dimension"n;
quit;


*Statistical Analysis;
*T-test: Vaccine;
proc ttest data=VaccinationDataNum;
    class Vaccine;
    var Estimate_Num;
run;

*One-way ANOVA: Dimension;
proc glm data=VaccinationDataNum;
    class Dimension;
    model Estimate_Num = Dimension;
    means Dimension / tukey;
    title "One-way ANOVA: Coverage by Dimension";
run;

*Two-way ANOVA: Vaccine × Dimension;
proc glm data=VaccinationDataNum;
    class Vaccine Dimension;
    model Estimate_Num = Vaccine Dimension Vaccine*Dimension;
    means Vaccine*Dimension / tukey;
    title "Two-way ANOVA: Vaccine and Dimension Effects on Coverage";
run;
quit;


*Interaction Plot;
proc sgplot data=VaccinationDataNum;
    vline Dimension / response=Estimate_Num group=Vaccine stat=mean markers lineattrs=(thickness=2);
    xaxis label="Dimension (Age / Race-Ethnicity)";
    yaxis label="Mean Coverage Rate (%)";
    title "Interaction Plot: Vaccine × Dimension on Coverage";
run;


*Plot Average Coverage by Dimension & Vaccine;
proc sgplot data=VaccinationByDimension;
    vbar Dimension / response=AvgCoverage group=Vaccine groupdisplay=cluster datalabel;
    yaxis label="Average Coverage (%)";
    xaxis discreteorder=data label="Dimension";
    title "Average Vaccine Coverage by Dimension";
run;






