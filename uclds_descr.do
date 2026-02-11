
do "~/Documents/GitHub/1851-UNICEF-Uganda/DISABILITY_2024.do"
* do "~/Documents/GitHub/1851-UNICEF-Uganda/SitAn/diloa/finalfigures_uclds_data.do"
*do "~/Documents/GitHub/1851-UNICEF-Uganda/SitAn/diloa/excost2.do"

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

winsor2 pc_exp, cuts(1 99)

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

**# Bookmark #3
tabstat poor_2019 [aw=wgt2], by(Region)
tabstat FunctionalDifficulty dislevel_sevmod if age<18 [aw=wgt1], by(Region)
tabstat dislevel_3 dislevel_4 dislevel_sevmod if age<18 [aw=wgt1], by(age)

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

*** 20/02 ***

egen has_modsev = max(dislevel_sevmod), by(hhid)
replace has_modsev=0 if missing(has_modsev)

gen single = (marital_status==3|marital_status==4|marital_status==5) if !missing(marital_status)
gen single_head = (relation==1 & single==1)
egen has_single_head = max(single_head), by(hhid)

gen female_head = (relation==1 & sex==2)
egen has_female_head = max(female_head), by(hhid)

gen minor_head = (relation==1 & age<18)
egen has_minor_head = max(minor_head), by(hhid)

egen has_wa = max(age>=18 & age<60), by(hhid)
gen has_skipgen = (has_child==1 & has_elder==1 & has_wa==0)

tabstat has_single_head has_female_head has_minor_head has_skipgen [aw=wgt1] if relation==1, by(has_modsev)

tab has_modsev has_female_head if relation==1 [aw=wgt1], row nofreq

foreach var of varlist has_single_head has_female_head has_minor_head has_skipgen {
	tab `var' has_modsev if relation==1
	tabstat hh_income_wk_month hh_income_pck if relation==1 & has_modsev==1 [aw=wgt2], by(`var')
}

gen cpi2019 = 107.612
gen cpi2025 = 137.904

replace hh_income_wk_month = hh_income_wk_month * cpi2025/cpi2019
gen hh_income_pc_2025 = hh_income_wk_month/hhsize

foreach var of varlist has_single_head has_female_head has_minor_head has_skipgen {
	tabstat hh_income_wk_month hh_income_pc_2025 if relation==1 & has_modsev==1 [aw=wgt2], by(`var')
}

** 7/03/2025

replace has_passistance = . if has_passistance==.a

global binary has_passistance need_passistance has_adevice has_passistance_hh passistance1_paid has_passistance2 passistance2_paid has_passistance_ext passistance_ext_paid adevice_mobil no_adevice_mobil adevice_hear no_adevice_hear adevice_see no_adevice_see adevice_cognit no_adevice_cognit home_modifications no_home_mod community_mod no_community_mod school_mod no_school_mod

foreach var of varlist $binary {
	replace `var' = 2-`var' // convert yes/no from 1/2 to 1/0
}

estpost sum has_passistance-no_school_modneed__98 [aw=wgt1] if age<18
esttab using "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/assist.csv", cells("count mean sd min max") replace
describe has_passistance-no_school_modneed__98

tab passitance1_relsh if age<18 [aw=wgt1], sort
tab passistance2_relsh if age<18 [aw=wgt1], sort
tab passistance_ext_relsh if age<18 [aw=wgt1], sort

tabstat $binary [aw=wgt1] if age>1 & age<18, by(age)
describe $binary
foreach var of varlist $binary {
	label var `var' ""
}
table () (age) if age>1 & age<18 [aw=wgt1], statistic(prop $binary )

tabstat $binary [aw=wgt1] if age>1 & age<18, by(SSHD_2to17)
table () (SSHD_2to17) if age>1 & age<18 [aw=wgt1], statistic(prop $binary )

tab SSHD_2to4 [aw=wgt1] if SSHD_2to4>2
tab SSHD_5to17 [aw=wgt1] if SSHD_5to17>2

** 13/03 

tab1 passistance1_paid passistance2_paid passistance_ext_paid

gen pass1pay = passistance1_value // monthly
replace pass1pay = pass1pay/3 if passistance1_paid_freq==4 // every three months

gen pass2pay = passistance2_value if passistance2_value!=98 // monthly

gen pass3pay = passistance_ext_value // monthly
replace pass3pay = pass3pay/3 if passistance_ext_paid_freq==4 // every three months
replace pass3pay = pass3pay*365/12 if passistance_ext_paid_freq==1 // per day
replace pass3pay = . if pass3pay==98

br pass*pay if passistance1_paid==1 | passistance2_paid==1 | passistance_ext_paid==1

egen passpay = rowtotal(pass*pay)
replace passpay = . if passpay==98 | passpay==0

egen passpay12 = rowtotal(pass1pay pass2pay)
replace passpay12 = . if passpay12==98 | passpay12==0

su passpay passpay12 pass3pay [aw=wgt2]

su educ_exp_total_hh [aw=wgt2] if (educ_attend==3 | educ_attend_lastyear==1)
su educ_exp_total_hh [aw=wgt2] if (educ_attend==3 | educ_attend_lastyear==1) & hh_disab_child==0
su educ_exp_total_hh [aw=wgt2] if (educ_attend==3 | educ_attend_lastyear==1) & hh_disab_child==1

su health_exp_total_hh [aw=wgt2] if suffered_illness==1
su health_exp_total_hh [aw=wgt2] if suffered_illness==1 & hh_disab_child==0
su health_exp_total_hh [aw=wgt2] if suffered_illness==1 & hh_disab_child==1

* 2/07

tabstat dislevel_4 [aw=wgt1] if age>=6 & age<=17 , by(age)
tab age dislevel_4 if age>=6 & age<=17 // 147 obs

tab dislevel_4 has_passistance if age>=6 & age<=17, miss
tab dislevel_4 need_passistance if age>=6 & age<=17, miss

gen need_care = (has_passistance==1 | need_passistance==1) if !missing(has_passistance)

tab has_passistance need_passistance, miss
tab need_care, miss

tab dislevel_4 need_care if age>=6 & age<=17

tab dislevel_4 need_care if age>=6 & age<=17 [aw=wgt1], row nofreq
tab dislevel_4 if age>=6 & age<=17 [aw=wgt1]

