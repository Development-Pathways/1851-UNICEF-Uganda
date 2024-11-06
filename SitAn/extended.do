*************************************
*************************************

/* This do file cleans the raw listing dataset and constructs basic demographic variables all in one person level dta */

*************************************
***** HH ID *************************
*************************************

cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019"

use "dta/hhid.dta", clear

merge 1:1 hhid using "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/dta/weights.dta", nogenerate keep(3)

gen interview__key = interview_key_ext
gen interview__id = interview_id_ext

drop if interview_key_ext==""

merge 1:n interview__key interview__id using "raw/extended/combined/hh_roster.dta", nogenerate keep(3)
drop interview__key interview__id
gen interview__key = interview_key_list
gen interview__id = interview_id_list
merge 1:1 interview__key interview__id hh_roster__id hh_list sex age relation marital spouse1 mother using "raw/listing/hh_roster.dta", keepusing(mother_id pcare_id spouse2__*) update
drop if _m==2
drop _m

drop interview__key interview__id
gen interview__key = interview_key_ext
gen interview__id = interview_id_ext

*Person id number
sort interview_key_ext hh_roster__id
egen pid = seq(), by(interview_key_ext)
order pid, before(hh_roster__id)

*************************************
***** Demographics / Disability *****
*************************************

* came from the listing dataset
run "scripts/roster_demographics.do"

** Dwarfism and Albinism
preserve
use "raw/extended/combined/extended.dta", clear
keep interview__key albinism__* hh_albinism
rename interview__key interview_key_ext
reshape long albinism__, i(interview hh_albinism) j(pid)
drop if albinism__==. | albinism__==.a
drop pid
gen has_albinism = 1
label variable has_albinism "Household member has albinism"
rename albinism__ hh_roster__id

save "dta/auxiliary/albinism.dta", replace
restore


merge 1:1 interview_key_ext hh_roster__id using "dta/auxiliary/albinism.dta", nogenerate
replace has_albinism = 0 if has_albinism!=1

preserve
use "raw/extended/combined/extended.dta", clear
keep interview__key dwarfism__*
rename interview__key interview_key_ext
reshape long dwarfism__ , i(interview) j(pid)
drop if dwarfism__==. | dwarfism__==.a
drop pid
gen has_dwarfism = 1
label variable has_dwarfism "Household member has dwarfism"
rename dwarfism__ hh_roster__id

save "dta/auxiliary/dwarfism.dta", replace
restore

merge 1:1 interview_key_ext hh_roster__id using "dta/auxiliary/dwarfism.dta", nogenerate
replace has_dwarfism = 0 if has_dwarfism!=1

*************************************
***** Education *********************
*************************************

gen __EDUCATION__ = .
order __EDUCATION__, before(educ_attend)

recode highest_grade (17 = 3) (11/17 = 2) (21/23 = 1) (31/35 = 4) (36 = 5)
	lab def highest_grade 3 "Completed Primary" 2 "Completed some primary education" 1 "Completed nursery" 4 "Completed some secondary education" 5 "Completed Secondary", add

*************************************
***** Health ************************
*************************************

gen __HEALTH__ = .
order __HEALTH__, after(educ_total_cost)

rename health1 suffered_illness
rename health3 days_suffer_illness
rename health4 days_nwork_illness
rename health5__0 major_sympton1
label variable major_sympton1 "Major symptom of illness or injury suffered from during the last 30 days?"
rename health5__1 major_sympton2
label variable major_sympton2 "Second symptom of illness or injury suffered from during the last 30 days?"
drop health5__*

label define sympton  1	"Diarrhoea (acute)" ///
											2	"Diarrhoea (chronic, 1 month or more)" ///
											3	"Weight loss (major)" ///
											4	"Fever (acute)" ///
											5	"Fever (recurring)" ///
											6	"Malaria" ///
											7	"Skin rash" ///
											8	"Weakness" ///
											9	"Severe headache" ///
											10 "Fainting" ///
											11	"Chills (feeling hot and cold)" ///
											12	"Vomiting" ///
											13	"Cough" ///
											14	"Coughing blood" ///
											15	"Pain on passing urine" ///
											16	"Genital sores" ///
											17	"Mental disorder" ///
											20	"Abdominal pain" ///
											21	"Sore throat" ///
											22	"Difficulty breathing" ///
											23	"Burn" ///
											24	"Fracture" ///
											25	"Wound" ///
											26	"Childbirth related" ///
											96	"Other"

label values major_sympton* sympton
rename health6 consult_illness
rename health7 reason_noconsult

*************************************
***** Assistance ********************
*************************************

gen __ASSISTANCE__ = .
order __ASSISTANCE__, after(health_exp_total)

rename pno_assist_a need_passistance
label variable need_passistance "Personal assistance needed"

*************************************
***** Work/Income *******************
*************************************

gen __WORK_INCOME__ = .
order __WORK_INCOME__, before(ever_work)
merge n:1 interview__key interview__id using "raw/extended/combined/extended.dta", nogenerate keep(1 3) keepusing(income_rent-income_tot_brac6)
order income_rent-income_tot_brac6, after(scg_benefit)

