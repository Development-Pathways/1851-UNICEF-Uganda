


egen age_newgroup = cut(age), at(2,5,18,120) label
lab def new_grp 0 "2 to 4 years" 1 "5 to 17 years" 2 "18 years plus"
lab val age_newgroup new_grp
label variable age_newgroup "Age groups"


egen age_wabroad = cut(age), at(18, 25, 40, 60, 65) label
label define age_wabroad2 0 "18-24yrs" 1 "25-39yrs" 2 "40-59yrs" 3 "60-64yrs"
label values age_wabroad age_wabroad2
label variable age_wabroad "Age groups"


egen age_broad = cut(age), at(5, 15, 25, 40, 60, 300) label
label define age_broad2 0 "5-15yrs" 1 "15-24yrs" 2 "25-39yrs" 3 "40-59yrs" 4 "60+ years"
label values age_broad age_broad2
label variable age_broad "Age groups"

egen age10yrbroad = cut(age), at(15, 25, 35, 45, 55, 65, 300) label
label define age10yrbroad2 0 "15-24yrs" 1 "25-34yrs" 2 "35-44yrs" 3 "45-54yrs" 4 "55-64yrs" 5 "65+ years"
label values age10yrbroad age10yrbroad2
label variable age10yrbroad "Broad 10 year age groups"

* number of functional limitations 

gen temp = 	(WG1_seeing_person>=2 & WG1_seeing_person!=.) + ///
			(WG2_hearing_person>=2 & WG2_hearing_person!=.) +  ///
			(WG3_walking_person>=2 & WG3_walking_person!=.) +  ///
			(WG4_remembering_person>=2 & WG4_remembering_person!=.) +  ///
			(WG5_selfcare_person>=2 & WG5_selfcare_person!=.) +  ///
			(WG6_communicating_person>=2 & WG6_communicating_person!=.) 
			
recode temp (0 = 0 "No limitation") (1 = 1 "One moderate or severe limitation") (2/3 = 2 "2-3 moderate or severe limitations")  (4/max = 3 "4+ moderate or severe limitations"), gen(n_modsevdisab)
label variable n_modsevdisab "Number of limitations - at least some difficulty"

replace n_modsevdisab =. if moderatedisabled==.
drop temp

gen temp = 	(WG1_seeing_person>=3 & WG1_seeing_person!=.) + ///
			(WG2_hearing_person>=3 & WG2_hearing_person!=.) +  ///
			(WG3_walking_person>=3 & WG3_walking_person!=.) +  ///
			(WG4_remembering_person>=3 & WG4_remembering_person!=.) +  ///
			(WG5_selfcare_person>=3 & WG5_selfcare_person!=.) +  ///
			(WG6_communicating_person>=3 & WG6_communicating_person!=.) 
			
recode temp (0 = 0 "No limitation") (1 = 1 "One severe limitation") (2/3 = 2 "2-3 severe limitations")  (4/max = 3 "4+ severe limitations"), gen(n_sevdisab)
label variable n_sevdisab "Number of limitations - at least a lot of difficulty"

replace n_sevdisab =. if disabled==.

egen hh_temp = sum(temp), by(hhid)

recode hh_temp (0 = 0 "No limitation") (1 = 1 "One severe limitation") (2/3 = 2 "2-3 severe limitations")  (4/max = 3 "4+ severe limitations"), gen(hh_n_sevdisab)
label variable hh_n_sevdisab "Number of limitations in household - at least a lot of difficulty"
replace hh_n_sevdisab =. if has_disabled==.

drop temp hh_temp


egen hh_disab_child = max(FunctionalDifficulty_2to4==1 | FunctionalDifficulty_5to17==1), by(hhid)

egen hh_disab_adult = max(FunctionalDifficulty_Adult==1), by(hhid)


