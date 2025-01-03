*Final figures & tables

global file "${figures}/finalfigures_uclds.xlsx"

global listing "psu [pw=wgt1], strata(strata_psu) fpc(fpc_psu) singleunit(scaled) || ssu, fpc(fpc_ssu)"
global extended "psu [pw=wgt2], strata(strata_psu) fpc(fpc_psu) singleunit(scaled) || ssu, fpc(fpc_ssu) || tsu, strata(strata_tsu) fpc(fpc_tsu)"


** Demographics (D)
{
/*
// Sheet 1: Percentage of persons with severe functional limitations across age groups in the population, including by sex
{
	svyset ${listing}
	
	local sheet "D.1"
	local variableofinterest = "FunctionalDifficulty"
	local stratifier = "disab_5yr_age"
	local title "`sheet': Percentage of persons with severe functional limitations across age groups in the population, including by sex"
	local source "Source: own calculations using the UCLDS 2019"

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
// Sheet 2: Percentage of all persons with severe functional limitations in each age group across the population, including by sex
{
	svyset ${listing}
	
	local sheet "D.2"
	local variableofinterest = "FunctionalDifficulty"
	local stratifier = "disab_5yr_age"
	local title "`sheet': Percentage of all persons with severe functional limitations in each age group across the population, including by sex"
	local source "Source: own calculations using the UCLDS 2019"

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
// Sheet 3: Prevalence of severe functional limitations across regions and area of residence, including by sex
{
	svyset ${listing}
	
	local sheet "D.3"
	local variableofinterest = "FunctionalDifficulty"
	local stratifier = "region urban"
	local title "`sheet': Prevalence of severe functional limitations across regions and area foz, including by sex"
	local source "Source: own calculations using the UCLDS 2019"

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


// Sheet 4: Population pyramids for people with severe functional limitations among the national population
{
	svyset ${listing}
	
	local sheet "D.4"
	local variableofinterest = "sex"
	local stratifier = "age5yrs"
	local title "`sheet': Population pyramids for people with severe functional limitations among the refugee and national populations"
	local source "Source: own calculations using the UCLDS 2019."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold
	
	di "`title'"

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(cell ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}

// Sheet 5: Disability prevalence: Proportion of all individuals with a functional limitation in each age group, including by sex
{
	svyset ${listing}
	
	local sheet "D.5"
	local title "`sheet': Disability prevalence: Proportion of all individuals with a functional limitation in each age group, including by sex"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Children 2 - 4 years", font(Arial, 12) bold
	
	tabout Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 sex using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(row) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
	
	putexcel I4="Children 5 - 17 years", font(Arial, 12) bold
	
	tabout Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 sex using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(row) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 9) sheet("`sheet'")
	
	putexcel Q4="Adults 18+ years", font(Arial, 12) bold
	
	tabout wgss_seeing wgss_hearing wgss_walking wgss_remembering wgss_selfcare wgss_communic sex using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(row) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 17) sheet("`sheet'")
}
// Sheet 6: Household structures for persons with and without severe functional limitations, including by sex
{

	svyset ${listing}

	local sheet "D.6"
	local variableofinterest = "FunctionalDifficulty"
	local stratifier = "hhtype3"
	local title "`sheet': Household structures for persons with and without severe functional limitations, including by sex"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	*male
	putexcel A4="Male individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if sex==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (5 1) sheet("`sheet'")
	*female
	putexcel A24="Female individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if sex==2 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (25 1) sheet("`sheet'")
	*total
	putexcel A44="All individuals", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (45 1) sheet("`sheet'")
	
}
// Sheet 7: Number of children among households with persons with disabilities
{

	svyset ${listing}

	local sheet "D.7"
	local variableofinterest = "hh_disab"
	local stratifier = "nchildren2"
	local title "`sheet': Number of children among households with persons with disabilities"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if pid==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}

// Sheet 8: Female headed households among households with persons with disabilities
{
	svyset ${listing}

	local sheet "D.8"
	local variableofinterest = "hh_disab"
	local stratifier = "age_adults_head urban region"
	local title "`sheet': Percentage of female headed households by disability status and other characteristics"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if pid==1 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean female_head_100 ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
// Sheet 9: Household heads by disability and other characteristics
{
	svyset ${listing}

	local sheet "D.9"
	local variableofinterest = "hh_disab"
	local stratifier = "sex_head age_adults_head urban region"
	local title "`sheet': Household heads by disability and other characteristics"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Adults 18+ years", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if relation==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
// Sheet 10: Percentage of persons with and without severe functional limitations by marital status and background characteristics
{
	local sheet "D.10"
	local variableofinterest = "marital_status"
	local stratifier = "sex age_adults urban region"
	local title "`sheet': Percentage of persons with and without severe functional limitations who are married, across background characteristics"
	local source "Source: own calculations using the UCLDS 2019"
	
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold

	*males
	putexcel A4="Adults with severe functional difficulties", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")

	*females
	putexcel A19="Adults without severe functional difficulties", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==0 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (35 1) sheet("`sheet'")
}
// Sheet 11: Household dependency ratio by household disability status and other household characteristics
{
	svyset ${listing}

	local sheet "D.11"
	local variableofinterest = "hh_disab"
	local stratifier = "sex_head age_adults_head urban region"
	local title "`sheet': Household dependency ratio by household disability status and other household characteristics"
	local source "Note: This is the ratio of the number of household members aged 0 to 15 years and over the age of 65 years to the number of household members aged 16 to 64. Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if pid==1 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean depratio ci) ///
	f(1) cwidth(15) mult(1) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
// Sheet 12: Age of onset of disability by sex and age
{
	svyset ${listing}

	local sheet "D.12"
	local variableofinterest = "funcdiff_onset"
	local stratifier = "sex disab_10yr_age urban region"
	local title "`sheet': Age of onset of disability by sex and age"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
*/
}
** Education (E)
{
/*
// Sheet 13: School Attendance by background characteristic
{
	svyset ${extended}

	local sheet "E.1"
	local variableofinterest = "educ_attend"
	local stratifier = "sex age_broad urban region quints"
	local title "`sheet': School Attendance by background characteristics"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals", font(Arial, 12) bold

	tabout educ_attend FunctionalDifficulty using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A15="Children with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & age<=17 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (16 1) sheet("`sheet'")
	
	putexcel A50="Adults with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & age>=18  using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (51 1) sheet("`sheet'")
}
// Sheet 14: Reason for not attending school
{
	svyset ${extended}

	local sheet "E.2"
	local variableofinterest = "FunctionalDifficulty"
	local stratifier = "notschool_reason"
	local title "`sheet': Reason for not attending school by disability"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A30 ="Children with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' sex if FunctionalDifficulty==1 & age<=17 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (31 1) sheet("`sheet'")
	
		
	putexcel A55 ="Adults with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' sex if FunctionalDifficulty==1 & age>=18 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (56 1) sheet("`sheet'")
}
// Sheet 15: School level of children with severe functional difficulty by age and sex
{
	svyset ${extended}

	local sheet "E.3"
	local variableofinterest = "school_level"
	local stratifier = "age_child5_18"
	local title "`sheet': School level of children with severe functional difficulty by age and sex"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Boys with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & sex==1 & age>=5 & age<=18 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A27 ="Girls with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & sex==2 & age>=5 & age<=18 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (28 1) sheet("`sheet'")
}
// Sheet 16: School management
{
	svyset ${extended}

	local sheet "E.4"
	local variableofinterest = "school_manag"
	local stratifier = "sex age_broad urban region quints"
	local title "`sheet': School Attendance by background characteristics"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals attending school", font(Arial, 12) bold

	tabout school_manag FunctionalDifficulty using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A20="Persons with severe functional difficulties attending school", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (21 1) sheet("`sheet'")
}
*
stop
total educational costs
*/
}

