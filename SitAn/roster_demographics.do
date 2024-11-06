*************************************
***** Demographics ******************
*************************************

gen __DEMOGRAPHICS__ = .

* 5-year age groups
egen age5yrs = cut(age), at(0(5)75, 120) icode nolabel
label variable age5yrs "Five-year age groups"
label define age5yrs 0 "0-4 yrs" 1 "5-9 yrs" 2 "10-14 yrs" 3 "15-19 yrs" 4 "20-24 yrs" ///
					 5 "25-29 yrs" 6 "30-34 yrs" 7 "35-39 yrs" 8 "40-44 yrs" ///
					 9 "45-49 yrs" 10 "50-54 yrs" 11 "55-59 yrs" 12 "60-64 yrs" ///
					 13 "65-69 yrs" 14 "70-74 yrs" 15 "75+ yrs"
label values age5yrs age5yrs

* 5-year age groups (children)
egen age5yrs_child = cut(age) if age<18, at(0,5,10,15,18) icode nolabel
label variable age5yrs_child "Age"
label define age5yrs_child 0 "0-4 yrs" 1 "5-9 yrs" 2 "10-14 yrs" 3 "15-17 yrs"
label values age5yrs_child age5yrs_child

* broad(1) age groups
recode age (0/17 = 1 "Child 0-17 years") (18/59 = 2 "Adult 18-59 years") (60/125 = 3 "Older person 60+ years"), gen(age_groups)
label variable age_groups "Age group"

egen age_newgroup = cut(age), at(2,5,18,120) label
lab def new_grp 0 "2 to 4 years" 1 "5 to 17 years" 2 "18 years plus"
lab val age_newgroup new_grp
label variable age_newgroup "Age groups"

* broad working age groups
egen age_wabroad = cut(age), at(18, 25, 40, 60, 65) label
label define age_wabroad2 0 "18-24yrs" 1 "25-39yrs" 2 "40-59yrs" 3 "60-64yrs"
label values age_wabroad age_wabroad2
label variable age_wabroad "Age groups"

* broad(2) age groups
egen age_broad = cut(age), at(5, 15, 25, 40, 60, 300) label
label define age_broad2 0 "5-15yrs" 1 "15-24yrs" 2 "25-39yrs" 3 "40-59yrs" 4 "60+ years"
label values age_broad age_broad2
label variable age_broad "Age groups"

* broad 10 year age groups
egen age10yrbroad = cut(age), at(15, 25, 35, 45, 55, 65, 300) label
label define age10yrbroad2 0 "15-24yrs" 1 "25-34yrs" 2 "35-44yrs" 3 "45-54yrs" 4 "55-64yrs" 5 "65+ years"
label values age10yrbroad age10yrbroad2
label variable age10yrbroad "Broad 10 year age groups"

** marital status
* drop variables with only missing values
drop spouse2__3 - spouse2__29
* infer head as spouse of spouse
replace marital = marital[_n-1] if relation==2
replace spouse1 = 1 if relation==2
replace spouse2__0 = 1 if relation==2

rename marital marital_status
rename spouse1 spouse
rename spouse2__0 spouse_id1
label variable spouse_id1 "Id of 1st spouse"
rename spouse2__1 spouse_id2
label variable spouse_id2 "Id of 2nd spouse"
rename spouse2__2 spouse_id3
label variable spouse_id3 "Id of 3rd spouse"

gen married = marital_status<=2
gen married_100 = married*100

lab var married "Married"
lab var married_100 "Married"

** mother
label variable mother "Does natural mother live in this household?"

** create household demographic variables

egen hhsize  = count(pid), by(hhid)
label variable hhsize "Number of persons in the household"

egen nchildren=sum(age<18), by(hhid)
label variable nchildren "Number of children under 18yrs in hh"

egen nadults=sum(age>=18), by(hhid)
label variable nadults "Number of adults aged 18 and over in hh"

egen nwadults=sum(age>=18 & age<60), by(hhid)
label variable nwadults "Number of working-age adults aged between 18 and 60yrs in hh"

egen nwadults15plus=sum(age>=15), by(hhid)
label variable nwadults15plus "Number of adults aged 15 and over in hh"