gen neet_15to24 = ever_work==2 & (educ_attend!=3 | ( work_situation==1 | work_situation==6 | work_situation==7)) if age>=15 & age<=24
gen neet_15to29 = ever_work==2 & (educ_attend!=3 | ( work_situation==1 | work_situation==6 | work_situation==7)) if age>=15 & age<=29

label define neetyesno 0 "No" 1 "Yes"
label values neet_15* neetyesno
label variable neet_15to24 "NEET status: Not in employment, education or training, 15 to 24 year olds"
label variable neet_15to29 "NEET status: Not in employment, education or training, 15 to 29 year olds"

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

	replace income_nwork = 250000 if (income_tot==98 | income_tot==99) & income_nwork_rng==1
	replace income_nwork = 500000 if (income_tot==98 | income_tot==99) & income_nwork_rng==2
	replace income_nwork = 1000000 if (income_tot==98 | income_tot==99) & income_nwork_rng==3
	replace income_nwork = 2000000 if (income_tot==98 | income_tot==99) & income_nwork_rng==4
	replace income_nwork = 5000000 if (income_tot==98 | income_tot==99) & income_nwork_rng==5
	replace income_nwork = 10000000 if (income_tot==98 | income_tot==99) & (income_nwork_rng==6 | income_nwork_rng==7)

egen hh_income = rowtotal(income_work income_nwork)
egen share_nwork = max(income_nwork/hh_income), by(hhid)

	lab var share_nwork "Share of household total income that comes from non-work"
	lab var income_nwork_rng "Annual household income range from non-work related activites"
	label var income_nwork "Annual household income from non-work related activites"
	label var income_work "Annual household income from work related activities"
	lab var hh_income "Total annual household income"

gen employed = (work_situation==2 | work_situation==3 | work_situation==4) & ever_work==1
	lab var employed "Employed - working for a wage"

gen employed_100 = employed*100
	lab var employed_100 "Employed - working for a wage"


*************************************
***** Perceptions *******************
*************************************

gen __PERCEPTIONS__ = .
preserve
use "raw/extended/combined/extended.dta", clear

keep interview__key interview__id pwd_*
gen hh_roster__id = pwd_personanswer

save "dta/auxiliary/perceptions.dta", replace
restore

merge 1:1 interview__key interview__id hh_roster__id using "dta/auxiliary/perceptions.dta", nogenerate keep(1 3)

compress
label data "Person extended dataset, UCLDS 2019"
save "dta/per_extended.dta", replace

*// Household extended dataset

use "raw/extended/combined/extended.dta", clear

// Remove interviews rejected by supervisors (likely to be repeated so they are duplicated)
drop if interview__status == 65

keep interview__key interview__id ea district subcounty urban parish village gps__Latitude ///
	 gps__Longitude gps__Accuracy gps__Altitude gps__Timestamp supervisor ///
	 visit_int laguange_int listing_date consent reschedule int_consent int_reschedule hh_list__0 hh_albinism hh_dwarfism ///
	 food_time know_food food_time_end rent rent_utils rent_period end_cons_time /// Expenditure
	 interview__status assignment__id interview_result end_time

rename interview__key interview_key_ext
rename interview__id interview_id_ext

*Name of household head
rename hh_list__0 head_name
label variable head_name "Name of household head"

** Fix subcounty code for replacement EAs (Rutabo I, Nyakagongo, Kirima)
replace subcounty = 413103 if ea == "Rutabo I"
replace subcounty = 405301 if ea == "Nyakagongo"

label define subcounty 413103 "Bwizi" 405301 "Eastern Division", add

** create hhousehold id variable
merge 1:n interview_key_ext using "dta/hhid.dta", nogenerate keep(3)

order hhid, first

gen sampled = interview_key_ext!=""
order sampled interview_key_ext interview_id_ext, after(hhid)

merge 1:n hhid using "dta/per_extended.dta", nogenerate keep(3)

merge n:1 hhid using "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/dta/weights.dta", nogenerate keep(3)

order has_dwarfism has_albinism hh_albinism hh_dwarfism, after(hh_disab)
order __DEMOGRAPHICS__, before(sex)
order age, after(age5yrs)
order hh_nodifficulty hh_moddisab hh_sevdisabled hh_sevdisabled_grp hh_max_disability_score order pik distance, after(hh_dwarfism)
order sample_status - region, after(hhid)
drop interview__status

** Label variables and values

label define yesno 1 "Yes" 0 "No"

label values hh_nodifficulty hh_moddisab hh_sevdisabled yesno
*************************************
***** Shocks ************************
*************************************

gen __SHOCKS__ = .
preserve
run "scripts/ext_shocks.do"
restore
merge n:1 interview_key_ext interview_id_ext using "dta/ext_shocks.dta", nogenerate keep(1 3)

*************************************
***** Assets ************************
*************************************

