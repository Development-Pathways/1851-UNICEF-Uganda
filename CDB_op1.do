// SIMULATIONS FOR CHILD DISABILITY BENEFIT IN UGANDA //

do "~/Documents/GitHub/1851-UNICEF-Uganda/DISABILITY_2024.do"

decode district, gen(District)
merge m:1 District using "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/Data/pop_by_district_2024.dta", keep(3)

sort hhid
set seed 999 
gen disab_below2_mod = runiform()<=0.026 if age<2

sort hhid
set seed 999 
gen disab_below2_sev = runiform()<=0.001 if age<2 & disab_below2_mod!=1

gen severe = (disab_below2_sev==1 |SSHD_2to4==4 | SSHD_5to17==4)
gen moderate = (disab_below2_mod==1 |SSHD_2to4==3| SSHD_5to17==3)

gen pilotsite = (District=="Kassanda"|District=="Mubende"|District=="Kyegegwa"|District=="Kabarole")

gen other_buganda = (Region=="Buganda" & pilotsite==0)
gen other_tooro = (Region=="Tooro" & pilotsite==0)

******************************
keep if !missing(wgt2) 
******************************

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

/*
tab age pilotsite if severe==1
tab age Region if severe==1
tab age other_buganda if severe==1
tab age other_tooro if severe==1
tab1 sev_20* // n. of beneficiaries in sample
*/

* 50% take-up
foreach var of varlist sev_* {
	sort hhid
	set seed 999 
	replace `var' = runiform()<0.5 if `var'==1
}	

* wider beneficiaries

foreach var of varlist sev_* {
	egen hh_`var' = max(`var'), by(hhid)
}

// CONSUMPTION

* winsorise & convert 
gen cpi2017 = 102.741 
gen cpi2019 = 107.612
gen cpi2025 = 137.904

sort hhid
set seed 111
winsor2 pc_exp, by(Region)
replace pc_exp_w = pc_exp_w * cpi2025/cpi2019

sort hhid
set seed 111
winsor2 hh_exp_total, by(Region)
replace hh_exp_total_w = hh_exp_total_w * cpi2025/cpi2019

xtile temp = pc_exp_w [aw=wgt2] if pid==1, n(10) // deciles household level welfare
egen decile_w = max(temp), by(hhid)
drop temp

/*
forval yy = 25/40 {
	
	gen tv_sev_20`yy' = 50000 if sev_20`yy'==1	
	egen tv_sev_20`yy'_pc = total(tv_sev_20`yy'), by(hhid)
	replace tv_sev_20`yy'_pc = tv_sev_20`yy'_pc/hhsize
	
	egen exp_20`yy' = rowtotal(pc_exp_w tv_s,ev_20`yy'_pc)
	gen D_exp_20`yy' = (exp_20`yy'-pc_exp_w)/pc_exp_w
}
*/

forval yy = 25/40 {
**# Bookmark #3
	gen tv_sev_20`yy' = 50000 if sev_20`yy'==1	
	egen tv_sev_20`yy'_hh = total(tv_sev_20`yy'), by(hhid)
	
	egen exp_20`yy' = rowtotal(hh_exp_total_w tv_sev_20`yy'_hh)
	
	gen exp_20`yy'_pc = exp_20`yy'/hhsize 
	
	gen D_exp_20`yy' = (exp_20`yy'-hh_exp_total_w)/hh_exp_total_w
	gen D_exp_20`yy'_pc = (exp_20`yy'_pc-pc_exp_w)/pc_exp_w
}

/*
mat A = J(1,1,.)
forval yy = 25/40 {
	su pc_exp_w if hh_sev_20`yy'==1 & pid==1 [aw=wgt2] // among beneficiary households
	mat A = A \ r(mean)
}

mat B = J(1,1,.)
forval yy = 25/40 {
	su exp_20`yy' if hh_sev_20`yy'==1 & pid==1 [aw=wgt2] // among beneficiary households
	mat B = B \ r(mean)
}

mat C = J(1,1,.)
forval yy = 25/40 {
	su D_exp_20`yy' if hh_sev_20`yy'==1 & pid==1 [aw=wgt2] // among beneficiary households
	mat C = C \ r(mean)
}

mat A = A, B, C 
mat list A

*/

/*
encode Region, gen(region2)
mean D_exp_2040 if (severe==1|moderate==1) & age<18 [aw=wgt2], over(region2) // children with disability
*/

*br hhid age severe pc_exp_w tv_sev_2040* *exp_2040 if Region=="Acholi" & severe==1 

// POVERTY

* gen poor_2019 = ae_exp09<spline
gen pov_base = pc_exp09<spline // 15.20749

gen spline19 = spline*(pc_exp/pc_exp09)
* gen pov_check = pc_exp<spline19 // 15.20748
replace spline19 = spline19 * cpi2025/cpi2019
egen spline_avg = mean(spline19)

// international poverty lines
gen ppp2017 = 1219.19 //https://data.worldbank.org/indicator/PA.NUS.PRVT.PP?locations=UG

gen cf = ppp2017*(cpi2025/cpi2017)*(365/12)

gen ipl215 = cf * 2.15
label variable ipl215 "International poverty line of PPP$2.15 per person per day, annualised in 2019 LCU"

gen ipl365 = cf * 3.65
label variable ipl365 "International poverty line of PPP$3.65 per person per day, annualised in 2019 LCU"

gen ipl658 = cf * 6.58
label variable ipl658 "International poverty line of PPP$6.58 per person per day, annualised in 2019 LCU"