** Perceptions (P)
{
/*
//Sheet 17: Tables on the questions on perceptions of persons without functional limitation on persons with disabilities
{	
	svyset ${extended}

	local sheet "P.1"
	local title "`sheet': Perceptions of disabled persons"
	local stratifier = "sex region"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Adults without functional difficulties", font(Arial, 12) bold

	local x = 5

	foreach g in pwd_intheway pwd_discomfort pwd_needcare pwd_same pwd_productive {
		local variableofinterest = "`g'"
		
		di "`title'"
		
		tabout sex region `variableofinterest' using "${file}", ///
		append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
		f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
		fn("`source'") ///
		location (`x' 1) sheet("`sheet'")
		local x = `x' + 13
}
}
//Sheet 18: Tables on the questions on perceptions of persons without functional limitation on persons with disabilities
{	
	svyset ${extended}

	local sheet "P.2"
	local title "`sheet': Perceptions of disabled persons"
	local stratifier = "sex region"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Adults without functional difficulties", font(Arial, 12) bold

	local x = 5

	foreach g in pwd_prejudice pwd_prevalence2 pwd_fulllife2 {
		local variableofinterest = "`g'"
		
		di "`title'"
		
		tabout sex region `variableofinterest' using "${file}", ///
		append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
		f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
		fn("`source'") ///
		location (`x' 1) sheet("`sheet'")
		local x = `x' + 13
}
}
//Sheet 19: Tables on the questions on perceptions of persons without functional limitation on persons with disabilities
{	
	svyset ${extended}

	local sheet "P.3"
	local title "`sheet': Perceptions of disabled persons"
	local stratifier = "sex region"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Adults without functional difficulties", font(Arial, 12) bold

	local x = 5

	foreach g in pwd_negshops pwd_negfriends pwd_negwork {
		local variableofinterest = "`g'"
		
		di "`title'"
		
		tabout sex region `variableofinterest' using "${file}", ///
		append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
		f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
		fn("`source'") ///
		location (`x' 1) sheet("`sheet'")
		local x = `x' + 13
}
}
	//Sheet 20: Tables on the questions on perceptions of persons without functional limitation on persons with disabilities
{	
	svyset ${extended}

	local sheet "P.4"
	local title "`sheet': Perceptions of disabled persons"
	local stratifier = "sex region"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Adults without functional difficulties", font(Arial, 12) bold

	local x = 5

	foreach g in pwd_neigh_sens pwd_neigh_phys pwd_neigh_learn pwd_sch_sens pwd_sch_phys pwd_sch_learn {
		local variableofinterest = "`g'"
		
		di "`title'"
		
		tabout sex region `variableofinterest' using "${file}", ///
		append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
		f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
		fn("`source'") ///
		location (`x' 1) sheet("`sheet'")
		local x = `x' + 13
}
}
*/
}
** Health (H)
{
/*
// Sheet 21: Suffered illness or injury in the past 30 days
{
	svyset ${extended}

	local sheet "H.1"
	local variableofinterest = "suffered_illness"
	local stratifier = "sex age_broad urban region quints"
	local title "`sheet': Suffered illness or injury in the past 30 days"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals", font(Arial, 12) bold

	tabout suffered_illness FunctionalDifficulty using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A15="Children with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & age<=17 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (16 1) sheet("`sheet'")
	
	putexcel A50="Adults with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & age>=18  using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (51 1) sheet("`sheet'")
}
// Sheet 22: Number of days sufferred from illness or injury in past 30 days
{
	svyset ${extended}

	local sheet "H.2"
	local variableofinterest = "days_suffer_illness2"
	local stratifier = "sex age_broad urban region quints"
	local title "`sheet': Number of days sufferred from illness or injury in past 30 days"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals with illness/injury in past 30 days", font(Arial, 12) bold

	tabout days_suffer_illness2 FunctionalDifficulty using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A20="Persons with severe functional difficulties with illness/injury in past 30 days", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (21 1) sheet("`sheet'")
}
// Sheet 23: Number of days stopped usual activities due to illness/injury in past 30 days
{
	svyset ${extended}

	local sheet "H.3"
	local variableofinterest = "days_nwork_illness2"
	local stratifier = "sex age_broad urban region quints"
	local title "`sheet': Number of days stopped usual activities due to illness/injury in past 30 days"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals with illness/injury in past 30 days", font(Arial, 12) bold

	tabout days_nwork_illness2 FunctionalDifficulty using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A20="Persons with severe functional difficulties with illness/injury in past 30 days", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (21 1) sheet("`sheet'")
}
// Sheet 24: Major symptom of the illness or injury
{
	svyset ${extended}

	local sheet "H.4"
	local variableofinterest = "FunctionalDifficulty"
	local stratifier = "major_sympton1"
	local title "`sheet': Major symptom of the illness or injury"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A38 ="Children with severe functional difficulties with illness/injury in past 30 days", font(Arial, 12) bold

	tabout `stratifier' sex if FunctionalDifficulty==1 & age<=17 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (39 1) sheet("`sheet'")
		
	putexcel A75 ="Adults with severe functional difficulties with illness/injury in past 30 days", font(Arial, 12) bold

	tabout `stratifier' sex if FunctionalDifficulty==1 & age>=18 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (76 1) sheet("`sheet'")
}
// Sheet 25: Was anyone consulted for the major illness or injury?
{
	svyset ${extended}

	local sheet "H.5"
	local variableofinterest = "consult_illness"
	local stratifier = "sex age_broad urban region quints"
	local title "`sheet': Was anyone consulted for the major illness or injury?"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals with illness/injury in past 30 days", font(Arial, 12) bold

	tabout consult_illness FunctionalDifficulty using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A15="Children with severe functional difficulties with illness/injury in past 30 days", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & age<=17 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (16 1) sheet("`sheet'")
	
	putexcel A50="Adults with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & age>=18  using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (51 1) sheet("`sheet'")
}
// Sheet 26: Reason for not consulting anyone
{
	svyset ${extended}

	local sheet "H.6"
	local variableofinterest = "FunctionalDifficulty"
	local stratifier = "reason_noconsult"
	local title "`sheet': Reason for not consulting anyone"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals with illness/injury in past 30 days and did not consult with anyone", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
*/
}
** Assets (A)
{
/*
//Sheet 27: Household assets by disability status
{	
	svyset ${extended}

	local sheet "A.1"
	local title "`sheet': Household assets by disability status"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households with members with servere functional difficulties", font(Arial, 12) bold

	local x = 5

	foreach var of varlist assets_household__1 - assets_bank  {
		local variableofinterest = "`var'"
		
		di "`title'"
		
		tabout hh_disab `variableofinterest' if relation == 1 using "${file}", ///
		append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
		f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
		fn("`source'") ///
		location (`x' 1) sheet("`sheet'")
		local x = `x' + 8
}
}
//Sheet 28: Dwelling type by disability status
{	
	svyset ${extended}

	local sheet "A.2"
	local variableofinterest = "hh_disab"
	local stratifier = "dwelling_type"
	local title "`sheet': Dwelling type by disability status"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if pid==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A25="Households with persons with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' urban if pid==1 & hh_disab==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (26 1) sheet("`sheet'")
}
//Sheet 29: Dwelling rooms by disability status and other household characteristics
{	
	svyset ${extended}

	local sheet "A.3"
	local variableofinterest = "dwelling_rooms2"
	local stratifier = "sex_head age_adults_head urban region"
	local title "`sheet': Dwelling rooms by disability status and other household characteristics"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `variableofinterest' hh_disab if pid==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A15="Households with persons with severe functional difficulties", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if pid==1 & hh_disab==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (16 1) sheet("`sheet'")
}
//Sheets 30 - 35: Housing structure by disability status and other household characteristics
{	
	svyset ${extended}
	
	
	local roof_type_lb "Type of roof"
	local wall_type_lb "Type of wall"
	local floor_type_lb "Type of floor" 
	local drinking_water_lb "Type of drinking water"
	local toilet_facility_lb "Type of toilet facility"
	local cooking_fuel_lb "Type of cooking fuel"
	
	local x = 4

	foreach var of varlist roof_type wall_type floor_type drinking_water toilet_facility cooking_fuel {

	local sheet "A.`x'"
	local variableofinterest = "`var'"
	local stratifier = "hh_disab"
	local title "`sheet': ``var'_lb' by disability status"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `variableofinterest' `stratifier' if pid==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A25="Households with persons with disabilities", font(Arial, 12) bold

	tabout `variableofinterest' urban if hh_disab==1 & pid==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (26 1) sheet("`sheet'")
	
	if "`var'" == "toilet_facility" {
		
		tabout share_toilet `stratifier' if pid==1 using "${file}", ///
		append svy style(xlsx) font(bold) c(col ci) ///
		f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
		fn("`source'") cisep(" - ")   ///
		location (50 1) sheet("`sheet'")
	}
		
		
	local ++x
}
}
*/
}
** Expenditure (X)
{
/*
//Sheet 36: Poverty headcount by different household characteristics and whether linving in households with persons with disabilities
{
	svyset ${extended}
	
	local sheet "X.1"
	local variableofinterest = "hh_disab" 
	local stratifier = "sex age_groups urban region assetindex_quintile"
	local title "`sheet': Poverty headcount by different household characteristics and whether linving in households with persons with disabilities"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold

	putexcel A4="Headcount", font(Arial, 12) bold
	
	tabout `stratifier' `variableofinterest'  using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean poor_2019_100 ci) ///
	f(1) mult(100) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
}
//Sheet 37: Poverty headcount by different household characteristics and whether linving in households with persons with disabilities
{
	svyset ${extended}
	
	local sheet "X.2"
	local variableofinterest = "hh_disab" 
	local stratifier = "sex age_groups urban region assetindex_quintile"
	local title "`sheet': Poverty headcount by different household characteristics and whether linving in households with persons with disabilities"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold

	putexcel A4="Headcount", font(Arial, 12) bold
	
	tabout quints `variableofinterest'  using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
	
	putexcel A25="Persons in households with persons with disabilities", font(Arial, 12) bold
	
	tabout `stratifier' quints if hh_disab==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'")   ///
	location (26 1) sheet("`sheet'")
}
// Sheet 38: Distribution of consumption from poorest to ‘richest’ individuals with severe functional limitation
{
	local sheet "X.3"
	local title "`sheet': Distribution of consumption from poorest to ‘richest’ individuals with severe functional limitation"
	local source "Source: own calculations using the UCLDS 2019. Note: values are in nominal UGX."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold	
	putexcel A41="`source'"
	   
	   tw (line ae_exp_pd cdf_ae_exp_pd [aw = wgt2] if hh_disab==1, sort ) ///
	   , xlabel(0 "0" 0.2 "20" 0.4 "40" 0.6 "60" 0.8 "80" 1 "100") ///
	   ylabel(0 "0" 20000 "20,000" 40000 "40,000" 60000 "60,000") ///
	   xtitle("Cumulative share of population with severe functional limitations (%)") ///
	   ytitle("Daily household per adult equivalent expenditure (UGX)") ///
	   graphregion(fcolor("242 242 242") lcolor("238 238 238")) plotregion(fcolor("242 242 242"))
	   
	graph save Graph "${figures}/aeCDF_pop.gph", replace
	graph export "${figures}/aeCDF_pop.png", as(png) width(500) height(350) replace

	putexcel A5= picture("${figures}/aeCDF_pop.png")
}
*/
}
** Shocks (S)
{
/*
//Sheet 39: Shocks in the past 12 months by household disability status"
{	
	svyset ${extended}

	local sheet "S.1"
	local title "`sheet': Shocks in the past 12 months by household disability status"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	local x = 5

	foreach var of varlist shocks_drought - shocks_other  {
		local variableofinterest = "`var'"
		
		di "`title'"
		
		tabout hh_disab `variableofinterest' if pid == 1 using "${file}", ///
		append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
		f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
		fn("`source'") ///
		location (`x' 1) sheet("`sheet'")
		local x = `x' + 8
}
}
//Sheet 40: First ranked shock
{	
	svyset ${extended}

	local sheet "S.2"
	local title "`sheet': Primary shock in the past 12 months by household disability status"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout sh_rank_1 hh_disab if pid == 1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
	
	putexcel A39="Impacts of primary shock", font(Arial, 18) bold
	putexcel A40="Households", font(Arial, 12) bold

	local x = 41

	foreach var of varlist income_sh_1 assets_sh_1 foodprod_sh_1 foodstock_sh_1 foodpurch_sh_1 {
		local variableofinterest = "`var'"
		
		di "`title'"
		
		tabout `variableofinterest' hh_disab if pid == 1 using "${file}", ///
		append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
		f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
		fn("`source'") ///
		location (`x' 1) sheet("`sheet'")
		local x = `x' + 8
	}
	
	putexcel A87="Impacts of primary response", font(Arial, 18) bold
	putexcel A88="Households", font(Arial, 12) bold

	tabout resi1_sh_1 hh_disab if pid == 1 using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (89 1) sheet("`sheet'")

}
*/
}

