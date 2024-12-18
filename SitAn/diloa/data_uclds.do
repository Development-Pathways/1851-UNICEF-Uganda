

 use "${uclds}", clear
	
	gen temp_sex_hh = sex if relation==1
	egen sex_hh = max(temp_sex_hh), by(hhid)
	label val sex_hh sex

	gen ae_exp_pd = ae_exp/30
	cumul ae_exp_pd [aw = wgt2] if ae_exp_pd>0 & ae_exp_pd!=. , gen(cdf_ae_exp_pd)
	
	gen share_nwork_100 = share_nwork*100
	
	label variable region "Region"
	label variable urban "Area of residence"
	
	*label define yesno 0 "No" 1 "Yes"
	label values FunctionalDifficulty yesno
	
	label variable sex "Sex"
	gen sex_head = sex if relation==1
	label variable sex_head "Sex of household head"
	label values sex_head sex
	
	gen age_head = age if relation==1
	label variable age_head "Age of household head"
	
	
	egen disab_5yr_age = cut(age), at(2,5(5)75, 120) icode
	label define disab_5yr_age 0 "2-4 yrs" 1 "5-9 yrs" 2 "10-14 yrs" 3 "15-19 yrs" 4 "20-24 yrs" ///
						 5 "25-29 yrs" 6 "30-34 yrs" 7 "35-39 yrs" 8 "40-44 yrs" ///
						 9 "45-49 yrs" 10 "50-54 yrs" 11 "55-59 yrs" 12 "60-64 yrs" ///
						 13 "65-69 yrs" 14 "70-74 yrs" 15 "75+ yrs"
	label values disab_5yr_age disab_5yr_age
	label variable disab_5yr_age "Five-year age groups"
	
	egen disab_10yr_age = cut(age), at(2,10(10)70, 120) icode
	label define disab_10yr_age 0 "2-9 yrs" 1 "10-19 yrs" 2 "20-29 yrs" 3 "30-39 yrs" ///
						 4 "40-49 yrs" 5 "50-59 yrs" 6 "60-69 yrs" 7 "70+ yrs"
	label values disab_10yr_age disab_10yr_age
	label variable disab_10yr_age "Ten-year age groups"
	
	egen female_head = max(relation==1 & sex==2), by(hhid)
	label variable female_head "Female headed household"
	label values female_head yesno
	
	gen female_head_100 = female_head*100
	label variable female_head_100 "Female headed household"

	egen age_adults = cut(age), at(18, 25, 40, 60, 75, 120) icode
	label define age_adults 0 "18-24 yrs" 1 "25-39 yrs" 2 "40-59 yrs" 3 "60-74 yrs" 4 "75+ yrs"
	label values age_adults age_adults
	label variable age_adults "Age groups"
	
	gen age_adults_head  = age_adults if relation==1
	label variable age_adults_head "Age groups of household head"
	label values age_adults_head age_adults

	recode nchildren (0 = 0 "0") (1 = 1 "1") (2 = 2 "2") (3 = 3 "3") (4 = 4 "4") (5/max = 5 "5+"), gen(nchildren2)
	label variable nchildren2 "Number of children under 18 years in household"
	
	label variable hh_disab " Household with person(s) with severe functional difficulties"
	label values hh_disab yesno
	
	label variable funcdiff_onset "Age of onset of functional difficulty"
	
	recode current_grade (1 = 1 "Pre-school") (10/16 = 2 "Primary") (30/35 = 3 "Secondary") (40 50 61 = 4 "Other") (. = 5 "Not attending school") if educ_attend!=., gen(school_level)
	label variable school_level "School level"
	
	label variable school_manag "Who manages the school"
	
	gen age_child5_18 = age if age>=5 & age<=18
	label variable age_child5_18 "Age"
	
	gen pwd_fulllife2 = pwd_fulllife
	replace pwd_fulllife2 = 2 if pwd_fulllife==2 & pwd_nfulllife==1
	replace pwd_fulllife2 = 3 if pwd_fulllife==2 & pwd_nfulllife==2
	replace pwd_fulllife2 = 4 if pwd_fulllife==2 & pwd_nfulllife==3
	replace pwd_fulllife2 = 5 if pwd_fulllife==2 & pwd_nfulllife==98
	
	label define pwd_fulllife2 1 "Yes" 2 "No, because of their health problem/disability" ///
							   3 "No, because of attitudes, barriers and behaviours in society" ///
							   4 "No, because of both health problem/disability and attitudes/barriers/behaviour in society" ///
							   5 "No, but don't know why" ///
							   98 "Don't know"
	label values pwd_fulllife2 pwd_fulllife2
	label variable pwd_fulllife2 "Do you think pwd can lead as full a life as non-disabled people?"

	recode pwd_prevalence (0/19 = 1 "Less than 20") (20/49 = 2 "20 - 49") (40/59 = 3 "40 - 59") (60/79 = 4 "60 - 79") (80/100 = 5 "80 and above") (998 = 6 "Don't know"), gen(pwd_prevalence2)
	label variable pwd_prevalence2 "Out of 100 people in Uganda, how many are persons with disabilties?"
	
	recode days_suffer_illness (1/5 = 1 "1 to 5 days") (6/10 = 2 "6 to 10 days") (11/20 = 3 "11 to 20 days") (21/max = 4 "over 20 days"), gen(days_suffer_illness2)
	label variable days_suffer_illness2 "Number of days sufferred from illness or injury in past 30 days"
	
	recode days_nwork_illness (0 = 0 "No days") (1/5 = 1 "1 to 5 days") (6/10 = 2 "6 to 10 days") (11/20 = 3 "11 to 20 days") (21/max = 4 "over 20 days"), gen(days_nwork_illness2)
	label variable days_nwork_illness2 "Number of days stopped usual activities due to illness/injury in past 30 days"

	recode age_work (98 =.), gen(age_work2)
	replace age_work2 = age - years_work if age_work2==.
	recode age_work2 (0/4 = .)
	label variable age_work2 "Age at which started working for pay?"
	
	recode dwelling_rooms (0 = 0 "No sleeping room") (1 = 1 "One sleeping room") (2 = 2 "Two sleeping rooms") (3 = 3 "Three sleeping rooms") (4/max = 4 "Four plus sleeping rooms"), gen(dwelling_rooms2)
	label variable dwelling_rooms2 "Number of rooms for sleeping"
	
	* number of children per mother
	gen num_children = .
	forvalues x = 1/25 {
		egen mother`x' = sum(mother_id==`x'), by(hhid)
		replace num_children = mother`x' if hh_roster__id==`x'
		drop mother`x'
	}
	replace num_children = . if sex==1
	label variable num_children "Number own children living with women"
	recode num_children (0 = 0 "No child") (1 = 1 "One child") (2 = 2 "Two children") (3 = 3 "Three children") (4/max = 4 "Four + children"), gen(num_children2)
	label variable num_children2 "Number own children living with women"
	
	recode mother (2 = 0 "No") (1 = 100 "Yes"), gen(mother2)
	label variable mother2 "Does natural mother live in household?"
	
	* number of limitations
	
	foreach var of varlist wgss_seeing wgss_hearing wgss_walking wgss_remembering wgss_selfcare wgss_communic {
		tab `var', gen(temp__`var')
	}
	egen num_funclimit = rowtotal(temp__*3 temp__*4 Seeing_2to4 - Behaviour_2to4 Seeing_5to17 - Depression_5to17)
	label variable num_funclimit "Number of functional limitations"
	recode num_funclimit (0 = 0 "0") (1 = 1 "1")  (2 = 2 "2")  (3/max = 3 "3+"), gen(num_funclimit2)
	label variable num_funclimit2 "Number of functional limitations"

	
	*International poverty lines
	
	gen pc_expPPP_daily = (pc_exp09/819.146)/30
	
	recode pc_expPPP_daily (min/1.89999999 = 1 "Below $1.9 PPP a day") ///
						   (1.9/3.19999999 = 2 "Between $1.9 and < $3.2 PPP a day") ///
						   (3.2/5.49999999 = 3 "Between $3.2 and < $5.5 PPP a day") ///
						   (5.5/9.99999999 = 4 "Between $5.5 and < $10 PPP a day") ///
						   (10/max = 5 "Above $10 PPP a day"), gen(pov_international)
						   
	recode poor_2019 (0 = 0 "Not poor") (1 = 100 "Poor"), gen(poor_2019_100)
	label variable poor_2019_100 "Household living below national poverty line"
	
	**share of food production bought, produced and received