gen __ASSETS__ = .
preserve
run "scripts/ext_assets.do"
restore
merge n:1 interview__key interview__id using "raw/extended/combined/extended.dta", nogenerate keep(1 3) keepusing(dwelling_type - assets_bank)
merge n:1 hhid using "dta/ext_assetindex.dta", nogenerate keep(1 3)
merge n:1 interview_key_ext interview_id_ext using "dta/ext_livestock.dta", nogenerate keep(1 3)
order numlivestock_*, after(livestock_type__96)

egen num_animals = rowtotal(numlivestock_*)
	lab var num_animals "Number of livestock owned by the household"
*************************************
***** Expenditure *******************
*************************************

gen __EXPENDITURE__ = .
order food_time know_food food_time_end rent rent_utils rent_period end_cons_time, after(__EXPENDITURE__)
preserve
run "scripts/ext_expenditure_master.do"
restore
merge n:1 interview__key interview__id using "dta/hh_expenditure.dta", nogenerate keep(1 3)


gen pc_exp = hh_exp_total/hhsize
gen ae_exp = hh_exp_total/ae

xtile temp = pc_exp [aw=wgt2] if pid==1, n(5) // quintiles household level welfare
	egen quints = max(temp), by(hhid)
		drop temp

xtile temp = pc_exp [aw=wgt2] if pid==1, n(10) // deciles household level welfare
	egen decile = max(temp), by(hhid)
		drop temp

xtile temp = pc_exp [aw=wgt2] if pid==1, n(100)	// percentiles household level welfare
	egen pctiles = max(temp), by(hhid)
		drop temp

cumul pc_exp [aw = wgt2] if pid==1, gen(cdf_temp)
	egen cdf_exp = max(cdf_temp), by(hhid)
		drop cdf_temp

gen temp = food_all_exp_total/hh_exp_total if pid==1 // share of household expenditure on food
	egen food_share = max(temp), by(hhid)
		drop temp

gen health_09 = health_exp_total/(166.57/100)
gen food_09 = food_all_exp_total/(185.98/100)
gen clothing_09 = clothing_exp_total/(209.93/100)
gen recreation_09 = recreation_exp_total/(139.82/100)
gen comm_09 = communications_exp_total/(98.34/100)
gen transport_09 = transport_exp_total/(164.09/100)
gen tobacco_09 = tobacco_exp_total/(161.39/100)
gen personal_09 =  personalcare_exp_total/(183.05/100)
gen durable_09 =  durables_exp_total/(193.77/100)
gen educ_09 =  educ_exp_total_hh/(222.01/100)
gen rent_09 = rent_exp_total/(205.44/100)
gen housing_09 = housing/(205.44/100)

egen exp09 = rowtotal(*_09)
gen pc_exp09 = exp09/hhsize
gen ae_exp09 = exp09/ae

				drop *_09

	egen regurb = group(region urban)

gen spline = 46233.65 if regurb==1 // central - urban 2009/10
	replace spline = 42584 if regurb==2 & spline==. // central - rural 2009/10
	replace spline = 44187.74 if regurb==3 & spline==. // easter - urban 2009/10
	replace spline = 41245.18 if regurb==4 & spline==. // easter - rural 2009/10
	replace spline = 43190.13 if regurb==5 & spline==. // western - urban 2009/10
	replace spline = 40558.76 if regurb==6 & spline==. // western - rural 2009/10
	replace spline = 43537.83 if regurb==7 & spline==. // northern - urban 2009/10
	replace spline = 41684.79 if regurb==8 & spline==. // northern - rural 2009/10


gen poor_2019 = ae_exp09<spline

label variable hh_exp_total "Total household expenditure"
label variable pc_exp "Household per capita expenditure"
label variable ae_exp "Household per adult equivalent expenditure"
label variable quints "Quintiles of household per capita expenditure, household level"
label variable decile "Deciles of household per capita expenditure, household level"
label variable pctiles "Percentiles of household per capita expenditure, household level"
label variable cdf_exp "Estimated CDF of household per capita expenditure, household level"
label variable food_share "Share of household expenditure spent on food"
label variable exp09 "Total household expenditure in 2009/10 prices"
label variable pc_exp09 "Household per capita expenditure in 2009/10 prices"
label variable ae_exp09 "Household adult equivalent expenditure in 2009/10 prices"
label variable spline "Regional x urban poverty lines in 2009/10 prices"
label variable poor_2019 "Household living below the poverty line"

*************************************
***** WFP indicators ****************
*************************************

gen __WFP__ = .
preserve
run "scripts/ext_wfp_indicators.do"
restore
merge n:1 interview__key using "dta/wfp_indicators_edit.dta", nogenerate keep(1 3)


*************************************
***** Save **************************
*************************************

compress
label data "Extended dataset, UCLDS 2019"
save "dta/extended.dta", replace


erase "dta/auxiliary/perceptions.dta"
erase "dta/auxiliary/albinism.dta"
erase "dta/auxiliary/dwarfism.dta"