/*



mat stat= J(1, 3, .)

local if "if pid==1 & hh_disab==1"
foreach var in FCS {
foreach strat of varlist  sex_head age_adults_head region urban quints assetindex_quintile {
tab `strat' `var' `if' [iw = wgt2], matcell(mat1)
tab `strat' `if' & `var'!=. [iw = wgt2], matcell(mattot)
mat mattot = mattot , mattot, mattot
matewd mat1 mattot matper
mat matper = matper*100
mat stat =  stat \ matper \ J(1, 3, .)
}
}
*
tab FCS [aw = wgt2] `if', matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[1..., 1] ), (matper[1,2] \ stat[1..., 2] ), (matper[1,3] \ stat[1..., 3])




mat stat= J(1, 3, .)

local if "if pid==1 & hh_disab==1"
foreach var in dietdiversity_group {
foreach strat of varlist  sex_head age_adults_head region urban quints assetindex_quintile {
tab `strat' `var' `if' [iw = wgt2], matcell(mat1)
tab `strat' `if' & `var'!=. [iw = wgt2], matcell(mattot)
mat mattot = mattot , mattot, mattot
matewd mat1 mattot matper
mat matper = matper*100
mat stat =  stat \ matper \ J(1, 3, .)
}
}
*
tab dietdiversity_group [aw = wgt2] `if', matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[1..., 1] ), (matper[1,2] \ stat[1..., 2] ), (matper[1,3] \ stat[1..., 3])

mat stat= J(1, 4, .)

local if "if pid==1 & hh_disab==1"
foreach var in foodshare_group {
foreach strat of varlist  sex_head age_adults_head region urban quints assetindex_quintile {
tab `strat' `var' `if' [iw = wgt2], matcell(mat1)
tab `strat' `if' & `var'!=. [iw = wgt2], matcell(mattot)
mat mattot = mattot , mattot, mattot, mattot
matewd mat1 mattot matper
mat matper = matper*100
mat stat =  stat \ matper \ J(1, 4, .)
}
}
*
tab foodshare_group [aw = wgt2] `if', matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[1..., 1] ), (matper[1,2] \ stat[1..., 2] ), (matper[1,3] \ stat[1..., 3]), (matper[1,4] \ stat[1..., 4])


	putexcel A17="Female individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age_broad!=0 & sex==2 & ever_work==1 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean employed_100 ci) ///
	f(1p) mult(100) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (18 1) sheet("`sheet'")


	local variableofinterest = "sex"
	local stratifier = "sex age_broad urban region quints"
	local title "`sheet': School Attendance by background characteristics"
	local source "Source: own calculations using the UCLDS 2019"
	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Individuals attending school", font(Arial, 12) bold

	tabout school_manag FunctionalDifficulty using "${file}", ///
	append svy style(xlsx) font(bold) c(col ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A20="Persons with severe functional difficulties attending school", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (21 1) sheet("`sheet'")

// Sheet 11: Proportion of individuals with severe functional limitations living under different poverty lines	3
{
	local sheet "D.11"
	local variableofinterest = "poor_2019"
	local stratifier = "sex_head age_broad hhtype3 n_sevdisab"
	local title "`sheet': Proportion of individuals with severe functional limitations living under different poverty lines"
	local source "Source: own calculations using the UCLDS 2019. Note: thresholds are computed from household per adult equivalent consumption expenditure. Adult equivalents scales are based on those reported in UNHS 2016/17"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	di "`title'"
	
	tabout FunctionalDifficulty `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

	putexcel A20="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

}


stop




// Figure 18. Percentage of refugee households including a person with a severe functional limitation with no consumption on broad expenditure items	5
	//STILL WORKING ON THIS ONE - DA
{	
	/*local sheet "F.18"
	local stratifier = "has_disabled"
	local title "`sheet': Percentage of refugee households including a person with a severe functional limitation with no consumption on broad expenditure items"
	local source "Source: own calculations using the UCLDS 2019"

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
	*/
}