replace food_share = food_share*100
recode food_share (0/49.999 = 1 "Low (<50%)") (50/64.999 = 2 "Medium (50-65%)") (65/74.999 = 3 "High (65-75%)") (75/max = 4 "Very high (75% and over)"), gen(foodshare_group)
label variable food_share "Food expenditure share groups"


preserve
keep hhid pid relation sex age
rename pid pcare_id 
rename relation rel_pcare
rename sex sex_pcare
rename age age_pcare
tempfile test
save `test'.dta, replace
restore
merge n:1 hhid pcare_id using `test'.dta
drop if _m==2
drop _m

gen rel_pcarev2 = .
replace rel_pcarev2 = 1 if sex_pcare==1 & (rel_pcare==1 | rel_pcare==2) & relation==3
replace rel_pcarev2 = 1 if sex_pcare==1 & (rel_pcare==3 | rel_pcare==5) & relation==4 & rel_pcarev2==.
replace rel_pcarev2 = 2 if sex_pcare==2 & (rel_pcare==1 | rel_pcare==2) & relation==3 & rel_pcarev2==.
replace rel_pcarev2 = 3 if (rel_pcare==1 | rel_pcare==2) & relation==4 & rel_pcarev2==.
replace rel_pcarev2 = 4 if (rel_pcare==3 | rel_pcare==5) & (relation==3 | relation==5) & rel_pcarev2==.
replace rel_pcarev2 = 6 if (rel_pcare==10 | rel_pcare==11) & relation<10 & rel_pcarev2==.
replace rel_pcarev2 = 6 if (relation==10 | relation==11) & rel_pcare<10 & rel_pcarev2==.
replace rel_pcarev2 = 5 if relation<10 & rel_pcare<10 & rel_pcarev2==.

