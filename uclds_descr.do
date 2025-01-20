
do "~/Documents/GitHub/1851-UNICEF-Uganda/DISABILITY_2024.do"
* do "~/Documents/GitHub/1851-UNICEF-Uganda/SitAn/diloa/finalfigures_uclds_data.do"
do "~/Documents/GitHub/1851-UNICEF-Uganda/SitAn/diloa/excost2.do"

* check each household has one head
by hhid, sort: egen head_count = total(relation == 1)
assert head_count == 1

* var for household level stats
*egen hh_lv = tag(hhid)

* albinism and dwarfism
tab has_dwarfism /*if age<18*/[aw=wgt1]
tab has_albinism /*if age<18*/ [aw=wgt1]

global child2to4 Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4
global child5to17 Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 MakingFriends_5to17 AcceptingChange_5to17 Behaviour_5to17 Anxiety_5to17 Depression_5to17

mean $child2to4 [aw=wgt1]
tab1 $child2to4

mean $child5to17 [aw=wgt1]
tab1 $child5to17

* income distribution

graph hbox hh_income 
winsor2 hh_income, cuts(0 99)

cumul hh_income_w [aw=wgt1], gen(cdf_income)
replace cdf_income = cdf_income*100

gen hh_income_wk = hh_income_w/1000

gen hh_income_wk_month = hh_income_wk/12

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

* household income by impairment (y/n)