egen nelderly=sum(age>=60), by(hhid)
label variable nelderly "Number of older people aged 60 and over in hh"

egen has_couple=max(spouse==1 & age>=18), by(hhid)
label variable has_couple "Household head has spouse 18yrs and over in household"
egen childheaded=sum(relation==1 & age<18), by(hhid)
label variable childheaded "Child headed household"

gen has_child = nchildren>0
label variable has_child "Household has children under 18yrs"

gen has_elder = nelderly>0
label variable has_elder "Household has older people aged 60 and over"

gen hhtype = 6
replace hhtype = 2 if has_couple>0 & nchildren==0
replace hhtype = 1 if has_couple>0 & nchildren>0
replace hhtype = 3 if nadults==1 & nchildren>0
replace hhtype = 4 if hhsize==1 & nadults==1 & nchildren==0 & age>=60
replace hhtype = 5 if hhsize==1 & nadults==1 & nchildren==0 & age<60

label define hhtype 1 "Couple household, with children"	///
					2 "Couple household, with no children"		///
					3 "Single-parent household"						///
					4 "One-person household, 60+ years"			///
					5 "One-person household, 18-59 years"	///
					6 "Other household types"
label values hhtype hhtype
label variable hhtype "Household structure"

recode hhsize (1 = 1 "One") (2/3 = 2 "Two or three") (4/5 = 3 "Four or five") (6/max = 4 "Six or more"), gen(hhsize_groups)
label variable hhsize_groups "Household size"

// With skipped generation households
recode hhtype (6 = 7), gen(hhtype2)
replace hhtype2 = 6 if (nchildren>0 & nchildren!=.) & (nelderly>0 & nelderly!=.) & (nwadults==0)

label define hhtype2 	1 "Couple household, with children"	///
			2 "Couple household, with no children"		///
			3 "Single parent/caregiver (<60 years)"						///
			4 "One-person household, 60+ years"			///
			5 "One-person household, 18-59 years"	///
			6 "Skipped generation"	///
			7 "Other household types"
label values hhtype2 hhtype2
label variable hhtype2 "Household structure, including skipped generation"

// With three generation households
gen hhtype3 = 8
replace hhtype3 = 2 if has_couple>0 & nchildren==0
replace hhtype3 = 1 if has_couple>0 & nchildren>0
replace hhtype3 = 3 if nadults==1 & nchildren>0
replace hhtype3 = 4 if hhsize==1 & nadults==1 & nchildren==0 & age>=60
replace hhtype3 = 5 if hhsize==1 & nadults==1 & nchildren==0 & age<60
replace hhtype3 = 6 if (nchildren>0 & nchildren!=.) & (nelderly>0 & nelderly!=.) & (nwadults>0)
replace hhtype3 = 7 if (nchildren>0 & nchildren!=.) & (nelderly>0 & nelderly!=.) & (nwadults==0)


label define hhtype3g 1 "Couple household, with children"    ///
                    2 "Couple household, with no children"        ///
                    3 "Single-carer household"                        ///
                    4 "One-person household, 60+ years"            ///
                    5 "One-person household, 18-59 years"    ///
                    6 "Three generation household"            ///
                    7 "Skipped generation"                    ///
                    8 "Other household types"
label values hhtype3 hhtype3g
label variable hhtype3 "Household structure, including skipped generation and three generation household"

egen nchildren15 = sum(age<=15), by(hhid)
label variable nchildren15 "Number of children aged 15 and under in HH"

// Dependency ratio
gen depratio = (nchildren15 + nelderly) / (hhsize - nchildren15 - nelderly)
label variable depratio "Dependency ratio"

*************************************
*** Adult equivalent scale **
**************************************

gen scale=1

