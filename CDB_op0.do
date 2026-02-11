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

replace dislevel_3 = 0 if age<2
replace dislevel_3 = 1 if disab_below2_mod==1

replace dislevel_4 = 0 if age<2
replace dislevel_4 = 1 if disab_below2_sev==1

******************************
keep if !missing(wgt2) 
******************************

drop dislevel_sevmod
gen dislevel_sevmod = (dislevel_3==1 | dislevel_4==1) if !missing(dislevel_3)

* 50% take-up
	sort hhid
	set seed 999 
	gen half_takeup = runiform()<0.5 if dislevel_sevmod==1

* wider beneficiaries

	egen hh_dislevel_sevmod = max(dislevel_sevmod), by(hhid)

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

	gen tv_all_low = 50000 if dislevel_sevmod==1
	gen tv_all_mid = 100000 if dislevel_sevmod==1	
	gen tv_all_high = 150000 if dislevel_sevmod==1	

	gen tv_sev_low = 50000 if dislevel_4==1
	gen tv_sev_mid = 100000 if dislevel_4==1	
	gen tv_sev_high= 150000 if dislevel_4==1	

foreach var of varlist tv_* {
	egen `var'_hh = total(`var'), by(hhid)
	egen exp_`var' = rowtotal(hh_exp_total_w `var'_hh)
	gen exp_`var'_pc = exp_`var'/hhsize 
	gen D_exp_`var' = (exp_`var'_pc-pc_exp_w)/pc_exp_w
}

// POVERTY

* gen poor_2019 = ae_exp09<spline
su poor_2019 [aw=wgt2]
local povrate=r(mean)*100
_pctile pc_exp_w [aw=wgt2], p(`povrate')
gen npl = r(r1) 


foreach exp of varlist pc_exp_w exp_*_pc {
		gen poor = .
		replace poor = 0 if `exp' != .
		replace poor = 1 if `exp' <= npl & `exp' != .
		gen p0_`exp' = poor * ((npl - `exp')/npl)^0
*		gen p1_`line'_`exp' = poor * ((`line'- `exp')/`line')^1
*		gen p2_`line'_`exp' = poor * ((`line'- `exp')/`line')^2
		drop poor
}

*** stats *** 

* beneficiaries

tabstat p0_pc_exp_w p0*all* if dislevel_sevmod==1 [aw=wgt2] 
tabstat p0_pc_exp_w p0*sev*  if dislevel_4==1 [aw=wgt2] 