foreach var of varlist Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 FunctionalDifficulty_2to4 Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty_5to17 {
	table (`var') () if age>=2 & age<18 [aw=wgt1], statistic(mean hh_income_wk) nototals name (`var')
}

collect combine all = Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 FunctionalDifficulty_2to4 Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty_5to17

collect layout (Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 FunctionalDifficulty_2to4 Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty_5to17) (var#result)

* household income by level of impairment 

foreach var of varlist SEE_IND_2to4 HEAR_IND_2to4 WALK_IND_2to4 MOT_IND_2to4 COM_IND_2to4 LEARN_IND_2to4 PLAY_IND_2to4 BEH_IND_2to4 SSHD_2to4 SEE_IND HEAR_IND WALK_IND1 WALK_IND2 WALK_IND SELF_IND COM_IND LEARN_IND REM_IND CONC_IND ACC_IND BEH_IND FRI_IND ANX_IND DEP_IND SSHD_5to17 {
	table (`var') () if age>=2 & age<18 [aw=wgt1], statistic(mean hh_income_wk) nototals name (`var')
}

collect combine all2 = SEE_IND_2to4 HEAR_IND_2to4 WALK_IND_2to4 MOT_IND_2to4 COM_IND_2to4 LEARN_IND_2to4 PLAY_IND_2to4 BEH_IND_2to4 SSHD_2to4 SEE_IND HEAR_IND WALK_IND1 WALK_IND2 WALK_IND SELF_IND COM_IND LEARN_IND REM_IND CONC_IND ACC_IND BEH_IND FRI_IND ANX_IND DEP_IND SSHD_5to17

collect layout (SEE_IND_2to4 HEAR_IND_2to4 WALK_IND_2to4 MOT_IND_2to4 COM_IND_2to4 LEARN_IND_2to4 PLAY_IND_2to4 BEH_IND_2to4 SSHD_2to4 SEE_IND HEAR_IND WALK_IND1 WALK_IND2 WALK_IND SELF_IND COM_IND LEARN_IND REM_IND CONC_IND ACC_IND BEH_IND FRI_IND ANX_IND DEP_IND SSHD_5to17) (var#result)

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

* poverty

mean poor_2019 [aw=wgt2], over(hh_disab)

foreach var of varlist SEE_IND_2to4 HEAR_IND_2to4 WALK_IND_2to4 MOT_IND_2to4 COM_IND_2to4 LEARN_IND_2to4 PLAY_IND_2to4 BEH_IND_2to4 SSHD_2to4 SEE_IND HEAR_IND WALK_IND1 WALK_IND2 WALK_IND SELF_IND COM_IND LEARN_IND REM_IND CONC_IND ACC_IND BEH_IND FRI_IND ANX_IND DEP_IND SSHD_5to17 {
	table (`var') () if age>=2 & age<18 [aw=wgt1], statistic(mean poor_2019) nototals name (p_`var')
}

collect combine all3 = p_SEE_IND_2to4 p_HEAR_IND_2to4 p_WALK_IND_2to4 p_MOT_IND_2to4 p_COM_IND_2to4 p_LEARN_IND_2to4 p_PLAY_IND_2to4 p_BEH_IND_2to4 p_SSHD_2to4 p_SEE_IND p_HEAR_IND p_WALK_IND1 p_WALK_IND2 p_WALK_IND p_SELF_IND p_COM_IND p_LEARN_IND p_REM_IND p_CONC_IND p_ACC_IND p_BEH_IND p_FRI_IND p_ANX_IND p_DEP_IND p_SSHD_5to17

collect layout (SEE_IND_2to4 HEAR_IND_2to4 WALK_IND_2to4 MOT_IND_2to4 COM_IND_2to4 LEARN_IND_2to4 PLAY_IND_2to4 BEH_IND_2to4 SSHD_2to4 SEE_IND HEAR_IND WALK_IND1 WALK_IND2 WALK_IND SELF_IND COM_IND LEARN_IND REM_IND CONC_IND ACC_IND BEH_IND FRI_IND ANX_IND DEP_IND SSHD_5to17) (var#result)


* health-related costs

gen health_exp_pc = health_exp_total_hh/hhsize

tabstat health_exp_total_hh if age<18 [aw=wgt1] , statistics( mean ) by(SSHD_2to17)
tabstat health_exp_pc if age<18 [aw=wgt1] , statistics( mean ) by(SSHD_2to17)

reg health_exp_total_hh FunctionalDifficulty if age<18 [aw=wgt1], robust

table (SSHD_2to17) (), statistic(mean health_exp_total*) nototals

mean health_exp_total_h  [aw=wgt2], over(FunctionalDifficulty)

mean health_exp_medicine [aw=wgt1], over(FunctionalDifficulty)

* food consumption score

mat A = J(3,1,.)
foreach var in /*Seeing_2to17 Hearing_2to17 Walking_2to17 Communication_2to17 Learning_2to17 Behaviour_2to17  Selfcare_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty severe_child*/ moderate_child {
	svy: tab FCS if `var'==1 & age>=2 & age<18
	mat A = A , e(b)'
}
mat list A

	svy: proportion FCS if FineMotor_2to4==1 & age>=2 & age<18
	svy: proportion FCS if Playing_2to4==1 & age>=2 & age<18

* dietary diversity

tab dietdiversity_group hh_disab [aw=wgt2], col nofreq

mat A = J(3,1,.)
foreach var in $vars {
	svy: tab dietdiversity_group if `var'==1 & age>=2 & age<18
	mat A = A , e(b)'
}
mat list A


* school attendance 

tab educ_attend if age>=5 & age<18 [aw=wgt1]

mat A = J(3,1,.)
foreach var in /*$child5to17*/ moderate_child severe_child {
	svy: tab educ_attend if `var'==1 & age>=5 & age<18
	mat A = A , e(b)'
}
mat list A


* Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 FunctionalDifficulty_2to4 Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty_5to17

*******************************************************************************


foreach imp in Seeing Hearing Walking Communication Learning Behaviour {
	clonevar `imp'_2to17 = `imp'_5to17
	replace `imp'_2to17 = `imp'_2to4 if age<5
}

clonevar severe_child = FunctionalDifficulty if age<18
replace severe_child = 0 if !missing(severe_child) & SSHD_2to17<4

gen moderate_child = (SSHD_2to17==3) if !missing(SSHD_2to17)

global vars Seeing_2to17 Hearing_2to17 Walking_2to17 Communication_2to17 Learning_2to17 Behaviour_2to17 FineMotor_2to4 Playing_2to4 Selfcare_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty severe_child moderate_child

	mat stat = J(1,10,.)
	foreach var in $vars {
	svy: mean health_exp_total_wins if `var'==1 & age<18
	mat stat = stat \ (r(table)', e(N))
	}

	mat stat = stat[2..., 1...]
	mat colnames stat = b se t pvalue ll ul df crit eform N
	mat rownames stat = $vars
mat list stat

**

	mat stat = J(1,10,.)
	foreach var in $vars {
	svy: mean poor_2019 if `var'==1 & age<18
	mat stat = stat \ (r(table)', e(N))
	}

	mat stat = stat[2..., 1...]
	mat colnames stat = b se t pvalue ll ul df crit eform N
	mat rownames stat = $vars
mat list stat

**

	mat stat = J(1,10,.)
	foreach var in $vars {
	svy: mean hh_income_wk_month if `var'==1 & age<18
	mat stat = stat \ (r(table)', e(N))
	}

	mat stat = stat[2..., 1...]
	mat colnames stat = b se t pvalue ll ul df crit eform N
	mat rownames stat = $vars
mat list stat

** educ_total_cost_wins

	mat stat = J(1,10,.)
	foreach var in $child5to17 moderate_child severe_child {
	svy: mean educ_total_cost_wins if `var'==1 & age>=5 & age<18
	mat stat = stat \ (r(table)', e(N))
	}

	mat stat = stat[2..., 1...]
	mat colnames stat = b se t pvalue ll ul df crit eform N
	mat rownames stat = $child5to17 moderate_child severe_child
mat list stat

svy: mean educ_total_cost_wins, over(FunctionalDifficulty_5to17)

** mean_hours_passistance

	mat stat = J(1,10,.)
	foreach var in $child5to17 severe_5to17 moderate_child {
	svy: mean personalassistance if `var'==1 & age>=5 & age<18
	mat stat = stat \ (r(table)', e(N))
	}
	mat stat = stat[2..., 1...]
	mat colnames stat = b se t pvalue ll ul df crit eform N
	mat rownames stat = $child5to17 severe_5to17 moderate_child 
mat list stat

**

	mat stat = J(1,10,.)
	foreach var in $child5to17 severe_5to17 moderate_child  {
	svy: mean mean_hours_passistance if `var'==1 & age>=5 & age<18
	mat stat = stat \ (r(table)', e(N))
	}
	mat stat = stat[2..., 1...]
	mat colnames stat = b se t pvalue ll ul df crit eform N
	mat rownames stat = $child5to17 severe_5to17 moderate_child 
mat list stat