gen disab_severity = .


	foreach var in wgss_seeing wgss_hearing wgss_walking wgss_remembering wgss_selfcare wgss_communic child2to4_seeing1  child2to4_seeing3 child2to4_hearing1 child2to4_hearing2 child2to4_hearing3 child2to4_walking2 child2to4_walking4 child2to4_finemotor child2to4_communic1 child2to4_communic2 child2to4_learning child2to4_playing child2to4_behaviour child5to17_seeing2 child5to17_seeing3 child5to17_hearing2 child5to17_hearing3 child5to17_walking2 child5to17_walking3 child5to17_walking4  child5to17_walking6 child5to17_walking7 child5to17_selfcare child5to17_communic1 child5to17_communic2 child5to17_learning child5to17_remember child5to17_concentrating child5to17_accept child5to17_behaviour child5to17_friends {
			replace disab_severity = 1 if `var' ==1 & disab_severity==.
			replace disab_severity = 2 if `var' ==2 & disab_severity==.
			replace disab_severity = 3 if `var' ==3 & disab_severity==.
			replace disab_severity = 4 if `var' ==4 & disab_severity==.
			}
			//
			
		child2to4_seeing1 child5to17_walking1 child5to17_hearing1
		
		lab define disab_sev 1 "No limitations" 2 "Moderate" 3 "Severe" 4 "Profound"
		
egen num_animals = rowtotal(numlivestock_*)
			
		
		
gen FunctionalDifficulty_100 = FunctionalDifficulty*100

gen employed = (work_situation==2 | work_situation==3 | work_situation==4) & ever_work==1

gen employed_100 = employed*100

recode highest_grade (17 = 3) (11/17 = 2) (21/23 = 1) (31/35 = 4) (36 = 5) 

	lab def highest_grade 3 "Completed Primary" 2 "Completed some primary education" 1 "Completed nursery" 4 "Completed some secondary education" 5 "Completed Secondary", add

 gen married = marital_status<=2
 gen married_100 = married*100

 
egen income_work = sum(work_earning), by(hhid)
gen income_nwork = income_tot if income_tot!=99 & income_tot!=98

gen income_nwork_rng =  . 
	replace income_nwork_rng = 1 if income_tot_brac4>=2 & income_tot_brac4!=. & income_nwork_rng==.
	replace income_nwork_rng = 2 if income_tot_brac2>=2 & income_tot_brac2!=. & income_nwork_rng==.
	replace income_nwork_rng= 3 if income_tot_brac1>=2 & income_tot_brac1!=. & income_nwork_rng==.
	replace income_nwork_rng= 4 if income_tot_brac3>=2 & income_tot_brac3!=. & income_nwork_rng==.
	replace income_nwork_rng= 5 if income_tot_brac5>=2 & income_tot_brac5!=. & income_nwork_rng==.
	replace income_nwork_rng= 6 if income_tot_brac6>=2 & income_tot_brac6!=. & income_nwork_rng==.
	replace income_nwork_rng= 7 if income_tot_brac6==1 & income_tot_brac6!=. & income_nwork_rng==.
	replace income_nwork_rng= . if income_tot!=99 & income_tot!=98
	
	
	label def range_nwork 1 "Less than or equal to UGX 250,000" ///
						2 "Less than or equal to UGX 500,000" 3 "Less than or equal to UGX 1,000,000" ///
						4 "Less than or equal to UGX 2,000,000" 5 "Less than or equal to UGX 5,000,000" ///
						6 "Less than or equal to UGX 10,000,000" 7 "More than UGX 10,000,000"
						
	lab val income_nwork_rng range_nwork
	lab var income_nwork_rng "Annual household income range from non-work related activites"
	
	label var income_nwork "Annual household income from non-work related activites"
	label var income_work "Annual household income from work related activities"
	
	
	replace income_nwork = 250000 if (income_tot==98 | income_tot==99) & income_nwork_rng==1
	replace income_nwork = 500000 if (income_tot==98 | income_tot==99) & income_nwork_rng==2
	replace income_nwork = 1000000 if (income_tot==98 | income_tot==99) & income_nwork_rng==3
	replace income_nwork = 2000000 if (income_tot==98 | income_tot==99) & income_nwork_rng==4
	replace income_nwork = 5000000 if (income_tot==98 | income_tot==99) & income_nwork_rng==5
	replace income_nwork = 10000000 if (income_tot==98 | income_tot==99) & (income_nwork_rng==6 | income_nwork_rng==7)
	
	
egen hh_income = rowtotal(income_work income_nwork)
	lab var hh_income "Total annual household income"

egen share_nwork = max(income_nwork/hh_income), by(hhid)
	lab var share_nwork "Share of household total income that comes from non-work"

 
 
 
 
 
