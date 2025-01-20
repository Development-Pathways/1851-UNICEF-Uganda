// SIMULATIONS FOR CHILD DISABILITY BENEFIT IN UGANDA //

do "~/Documents/GitHub/1851-UNICEF-Uganda/DISABILITY_2024.do"

decode district, gen(District)
merge m:1 District using "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/Data/pop_by_district_2024.dta", keep(3)

set seed 999 
gen disab_below2 = runiform()<=0.027 if age<2

gen severe = (disab_below2==1 |SSHD_2to4==4 | SSHD_5to17==4)
gen moderate = (SSHD_2to4==3| SSHD_5to17==3)

gen pilotsite = (District=="Kassanda"|District=="Mubende"|District=="Kyegegwa"|District=="Kabarole")

gen other_buganda = (Region=="Buganda" & pilotsite==0)
gen other_tooro = (Region=="Tooro" & pilotsite==0)

// COVERAGE BY YEAR - GRADUAL EXPANSION //

gen cov_2025 = ((severe==1|moderate==1) & age<=12 & pilotsite==1)

gen cov_2026 = ((severe==1|moderate==1) & age<=12 & pilotsite==1)

gen cov_2027 = ((severe==1|moderate==1) & age<=12 & (pilotsite==1|Region=="Acholi"))

gen cov_2028 = ((severe==1|moderate==1) & age<=13 & (pilotsite==1|Region=="Acholi"|Region=="Lango"))

gen cov_2029 = ((severe==1|moderate==1) & age<=14 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"))

gen cov_2030 = ((severe==1|moderate==1) & age<=15 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"))

gen cov_2031 = ((severe==1|moderate==1) & age<=16 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"))

gen cov_2032 = ((severe==1|moderate==1) & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"))

gen cov_2033 = ((severe==1|moderate==1) & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"))

gen cov_2034 = ((severe==1|moderate==1) & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"))

gen cov_2035 = ((severe==1|moderate==1) & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1))

gen cov_2036 = ((severe==1|moderate==1) & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"))

gen cov_2037 = ((severe==1|moderate==1) & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1))

gen cov_2038 = ((severe==1|moderate==1) & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"))

gen cov_2039 = ((severe==1|moderate==1) & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"|Region=="Kampala"))

gen cov_2040 = ((severe==1|moderate==1) & age<=17)

/*
tab age pilotsite if moderate==1
tab age Region if moderate==1
tab age other_buganda if moderate==1
tab age other_tooro if moderate==1
tab1 mod_20* // n. of beneficiaries in sample
*/

tab1 cov_20* // n. of beneficiaries in sample

* 50% take-up
foreach var of varlist cov_* {
	set seed 999 
	replace `var' = runiform()<0.5 if `var'==1
}	

* wider beneficiaries

foreach var of varlist cov_* {
	egen hh_`var' = max(`var'), by(hhid)
}

******************************
keep if !missing(pc_exp) 
******************************

* tab1 cov_20* // n. of beneficiaries in sample

// CONSUMPTION

forval yy = 25/40 {
	
	gen tv_cov_20`yy' = 50000 if cov_20`yy'==1	
	replace tv_cov_20`yy' = 100000 if cov_20`yy'==1 & severe==1
	
	egen tv_cov_20`yy'_pc = total(tv_cov_20`yy'), by(hhid)
	replace tv_cov_20`yy'_pc = tv_cov_20`yy'_pc/hhsize
	
	egen exp_op1_20`yy' = rowtotal(pc_exp tv_cov_20`yy'_pc)
	gen D_exp_op1_20`yy' = (exp_op1_20`yy'-pc_exp)/pc_exp
}

mean pc_exp exp_op1_* D_exp_op1_20* [aw=wgt2] // national level

mat A = J(1,1,.)
forval yy = 25/40 {
	su D_exp_op1_20`yy' if cov_20`yy'==1 [aw=wgt2] // among beneficiaries
	mat A = A \ r(mean)
}
mat list A

mean pc_exp exp_op1_2040 D_exp_op1_2040 [aw=wgt2], over(decile) // national level full rollout

// POVERTY

* gen poor_2019 = ae_exp09<spline
gen pov_base = pc_exp09<spline // 15.20749

gen spline19 = spline*(pc_exp/pc_exp09)
* gen pov_check = pc_exp<spline19 // 15.20748

forval yy = 25/40 {
	gen poor_op1_20`yy' = exp_op1_20`yy'<spline19
}

mean pov_base poor_op1_20* [aw=wgt2] // national level

mat B = J(1,1,.)
forval yy = 25/40 {
	su poor_op1_20`yy' if cov_20`yy'==1 [aw=wgt2] // among beneficiaries
	mat B = B \ r(mean)
}
mat list B

mean poor_2019 poor_op1_2040 [aw=wgt2], over(age5yrs) // national level full rollout