/* Create FGT poverty measures
label define poor 0 "Above poverty line" 1 "Below poverty line"
foreach var of varlist spline_avg ipl* {
	gen poor = .
	replace poor = 0 if cons_pc != .
	replace poor = 1 if cons_pc <= `var' & cons_pc != .
	gen p0_`var' = poor * ((`var'- cons_pc)/`var')^0
	gen p1_`var' = poor * ((`var'- cons_pc)/`var')^1
  	gen p2_`var' = poor * ((`var'- cons_pc)/`var')^2
  label values p0_`var' poor
  label variable p0_`var' "Poverty status"
  label variable p1_`var' "Poverty gap"
   label variable p2_`var' "Poverty severity"
	drop poor
}
*/

foreach exp of varlist pc_exp_w exp_20*_pc {
	foreach line of varlist spline_avg ipl* {
		gen poor = .
		replace poor = 0 if `exp' != .
		replace poor = 1 if `exp' <= `line' & `exp' != .
		gen p0_`line'_`exp' = poor * ((`line'- `exp')/`line')^0
		gen p1_`line'_`exp' = poor * ((`line'- `exp')/`line')^1
		gen p2_`line'_`exp' = poor * ((`line'- `exp')/`line')^2
		drop poor
	}
}

/*
forval yy = 25/40 {
	gen poor_20`yy' = exp_20`yy'<spline_avg
}
*/

*** stats *** 

* national level
mean hh_exp_total_w exp_2040 pc_exp_w exp_2040_pc D_exp_2040 if pid==1 [aw=wgt2] 
mean D_exp_2040 if pid==1 [aw=wgt2], over(decile) 
mean p0_spline_avg_pc_exp_w p0_spline_avg_exp_2040 p1_spline_avg_pc_exp_w p1_spline_avg_exp_2040 p2_spline_avg_pc_exp_w p2_spline_avg_exp_2040 p0_ipl215_pc_exp_w p0_ipl215_exp_2040 p0_ipl365_pc_exp_w p0_ipl365_exp_2040 p0_ipl658_pc_exp_w p0_ipl658_exp_2040 [aw=wgt2] 

* children with disability
mean hh_exp_total_w exp_2040 pc_exp_w exp_2040_pc D_exp_2040 if (severe==1|moderate==1) & age<18 [aw=wgt2] 
mean D_exp_2040 if (severe==1|moderate==1) & age<18 [aw=wgt2], over(decile) 
mean p0_spline_avg_pc_exp_w p0_spline_avg_exp_2040 p1_spline_avg_pc_exp_w p1_spline_avg_exp_2040 p2_spline_avg_pc_exp_w p2_spline_avg_exp_2040 p0_ipl215_pc_exp_w p0_ipl215_exp_2040 p0_ipl365_pc_exp_w p0_ipl365_exp_2040 p0_ipl658_pc_exp_w p0_ipl658_exp_2040 if (severe==1|moderate==1) & age<18 [aw=wgt2] 

* beneficiaries
mean hh_exp_total_w exp_2040 pc_exp_w exp_2040_pc D_exp_2040 if sev_2040==1 [aw=wgt2] 
mean D_exp_2040 if sev_2040==1  [aw=wgt2], over(decile) 
mean p0_spline_avg_pc_exp_w p0_spline_avg_exp_2040 p1_spline_avg_pc_exp_w p1_spline_avg_exp_2040 p2_spline_avg_pc_exp_w p2_spline_avg_exp_2040 p0_ipl215_pc_exp_w p0_ipl215_exp_2040 p0_ipl365_pc_exp_w p0_ipl365_exp_2040 p0_ipl658_pc_exp_w p0_ipl658_exp_2040 if sev_2040==1 [aw=wgt2] 

* share of beneficiaries emerged from poverty 
tab p0_spline_avg_pc_exp_w p0_spline_avg_exp_2040 if sev_2040==1 [aw=wgt2], cell nofreq 

/*
* mean pov_base poor_2040 [aw=wgt2], over(age5yrs) // national level full rollout
mean p0_spline_avg_pc_exp p0_spline_avg_exp_2040 [aw=wgt2], over(region2)

* mean pov_base poor_2040 if sev_2040==1 [aw=wgt2], over(age5yrs) // national level full rollout
mean p0_spline_avg_pc_exp p0_spline_avg_exp_2040 if (severe==1|moderate==1) & age<18 [aw=wgt2], over(region2)
*/

/*

**** more stats ****

tab pilotsite sex if severe==1 & age<=17 [aw=wgt1], row nofreq
tab Region sex if severe==1 & age<=17 //[aw=wgt1], row nofreq
tab other_tooro sex if severe==1 & age<=17 //[aw=wgt1], row nofreq
tab other_buganda sex if severe==1 & age<=17 //[aw=wgt1], row nofreq

tab decile if severe==1 & age<=17 //[aw=wgt2]
tab decile if (severe==1|moderate==1) [aw=wgt2]

tab age sex if severe==1 & age<=17 [aw=wgt1], row nofreq

foreach imp in Seeing Hearing Walking Communication Learning Behaviour {
	clonevar `imp'_2to17 = `imp'_5to17
	replace `imp'_2to17 = `imp'_2to4 if age<5
}

tab1 Seeing_2to17 Hearing_2to17 Walking_2to17 Communication_2to17 Learning_2to17 Behaviour_2to17 FineMotor_2to4 Playing_2to4 Selfcare_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 if (severe==1|moderate==1) [aw=wgt1], miss

*/