replace scale = 750/3000 if scale!=. & age <1
replace scale = 1150/3000 if scale!=. & age >=1 & age <2
replace scale = 1350/3000 if scale!=. & age >=2 & age <3
replace scale = 1550/3000 if scale!=. & age >=3 & age <5
replace scale = 1850/3000 if scale!=. & age >=5 & age <7 & sex==1
replace scale = 1750/3000 if scale!=. & age >=5 & age <7 & sex==2
replace scale = 2100/3000 if scale!=. & age >=7 & age <10 & sex==1
replace scale = 1800/3000 if scale!=. & age >=7 & age <10 & sex==2
replace scale = 2200/3000 if scale!=. & age >=10 & age <12 & sex==1
replace scale = 1950/3000 if scale!=. & age >=10 & age <12 & sex==2
replace scale = 2550/3000 if scale!=. & age >=12 & age <14 & sex==1
replace scale = 2100/3000 if scale!=. & age >=12 & age <14 & sex==2
replace scale = 2650/3000 if scale!=. & age >=14 & age <15 & sex==1
replace scale = 2250/3000 if scale!=. & age >=14 & age <15 & sex==2
replace scale = 3000/3000 if scale!=. & age >=15 & age <18 & sex==1
replace scale = 2625/3000 if scale!=. & age >=15 & age <60 & sex==2

replace scale = 2580/3000 if scale!=. & age >=60 & age !=. & sex==1
replace scale = 2310/3000 if scale!=. & age >=60 & age !=. & sex==2

egen ae = sum(scale), by(hhid)
drop scale
label variable ae "Adult equivalent scale"


*************************************
***** Disability ********************
*************************************

* onset of disability
egen funcdiff_onset = rowtotal(*onset)
replace funcdiff_onset = . if funcdiff_onset==0
label values funcdiff_onset wgss_onset

drop adult_disab adult_sum adult_score see_ind2 seeing_5to17 hear_ind2 hearing_5to17 ///
	 walk_ind2a walk_ind2b walk_ind2 walking_5to17 selfcare_5to17 com_ind2 ///
	 communication_5to17 learning_5to17 remembering_5to17 concentrating_5to17 ///
	 acceptingchange_5to17 behaviour_5to17 makingfriends_5to17 anxiety_5to17 ///
	 depression_5to17 young_disab young_sum young_score see_ind seeing_2to4 hear_ind ///
	 hearing_2to4 walk_ind walking_2to4 finemotor_2to4 com_ind communication_2to4 ///
	 learning_2to4 playing_2to4 behaviour_2to4 child_disab child_sum child_score ///
	 wgss_onset young_onset child_onset


*Based on the recommended cut-off, the disability indicator includes "a lot more"
*difficulty for the question on controlling behavior, and “a lot of difficulty"
*and "cannot do at all" for all other questions *

* Adult functioning

gen FunctionalDifficulty_Adult = .
label variable FunctionalDifficulty_Adult "Adult with severe functional difficulty"
replace FunctionalDifficulty_Adult = 1 if	(wgss_seeing == 3 | wgss_seeing ==4) |		///
						(wgss_hearing == 3 | wgss_hearing ==4) |	///
						(wgss_walking == 3 | wgss_walking ==4)	|	///
						(wgss_remembering == 3 | wgss_remembering ==4) |	///
						(wgss_selfcare == 3 | wgss_selfcare ==4) |			///
						(wgss_communic == 3 | wgss_communic ==4)
replace FunctionalDifficulty_Adult = 0 if wgss_seeing <=2 &		///
						wgss_hearing <=2 &	///
						wgss_walking <=2 &	///
						wgss_remembering <=2 &	///
						wgss_selfcare <=2 &		///
						wgss_communic <=2

label define funcdiff 0 "No functional difficulty" 1 "With functional difficulty"
label values FunctionalDifficulty_Adult funcdiff

* child functioning	(2to4yrs)
rename child_* child2to4_*

* PART ONE: Creating separate variables per domain of functioning *

* SEEING DOMAIN *
gen SEE_IND = child2to4_seeing2
replace SEE_IND = child2to4_seeing3 if child2to4_seeing2 == .
tab SEE_IND

gen Seeing_2to4 = .
replace Seeing_2to4 = 0 if inrange(SEE_IND, 1, 2)
replace Seeing_2to4 = 1 if inrange(SEE_IND, 3, 4)
label value Seeing_2to4 funcdiff
label variable Seeing_2to4 "Functional difficulty, 2 to 4 year olds: seeing"

