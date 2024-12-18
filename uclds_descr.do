
* check each household has one head
by hhid, sort: egen head_count = total(relation == 1)
assert head_count == 1

* var for household level stats
*egen hh_lv = tag(hhid)

* income distribution

graph hbox hh_income 
winsor2 hh_income, cuts(0 99)

cumul hh_income_w [aw=wgt1], gen(cdf_income)
replace cdf_income = cdf_income*100

gen hh_income_wk = hh_income_w/1000

twoway	(line hh_income_wk cdf_income if /*cdf_income<=95 &*/ pid==1 [aw=wgt1], sort lcolor("0 57 114")), ///
xtitle("Cumulative percentage of total household income (%)") xtitle(, color("70 70 70")) ///
ytitle("Annual total household income ('000)") ytitle(, color("70 70 70"))

gen hh_income_pc = hh_income/hhsize

graph box hh_income_pc

winsor2 hh_income_pc, cuts(0 99)

cumul hh_income_pc_w [aw=wgt1], gen(cdf_incomepc)
replace cdf_incomepc = cdf_incomepc*100

gen hh_income_pck = hh_income_pc_w/1000

kdensity hh_income_pck if pid==1 [aw=wgt1], lcolor("0 57 114") xtitle("Annual household income per capita ('000)")

twoway	(line hh_income_pck cdf_incomepc if pid==1 [aw=wgt1], sort lcolor("0 57 114")), ///
xtitle("Cumulative percentage of per capita income (%)") xtitle(, color("70 70 70")) ///
ytitle("Annual household income per capita ('000)") ytitle(, color("70 70 70"))

* household income by impairment

foreach var of varlist Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 FunctionalDifficulty_2to4 Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty_5to17 {
	table (`var') () if age>=2 & age<18 [aw=wgt1], statistic(mean hh_income_wk) nototals name (`var')
}

collect combine all = Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 FunctionalDifficulty_2to4 Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty_5to17

collect layout (Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 FunctionalDifficulty_2to4 Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty_5to17) (var#result)

* consumption distribution 

graph box pc_exp

winsor2 pc_exp, cuts(0 99)

cumul pc_exp_w [aw=wgt1], gen(cdf_exp_w)
replace cdf_exp_w = cdf_exp_w*100

gen pc_exp_wk = pc_exp_w/1000

kdensity pc_exp_wk if pid==1 [aw=wgt1], lcolor("0 57 114") xtitle("Annual household income per capita ('000)")

twoway	(line pc_exp_wk cdf_exp_w if pid==1 [aw=wgt1], sort lcolor("0 57 114")), ///
xtitle("Cumulative percentage of per capita expenditure (%)") xtitle(, color("70 70 70")) ///
ytitle("Annual household expenditure per capita ('000)") ytitle(, color("70 70 70"))

mean pc_exp if pid==1 [aw=wgt2], over(decile)

* health-related costs

gen health_exp_total_pc = health_exp_total_hh/hhsize

tabstat health_exp_total_hh if age<18 [aw=wgt1] , statistics( mean ) by(SSHD_2to17)
tabstat health_exp_total_pc if age<18 [aw=wgt1] , statistics( mean ) by(SSHD_2to17)

reg health_exp_total_hh FunctionalDifficulty if age<18 [aw=wgt1], robust

table (SSHD_2to17) (), statistic(mean health_exp_total*) nototals

mean health_exp_total /* if suffered_illness==1 */ [aw=wgt1], over(FunctionalDifficulty)
mean health_exp_medicine [aw=wgt1], over(FunctionalDifficulty)
