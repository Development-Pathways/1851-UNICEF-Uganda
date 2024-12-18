**Uganda disability SitAn

*UCLDS 2019 (tables and figures)
use "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/dta/listing.dta", clear
*global file "${path_tables}/output_demographics"
global file "~/Development Pathways Ltd/ESP 2019 (WFP) - DP 1294 - Disability/Research/quantitative/primary analysis/workbook/output_uclds_demogr.xlsx"
cap erase "${file}"

** merge with weights
merge n:1 hhid using "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/dta/weights_v0.dta", nogenerate

drop if ssu_wgt==.

** set survey design
svyset psu [pweight=ssu_wgt], strata(psu_strata) singleunit(certainty) || ssu

////// INDIVIDUALS //////

*Population pyramid tables
	local sheet "population_pyramid"
	local variableofinterest = " sex"
	local stratifier = "age5yrs"
	local title "`sheet': Population pyramids"
	local subtitle "Persons with and without disabilities"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(cel ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A2="`subtitle'", font(Arial, 14) bold
	putexcel A4="Individuals (with disabilities)", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==0 using "${file}", ///
	append svy style(xlsx) font(bold) c(cel ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (36 1) sheet("`sheet'")

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A35="Individuals (without disabilites)", font(Arial, 12) bold

*Prevalence  
	local sheet "prevalence"
	local variableofinterest = " FunctionalDifficulty"
	local stratifier = " sex age5yrs urban"
	local title "`sheet': Disability prevalence"
	local subtitle "Disability prevelance of individuals aged 2 years and above by 5 year age groups, sex and residency"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"

	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A2="`subtitle'", font(Arial, 14) bold
	putexcel A4="Individuals", font(Arial, 12) bold

	
* Marital status
	local sheet "marital_status"
	local variableofinterest = " marital_status"
	local stratifier = "sex age_groups urban"
	local title "`sheet': Marital status"
	local subtitle "Marital status of persons with and persons without disabilities by sex and 5 year age groups"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1  using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A2="`subtitle'", font(Arial, 14) bold
	putexcel A4="Individuals (with disabilities)", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if marital_status<=2 & FunctionalDifficulty==0 using "${file}", ///
	append style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (36 1) sheet("`sheet'")

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A35="Individuals (without disabilites)", font(Arial, 12) bold
	
*Disability type 
		//children 2-4 years
		
		//children 5-17 years
		
	local sheet "Type adult"
	local title "Type of functional limitation"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout wgss_walking wgss_selfcare wgss_seeing wgss_remembering wgss_hearing wgss_communic urban using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(row) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
	
////// HOUSEHOLDS //////
*Living arrangements
	local sheet "living_arrangement"
	local variableofinterest = " hh_disab"
	local stratifier = "hhtype3"
	local title "`sheet': Living arrangements"
	local subtitle "Living arrangements of households with member(s) with at least a lot of difficulty in at least one functional domain"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"

	tabout `stratifier' `variableofinterest' if relation using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A2="`subtitle'", font(Arial, 14) bold
	putexcel A4="Households", font(Arial, 12) bold
	
*Hosuehold size
	local sheet "household_size"
	local variableofinterest = " hh_disab"
	local stratifier = "sex age5yrs"
	local title "`sheet': Household size"
	local subtitle "Average household size of households with member(s) with at least a lot of difficulty in at least one functional domain by sex and age of household head"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"

	tabout `stratifier' `variableofinterest' if relation using "${file}", ///
	append svy style(xlsx) font(bold) c(mean hhsize ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A2="`subtitle'", font(Arial, 14) bold
	putexcel A4="Households", font(Arial, 12) bold	
	
*Dependency ratio	
	local sheet "dependency_ratio"
	local variableofinterest = " hh_disab"
	local stratifier = "sex age5yrs"
	local title "`sheet': Dependency ratio"
	local subtitle "Average household dependency ratios for households with member(s) with at least a lot of difficulty in at least one functional domain by sex and age of household head"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"

	tabout `stratifier' `variableofinterest' if relation using "${file}", ///
	append svy style(xlsx) font(bold) c(mean depratio ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A2="`subtitle'", font(Arial, 14) bold
	putexcel A4="Households", font(Arial, 12) bold	
