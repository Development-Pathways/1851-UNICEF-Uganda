// SIMULATIONS FOR CHILD DISABILITY BENEFIT IN UGANDA //

/*
// merge population data from census 2024

import excel "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/Data/NPHC-2024-Preliminary-Tables-upload.xlsx", sheet("Population size by sex, 2024 ") cellrange(A3:D179) firstrow clear

drop if missing(Total)

tempfile pop
save `pop'
*/

* import excel "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/Data/pop_by_district_2024.xlsx", sheet("pop") firstrow clear
* save "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/Data/pop_by_district_2024.dta"
* use "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/Data/Processed data/uclds2019.dta", clear

do "~/Documents/GitHub/1851-UNICEF-Uganda/DISABILITY_2024.do"

decode district, gen(District)

merge m:1 District using "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/Data/pop_by_district_2024.dta", keep(3)

/*
* disability 0-2 
tab funcdiff_onset [aw=wgt1], miss // since birth = 2.7%

* average poverty by region
tab Region poor_2019 [aw=wgt1], row nofreq
* average poverty in Buganda districts
tab District poor_2019 if Region=="Buganda" [aw=wgt1], row nofreq
*/

set seed 999 
gen disab_below2 = runiform()<=0.027 if age<2

gen severe = (disab_below2==1 |SSHD_2to4==4 | SSHD_5to17==4)
gen moderate = (SSHD_2to4==3| SSHD_5to17==3)

gen pilotsite = (District=="Kassanda"|District=="Nakasongola"|District=="Rakai"|District=="Mukono")
gen other_buganda = (Region=="Buganda" & pilotsite==0)

// COVERAGE BY YEAR - GRADUAL EXPANSION //

gen sev_2025 = (severe==1 & age<=12 & pilotsite==1)

* gen sev_2026 = (severe==1 & age<=12 & pilotsite==1)

gen sev_2027 = (severe==1 & age<=12 & (pilotsite==1|Region=="Acholi"))

gen sev_2028 = (severe==1 & age<=13 & (pilotsite==1|Region=="Acholi"|Region=="Lango"))

gen sev_2029 = (severe==1 & age<=14 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"))

gen sev_2030 = (severe==1 & age<=15 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"))

gen sev_2031 = (severe==1 & age<=16 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"))

gen sev_2032 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"))

gen sev_2033 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"))

gen sev_2034 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"))

gen sev_2035 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"))

gen sev_2036 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"|Region=="Bukedi"))

gen sev_2037 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"|Region=="Bukedi"|other_buganda==1))

gen sev_2038 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"))

gen sev_2039 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"|Region=="Kampala"))

gen sev_2040 = (severe==1 & age<=17)

* option 2

gen mod_2025 = (moderate==1 & age<=12 & pilotsite==1)

* gen mod_2026 = (moderate==1 & age<=12 & pilotsite==1)

gen mod_2027 = (moderate==1 & age<=12 & (pilotsite==1|Region=="Acholi"))

gen mod_2028 = (moderate==1 & age<=13 & (pilotsite==1|Region=="Acholi"|Region=="Lango"))

gen mod_2029 = (moderate==1 & age<=14 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"))

gen mod_2030 = (moderate==1 & age<=12 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"))

gen mod_2031 = (moderate==1 & age<=13 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"))

gen mod_2032 = (moderate==1 & age<=14 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"))

gen mod_2033 = (moderate==1 & age<=15 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"))

gen mod_2034 = (moderate==1 & age<=16 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"))

gen mod_2035 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"))

gen mod_2036 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"|Region=="Bukedi"))

gen mod_2037 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"|Region=="Bukedi"|other_buganda==1))

gen mod_2038 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"))

gen mod_2039 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|Region=="Tooro"|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"|Region=="Kampala"))

gen mod_2040 = (moderate==1 & age<=17)

* 50% take-up
foreach var of varlist sev_* mod_* {
	set seed 999 
	replace `var' = runiform()<0.5 if `var'==1
}	

* wider beneficiaries

foreach var of varlist sev_* {
	egen hh_`var' = max(`var'), by(hhid)
}

* tab age5yrs hh_sev_2025
* tab decile hh_sev_2025

// CONSUMPTION

gen tv_op1_2025 = 100000/hhsize if sev_2025

gen exp_op1_2025 = pc_exp + tv_op1_2025

mean pc_exp exp_op1_2025, over(decile)

// POVERTY

* gen poor_2019 = ae_exp09<spline