replace rel_pcarev2 = 5 if rel_pcarev2==.
replace rel_pcarev2 = . if rel_pcare==.


mat educ_type = J(1,3,.)
foreach type in Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 {
	tab `type' educ_attend if `type' == 1 [iw = wgt2], matcell(stat)
	local tot = `r(N)'
	mat educ_type = educ_type \ stat*100/`tot'
	}
mat educ_type = educ_type[2...,1...]
mat rownames educ_type = Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17
	
	

preserve
keep hhid pid relation sex age
rename pid passitance1_id 
rename relation rel_pa1
rename sex sex_pa1
rename age age_pa1
tempfile test
save `test'.dta, replace
restore
merge n:1 hhid passitance1_id using `test'.dta
drop if _m==2
drop _m

preserve
keep hhid pid relation sex age
rename pid passistance2_id 
rename relation rel_pa2
rename sex sex_pa2
rename age age_pa2
tempfile test
save `test'.dta, replace
restore
merge n:1 hhid passistance2_id using `test'.dta
drop if _m==2
drop _m



gen Seeing_18plus = wgss_seeing >=3  if wgss_seeing!=.
gen Hearing_18plus = wgss_hearing >=3 if wgss_hearing!=.
gen Walking_18plus = wgss_walking >=3 if wgss_walking!=.
gen Remembering_18plus = wgss_remembering >=3 if wgss_remembering!=.
gen Selfcare_18plus = wgss_selfcare >=3  if wgss_selfcare!=.
gen Communicating_18plus = wgss_communic >=3 if wgss_communic!=.




gen pSeeing_18plus = wgss_seeing >=4 if wgss_seeing!=.
gen pHearing_18plus = wgss_hearing >=4 if wgss_hearing!=.
gen pWalking_18plus = wgss_walking >=4 if wgss_walking!=.
gen pRemembering_18plus = wgss_remembering >=4 if wgss_remembering!=.
gen pSelfcare_18plus = wgss_selfcare >=4 if wgss_selfcare!=.
gen pCommunicating_18plus = wgss_communic >=4 if wgss_communic!=.
gen profoundDifficulty = pSeeing_18plus==1 | pHearing_18plus==1 | ///
						 pWalking_18plus==1 | pRemembering_18plus==1 | ///
						 pSelfcare_18plus==1 | pCommunicating_18plus==1 if wgss_seeing!=.

						 