* HEARING DOMAIN *
gen HEAR_IND = child2to4_hearing2
replace HEAR_IND = child2to4_hearing3 if child2to4_hearing2 == .
tab HEAR_IND

gen Hearing_2to4 = .
replace Hearing_2to4 = 0 if inrange(HEAR_IND, 1, 2)
replace Hearing_2to4 = 1 if inrange(HEAR_IND, 3, 4)
label value Hearing_2to4 funcdiff
label variable Hearing_2to4 "Functional difficulty, 2 to 4 year olds: hearing"


* WALKING DOMAIN *
gen WALK_IND = child2to4_walking2
replace WALK_IND = child2to4_walking4 if child2to4_walking2 == .
tab WALK_IND

gen Walking_2to4 = .
replace Walking_2to4 = 0 if inrange(WALK_IND, 1, 2)
replace Walking_2to4 = 1 if inrange(WALK_IND, 3, 4)
label value Walking_2to4 funcdiff
label variable Walking_2to4 "Functional difficulty, 2 to 4 year olds: walking"

* FINE MOTOR DOMAIN *
gen FineMotor_2to4 = .
replace FineMotor_2to4 = 0 if inrange(child2to4_finemotor, 1, 2)
replace FineMotor_2to4 = 1 if inrange(child2to4_finemotor, 3, 4)
label value FineMotor_2to4 funcdiff
label variable FineMotor_2to4 "Functional difficulty, 2 to 4 year olds: fine motor"

* COMMUNICATING DOMAIN *
gen COM_IND = 0
replace COM_IND = 4 if (child2to4_communic1 == 4 | child2to4_communic2 == 4)
replace COM_IND = 3 if (COM_IND != 4 & (child2to4_communic1 == 3 | child2to4_communic2 == 3))
replace COM_IND = 2 if (COM_IND != 4 & COM_IND != 3 & (child2to4_communic1 == 2 | child2to4_communic2 == 2))
replace COM_IND = 1 if (COM_IND != 4 & COM_IND != 3 & COM_IND != 1 & (child2to4_communic1 == 1 | child2to4_communic2 == 1))
replace COM_IND = . if ((COM_IND == 2 | COM_IND == 1) & (child2to4_communic1 == . | child2to4_communic2 == .))
tab COM_IND

gen Communication_2to4 = .
replace Communication_2to4 = 0 if inrange(COM_IND, 1, 2)
replace Communication_2to4 = 1 if inrange(COM_IND, 3, 4)
label value Communication_2to4 funcdiff
label variable Communication_2to4 "Functional difficulty, 2 to 4 year olds: communication"

* LEARNING DOMAIN *
gen Learning_2to4 = .
replace Learning_2to4 = 0 if inrange(child2to4_learning, 1, 2)
replace Learning_2to4 = 1 if inrange(child2to4_learning, 3, 4)
label value Learning_2to4 funcdiff
label variable Learning_2to4 "Functional difficulty, 2 to 4 year olds: learning"


* PLAYING DOMAIN *
gen Playing_2to4 = .
replace Playing_2to4 = 0 if inrange(child2to4_playing, 1, 2)
replace Playing_2to4 = 1 if inrange(child2to4_playing, 3, 4)
label value Playing_2to4 funcdiff
label variable Playing_2to4 "Functional difficulty, 2 to 4 year olds: playing"


* BEHAVIOUR DOMAIN *
gen Behaviour_2to4 = .
replace Behaviour_2to4 = 0 if inrange(child2to4_behaviour, 1, 3)
replace Behaviour_2to4 = 1 if child2to4_behaviour == 4
label value Behaviour_2to4 funcdiff
label variable Behaviour_2to4 "Functional difficulty, 2 to 4 year olds: behaviour"


* PART TWO: Creating disability indicator for children age 2-4 years *

