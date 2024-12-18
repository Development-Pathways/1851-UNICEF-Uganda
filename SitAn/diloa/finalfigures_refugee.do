*Final figures & tables

global file "${path_tables}/finalfigures.xlsx"

// Figure 1: Prevalence of severe functional limitations and percentage of persons with severe functional limitations across the refugee population, including by gender	3
{
	local sheet "F.1"
	local variableofinterest = "disability_severity2"
	local stratifier = "age5yrs"
	local title "`sheet': Disability prevalence: Prevalence of severe functional limitations and percentage of persons with severe functional limitations across the refugee population, including by gender"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"
	
	*male
	putexcel A4="Male individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if sex==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
	*female
	putexcel A29="Female individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if sex==2 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (30 1) sheet("`sheet'")
	*total
	putexcel A54="All individuals", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (55 1) sheet("`sheet'")
}	
// Figure 2: Percentage of all persons with severe functional limitations in each age group across the refugee population, including by gender	4
{
	local sheet "F.2"
	local variableofinterest = "disability_severity2"
	local stratifier = "age5yrs"
	local title "`sheet': Percentage of all persons with severe functional limitations in each age group across the refugee population, including by gender"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"
	*male
	putexcel A4="Male individuals", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if sex==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
	*female
	putexcel A29="Female individuals", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if sex==2 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (30 1) sheet("`sheet'")
	*total
	putexcel A54="All individuals", font(Arial, 12) bold		
	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (55 1) sheet("`sheet'")
}	
// Figure 3: Prevalence of severe functional limitations across refugee districts, including by gender	5
{
	local sheet "F.3"
	local variableofinterest = "disability_severity2"
	local stratifier = "district"
	local title "`sheet': Prevalence of severe functional limitations across refugee districts, including by gender"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"

	*male
	putexcel A4="Male individuals", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if sex==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")

	*female
	putexcel A24="Female individuals", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if sex==2 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (25 1) sheet("`sheet'")
	
	*total
	putexcel A44="All individuals", font(Arial, 12) bold		
	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (45 1) sheet("`sheet'")
}	
// Figure 4: Population pyramids for people with severe functional limitations among the refugee and national populations	6
{
	local sheet "F.4"
	local variableofinterest = "sex"
	local stratifier = "age5yrs"
	local title "`sheet': Population pyramids for people with severe functional limitations among the refugee and national populations"
	local source "Source: own calculations using the URVS 2017. Washington Group Short Set of Questions were only applied to individuals aged 5 years and over"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold
	
	di "`title'"

	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(cell ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
// Figure 5: Prevalence of severe functional limitations by time in country and age groups	7
{
	local sheet "F.5"
	local variableofinterest = "yearsincountry"
	local stratifier = "age_broad"
	local title "`sheet': Prevalence of severe functional limitations by time in country and age groups"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	di "`title'"

	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean disabled_100 ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
}
// Figure 6: Distribution of severe functional limitations across different age groups in the population	8
{
	local sheet "F.6"
	local title "`sheet': Disability prevalence: Proportion of all individuals with a functional limitation in each age group"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout seeing hearing walking remembering selfcare communicating age_groups using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(row) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
}
// Figure 7: Proportion of persons with multiple severe functional limitations within each age groups	8
{
	local sheet "F.7"
	local title "`sheet': Proportion of persons with multiple severe functional limitations within each age groups"
	local source "Source: own calculations using the URVS 2017. Note: the corresponding figure in the report shows the distribution of severe functional limitations by type of limitation within each age group which is different from the estimates in this table"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout seeing hearing walking remembering selfcare communicating age_groups using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(row) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
	
	// Note: further manipulation was performed in the workbook to standardise within each age group	
}	
// Figure 8: Household structures for persons with severe functional limitations and no disability	9
{
	local sheet "F.8"
	local variableofinterest = "disabled"
	local stratifier = "hhtype2 hhtype3"
	local title "`sheet': Household structures for persons with severe functional limitations and no disability"
	local source "Source: own calculations using the URVS 2017"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
// Figure 9: Household structures among people with severe functional limitations, disaggregated by gender	10
{
	local sheet "F.9"
	local variableofinterest = "sex"
	local stratifier = "hhtype3"
	local title "`sheet': Household structures among people with severe functional limitations, disaggregated by gender"
	local source "Source: own calculations using the URVS 2017"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
// Figure 10: Percentage of male and female refugees with and without severe functional limitations who are married, across age groups	11
{
	local sheet "F.10"
	local variableofinterest = "disabled"
	local stratifier = "age10yrbroad"
	local title "`sheet': Percentage of male refugees with and without functional limitations who are married, by age groups"
	local source "Source: own calculations using the URVS 2017"
	
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold

	*males
	putexcel A4="Male individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if sex==1 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean married_100 ci) ///
	f(1p) cwidth(15) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")

	*females
	putexcel A19="Female individuals", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if sex==2 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean married_100 ci) ///
	f(1p) cwidth(15) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (20 1) sheet("`sheet'")
}
// Figure 11: Proportion of refugees recognised by UNHCR as having a disability, by district, compared to the proportion with severe functional limitations identified in the URVS	2
{
	local sheet "F.11"
	local variableofinterest = ""
	local stratifier = "district"
	local title "`sheet': Proportion of refugees recognised by UNHCR as having a disability, by district, compared to the proportion with severe functional limitations identified in the URVS"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
 
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold
	tabout `stratifier' disabled if age>=5 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")

	putexcel A23="Persons with profound functional limitations", font(Arial, 12) bold	
	tabout `stratifier' unabletodo if age>=5 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(2p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (24 1) sheet("`sheet'")
}
// Figure 12: Proportion of refugees recognised by UNHCR as having a disability, disaggregated by age and gender, compared to the proportions with severe functional limitations identified in the URVS	3
{
	local sheet "F.12"
	local variableofinterest = "disability_severity"
	local stratifier = "age_unhcr sex"
	local title "`sheet': Proportion of refugees recognised by UNHCR as having a disability, disaggregated by age and gender, compared to the proportions with severe functional limitations identified in the URVS"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if age>=5 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
}
// Figure 13 Proportion of refugees recognised as having different types of functional limitation by UNHCR	4	
	// N/A - external //
// Figure 14: Proportion of people with different types of severe functional limitations who were recognised as EVIs	5
{
	local sheet "F.14"
	local variableofinterest = "evi"
	local stratifier = "seeing hearing walking remembering selfcare communicating"
	local title "`sheet': Proportion of people with different types of severe functional limitations who were recognised as EVIs"
	local source "Source: own calculations using the URVS 2017. Note: thresholds are computed from household per adult equivalent consumption expenditure. Adult equivalents scales are based on those reported in UNHS 2016/17."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold
	
	di "`title'"
	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}	
// Figure 15: Percentage of refugees with and without functional limitations under different poverty lines (based on consumption), pre- and post-transfer	1
	// N/A - external //
// Figure 16: Proportion of different categories of refugees with severe functional limitations living under different poverty lines, pre-transfer	3
{
	local sheet "F.16"
	local variableofinterest = "preae_exp_grp5"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Proportion of different categories of refugees with severe functional limitations living under different poverty lines, pre-transfer"
	local source "Source: own calculations using the URVS 2017. Note: thresholds are computed from household per adult equivalent consumption expenditure. Adult equivalents scales are based on those reported in UNHS 2016/17"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	di "`title'"
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold		
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
// Figure 17: Distribution of consumption from poorest to ‘richest’ refugees with severe functional limitations, both pre- and post-transfer	4
{
	local sheet "F.17"
	local title "`sheet': Distribution of consumption from poorest to ‘richest’ refugees with severe functional limitation, both pre- and post-transfer"
	local source "Source: own calculations using the URVS 2017. Note: values are in nominal UGX."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold	
	putexcel A41="`source'"
	
	tw (line ae_daily_exp ae_cdf_d3 [aw = wgt_per] if ae_daily_exp<=15000 & disability_severity2==3, sort ) ///
	   (line ae_daily_exp_pre ae_pre_cdf_d3 [aw = wgt_per] if ae_daily_exp_pre<=15000 & disability_severity2==3, sort) ///
	   , ylabel(0(2500)15000) xtitle("Cumulative share of refugee population with severe functional limitations (%)") ///
	   ytitle("Daily household per adult equivalent expenditure (UGX)") legend(order(1 "Post-transfer" 2 "Pre-transfer") position(11) ring(0)) ///
	   graphregion(fcolor("242 242 242") lcolor("238 238 238")) plotregion(fcolor("242 242 242"))

	graph save Graph "${path_figures}/aeCDF_preandpost_pop.gph", replace
	graph export "${path_figures}/aeCDF_preandpost_pop.png", as(png) width(500) height(350) replace

	putexcel A5= picture("${path_figures}/aeCDF_preandpost_pop.png")
}
// Figure 18. Percentage of refugee households including a person with a severe functional limitation with no consumption on broad expenditure items	5
	//STILL WORKING ON THIS ONE - DA
{	
	local sheet "F.18"
	local stratifier = "has_disabled"
	local title "`sheet': Percentage of refugee households including a person with a severe functional limitation with no consumption on broad expenditure items"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	di "`title'"
	putexcel A5="Housing", font(Arial, 10) bold
	tabout `stratifier' if head==1  using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean EX1_housing_zero ci) ///
	f(1p) mult(100) cwidth(15) cisep(" - ") h2("housing") h3("Households with disabled members?") ///
	location (6 1) sheet("`sheet'") npos(col) nlab(Observations) /
	
	local x = 11
	local y=2
	foreach var in utilities items transport health clothing kitchenitems  {
	putexcel A`x'="`var'", font(Arial, 10) bold
	local ++x
	tabout `stratifier' if head==1  using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean EX`y'_`var'_zero ci) h2("`var'") h3("Households with disabled members?") ///
	f(1p) mult(100) cwidth(15) cisep(" - ") npos(col) nlab(Observations) ///
	location (`x' 1) sheet("`sheet'")
	local x = `x'+6
	local ++y
	}
	*
	
	putexcel A`x'="Education", font(Arial, 10) bold
	tabout `stratifier' if head==1  using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean EX8_education_zero ci) ///
	f(1p) mult(100) cwidth(15) cisep(" - ") npos(col) nlab(Observations) h2("education")  h3("Households with disabled members?") ///
	fn("`source'") ///
	location (`x' 1) sheet("`sheet'")
}
// Figure 19: Distribution of refugees with severe functional limitations by composite food security index groups
{
	local sheet "F.19"
	local variableofinterest = "FSI_group_ipc"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Distribution of refugees with severe functional limitations by composite food security index groups"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"

	putexcel A4="Individuals", font(Arial, 12) bold
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
// Figure 20: Results of multivariate regressions showing odds ratios of being severely food insecure among people with severe functional limitations	8
	//STILL WORKING ON THIS ONE - DA
{
	local sheet "F.20"
	local title "`sheet': Results of multivariate regressions showing odds ratios of being severely food insecure among people with severe functional limitations"
	local source "Source: own calculations using the URVS 2017. Note: values are in nominal UGX."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold
	putexcel A56="`source'"


logit severelyfoodinsecure i.sex i.yearsincountry i.type_assistance i.hhtype3 i.edu_max prop_adultsemployed /* i.mainsourcecash */ assetindex ///
		i.(sevseeing - sevcommunicating) i.district if disabled ==1 [pw = wgt_per], vce(cluster psu)

label variable assetindex "Asset index"
label variable prop_adultsemployed "Proportion of adults employed"

coefplot, drop(_cons) xline(1) eform base xtitle(Odds ratio) xlabel(0(1)10) xscale(range(0(1)10)) ///
	keep(1.sex 2.sex ///
	1.yearsincountry 2.yearsincountry 3.yearsincountry 4.yearsincountry ///
	1.type_assistance 2.type_assistance 3.type_assistance 4.type_assistance ///
	1.hhtype3 2.hhtype3 3.hhtype3 4.hhtype3 5.hhtype3 6.hhtype3 7.hhtype3 8.hhtype3 ///
	1.edu_max 2.edu_max 3.edu_max 4.edu_max ///
	prop_adultsemployed ///
	/* 1.mainsourcecash 2.mainsourcecash 3.mainsourcecash 4.mainsourcecash 5.mainsourcecash 6.mainsourcecash 7.mainsourcecash 8.mainsourcecash 9.mainsourcecash 10.mainsourcecash */ /// 
	assetindex ///
	1.sevseeing 2.sevseeing ///
	1.sevhearing 2.sevhearing ///
	1.sevwalking 2.sevwalking ///
	1.sevremembering 2.sevremembering ///
	1.sevselfcare 2.sevselfcare ///
	1.sevcommunicating 2.sevcommunicating ///
	) ///
	headings(1.sex = "Sex of head" ///
	1.yearsincountry = "Years in country" ///
	1.type_assistance = "Type of food assistance" ///
	1.nationality = "Nationality of head" ///
	1.hhtype3 = "Household Type" ///
	1.edu_max = "Highest education in household" ///
	/* 1.mainsourcecash = "Main income source" */ ///
	prop_adultsemployed = " " ///
	assetindex = " " ///
	1.sevseeing = "Type of severe difficulty" /// 
	, labcolor(orange))

	graph save Graph "${path_figures}/or_sfi.gph", replace
	graph export "${path_figures}/or_sfi.png", as(png) width(600) height(500) replace

	putexcel A5= picture("${path_figures}/or_sfi.png")
}
// Figure 21: Size of landholdings among refugees with severe functional limitations
{
	*Individual
	local sheet "F.21"
	local variableofinterest = "size_land"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Size of landholdings among refugees with severe functional limitations"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"
	
	putexcel A4="Individuals", font(Arial, 12) bold	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1  using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold	
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
// Figure 22: Livestock ownership of households among refugees with functional limitations by background characteristics
{	
	*Individual
	local sheet "F.22"
	local variableofinterest = "num_animals"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Livestock ownership of households among refugees with functional limitations by background characteristics"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"
	
	putexcel A4="Individuals", font(Arial, 12) bold
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold	
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
// Figure 23: Livestock ownership of households among refugees with severe functional limitation by length of time in country and region
{
	*Individual
	local sheet "F.23"
	local variableofinterest = "num_animals"
	local stratifier = "nationality2 yearsincountry subregion"
	local title "`sheet': Livestock ownership of households among refugees with severe functional limitation by length of time in country and region"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold	

	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")

}	
// Figure 24: Employment status of refugees above 15 years, by severity and type of functional limitation	5
{
	local sheet "F.24"
	local variableofinterest = "labour_force_status2" 
	local stratifier = "disability_severity"
	local title "`sheet': Employment status of refugees above 15 years, by severity and type of functional limitation"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout n_sevdisab `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (21 1) sheet("`sheet'")
}
// Figure 25: Percentage of refugees employed by gender, presence of a severe functional limitation and age group	6
{
	local sheet "F.25"
	local variableofinterest = "disability_severity2" 
	local stratifier = "age_broad"
	local title "`sheet': Percentage of refugees employed by gender, presence of a severe functional limitation and age group"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A3="Individuals", font(Arial, 12) bold
	*male
	putexcel A4="Male individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age_broad!=0 & sex==1 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean employed_100 ci) ///
	f(1p) mult(100) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A17="Female individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age_broad!=0 & sex==2 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean employed_100 ci) ///
	f(1p) mult(100) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (18 1) sheet("`sheet'")
}	
// Figure 26: Percentage of individuals with severe functional limitations employed by time in country and age group	7
{
	local sheet "F.26"
	local variableofinterest = "disability_severity2" 
	local stratifier = "age_broad"
	local title "`sheet': Percentage of individuals with severe functional limitations employed by time in country and age group"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold

	* <2 years
	putexcel A4="Individuals in Uganda for less than two years", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age_broad!=0 & yearsincountry==1 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean employed_100 ci) ///
	f(1p) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")

	* 2-5 years
	putexcel A18="Individuals in Uganda for 2 to 5 years", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age_broad!=0 & yearsincountry==2 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean employed_100 ci) ///
	f(1p) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (19 1) sheet("`sheet'")

	* 6+ years
	putexcel A32="Individuals in Uganda for 6 or more years", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age_broad!=0 & yearsincountry==3 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean employed_100 ci) ///
	f(1p) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (33 1) sheet("`sheet'")
}
// Figure 27: Main sources of income for refugee households with and without members with severe functional limitations	8
{
	*Individual
	local sheet "F.27"
	local variableofinterest = "has_disabled"
	local stratifier = "mainsourcecash"
	local title "`sheet': Main sources of income for households of refugees with and without with severe functional limitations"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if head==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) cisep(" - ") ///
	f(1p) mult(100) npos(row) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 28: Numbers of cash earners in different types of household	8
{
	local sheet "F.28"
	local variableofinterest = "grp_ncashearners"
	local stratifier = "has_disabled"
	local title "`sheet': Numbers of cash earners in different types of household"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if head==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 29: Levels of education among working age people with severe functional limitations and without disabilities	9
{
	local sheet "F.29"
	local variableofinterest = "education"
	local stratifier = "sex age_wabroad hhtype3 n_sevdisab"
	local title "`sheet': Levels of education among working age people with severe functional limitations and without disabilities"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout disabled unabletodo `variableofinterest' if age>=18 & age<=64 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if age>=18 & age<=64 & disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A53="Individuals", font(Arial, 12) bold		
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' if age>=18 & age<=64 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (54 1) sheet("`sheet'")
}
// Figure 30: Percentage of refugee households that can receive support to others by background characteristics	11
{
	local sheet "F.30"
	local variableofinterest = "canreceive_food"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Percentage of refugee households that can receive support to others by background characteristics"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold		
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
// Figure 31: Percentage of refugee households that provides support to others by background characteristics	12
{
	local sheet "F.31"
	local variableofinterest = "give_food"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Percentage of refugee households that provides support to others by background characteristics"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold		
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
// Figure 32: Reasons given for contracting new debt or credit in the six months preceding the URVS	13
{
	local sheet "F.32"
	local variableofinterest = "has_disabled"
	local stratifier = "debt_reason"
	local title "`sheet': Reasons given for contracting new debt or credit in the six months preceding the URVS"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold
	
	di "`title'"
	
	tabout `stratifier' `variableofinterest' if head==1 [aw = wgt_hh] using "${file}", ///
	append style(xlsx) font(bold) svy c(col ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 33: Refugee households with member(s) with severe functional limitations by whether or not they have existing debt/credit or have contracted new debt/credit in the past six months, and by type of assistance	14
{
	local sheet "F.33"
	local variableofinterest = "type_assistance"
	local stratifier = "D1_debt D2_newdebt"
	local title "`sheet': Refugee households with member(s) with severe functional limitations by whether or not they have existing debt/credit or have contracted new debt/credit in the past six months, and by type of assistance"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households with members with severe functional limitations", font(Arial, 12) bold
	
	di "`title'"
	
	tabout `stratifier' `variableofinterest' if head==1 & has_disabled==1 using "${file}", ///
	append style(xlsx) font(bold) svy c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 34: Proportion of refugee households with a person with a severe functional limitation and without a person with a disability that have used coping strategies in the seven days prior to the survey	15
{
	local sheet "F.34"
	local variableofinterest = "has_disabled"
	local stratifier = "CS1_rcopingstratindex CS2_rcopingstratindex CS3_rcopingstratindex CS4_rcopingstratindex CS5_rcopingstratindex"
	local title "`sheet': Proportion of refugee households with a person with a severe functional limitation and without a person with a disability that have used coping strategies in the seven days prior to the survey"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if head==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
}
// Figure 35: Percentage of refugee households that used coping strategies on five or more days during the previous week, by background characteristics	16
{
	local sheet "F.35"
	local variableofinterest = "has_coping5days"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Percentage of refugee households that used coping strategies on five or more days during the previous week, by background characteristics"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold		
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
// Figure 36: Comparison between households including persons with and without severe functional limitations and type and number of coping strategies	17
{
	local sheet "F.36"
	local variableofinterest = "has_disabled"
	local stratifier = "CS1_rcopingstratindex CS2_rcopingstratindex CS3_rcopingstratindex CS4_rcopingstratindex CS5_rcopingstratindex"
	local title "`sheet': Comparison between households including persons with and without severe functional limitations and type and number of coping strategies"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if head==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
}
// Figure 37: Proportion of school age children attending school full-time by age groups and functional limitation severity	4
{
	local sheet "F.37"
	local variableofinterest = "disability_severity2"
	local stratifier = "age5yrs_child"
	local title "`sheet': Proportion of school age children attending school full-time by age groups and functional limitation severity"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Children", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if age5yrs_child!=0 & age>=5 & age<=17  using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean fulltime_ed_100 ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
}
// Figure 38: School attendance of children in households with an adult family member with a severe functional limitation, by background characteristics	6
{	
	local sheet "F.38"
	local variableofinterest = "school_attendance"
	local stratifier = "sex sex_hh age5yrs_child hhtype3 nationality2 yearsincountry subregion has_seeing has_hearing has_walking has_remembering has_selfcare has_communicating"
	local title "`sheet': School attendance of children in households with an adult family member with a severe functional limitation, by background characteristics"
	local source "Source: own calculations using the URVS 2017"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Children in households without child member(s) with severe functional limitations", font(Arial, 12) bold
	tabout has_disabled has_unabletodo `variableofinterest' if age>=5 & age<=17 & disab_child==0 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")	
	
	putexcel A20="Children in households with member(s) with severe functional limitations", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age>=5 & age<=17 & disab_child==0 & has_disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (21 1) sheet("`sheet'")
}
// Figure 39: Percentage of refugee households by housing conditions	9
{
	local sheet "F.39"
	local variableofinterest = "has_disabled"
	local stratifier = "HC6_floor HC7_roof HC8_walls HC2_toilet"
	local title "`sheet': Percentage of refugee households by housing conditions"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold

	di "`title'"

	putexcel A4="Households in Uganda for less than 3 years", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if head==1 & yearsincoutry3==0 using "${file}", ///
	append style(xlsx) font(bold) svy c(col ci) cisep(" - ") ///
	f(1p) mult(100) npos(row) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel I4="Households in Uganda for 3 years and more", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if head==1 & yearsincoutry3==1 using "${file}", ///
	append style(xlsx) font(bold) svy c(col ci) cisep(" - ") ///
	f(1p) mult(100) npos(row) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 9) sheet("`sheet'")

}
// Figure 40: Distribution of refugee households with a member with severe functional limitation by type of food assistance	12
{	
	*Individual
	local sheet "F.40"
	local variableofinterest = "type_assistance"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Distribution of refugees with severe functional limitation by type of food assistance"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	di "`title'"
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
	
	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold		
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
// Figure 41: Refugee households with a member with severe functional limitation excluded from food assistance	13
{
	local sheet "F.41"
	local title "`sheet': Refugees with severe functional limitation excluded from food assistance"
	local source "Source: own calculations using the URVS 2017."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold	
	
	di "`title'"
	
	tabout new_yearsin type_assistance if disabled==1 & yearsincountry<4 using "${file}", ///
	append svy style(xlsx) font(bold) c(cell ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 42: Distribution of refugee households with a member with severe functional limitation by food assistance per capita transfer value groups	14
{
	local sheet "F.42"
	local variableofinterest = "pc_transfer_group"
	local stratifier = "sex age_broad hhtype3 n_sevdisab yearsincountry"
	local title "`sheet': Distribution of refugees with severe functional limitation by food assistance per capita transfer value groups"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	di "`title'"
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
	
	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A62="Individuals", font(Arial, 12) bold
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (63 1) sheet("`sheet'")
}
// Figure 43: Distribution of refugee households with a member with severe functional limitation by food assistance transfer value groups and type of assistance	15
{
	local sheet "F.43"
	local variableofinterest = "pc_transfer_group"
	local stratifier = "sex age_broad hhtype3 n_sevdisab yearsincountry"
	local title "`sheet': Distribution of refugees with severe functional limitation by food assistance transfer value groups and type of assistance"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"
	
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout type_assistance `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 44: Distribution of per capita food assistance amounts – cash and food – received by refugees with and without severe functional limitations who have been in Uganda for less than two years, during the latest distribution 	16
{
	local sheet "F.44"
	local title "`sheet': Distribution of per capita food assistance amounts – cash and food – received by refugees with and without severe functional limitations who have been in Uganda for less than two years, during the latest distribution"
	local source "Source: own calculations using the URVS 2017."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	putexcel A56="`source'"
	
	twoway (hist pc_transfer_newarrival [fw = fw] if disabled==1, start(0) width(10) percent color(navy)) ///
	(hist pc_transfer_newarrival [fw = fw] if disabled==0, start(0) width(10) percent fcolor(none) lcolor(red)) ///
	, legend(order(1 "With severe functional limitation" 2 "Without severe functional limitations" ) ring(0) pos(11)) ///
	graphregion(fcolor("242 242 242") lcolor("238 238 238")) plotregion(fcolor("242 242 242")) ///
	xtitle("Amount of food assistance as a proportion of full food assistance (%)") ///
	ytitle(Percentage of refugees)
	
	graph save Graph "${path_figures}/food_assistance_amount2.gph", replace
	graph export "${path_figures}/food_assistance_amount2.png", as(png) width(600) height(500) replace

	putexcel A5= picture("${path_figures}/food_assistance_amount2.png")
}
// Figure 45: Distribution of refugee households with a member with severe functional limitation in country for at least 2 years by EVI/H food assistance and vulnerability status of household (based on meeting WFP’s EVI/H criteria)	17
{
	local sheet "F.45"
	local variableofinterest = "EVH"
	local title "`sheet': Distribution of refugee households with a member with severe functional limitation in country for at least 2 years by EVI/H food assistance and vulnerability status of household (based on meeting WFP’s EVI/H criteria"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"
	
	putexcel A4="Households with member(s) with severe functional limitations", font(Arial, 12) bold	
	tabout EVIamount `variableofinterest' if has_disabled==1 & head==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 46: Proportion of refugee households with a member with severe functional limitation in country for at least 2 years by categories of WFP’s vulnerability criteria that should be receiving EVI/H food	17
{	
	local sheet "F.46"
	local variableofinterest = "EVIamount"
	local stratifier = "EVH_singleparent EVH_olderperson EVH_disabled"
	local title "`sheet': Proportion of refugees with severe functional limitation(s) in country for at least 2 years by categories of WFP’s vulnerability criteria in households that should be receiving EVI/H food"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"

	putexcel A4="Persons with severe functional limitations in Uganda for at least 2 years", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if disabled==1 & yearsincountry2__1==0 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (40 1) sheet("`sheet'")
}
// Figure 47. Percentage of refugees living in households with no expenditure on transportation by severity of functional limitation and type of severe difficulty	21
{
	local sheet "F.47"
	local stratifier = "disability_severity seeing hearing walking remembering selfcare communicating"
	local title "`sheet': Percentage of refugees living in households with no expenditure on transportation by severity of functional limitation and type of severe difficulty"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold

	di "`title'"

	tabout `stratifier' [aw = wgt_per] using "${file}", ///
	append style(xlsx) font(bold) svy oneway sum c(mean EX4_transport_zero ci) ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15)  cisep(" - ") ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")	
}	
// Figure 48: Among those spending on transport, the proportions of households with and without severe functional limitations spending different amounts in previous 30 days	21
{	
	local sheet "F.48"
	local variableofinterest = "transpor_exp"
	local title "`sheet': Among those spending on transport, the proportions of households with and without severe functional limitations spending different amounts in previous 30 days"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold
	
	di "`title'"
	
	tabout has_disabled `variableofinterest' if head==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 49: Amount spent on transport in previous 30 days by households including a member with a severe functional limitation, disaggregated by type of transfer	22
{
	local sheet "F.49"
	local variableofinterest = "transpor_exp"
	local title "`sheet': Amount spent on transport in previous 30 days by households including a member with a severe functional limitation, disaggregated by type of transfer"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households with member(s) with severe functional limitations", font(Arial, 12) bold
	
	di "`title'"
	
	tabout type_assistance `variableofinterest' if head==1 & has_disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 50: Proportion of different categories of refugees with severe functional limitations living under different poverty lines, post-transfer	10
{
	local sheet "F.50"
	local variableofinterest = "ae_exp_grp5"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Proportion of different categories of refugees with severe functional limitations living under different poverty lines, post-transfer"
	local source "Source: own calculations using the URVS 2017. Note: thresholds are computed from household per adult equivalent consumption expenditure. Adult equivalents scales are based on those reported in UNHS 2016/17."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A2="`subtitle'", font(Arial, 14) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	di "`title'"
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
	
	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	putexcel A54="Individuals", font(Arial, 12) bold	
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
}
* Figures 51-54 are all in the same loop below

// Figure 51: Distribution of refugee households with a member with severe functional limitation by Food Consumption Score (FCS) groups, 2017	10
// Figure 52: Distribution of refugee households with a member with severe functional limitation by Dietary Diversity Score (DDS) groups, 2017	12
// Figure 53: Distribution of refugee households with a member with severe functional limitation by Reduced Coping Strategy Index (rCSI) groups, 2017	13
// Figure 54: Distribution of refugee households with a member with severe functional limitation by Food Insecurity Expenditure Scale (FIES) groups, 2017	14
{
local x = 51

local labelfcs_group "food consumption score groups"
local labeldietdiversity_group "dietary diversity score groups"
local labelrcsi_group "reduced coping strategy index (rCSI) groups"
local labelfies_group "Food Insecurity Experience Scale groups"

local title51 "Distribution of refugees with severe functional limitation by Food Consumption Score (FCS) groups, 2017"
local title52 "Distribution of refugees with severe functional limitation by Dietary Diversity Score (DDS) groups, 2017"
local title53 "Distribution of refugees with severe functional limitation by Reduced Coping Strategy Index (rCSI) groups, 2017"
local title54 "Distribution of refugees with severe functional limitation by Food Insecurity Expenditure Scale (FIES) groups, 2017"

foreach g in fcs_group dietdiversity_group rcsi_group fies_group {
	local sheet "F.`x'"
	local variableofinterest = "`g'"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': `title`x''"
	local source "Source: own calculations using the URVS 2017"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	di "`title'"
	
	tabout disabled unabletodo `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
	
	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if disabled==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")
	
	putexcel A54="Individuals", font(Arial, 12) bold
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")
	
local ++x
}
}
*

// Table 1: Proportion of refugee population with a disability and proportion of households that include at least one person with a disability

*Taken from the URVS report

// Table 2: Disability prevalence levels across functional domains

*Taken from the URVS report

// Table 3: Education levels of persons with and without severe functional limitations among the national population, by sex

*Taken from the DHS dataset on ad-hoc basis

// Table 4: EVI/H criteria for WFP assistance

*Taken from the URVS report