preserve
keep hhid mother_id
keep if mother_id!=.
rename mother_id pid
egen num_child = count(pid), by(pid hhid)
duplicates drop
tempfile test
save `test'.dta, replace
restore
merge n:1 hhid pid using `test'.dta
drop if _m==2
drop _m

gen never_work2 = (ever_work==2)*100

**profound disability

* PART ONE: Creating separate variables per domain of functioning *

* SEEING DOMAIN *
gen SEE_IND = child2to4_seeing2
replace SEE_IND = child2to4_seeing3 if child2to4_seeing2 == .
tab SEE_IND

gen pSeeing_2to4 = .
replace pSeeing_2to4 = 0 if inrange(SEE_IND, 1, 3)
replace pSeeing_2to4 = 1 if SEE_IND == 4
label value pSeeing_2to4 funcdiff
label variable pSeeing_2to4 "Profound functional difficulty, 2 to 4 year olds: seeing"

* HEARING DOMAIN *
gen HEAR_IND = child2to4_hearing2
replace HEAR_IND = child2to4_hearing3 if child2to4_hearing2 == .
tab HEAR_IND

gen pHearing_2to4 = .
replace pHearing_2to4 = 0 if inrange(HEAR_IND, 1, 3)
replace pHearing_2to4 = 1 if HEAR_IND == 4
label value pHearing_2to4 funcdiff
label variable pHearing_2to4 "Profound functional difficulty, 2 to 4 year olds: hearing"


* WALKING DOMAIN *
gen WALK_IND = child2to4_walking2
replace WALK_IND = child2to4_walking4 if child2to4_walking2 == .
tab WALK_IND

gen pWalking_2to4 = .
replace pWalking_2to4 = 0 if inrange(WALK_IND, 1, 3)
replace pWalking_2to4 = 1 if WALK_IND== 4
label value pWalking_2to4 funcdiff
label variable pWalking_2to4 "Profound functional difficulty, 2 to 4 year olds: walking"

* FINE MOTOR DOMAIN *
gen pFineMotor_2to4 = .
replace pFineMotor_2to4 = 0 if inrange(child2to4_finemotor, 1,3)
replace pFineMotor_2to4 = 1 if child2to4_finemotor ==4
label value pFineMotor_2to4 funcdiff
label variable pFineMotor_2to4 "Profound functional difficulty, 2 to 4 year olds: fine motor"

* COMMUNICATING DOMAIN *
gen COM_IND = 0
replace COM_IND = 4 if (child2to4_communic1 == 4 | child2to4_communic2 == 4)
replace COM_IND = 3 if (COM_IND != 4 & (child2to4_communic1 == 3 | child2to4_communic2 == 3))
replace COM_IND = 2 if (COM_IND != 4 & COM_IND != 3 & (child2to4_communic1 == 2 | child2to4_communic2 == 2))
replace COM_IND = 1 if (COM_IND != 4 & COM_IND != 3 & COM_IND != 1 & (child2to4_communic1 == 1 | child2to4_communic2 == 1))
replace COM_IND = . if ((COM_IND == 2 | COM_IND == 1) & (child2to4_communic1 == . | child2to4_communic2 == .))
tab COM_IND

gen pCommunication_2to4 = .
replace pCommunication_2to4 = 0 if inrange(COM_IND, 1, 3)
replace pCommunication_2to4 = 1 if COM_IND==4
label value pCommunication_2to4 funcdiff
label variable pCommunication_2to4 "Profound functional difficulty, 2 to 4 year olds: communication"

* LEARNING DOMAIN *
gen pLearning_2to4 = .
replace pLearning_2to4 = 0 if inrange(child2to4_learning, 1, 3)
replace pLearning_2to4 = 1 if child2to4_learning==4
label value pLearning_2to4 funcdiff
label variable pLearning_2to4 "Profound functional difficulty, 2 to 4 year olds: learning"


* PLAYING DOMAIN *
gen pPlaying_2to4 = .
replace pPlaying_2to4 = 0 if inrange(child2to4_playing, 1, 3)
replace pPlaying_2to4 = 1 if child2to4_playing == 4
label value pPlaying_2to4 funcdiff
label variable pPlaying_2to4 "Profound functional difficulty, 2 to 4 year olds: playing"