gen FunctionalDifficulty_2to4 = 0
replace FunctionalDifficulty_2to4 = 1 if (Seeing_2to4 == 1 | Hearing_2to4 == 1 | Walking_2to4 == 1 | FineMotor_2to4 == 1 | Communication_2to4 == 1 | Learning_2to4 == 1 | Playing_2to4 == 1 | Behaviour_2to4 == 1)
replace FunctionalDifficulty_2to4 = . if (FunctionalDifficulty_2to4 != 1 & (Seeing_2to4 == . | Hearing_2to4 == . | Walking_2to4 == . | FineMotor_2to4 == . | Communication_2to4 == . | Learning_2to4 == . | Playing_2to4 == . | Behaviour_2to4 == .))
label value FunctionalDifficulty_2to4 funcdiff
label variable FunctionalDifficulty_2to4 "Child 2 to 4 with severe functional difficulty"

drop SEE_IND HEAR_IND WALK_IND COM_IND

* child functioning	(5to17yrs)
rename young_* child5to17_*

* PART ONE: Creating separate variables per domain of functioning *

* SEEING DOMAIN *
gen SEE_IND = child5to17_seeing2
replace SEE_IND = child5to17_seeing3 if child5to17_seeing2 == .
tab SEE_IND

gen Seeing_5to17 = .
replace Seeing_5to17 = 0 if inrange(SEE_IND, 1, 2)
replace Seeing_5to17 = 1 if inrange(SEE_IND, 3, 4)
label value Seeing_5to17 funcdiff
label variable Seeing_5to17 "Functional difficulty, 5 to 17 year olds: seeing"


* HEARING DOMAIN *
gen HEAR_IND = child5to17_hearing2
replace HEAR_IND = child5to17_hearing3 if child5to17_hearing2 == .
tab HEAR_IND

gen Hearing_5to17 = .
replace Hearing_5to17 = 0 if inrange(HEAR_IND, 1, 2)
replace Hearing_5to17 = 1 if inrange(HEAR_IND, 3, 4)
label value Hearing_5to17 funcdiff
label variable Hearing_5to17 "Functional difficulty, 5 to 17 year olds: hearing"


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

gen Walking_5to17 = .
replace Walking_5to17 = 0 if inrange(WALK_IND, 1, 2)
replace Walking_5to17 = 1 if inrange(WALK_IND, 3, 4)
label value Walking_5to17 funcdiff
label variable Walking_5to17 "Functional difficulty, 5 to 17 year olds: walking"


* SELFCARE DOMAIN *
gen Selfcare_5to17 = .
replace Selfcare_5to17 = 0 if inrange(child5to17_selfcare, 1, 2)
replace Selfcare_5to17 = 1 if inrange(child5to17_selfcare, 3, 4)
label value Selfcare_5to17 funcdiff
label variable Selfcare_5to17 "Functional difficulty, 5 to 17 year olds: self care"


* COMMUNICATING DOMAIN *
gen COM_IND = 0
replace COM_IND = 4 if (child5to17_communic1 == 4 | child5to17_communic2 == 4)
replace COM_IND = 3 if (COM_IND != 4 & (child5to17_communic1 == 3 | child5to17_communic2 == 3))
replace COM_IND = 2 if (COM_IND != 4 & COM_IND != 3 & (child5to17_communic1 == 2 | child5to17_communic2 == 2))
replace COM_IND = 1 if (COM_IND != 4 & COM_IND != 3 & COM_IND != 1 & (child5to17_communic1 == 1 | child5to17_communic2 == 1))
replace COM_IND = . if ((COM_IND == 2 | COM_IND == 1) & (child5to17_communic1 == . | child5to17_communic2 == .))
tab COM_IND

gen Communication_5to17 = .
replace Communication_5to17 = 0 if inrange(COM_IND, 1, 2)
replace Communication_5to17 = 1 if inrange(COM_IND, 3, 4)
label value Communication_5to17 funcdiff
label variable Communication_5to17 "Functional difficulty, 5 to 17 year olds: communicating"


* LEARNING DOMAIN *
gen Learning_5to17 = .
replace Learning_5to17 = 0 if inrange(child5to17_learning, 1, 2)
replace Learning_5to17 = 1 if inrange(child5to17_learning, 3, 4)
label value Learning_5to17 funcdiff
label variable Learning_5to17 "Functional difficulty, 5 to 17 year olds: learning"