gen seeing = .

	replace seeing =1 if seeing==. & (wgss_seeing==1 | child2to4_seeing2==1 | child2to4_seeing3==1 | child5to17_seeing2==1 | child5to17_seeing3==1)
	replace seeing =2 if seeing==. & (wgss_seeing==2 | child2to4_seeing2==2 | child2to4_seeing3==2 | child5to17_seeing2==2 | child5to17_seeing3==2)
	replace seeing =3 if seeing==. & (wgss_seeing==3 | child2to4_seeing2==3 | child2to4_seeing3==3 | child5to17_seeing2==3 | child5to17_seeing3==3)
	replace seeing =4 if seeing==. & (wgss_seeing==4 | child2to4_seeing2==4 | child2to4_seeing3==4 | child5to17_seeing2==4 | child5to17_seeing3==4)
	
gen	hearing =.

	replace hearing = 1 if hearing==.  & (wgss_hearing==1 | child2to4_hearing2==1 | child2to4_hearing3==1 | child5to17_hearing2==1 | child5to17_hearing3==1)
	replace hearing = 2 if hearing==.  & (wgss_hearing==2 | child2to4_hearing2==2 | child2to4_hearing3==2 | child5to17_hearing2==2 | child5to17_hearing3==2)
	replace hearing = 3 if hearing==.  & (wgss_hearing==3 | child2to4_hearing2==3 | child2to4_hearing3==3 | child5to17_hearing2==3 | child5to17_hearing3==3)
	replace hearing = 4 if hearing==.  & (wgss_hearing==4 | child2to4_hearing2==4 | child2to4_hearing3==4 | child5to17_hearing2==4 | child5to17_hearing3==4)
	
gen walking = .
	replace walking  = 1 if walking==. & (child2to4_walking2==1 | child2to4_walking3==1 | child2to4_walking4==1)
	replace walking  = 2 if walking==. & (child2to4_walking2==2 | child2to4_walking3==2 | child2to4_walking4==2)
	replace walking  = 3 if walking==. & (child2to4_walking2==3 | child2to4_walking3==3 | child2to4_walking4==3)
	replace walking  = 4 if walking==. & (child2to4_walking2==4 | child2to4_walking3==4 | child2to4_walking4==4)

gen selfcare = .
	replace selfcare = 1 if selfcare==. * (wgss_selfcare==1 | child5to17_selfcare==1 |  Selfcare_5to17==1 )
	replace selfcare = 2 if selfcare==. * (wgss_selfcare==2 | child5to17_selfcare==2 |  Selfcare_5to17==2 )
	replace selfcare = 3 if selfcare==. * (wgss_selfcare==3 | child5to17_selfcare==3 |  Selfcare_5to17==3 )
	replace selfcare = 4 if selfcare==. * (wgss_selfcare==4 | child5to17_selfcare==4 |  Selfcare_5to17==4 )

gen communicating =.
	replace communicating = 1 if communicating==. & (wgss_communic==1 | child2to4_communic1==1 | child2to4_communic2==1 | child5to17_communic1==1 | child5to17_communic2==1 )
	replace communicating =2 if communicating==. & (wgss_communic==2 | child2to4_communic1==2 | child2to4_communic2==2 | child5to17_communic1==2 | child5to17_communic2==2 )
	replace communicating =3 if communicating==. & (wgss_communic==3 | child2to4_communic1==3 | child2to4_communic2==3 | child5to17_communic1== 3 | child5to17_communic2==3 )
	replace communicating = 4 if communicating==. & (wgss_communic==4 | child2to4_communic1==4 | child2to4_communic2==4 | child5to17_communic1==4 | child5to17_communic2==4 )

gen behaviour = .
	replace behaviour = 1 if behaviour==. & (child2to4_behaviour==1 | child5to17_behaviour==1 )
	replace behaviour =  2 if behaviour==. & (child2to4_behaviour==2 | child5to17_behaviour==2 )
	replace behaviour = 3 if behaviour==. & (child2to4_behaviour==3 | child5to17_behaviour==3 )
	replace behaviour = 4 if behaviour==. & (child2to4_behaviour==4 | child5to17_behaviour==4 )

gen learning = . 
	replace learning = 1 if learning==. & (child2to4_learning==1 | child5to17_learning==1)
	replace learning = 2 if learning==. & (child2to4_learning==2 | child5to17_learning==2)
	replace learning = 3 if learning==. & (child2to4_learning==3 | child5to17_learning==3)
	replace learning = 4 if learning==. & (child2to4_learning==4 | child5to17_learning==4)
	
gen playing = . 
child2to4_playing

gen accept = . 
child5to17_accept