* BEHAVIOUR DOMAIN *
gen pBehaviour_2to4 = .
replace pBehaviour_2to4 = 0 if inrange(child2to4_behaviour, 1, 3)
replace pBehaviour_2to4 = 1 if child2to4_behaviour == 4
label value pBehaviour_2to4 funcdiff
label variable pBehaviour_2to4 "Profound Functional difficulty, 2 to 4 year olds: behaviour"


* PART TWO: Creating disability indicator for children age 2-4 years *

gen ProfoundDifficulty_2to4 = 0
replace ProfoundDifficulty_2to4 = 1 if (pSeeing_2to4 == 1 | pHearing_2to4 == 1 | pWalking_2to4 == 1 | pFineMotor_2to4 == 1 | pCommunication_2to4 == 1 | pLearning_2to4 == 1 | pPlaying_2to4 == 1 | pBehaviour_2to4 == 1)
replace ProfoundDifficulty_2to4 = . if (ProfoundDifficulty_2to4 != 1 & (pSeeing_2to4 == . | pHearing_2to4 == . | pWalking_2to4 == . | pFineMotor_2to4 == . | pCommunication_2to4 == . | pLearning_2to4 == . | pPlaying_2to4 == . | pBehaviour_2to4 == .))
label value ProfoundDifficulty_2to4 funcdiff
label variable ProfoundDifficulty_2to4 "Child 2 to 4 with profound functional difficulty"

drop SEE_IND HEAR_IND WALK_IND COM_IND

* child functioning	(5to17yrs)

* PART ONE: Creating separate variables per domain of functioning *

* SEEING DOMAIN *
gen SEE_IND = child5to17_seeing2
replace SEE_IND = child5to17_seeing3 if child5to17_seeing2 == .
tab SEE_IND

gen pSeeing_5to17 = .
replace pSeeing_5to17 = 0 if inrange(SEE_IND, 1, 3)
replace pSeeing_5to17 = 1 if SEE_IND == 4
label value pSeeing_5to17 funcdiff
label variable pSeeing_5to17 "Profound functional difficulty, 5 to 17 year olds: seeing"


* HEARING DOMAIN *
gen HEAR_IND = child5to17_hearing2
replace HEAR_IND = child5to17_hearing3 if child5to17_hearing2 == .
tab HEAR_IND

gen pHearing_5to17 = .
replace pHearing_5to17 = 0 if inrange(HEAR_IND, 1, 3)
replace pHearing_5to17 = 1 if (HEAR_IND ==  4)
label value pHearing_5to17 funcdiff
label variable pHearing_5to17 "Profound functional difficulty, 5 to 17 year olds: hearing"


* WALKING DOMAIN *
gen WALK_IND1 = child5to17_walking2
replace WALK_IND1 = child5to17_walking3 if child5to17_walking2 == 2
tab WALK_IND1

gen WALK_IND2 = child5to17_walking6
replace WALK_IND2 = child5to17_walking7 if (child5to17_walking6 == 1 | child5to17_walking6 == 2)
tab WALK_IND2

gen WALK_IND = WALK_IND1
replace WALK_IND = WALK_IND2 if WALK_IND1 == .
tab WALK_IND

gen pWalking_5to17 = .
replace pWalking_5to17 = 0 if inrange(WALK_IND, 1, 3)
replace pWalking_5to17 = 1 if (WALK_IND ==  4)
label value pWalking_5to17 funcdiff
label variable pWalking_5to17 "Profound functional difficulty, 5 to 17 year olds: walking"


* SELFCARE DOMAIN *
gen pSelfcare_5to17 = .
replace pSelfcare_5to17 = 0 if inrange(child5to17_selfcare, 1, 3)
replace pSelfcare_5to17 = 1 if (child5to17_selfcare ==  4)
label value pSelfcare_5to17 funcdiff
label variable pSelfcare_5to17 "Profound functional difficulty, 5 to 17 year olds: self care"