* REMEMBERING DOMAIN *
gen Remembering_5to17 = .
replace Remembering_5to17 = 0 if inrange(child5to17_remember, 1, 2)
replace Remembering_5to17 = 1 if inrange(child5to17_remember, 3, 4)
label value Remembering_5to17 funcdiff
label variable Remembering_5to17 "Functional difficulty, 5 to 17 year olds: remembering"


* CONCENTRATING DOMAIN *
gen Concentrating_5to17 = .
replace Concentrating_5to17 = 0 if inrange(child5to17_concentrating, 1, 2)
replace Concentrating_5to17 = 1 if inrange(child5to17_concentrating, 3, 4)
label value Concentrating_5to17 funcdiff
label variable Concentrating_5to17 "Functional difficulty, 5 to 17 year olds: concentrating"


* ACCEPTING CHANGE DOMAIN *
gen AcceptingChange_5to17 = .
replace AcceptingChange_5to17 = 0 if inrange(child5to17_accept, 1, 2)
replace AcceptingChange_5to17 = 1 if inrange(child5to17_accept, 3, 4)
label value AcceptingChange_5to17 funcdiff
label variable AcceptingChange_5to17 "Functional difficulty, 5 to 17 year olds: accpting change"


* BEHAVIOUR DOMAIN *
gen Behaviour_5to17 = .
replace Behaviour_5to17 = 0 if inrange(child5to17_behaviour, 1, 2)
replace Behaviour_5to17 = 1 if inrange(child5to17_behaviour, 3, 4)
label value Behaviour_5to17 funcdiff
label variable Behaviour_5to17 "Functional difficulty, 5 to 17 year olds: behaviour"


* MAKING FRIENDS DOMAIN *
gen MakingFriends_5to17 = .
replace MakingFriends_5to17 = 0 if inrange(child5to17_friends, 1, 2)
replace MakingFriends_5to17 = 1 if inrange(child5to17_friends, 3, 4)
label value MakingFriends_5to17 funcdiff
label variable MakingFriends_5to17 "Functional difficulty, 5 to 17 year olds: making friends"


* ANXIETY DOMAIN *
gen Anxiety_5to17 = .
replace Anxiety_5to17 = 0 if inrange(child5to17_anxiety, 2, 5)
replace Anxiety_5to17 = 1 if (child5to17_anxiety == 1)
label value Anxiety_5to17 funcdiff
label variable Anxiety_5to17 "Functional difficulty, 5 to 17 year olds: axiety"


* DEPRESSION DOMAIN *
gen Depression_5to17 = .
replace Depression_5to17 = 0 if inrange(child5to17_depressed, 2, 5)
replace Depression_5to17 = 1 if (child5to17_depressed == 1)
label value Depression_5to17 funcdiff
label variable Depression_5to17 "Functional difficulty, 5 to 17 year olds: depression"


* PART TWO: Creating disability indicator for children age 5-17 years *

gen FunctionalDifficulty_5to17 = 0
replace FunctionalDifficulty_5to17 = 1 if (Seeing_5to17 == 1 | Hearing_5to17 == 1 | Walking_5to17 == 1 | Selfcare_5to17 == 1 | Communication_5to17 == 1 | Learning_5to17 == 1 | Remembering_5to17 == 1 | Concentrating_5to17 == 1 | AcceptingChange_5to17 == 1 | Behaviour_5to17 == 1 | MakingFriends_5to17 == 1 | Anxiety_5to17 == 1 | Depression_5to17 == 1)
replace FunctionalDifficulty_5to17 = . if (FunctionalDifficulty_5to17 != 1 & (Seeing_5to17 == . | Hearing_5to17 == . | Walking_5to17 == . | Selfcare_5to17 == . | Communication_5to17 == . | Learning_5to17 == . | Remembering_5to17 == . | Concentrating_5to17 == . | AcceptingChange_5to17 == . | Behaviour_5to17 == . | MakingFriends_5to17 == . | Anxiety_5to17 == . | Depression_5to17 == .))
label value FunctionalDifficulty_5to17 funcdiff
label variable FunctionalDifficulty_5to17 "Child 5 to 17 with severe functional difficulty"

