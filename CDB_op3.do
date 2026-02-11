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

**

gen mod_2025 = (moderate==1 & age<=12 & pilotsite==1)

gen mod_2026 = (moderate==1 & age<=12 & pilotsite==1)

gen mod_2027 = (moderate==1 & age<=12 & (pilotsite==1|Region=="Acholi"))

gen mod_2028 = (moderate==1 & age<=13 & (pilotsite==1|Region=="Acholi"|Region=="Lango"))

gen mod_2029 = (moderate==1 & age<=14 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"))

gen mod_2030 = (moderate==1 & age<=15 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"))

gen mod_2031 = (moderate==1 & age<=16 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"))

gen mod_2032 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"))

gen mod_2033 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"))

gen mod_2034 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"))

gen mod_2035 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1))

gen mod_2036 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"))

gen mod_2037 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1))

gen mod_2038 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"))

gen mod_2039 = (moderate==1 & age<=17 & (pilotsite==1|Region=="Acholi"|Region=="Lango"|Region=="Teso"|Region=="Bunyoro"|Region=="Karamoja"|Region=="Elgon"|Region=="West Nile"|Region=="Busoga"|other_tooro==1|Region=="Bukedi"|other_buganda==1|Region=="Kigezi"|Region=="Kampala"))

gen mod_2040 = (moderate==1 & age<=17)

* 50% take-up
foreach var of varlist sev_* mod_* {
	sort hhid
	set seed 999 
	replace `var' = runiform()<0.5 if `var'==1
}	

// CONSUMPTION

* winsorise & convert 
gen cpi2017 = 102.741 
gen cpi2019 = 107.612
gen cpi2025 = 137.904

sort hhid
set seed 111
winsor2 hh_exp_total, by(Region)
replace hh_exp_total_w = hh_exp_total_w * cpi2025/cpi2019

gen pc_exp_w = hh_exp_total_w/hhsize

forval yy = 25/40 {
	
	gen tv_20`yy' = 50000 if mod_20`yy'==1	
	replace tv_20`yy' = 100000 if sev_20`yy'==1
	
	egen tv_20`yy'_hh = total(tv_20`yy'), by(hhid)
	
	egen exp_20`yy' = rowtotal(hh_exp_total_w tv_20`yy'_hh)
	
	gen exp_20`yy'_pc = exp_20`yy'/hhsize 
	
	gen D_exp_20`yy' = (exp_20`yy'-hh_exp_total_w)/hh_exp_total_w
	gen D_exp_20`yy'_pc = (exp_20`yy'_pc-pc_exp_w)/pc_exp_w

}

// POVERTY

su poor_2019 [aw=wgt2]
local povrate=r(mean)*100
_pctile pc_exp_w [aw=wgt2], p(`povrate')
gen npl = r(r1) 

// international poverty lines
gen ppp2017 = 1219.19 //https://data.worldbank.org/indicator/PA.NUS.PRVT.PP?locations=UG

gen cf = ppp2017*(cpi2025/cpi2017)*(365/12)

gen ipl215 = cf * 2.15
gen ipl365 = cf * 3.65
gen ipl685 = cf * 6.85

foreach exp of varlist pc_exp_w exp_20*_pc {
	foreach line of varlist npl ipl* {
		gen poor = .
		replace poor = 0 if `exp' != .
		replace poor = 1 if `exp' <= `line' & `exp' != .
		gen p0_`line'_`exp' = poor * ((`line'- `exp')/`line')^0
		gen p1_`line'_`exp' = poor * ((`line'- `exp')/`line')^1
		gen p2_`line'_`exp' = poor * ((`line'- `exp')/`line')^2
		drop poor
	}
}

*** stats *** 

* national level
mean hh_exp_total_w exp_2040 pc_exp_w exp_2040_pc D_exp_2040 if pid==1 [aw=wgt2] 
mean D_exp_2040 if pid==1 [aw=wgt2], over(decile) 
mean p0_npl_pc_exp_w p0_npl_exp_2040 p1_npl_pc_exp_w p1_npl_exp_2040 p2_npl_pc_exp_w p2_npl_exp_2040 p0_ipl215_pc_exp_w p0_ipl215_exp_2040 p0_ipl365_pc_exp_w p0_ipl365_exp_2040 p0_ipl685_pc_exp_w p0_ipl685_exp_2040 [aw=wgt2] 

* children with disability
mean hh_exp_total_w exp_2040 pc_exp_w exp_2040_pc D_exp_2040 if (severe==1|moderate==1) & age<18 [aw=wgt2] 
mean D_exp_2040 if (severe==1|moderate==1) & age<18 [aw=wgt2], over(decile) 
mean p0_npl_pc_exp_w p0_npl_exp_2040 p1_npl_pc_exp_w p1_npl_exp_2040 p2_npl_pc_exp_w p2_npl_exp_2040 p0_ipl215_pc_exp_w p0_ipl215_exp_2040 p0_ipl365_pc_exp_w p0_ipl365_exp_2040 p0_ipl685_pc_exp_w p0_ipl685_exp_2040 if (severe==1|moderate==1) & age<18 [aw=wgt2] 

* beneficiaries
mean hh_exp_total_w exp_2040 pc_exp_w exp_2040_pc D_exp_2040 if (sev_2040==1|mod_2040==1) [aw=wgt2] 
mean D_exp_2040 if (sev_2040==1|mod_2040==1)  [aw=wgt2], over(decile) 
mean p0_npl_pc_exp_w p0_npl_exp_2040 p1_npl_pc_exp_w p1_npl_exp_2040 p2_npl_pc_exp_w p2_npl_exp_2040 p0_ipl215_pc_exp_w p0_ipl215_exp_2040 p0_ipl365_pc_exp_w p0_ipl365_exp_2040 p0_ipl685_pc_exp_w p0_ipl685_exp_2040 if (sev_2040==1|mod_2040==1) [aw=wgt2] 

* share of beneficiaries emerged from poverty 
tab p0_npl_pc_exp_w p0_npl_exp_2040 if sev_2040==1 [aw=wgt2], cell nofreq 

