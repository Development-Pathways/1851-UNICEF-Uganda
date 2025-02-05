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

* disability 0-2 
tab funcdiff_onset [aw=wgt1], miss // since birth = 2.7%

gen severe_adult = (wgss_seeing==4 | wgss_hearing==4 | wgss_walking==4 | wgss_remembering==4 | wgss_selfcare==4 | wgss_communic==4)

tab funcdiff_onset severe_adult [aw=wgt1], miss cell nofreq // 2.6% moderate 0.10% severe

* average poverty by region
tab Region poor_2019 [aw=wgt1], row nofreq
* average poverty in Buganda districts
tab District poor_2019 if Region=="Buganda" [aw=wgt1], row nofreq
*/

set seed 999 
gen disab_below2 = runiform()<=0.027 if age<2

gen severe = (disab_below2==1 |SSHD_2to4==4 | SSHD_5to17==4)
gen moderate = (SSHD_2to4==3| SSHD_5to17==3)

gen pilotsite = (District=="Kassanda"|District=="Mubende"|District=="Kyegegwa"|District=="Kabarole")

gen other_buganda = (Region=="Buganda" & pilotsite==0)
gen other_tooro = (Region=="Tooro" & pilotsite==0)

// COVERAGE BY YEAR - GRADUAL EXPANSION //

gen sev_2025 = (severe==1 & age<=12 & pilotsite==1)

gen sev_2026 = (severe==1 & age<=12 & pilotsite==1)

gen sev_2027 = (severe==1 & age<=12 & (pilotsite==1|Region=="Acholi"))

gen sev_2028 = (severe==1 & age<=13 & (pilotsite==1|Region=="Acholi"|Region=="Lango"))

gen sev_2029 = (severe==1 & age<=14 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"))

gen sev_2030 = (severe==1 & age<=15 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"))

gen sev_2031 = (severe==1 & age<=16 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"))

gen sev_2032 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"))

gen sev_2033 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"))

gen sev_2034 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"))

gen sev_2035 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1))

gen sev_2036 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"))

gen sev_2037 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1))

gen sev_2038 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"))

gen sev_2039 = (severe==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"|Region=="Kampala"))

gen sev_2040 = (severe==1 & age<=17)

* option 2

gen mod_2025 = (moderate==1 & age<=12 & pilotsite==1)

gen mod_2026 = (moderate==1 & age<=12 & pilotsite==1)

gen mod_2027 = (moderate==1 & age<=12 & (pilotsite==1|Region=="Acholi"))

gen mod_2028 = (moderate==1 & age<=13 & (pilotsite==1|Region=="Acholi"|Region=="Lango"))

gen mod_2029 = (moderate==1 & age<=14 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"))

gen mod_2030 = (moderate==1 & age<=12 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"))

gen mod_2031 = (moderate==1 & age<=13 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"))

gen mod_2032 = (moderate==1 & age<=14 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"))

gen mod_2033 = (moderate==1 & age<=15 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"))

gen mod_2034 = (moderate==1 & age<=16 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"))

gen mod_2035 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1))

gen mod_2036 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"))

gen mod_2037 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1))

gen mod_2038 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"))

gen mod_2039 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"|Region=="Kampala"))

gen mod_2040 = (moderate==1 & age<=17)

* 50% take-up
foreach var of varlist sev_* mod_* {
	set seed 999 
	replace `var' = runiform()<0.5 if `var'==1
}	

tab1 sev_20*

* wider beneficiaries

foreach var of varlist sev_* {
	egen hh_`var' = max(`var'), by(hhid)
}

* tab age5yrs hh_sev_2025
* tab decile hh_sev_2025

******************************
keep if !missing(pc_exp) 
******************************

// CONSUMPTION

forval yy = 25/40 {
	
	gen tv_sev_20`yy' = 100000 if sev_20`yy'==1
*	gen tv_mod_20`yy' = 50000 if mod_20`yy'==1
	
	egen tv_sev_20`yy'_pc = total(tv_sev_20`yy'), by(hhid)
	replace tv_sev_20`yy'_pc = tv_sev_20`yy'_pc/hhsize
	
	egen exp_op1_20`yy' = rowtotal(pc_exp tv_sev_20`yy'_pc)
		gen D_exp_op1_20`yy' = (exp_op1_20`yy'-pc_exp)/pc_exp

*	egen exp_op3_20`yy' = rowtotal(pc_exp tv_sev_20`yy' tv_mod_20`yy')
}




* option 1
mean pc_exp exp_op1_* 

mat A = J(1,1,.)
forval yy = 25/40 {
	su D_exp_op1_20`yy' if sev_20`yy'==1
	mat A = A \ r(mean)
}
mat list A

* option 2
mean pc_exp exp_op1_2025-exp_op1_2029 // exp_op2_2030-exp_op2_2040
* option 3
mean pc_exp

mean pc_exp exp_op1_2025, over(decile)

// POVERTY

* gen poor_2019 = ae_exp09<spline
gen pov_base = pc_exp09<spline // 15.20749

gen spline19 = spline*(pc_exp/pc_exp09)
* gen pov_check = pc_exp<spline19 // 15.20748

forval yy = 25/40 {
	gen poor_op1_20`yy' = exp_op1_20`yy'<spline19
}

mean poor_op1_20*

forval yy = 25/40 {
	mean poor_op1_20`yy' if sev_20`yy'==1
}

mean poor_2019 poor_op1_2025, over(age5yrs)