drop COM_IND WALK_IND2 WALK_IND1 WALK_IND HEAR_IND SEE_IND

gen __DISABILIY__ = .
order __DISABILIY__ wgss_* child2to4_* child5to17_*, before(funcdiff_onset)

egen FunctionalDifficulty = rowtotal(FunctionalDifficulty_*)
replace FunctionalDifficulty = . if FunctionalDifficulty_2to4==. & FunctionalDifficulty_5to17==. & FunctionalDifficulty_Adult==.
label variable FunctionalDifficulty "Person with severe functional difficulty"

gen FunctionalDifficulty_100 = FunctionalDifficulty*100
label variable FunctionalDifficulty_100 "Person with severe functional difficulty"

egen hh_disab = max(FunctionalDifficulty), by(hhid)
label variable hh_disab "Household with person with severe functional difficulty"


* PART THREE: creating additional indicators

*number of functional limitations (individual)
gen temp = 	(wgss_seeing>=3 & wgss_seeing!=.) + ///
			(wgss_hearing>=3 & wgss_hearing!=.) +  ///
			(wgss_walking>=3 & wgss_walking!=.) +  ///
			(wgss_remembering>=3 & wgss_remembering!=.) +  ///
			(wgss_selfcare>=3 & wgss_selfcare!=.) +  ///
			(wgss_communic>=3 & wgss_communic!=.) + ///
			(Seeing_5to17==1 & Seeing_5to17!=.) + ///
			(Hearing_5to17==1 & Hearing_5to17!=.) + ///
			(Walking_5to17==1 & Walking_5to17!=.) + ///
			(Selfcare_5to17==1 & Selfcare_5to17!=.) + ///
			(Communication_5to17==1 & Communication_5to17!=.) + ///
			(Learning_5to17==1 & Learning_5to17!=.) + ///
			(Remembering_5to17==1 & Remembering_5to17!=.) + ///
			(Concentrating_5to17==1 & Concentrating_5to17) + ///
			(AcceptingChange_5to17==1 & AcceptingChange_5to17!=.) + ///
			(Behaviour_5to17==1 & Behaviour_5to17!=.) + ///
			(MakingFriends_5to17==1 & MakingFriends_5to17!=.) + ///
			(Anxiety_5to17==1 & Anxiety_5to17!=.) + ///
			(Depression_5to17==1 & Depression_5to17!=.) + ///
			(Seeing_2to4==1 & Seeing_2to4!=.) + ///
			(Hearing_2to4==1 & Hearing_2to4!=.) + ///
			(Walking_2to4==1 & Walking_2to4!=.) + ///
			(FineMotor_2to4==1 & FineMotor_2to4!=.) + ///
			(Communication_2to4==1 & Communication_2to4!=.) + ///
			(Learning_2to4==1 & Learning_2to4!=.) + ///
			(Playing_2to4==1 & Playing_2to4!=.) + ///
			(Behaviour_2to4==1 & Behaviour_2to4!=.)
			
recode temp (0 = 0 "No limitation") (1 = 1 "One severe limitation") (2/3 = 2 "2-3 severe limitations")  (4/max = 3 "4+ severe limitations"), gen(n_sevdisab)
label variable n_sevdisab "Number of limitations - at least a lot of difficulty"

replace n_sevdisab =. if FunctionalDifficulty==.

* number of functional limitations (household)
egen hh_temp = sum(temp), by(hhid)
recode hh_temp (0 = 0 "No limitation") (1 = 1 "One severe limitation") (2/3 = 2 "2-3 severe limitations")  (4/max = 3 "4+ severe limitations"), gen(hh_n_sevdisab)
		label variable hh_n_sevdisab "Number of limitations in household - at least a lot of difficulty"
		replace hh_n_sevdisab =. if hh_disab==.

			drop temp hh_temp

* disabled child/adult identifier
egen hh_disab_child = max(FunctionalDifficulty_2to4==1 | FunctionalDifficulty_5to17==1), by(hhid)
egen hh_disab_adult = max(FunctionalDifficulty_Adult==1), by(hhid)

* 