* COMMUNICATING DOMAIN *
gen COM_IND = 0
replace COM_IND = 4 if (child5to17_communic1 == 4 | child5to17_communic2 == 4)
replace COM_IND = 3 if (COM_IND != 4 & (child5to17_communic1 == 3 | child5to17_communic2 == 3))
replace COM_IND = 2 if (COM_IND != 4 & COM_IND != 3 & (child5to17_communic1 == 2 | child5to17_communic2 == 2))
replace COM_IND = 1 if (COM_IND != 4 & COM_IND != 3 & COM_IND != 1 & (child5to17_communic1 == 1 | child5to17_communic2 == 1))
replace COM_IND = . if ((COM_IND == 2 | COM_IND == 1) & (child5to17_communic1 == . | child5to17_communic2 == .))
tab COM_IND

gen pCommunication_5to17 = .
replace pCommunication_5to17 = 0 if inrange(COM_IND, 1, 3)
replace pCommunication_5to17 = 1 if (COM_IND ==  4)
label value pCommunication_5to17 funcdiff
label variable pCommunication_5to17 "Profound functional difficulty, 5 to 17 year olds: communicating"


* LEARNING DOMAIN *
gen pLearning_5to17 = .
replace pLearning_5to17 = 0 if inrange(child5to17_learning, 1, 3)
replace pLearning_5to17 = 1 if (child5to17_learning ==  4)
label value pLearning_5to17 funcdiff
label variable pLearning_5to17 "Profound functional difficulty, 5 to 17 year olds: learning"

* REMEMBERING DOMAIN *
gen pRemembering_5to17 = .
replace pRemembering_5to17 = 0 if inrange(child5to17_remember, 1, 3)
replace pRemembering_5to17 = 1 if (child5to17_remember == 4)
label value pRemembering_5to17 funcdiff
label variable pRemembering_5to17 "Profound functional difficulty, 5 to 17 year olds: remembering"


* CONCENTRATING DOMAIN *
gen pConcentrating_5to17 = .
replace pConcentrating_5to17 = 0 if inrange(child5to17_concentrating, 1, 3)
replace pConcentrating_5to17 = 1 if (child5to17_concentrating ==  4)
label value pConcentrating_5to17 funcdiff
label variable pConcentrating_5to17 "Profound functional difficulty, 5 to 17 year olds: concentrating"


* ACCEPTING CHANGE DOMAIN *
gen pAcceptingChange_5to17 = .
replace pAcceptingChange_5to17 = 0 if inrange(child5to17_accept, 1, 3)
replace pAcceptingChange_5to17 = 1 if (child5to17_accept ==  4)
label value pAcceptingChange_5to17 funcdiff
label variable pAcceptingChange_5to17 "Profound functional difficulty, 5 to 17 year olds: accpting change"


* BEHAVIOUR DOMAIN *
gen pBehaviour_5to17 = .
replace pBehaviour_5to17 = 0 if inrange(child5to17_behaviour, 1, 3)
replace pBehaviour_5to17 = 1 if (child5to17_behaviour ==  4)
label value pBehaviour_5to17 funcdiff
label variable pBehaviour_5to17 "Profound functional difficulty, 5 to 17 year olds: behaviour"


* MAKING FRIENDS DOMAIN *
gen pMakingFriends_5to17 = .
replace pMakingFriends_5to17 = 0 if inrange(child5to17_friends, 1, 3)
replace pMakingFriends_5to17 = 1 if (child5to17_friends == 4)
label value pMakingFriends_5to17 funcdiff
label variable pMakingFriends_5to17 "Profound functional difficulty, 5 to 17 year olds: making friends"


* ANXIETY DOMAIN *
gen pAnxiety_5to17 = .
replace pAnxiety_5to17 = 0 if inrange(child5to17_anxiety, 2, 5)
replace pAnxiety_5to17 = 1 if (child5to17_anxiety == 1)
label value pAnxiety_5to17 funcdiff
label variable pAnxiety_5to17 "Profound functional difficulty, 5 to 17 year olds: axiety"


* DEPRESSION DOMAIN *
gen pDepression_5to17 = .
replace pDepression_5to17 = 0 if inrange(child5to17_depressed, 2, 5)
replace pDepression_5to17 = 1 if (child5to17_depressed == 1)
label value pDepression_5to17 funcdiff
label variable pDepression_5to17 "Profound functional difficulty, 5 to 17 year olds: depression"


