


** extra cost (goods and services used approach)

*Education
{
**outliers in cost of education

foreach var of varlist educ_cost_schoolfees educ_cost_reg educ_cost_exams educ_cost_boarding educ_cost_uniform educ_cost_supplies educ_cost_transport educ_cost_daycare educ_cost_other {
	gen `var'_temp = `var'
	replace `var' = . if `var'==0
	winsor2 `var', suffix(_wins)
	replace `var'_wins = 0 if `var'_temp==0
	replace `var' = `var'_temp
	drop `var'_temp
	}
	*
egen educ_total_cost_wins = rowtotal(educ_cost_*_wins)
replace educ_total_cost_wins=. if educ_total_cost==.
	
	
gen alotofdifficuly = FunctionalDifficulty==1 & ProfoundDifficulty==0 if FunctionalDifficulty!=.



// Svy settings for analysing data from in-depth questionnaire
svyset psu [pw=wgt2], strata(strata_psu) fpc(fpc_psu) singleunit(scaled) || ssu, fpc(fpc_ssu) || tsu, strata(strata_tsu) fpc(fpc_tsu)


mat stat = J(1,10,.)
foreach var of varlist educ_cost_schoolfees educ_cost_reg educ_cost_exams educ_cost_boarding educ_cost_uniform educ_cost_supplies educ_cost_transport educ_cost_daycare educ_cost_other educ_total_cost {
svy: mean `var'_wins, over(FunctionalDifficulty_5to17)
mat stat = stat \ r(table)' , e(_N)'
reg `var'_wins i.FunctionalDifficulty_5to17 [aw = wgt2], vce(cluster psu)
}
mat list stat


reg educ_total_cost_wins i.FunctionalDifficulty_5to17 [aw = wgt2] if educ_total_cost!=. , vce(cluster psu)

gen ln_educ = log(educ_total_cost_wins+1)
svy: reg ln_educ i.FunctionalDifficulty_5to17 i.sex c.age##c.age i.current_grade i.school_manag i.school_type i.urban i.quints i.region if educ_total_cost>0
reg ln_educ i.ProfoundDifficulty_5to17 i.sex c.age##c.age i.current_grade i.school_manag i.school_type i.urban i.quints i.region if educ_total_cost>0 & alotofdifficuly==0 [aw = wgt2], vce(cluster psu)

gen educ_cost_compl_wins = educ_total_cost_wins - educ_cost_schoolfees_wins


gen ln_educ_compl = log(educ_cost_compl_wins +1 )
reg ln_educ_compl i.FunctionalDifficulty_5to17 i.sex c.age##c.age i.current_grade i.school_manag i.school_type i.urban i.quints i.region [aw = wgt2], vce(cluster psu)
reg ln_educ_compl i.ProfoundDifficulty_5to17 i.sex c.age##c.age i.current_grade i.school_manag i.school_type i.urban i.quints i.region if alotofdifficuly==0 [aw = wgt2], vce(cluster psu)

reg ln_educ_compl i.FunctionalDifficulty_5to17 [aw = wgt2], vce(cluster psu)
reg ln_educ_compl i.ProfoundDifficulty_5to17  if alotofdifficuly==0 [aw = wgt2], vce(cluster psu)

gen disab_level = 0 if FunctionalDifficulty_5to17==0
replace disab_level = 1 if FunctionalDifficulty_5to17==1 & ProfoundDifficulty_5to17==0
replace disab_level = 2 if disab_level==. & ProfoundDifficulty_5to17==1

reg ln_educ_compl i.disab_level i.sex c.age##c.age i.current_grade i.school_manag i.school_type i.urban i.quints i.region [aw = wgt2], vce(cluster psu)
reg ln_educ_compl i.disab_level [aw = wgt2], vce(cluster psu)


mat stat = J(1,10,.)
foreach var in Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 FunctionalDifficulty_5to17 ProfoundDifficulty_5to17 {
svy: mean educ_cost_schoolfees_wins educ_cost_compl_wins educ_total_cost_wins if `var'==1 & educ_total_cost!=.
mat stat = stat \ (r(table)', e(_N)')
}
qui svy: mean educ_cost_schoolfees_wins educ_cost_compl_wins educ_total_cost_wins if FunctionalDifficulty_5to17==0 & educ_total_cost!=.
mat stat = stat \ (r(table)', e(_N)')

mat stat = stat[2..., 1...]
mat colnames stat = b se t pvalue ll ul df crit eform N
mat rownames stat = Seeing Hearing Walking Selfcare Communications Learning Remembering Concentration Accepting Behaviour Friends Anxiety Depresion Disabled cannot NoDisability



gen age_school = age>=5 & age<=12
replace age_school = . if age<5 | age>17
label define age_school 0 "Aged 13-17 yrs" 1 "Aged 5-12 yrs"
label values age_school age_school

svy: mean educ_total_cost_wins if educ_total_cost!=., over(age_school FunctionalDifficulty_5to17)
mat stat = r(table) \ e(_N)
mat stat = stat'
mat list stat

svy: mean educ_total_cost_wins if educ_total_cost!=., over(urban FunctionalDifficulty_5to17)
mat stat = r(table) \ e(_N)
mat stat = stat'
mat list stat

svy: mean educ_total_cost_wins if educ_total_cost!=., over(quints FunctionalDifficulty_5to17)
mat stat = r(table) \ e(_N)
mat stat = stat'
mat list stat

foreach var in educ_cost_schoolfees educ_total_cost educ_cost_compl {
svy: mean `var'_wins if `var'_wins!=., over(FunctionalDifficulty_5to17)
mat stat = r(table) \ e(_N)
mat stat = stat'
mat list stat
reg `var'_wins i.FunctionalDifficulty_5to17 [aw = wgt2], vce(cluster psu)
}


}


*Health
foreach var of varlist health_exp_consult health_exp_medicine health_exp_hospital health_exp_traditional health_exp_transport health_exp_other {
	gen `var'_temp = `var'
	replace `var' = . if `var'==0
	winsor2 `var', suffix(_wins)
	replace `var'_wins = 0 if `var'_temp==0
	replace `var' = `var'_temp
	drop `var'_temp
	}
	*
egen health_exp_total_wins = rowtotal(health_exp_*_wins)
replace health_exp_total_wins=. if health_exp_total==.


// Svy settings for analysing data from in-depth questionnaire
svyset psu [pw=wgt2], strata(strata_psu) fpc(fpc_psu) singleunit(scaled) || ssu, fpc(fpc_ssu) || tsu, strata(strata_tsu) fpc(fpc_tsu)


mat stat = J(1,10,.)
foreach var of varlist health_exp_consult health_exp_medicine health_exp_hospital health_exp_traditional health_exp_transport health_exp_other health_exp_total {
svy: mean `var'_wins, over(FunctionalDifficulty)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist health_exp_consult health_exp_medicine health_exp_hospital health_exp_traditional health_exp_transport health_exp_other health_exp_total {
svy: mean `var'_wins, over(ProfoundDifficulty)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

recode age (2/4 = 1 "Early childhood") (5/17 = 2 "School age") (18/29 = 3 "Youth") (30/59 = 4 "Working age") (60/120 = 5 "Elderly"), gen(lifecycle_age_groups)

mat stat = J(1,10,.)
foreach var of varlist health_exp_total {
svy: mean `var'_wins, over(lifecycle_age_groups FunctionalDifficulty)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist health_exp_total {
svy: mean `var'_wins, over(urban FunctionalDifficulty)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist health_exp_total {
svy: mean `var'_wins, over(quints FunctionalDifficulty)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

replace selfcare = 1 if selfcare==2
replace communicating = 1 if communicating==2

mat stat = J(1,10,.)
foreach var in seeing hearing walking selfcare communicating learning_2to17 remembering_5plus FunctionalDifficulty ProfoundDifficulty {
qui svy: mean health_exp_total_wins if `var'==1 & health_exp_total!=.
mat stat = stat \ (r(table)', e(N))
}
qui svy: mean health_exp_total_wins if FunctionalDifficulty_5to17==0 & health_exp_total!=.
mat stat = stat \ (r(table)', e(N))

mat stat = stat[2..., 1...]
mat colnames stat = b se t pvalue ll ul df crit eform N
mat rownames stat = seeing hearing walking selfcare communicating learning_2to17 remembering_5plus FunctionalDifficulty ProfoundDifficulty NoDisability

gen disab_level2 = 0 if FunctionalDifficulty==0
replace disab_level2 = 1 if FunctionalDifficulty==1 & ProfoundDifficulty==0
replace disab_level2 = 2 if disab_level2==. & ProfoundDifficulty==1

gen ln_health = log(health_exp_total_wins)
svy: reg ln_health i.FunctionalDifficulty i.sex c.age##c.age i.consult_illness i.major_sympton1 i.urban i.quints i.region 
reg ln_health i.FunctionalDifficulty i.sex c.age##c.age i.consult_illness i.major_sympton1 i.urban i.quints i.region  [aw = wgt2], vce(cluster psu)
reg ln_health i.disab_level2 i.sex c.age##c.age i.consult_illness i.major_sympton1 i.urban i.quints i.region  [aw = wgt2], vce(cluster psu)
reg ln_health i.ProfoundDifficulty i.sex c.age##c.age i.consult_illness i.major_sympton1 i.urban i.quints i.region if alotofdifficuly==0 [aw = wgt2], vce(cluster psu)

reg ln_health i.FunctionalDifficulty   [aw = wgt2], vce(cluster psu)
reg ln_health i.disab_level2   [aw = wgt2], vce(cluster psu)
reg ln_health i.ProfoundDifficulty  if alotofdifficuly==0 [aw = wgt2], vce(cluster psu)


*Personal assistance

gen personalassistance = has_passistance ==1 if has_passistance !=. & FunctionalDifficulty==1

mat stat = J(1,10,.)
foreach var of varlist personalassistance {
svy: mean `var', over(sex)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist personalassistance {
svy: mean `var', over(lifecycle_age_groups)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist personalassistance {
svy: mean `var', over(urban)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist personalassistance {
svy: mean `var', over(quints)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var in seeing hearing walking selfcare communicating learning_2to17 remembering_5plus FunctionalDifficulty ProfoundDifficulty {
svy: mean personalassistance if `var'==1
mat stat = stat \ (r(table)', e(N))
}
mat stat = stat[2..., 1...]
mat colnames stat = b se t pvalue ll ul df crit eform N
mat rownames stat = seeing hearing walking selfcare communicating learning_2to17 remembering_5plus FunctionalDifficulty ProfoundDifficulty

gen needpersonalassistance = need_passistance ==1 if need_passistance !=. & FunctionalDifficulty==1

mat stat = J(1,10,.)
foreach var of varlist needpersonalassistance {
svy: mean `var', over(sex)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist needpersonalassistance {
svy: mean `var', over(lifecycle_age_groups)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist needpersonalassistance {
svy: mean `var', over(urban)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist needpersonalassistance {
svy: mean `var', over(quints)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var in remembering_5plus learning_2to17 communicating selfcare walking hearing seeing  ProfoundDifficulty FunctionalDifficulty{
svy: mean needpersonalassistance if `var'==1
mat stat = stat \ (r(table)', e(N))
}
mat stat = stat[2..., 1...]
mat colnames stat = b se t pvalue ll ul df crit eform N
mat rownames stat = remembering_5plus learning_2to17 communicating selfcare walking hearing seeing  ProfoundDifficulty FunctionalDifficultyy

gen passistancefromhh = has_passistance_hh ==1 if has_passistance_hh !=. & FunctionalDifficulty==1 
gen passistancefromext = has_passistance_ext ==1 if has_passistance_ext !=. & FunctionalDifficulty==1

gen passistancefrom = 1 if passistancefromhh==1 & passistancefromext==0
replace passistancefrom = 2 if passistancefromhh==1 & passistancefromext==1
replace passistancefrom = 3 if passistancefromhh==0 & passistancefromext==1
replace passistancefrom = 4 if passistancefromhh==0 & passistancefromext==0

mat stat = J(1,10,.)
svy: proportion passistancefrom, over(sex)
mat stat = stat \ r(table)' , e(_N)'
mat list stat

mat stat = J(1,10,.)
svy: proportion passistancefrom, over(lifecycle_age_groups)
mat stat = stat \ r(table)' , e(_N)'
mat list stat

mat stat = J(1,10,.)
svy: proportion passistancefrom, over(urban)
mat stat = stat \ r(table)' , e(_N)'
mat list stat

mat stat = J(1,10,.)
svy: proportion passistancefrom, over(quints)
mat stat = stat \ r(table)' , e(_N)'
mat list stat

mat stat = J(1,10,.)
foreach var in remembering_5plus learning_2to17 communicating selfcare walking hearing seeing  ProfoundDifficulty FunctionalDifficulty{
svy: proportion passistancefrom if `var'==1
mat stat = stat \ (r(table)', e(_N)')
}
mat stat = stat[2..., 1...]
mat colnames stat = b se t pvalue ll ul df crit eform N
*mat rownames stat = /*remembering_5plus learning_2to17 communicating selfcare walking hearing seeing*/ ProfoundDifficultyFunctionalDifficulty 

recode passistance1_days passistance2_days passistance_ext_days (98 = .), prefix(_new)
egen max_passistance_days =  rowmax(_newpassistance1_days _newpassistance2_days _newpassistance_ext_days)
recode max_passistance_days (0/5 = 1 "Less than 5 days") (5/10 = 2 "5-10 days") (11/20 = 3 "11-20 days") (21/27 = 4 "21-27 days") (28 = 5 "All days"), gen(max_passistance_days2)


mat stat = J(1,10,.)
svy: proportion max_passistance_days2, over(sex)
mat stat = stat \ r(table)' , e(_N)'
mat list stat

mat stat = J(1,10,.)
svy: proportion max_passistance_days2, over(lifecycle_age_groups)
mat stat = stat \ r(table)' , e(_N)'
mat list stat

mat stat = J(1,10,.)
svy: proportion max_passistance_days2, over(urban)
mat stat = stat \ r(table)' , e(_N)'
mat list stat

mat stat = J(1,10,.)
svy: proportion max_passistance_days2, over(quints)
mat stat = stat \ r(table)' , e(_N)'
mat list stat

mat stat = J(1,10,.)
foreach var in remembering_5plus learning_2to17 communicating selfcare walking hearing seeing  ProfoundDifficulty FunctionalDifficulty{
svy: proportion max_passistance_days2 if `var'==1
mat stat = stat \ (r(table)', e(_N)')
}
mat stat = stat[2..., 1...]
mat colnames stat = b se t pvalue ll ul df crit eform N
*mat rownames stat = /*remembering_5plus learning_2to17 communicating selfcare walking hearing seeing*/ ProfoundDifficultyFunctionalDifficulty 

recode passistance1_hours passistance2_hours passistance_ext_hours (98 = .), prefix(new_)
gen temp1 = _newpassistance1_days*new_passistance1_hours
gen temp2 = _newpassistance2_days*new_passistance2_hours
gen temp3 = _newpassistance_ext_days*new_passistance_ext_hours
egen temp4 = rowtotal(temp1 - temp3)
egen temp5 = rowtotal(_newpassistance1_days _newpassistance2_days _newpassistance_ext_days)
gen mean_hours_passistance = temp4/temp5
drop temp1 - temp5

mat stat = J(1,10,.)
foreach var of varlist mean_hours_passistance {
svy: mean `var', over(sex)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist mean_hours_passistance {
svy: mean `var', over(lifecycle_age_groups)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist mean_hours_passistance {
svy: mean `var', over(urban)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var of varlist mean_hours_passistance {
svy: mean `var', over(quints)
mat stat = stat \ r(table)' , e(_N)'
}
mat list stat

mat stat = J(1,10,.)
foreach var in remembering_5plus learning_2to17 communicating selfcare walking hearing seeing  ProfoundDifficulty FunctionalDifficulty{
svy: mean mean_hours_passistance if `var'==1
mat stat = stat \ (r(table)', e(N))
}
mat stat = stat[2..., 1...]
mat colnames stat = b se t pvalue ll ul df crit eform N
mat rownames stat = remembering_5plus learning_2to17 communicating selfcare walking hearing seeing  ProfoundDifficulty FunctionalDifficultyy


*
gen paid_assistance = passistance1_paid==1 | passistance2_paid==1 | passistance_ext_paid==1 if FunctionalDifficulty==1 &  (has_passistance_hh==1 | has_passistance_ext==1)


foreach var of varlist housing recreation_exp_total communications_exp_total transport_exp_total{
	gen `var'_temp = `var'
	replace `var' = . if `var'==0
	winsor2 `var', suffix(_wins)
	replace `var'_wins = 0 if `var'_temp==0
	replace `var' = `var'_temp
	drop `var'_temp
	}

gen ln_house = log(housing + 1) 
gen ln_rec = log(recreation_exp_total + 1) 
gen ln_comms = log(communications_exp_total + 1)
gen ln_trans = log(transport_exp_total + 1)

gen ln_house_wins = log(housing_wins + 1) 
gen ln_rec_wins = log(recreation_exp_total_wins + 1) 
gen ln_comms_wins = log(communications_exp_total_wins + 1)
gen ln_trans_wins = log(transport_exp_total_wins + 1)

foreach var of varlist ln_house ln_trans ln_comms  {
reg `var'_wins i.hh_disab  if  pid==1 [aw = wgt2], vce(cluster psu)
reg `var'_wins i.hh_disab hhsize i.sex_head c.age_head##c.age_head i.urban assetindex i.region i.depratio2 i.hhtype3 if  pid==1 [aw = wgt2], vce(cluster psu)
}
*