// Figure 19: Distribution of persons with severe functional limitations by Food Consumption Score (FCS) of household
{
	local sheet "F.19"
	local variableofinterest = "FCS"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Distribution of persons with severe functional limitations by Food Consumption Score (FCS)"
	local source "Source: own calculations using the UCLDS 2019"

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
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (21 1) sheet("`sheet'")

	/*putexcel A54="Individuals", font(Arial, 12) bold
	tabout seeing hearing walking remembering selfcare communicating `variableofinterest' using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (55 1) sheet("`sheet'")*/
}
// Figure 20: Results of multivariate regressions showing odds ratios of being severely food insecure among people with severe functional limitations	8
	//STILL WORKING ON THIS ONE - DA
{
	local sheet "F.20"
	local title "`sheet': Results of multivariate regressions showing odds ratios of being severely food insecure among people with severe functional limitations"
	local source "Source: own calculations using the UCLDS 2019. Note: values are in nominal UGX."

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
	local variableofinterest = "land_agri_acres"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Size of landholdings among individuals with severe functional limitations"
	local source "Source: own calculations using the UCLDS 2019"

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
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1  using "${file}", ///
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
	local stratifier = "sex age_broad hhtype3 n_sevdisab region"
	local title "`sheet': Livestock ownership of households among individuals with functional limitations by background characteristics"
	local source "Source: own calculations using the UCLDS 2019"

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
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
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
// Figure 24: Employment status of refugees above 15 years, by severity and type of functional limitation	5
{
	svy ${extended}
	local sheet "F.24"
	local variableofinterest = "work_situation" 
	local stratifier = "FunctionalDifficulty"
	local title "`sheet': Employment status of individuals above 15 years, by severity and type of functional limitation"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Individuals", font(Arial, 12) bold
	
	tabout `stratifier' `variableofinterest' using "${file}", ///
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
// Figure 25: Percentage employed by gender, presence of a severe functional limitation and age group	6
{

	svy ${listing}
	local sheet "F.25"
	local variableofinterest = "FunctionalDifficulty" 
	local stratifier = "age_broad"
	local title "`sheet': Percentage employed by gender, presence of a severe functional limitation and age group"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A3="Individuals", font(Arial, 12) bold
	*male
	putexcel A4="Male individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age_broad!=0 & sex==1 & ever_work==1  using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean employed_100 ci) ///
	f(1p) mult(100) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")
	
	putexcel A17="Female individuals", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age_broad!=0 & sex==2 & ever_work==1 using "${file}", ///
	append svy style(xlsx) font(bold) sum c(mean employed_100 ci) ///
	f(1p) mult(100) cwidth(15) ///
	fn("`source'") cisep(" - ")   ///
	location (18 1) sheet("`sheet'")
}	

// Figure 27: Share of household income coming from non-work for households with and without members with severe functional limitations"
{
	*Individual
	local sheet "F.27"
	local variableofinterest = "hh_disab"
	local stratifier = "sex "
	local title "`sheet': Share of household income coming from non-work for households with and without members with severe functional limitations"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households", font(Arial, 12) bold

	tabout `stratifier' `variableofinterest' if pid==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(mean share_nwork_100 ci) cisep(" - ") ///
	f(1p) mult(100) npos(row) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 28: Numbers of cash earners in different types of household	8 ///NEEDS EDIT
{
	local sheet "F.28"
	local variableofinterest = ""
	local stratifier = "has_disabled"
	local title "`sheet': Numbers of cash earners in different types of household"
	local source "Source: own calculations using the UCLDS 2019"

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
	local variableofinterest = "highest_grade"
	local stratifier = "sex age_wabroad hhtype3 n_sevdisab"
	local title "`sheet': Levels of education among working age people with severe functional limitations and without disabilities"
	local source "Source: own calculations using the UCLDS 2019"

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
	tabout `stratifier' `variableofinterest' if age>=18 & age<=64 & FunctionalDifficulty==1 using "${file}", ///
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

// Figure 37: Proportion of school age children attending school full-time by age groups and functional limitation severity	4
{
	local sheet "F.37"
	local variableofinterest = "FunctionalDifficulty"
	local stratifier = "age5yrs_child"
	local title "`sheet': Proportion of school age children attending school full-time by age groups and functional limitation severity"
	local source "Source: own calculations using the UCLDS 2019"

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
	local variableofinterest = "educ_attend"
	local stratifier = "sex sex_hh age5yrs_child hhtype3 region has_seeing has_hearing has_walking has_remembering has_selfcare has_communicating"
	local title "`sheet': School attendance of children in households with an adult family member with a severe functional limitation, by background characteristics"
	local source "Source: own calculations using the UCLDS 2019"

	di "`title'"
	
	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	putexcel A4="Children in households without member(s) with severe functional limitations", font(Arial, 12) bold
	tabout has_disabled has_unabletodo `variableofinterest' if age>=2 & age<=17 & hh_disab_child==0 & hh_disab==0 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")   ///
	location (5 1) sheet("`sheet'")	
	
	putexcel A20="Children in households with member(s) with severe functional limitations", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if age>=2 & age<=17 & hh_disab_child==0 & hh_disab==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) ///
	f(1p) cwidth(15) mult(100) npos(col) nlab(Observations) ///
	fn("`source'") cisep(" - ")  ///
	location (21 1) sheet("`sheet'")
}
// Figure 39: Percentage of refugee households by housing conditions	9
{
	local sheet "F.39"
	local variableofinterest = "hh_disab"
	local stratifier = "dwelling_type roof_type wall_type floor_type drinking_water toilet_facility share_toilet"
	local title "`sheet': Percentage of households by housing conditions"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold

	di "`title'"

	putexcel A4="Households", font(Arial, 12) bold
	tabout `stratifier' `variableofinterest' if pid==1 using "${file}", ///
	append style(xlsx) font(bold) svy c(col ci) cisep(" - ") ///
	f(1p) mult(100) npos(row) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")

}
// Figure 40: Distribution of refugee households with a member with severe functional limitation by type of food assistance	12 ///NEEDS EDIT
{	
	*Individual
	local sheet "F.40"
	local variableofinterest = "type_assistance"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Distribution of refugees with severe functional limitation by type of food assistance"
	local source "Source: own calculations using the UCLDS 2019"

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
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
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
// Figure 41: Refugee households with a member with severe functional limitation excluded from food assistance	13 ///NEEDS EDIT
{
	local sheet "F.41"
	local title "`sheet': Refugees with severe functional limitation excluded from food assistance"
	local source "Source: own calculations using the UCLDS 2019."

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold	
	
	di "`title'"
	
	tabout new_yearsin type_assistance if FunctionalDifficulty==1 & yearsincountry<4 using "${file}", ///
	append svy style(xlsx) font(bold) c(cell ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 42: Distribution of refugee households with a member with severe functional limitation by food assistance per capita transfer value groups	14 ///NEEDS EDIT
{
	local sheet "F.42"
	local variableofinterest = "pc_transfer_group"
	local stratifier = "sex age_broad hhtype3 n_sevdisab yearsincountry"
	local title "`sheet': Distribution of refugees with severe functional limitation by food assistance per capita transfer value groups"
	local source "Source: own calculations using the UCLDS 2019"

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
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
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
// Figure 43: Distribution of refugee households with a member with severe functional limitation by food assistance transfer value groups and type of assistance	15 ///NEEDS EDIT
{
	local sheet "F.43"
	local variableofinterest = "pc_transfer_group"
	local stratifier = "sex age_broad hhtype3 n_sevdisab yearsincountry"
	local title "`sheet': Distribution of refugees with severe functional limitation by food assistance transfer value groups and type of assistance"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"
	
	putexcel A4="Persons with severe functional limitations", font(Arial, 12) bold	
	tabout type_assistance `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 45: Distribution of refugee households with a member with severe functional limitation in country for at least 2 years by EVI/H food assistance and vulnerability status of household (based on meeting WFP’s EVI/H criteria)	17 ///NEEDS EDIT
{
	local sheet "F.45"
	local variableofinterest = "EVH"
	local title "`sheet': Distribution of refugee households with a member with severe functional limitation in country for at least 2 years by EVI/H food assistance and vulnerability status of household (based on meeting WFP’s EVI/H criteria"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"
	
	putexcel A4="Households with member(s) with severe functional limitations", font(Arial, 12) bold	
	tabout EVIamount `variableofinterest' if has_FunctionalDifficulty==1 & head==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 46: Proportion of refugee households with a member with severe functional limitation in country for at least 2 years by categories of WFP’s vulnerability criteria that should be receiving EVI/H food	17 ///NEEDS EDIT
{	
	local sheet "F.46"
	local variableofinterest = "EVIamount"
	local stratifier = "EVH_singleparent EVH_olderperson EVH_disabled"
	local title "`sheet': Proportion of refugees with severe functional limitation(s) in country for at least 2 years by categories of WFP’s vulnerability criteria in households that should be receiving EVI/H food"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	
	di "`title'"

	putexcel A4="Persons with severe functional limitations in Uganda for at least 2 years", font(Arial, 12) bold	
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 & yearsincountry2__1==0 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (40 1) sheet("`sheet'")
}
// Figure 47. Percentage of refugees living in households with no expenditure on transportation by severity of functional limitation and type of severe difficulty	21 ///NEEDS EDIT
{
	local sheet "F.47"
	local stratifier = "disability_severity seeing hearing walking remembering selfcare communicating"
	local title "`sheet': Percentage of refugees living in households with no expenditure on transportation by severity of functional limitation and type of severe difficulty"
	local source "Source: own calculations using the UCLDS 2019"

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
// Figure 48: Among those spending on transport, the proportions of households with and without severe functional limitations spending different amounts in previous 30 days	21 ///NEEDS EDIT
{	
	local sheet "F.48"
	local variableofinterest = "transpor_exp"
	local title "`sheet': Among those spending on transport, the proportions of households with and without severe functional limitations spending different amounts in previous 30 days"
	local source "Source: own calculations using the UCLDS 2019"

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
// Figure 49: Amount spent on transport in previous 30 days by households including a member with a severe functional limitation, disaggregated by type of transfer	22 ///NEEDS EDIT
{
	local sheet "F.49"
	local variableofinterest = "transpor_exp"
	local title "`sheet': Amount spent on transport in previous 30 days by households including a member with a severe functional limitation, disaggregated by type of transfer"
	local source "Source: own calculations using the UCLDS 2019"

	putexcel set "${file}", sheet("`sheet'") modify
	putexcel A1="`title'", font(Arial, 18) bold
	putexcel A4="Households with member(s) with severe functional limitations", font(Arial, 12) bold
	
	di "`title'"
	
	tabout type_assistance `variableofinterest' if head==1 & has_FunctionalDifficulty==1 using "${file}", ///
	append svy style(xlsx) font(bold) c(row ci) cisep(" - ") ///
	f(1p) mult(100) npos(col) nlab(Observations) cwidth(15) ///
	fn("`source'") ///
	location (5 1) sheet("`sheet'")
}
// Figure 50: Proportion of different categories of refugees with severe functional limitations living under different poverty lines, post-transfer	10 ///NEEDS EDIT
{
	local sheet "F.50"
	local variableofinterest = "ae_exp_grp5"
	local stratifier = "sex age_broad hhtype3 n_sevdisab"
	local title "`sheet': Proportion of different categories of refugees with severe functional limitations living under different poverty lines, post-transfer"
	local source "Source: own calculations using the UCLDS 2019. Note: thresholds are computed from household per adult equivalent consumption expenditure. Adult equivalents scales are based on those reported in UNHS 2016/17."

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
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
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
* Figures 51-54 are all in the same loop below ///NEEDS EDIT

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
	local source "Source: own calculations using the UCLDS 2019"

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
	tabout `stratifier' `variableofinterest' if FunctionalDifficulty==1 using "${file}", ///
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