* PART TWO: Creating disability indicator for children age 5-17 years *

gen ProfoundDifficulty_5to17 = 0
replace ProfoundDifficulty_5to17 = 1 if (pSeeing_5to17 == 1 | pHearing_5to17 == 1 | pWalking_5to17 == 1 | pSelfcare_5to17 == 1 | pCommunication_5to17 == 1 | pLearning_5to17 == 1 | pRemembering_5to17 == 1 | pConcentrating_5to17 == 1 | pAcceptingChange_5to17 == 1 | pBehaviour_5to17 == 1 | pMakingFriends_5to17 == 1 | pAnxiety_5to17 == 1 | pDepression_5to17 == 1)
replace ProfoundDifficulty_5to17 = . if (ProfoundDifficulty_5to17 != 1 & (pSeeing_5to17 == . | pHearing_5to17 == . | pWalking_5to17 == . | pSelfcare_5to17 == . | pCommunication_5to17 == . | pLearning_5to17 == . | pRemembering_5to17 == . | pConcentrating_5to17 == . | pAcceptingChange_5to17 == . | pBehaviour_5to17 == . | pMakingFriends_5to17 == . | pAnxiety_5to17 == . | pDepression_5to17 == .))
label value ProfoundDifficulty_5to17 funcdiff
label variable ProfoundDifficulty_5to17 "Child 5 to 17 with profound functional difficulty"

drop COM_IND WALK_IND2 WALK_IND1 WALK_IND HEAR_IND SEE_IND

gen ProfoundDifficulty_18plus = profoundDifficulty 
egen ProfoundDifficulty = rowtotal(ProfoundDifficulty*)

replace ProfoundDifficulty = . if ProfoundDifficulty_2to4==. & ProfoundDifficulty_5to17==. & ProfoundDifficulty_18plus==.
label variable ProfoundDifficulty "Person with profound functional difficulty"


**Living arrangements  
label define livarr 1 "Living alone" 2 "Living with spouse only" ///
					3 "Living with children/children-in-law" ///
					4 "Living with grandchildren (without children)" ///
					5 "Living with other relatives" ///
					6 "Living with non-relatives" 

*aux variables
egen lastrelat = max(relation), by(hhid)
egen child = max(relation==3 | relation==5), by(hhid)
egen grandchild = max(relation==4), by(hhid)
egen parent = max(relation==6), by(hhid)

gen livarr = .
replace livarr = 1 if relation==1 & hhsize==1 & livarr==.
replace livarr = 2 if lastrelat==2 & hhsize==2 & livarr==.
replace livarr = 3 if (relation==8) | (relation==9)  | (relation==1 & child==1) | (relation==2 & child==1) & livarr==.
replace livarr = 4 if  (relation==1 & child==0 & grandchild==1) | (relation==2 & child==0 & grandchild==1) & livarr==.
replace livarr = 6 if relation>=10 & livarr==. //any of the non-relatives live in the same household
replace livarr = 5 if livarr==. 
label values livarr livarr
label variable livarr "Living arrangements"

drop lastrelat child grandchild parent



egen seeing = rowtotal(Seeing_2to4 Seeing_5to17 Seeing_18plus) if age>=2
egen hearing = rowtotal(Hearing_2to4 Hearing_5to17 Hearing_18plus) if age>=2
egen walking = rowtotal(Walking_2to4 Walking_5to17 Walking_18plus) if age>=2
egen selfcare = rowtotal(FineMotor_2to4 Selfcare_5to17 Selfcare_18plus Selfcare_18plus) if age>=2
egen communicating = rowtotal(Communication_2to4 Communication_5to17 Communication_5to17 Communicating_18plus) if age>=2
egen learning_2to17 = rowtotal(Learning_2to4 Learning_5to17) if age<=17 & age>=2
egen remembering_5plus = rowtotal(Remembering_5to17 Remembering_18plus) if age>=5


foreach var of varlist seeing - remembering_5plus FunctionalDifficulty ProfoundDifficulty {
qui sum poor_2019_100 if `var'==1 [aw = wgt2]
di `r(mean)'
}
*
     
	 
egen num_shocks = rowtotal(shocks_drought - shocks_conflict) if wgt2!=.




