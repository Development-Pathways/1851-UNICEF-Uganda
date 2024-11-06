cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019"


use "raw/extended/combined/food_roster.dta", clear


**************************************
***** WFP Food security indicators ***
**************************************

	//FCS

*create food groups
recode food_roster__id (1/13 = 1 "main staples") (15/18 = 2 "pulses") (19/23 = 3 "veg") ///
 (24/28 = 4 "fruit") (29/35 = 5 "meat and fish") (36 37 = 6 "milk") (14 = 7 "sugar") ///
 (38 39 = 8 "oil") (40 41 42 43 = 9 "condiments"), gen(food_grp)
drop if food_days==.a

collapse (sum) food_days, by(food_grp interview__key)
replace food_days = 7 if food_days>7
gen food_scores = 2*food_days*(food_grp==1) + ///
                  3*food_days*(food_grp==2) + ///
                  1*food_days*(food_grp==3) + ///
                  1*food_days*(food_grp==4) + ///
                  4*food_days*(food_grp==5) + ///
                  4*food_days*(food_grp==6) + ///
                  0.5*food_days*(food_grp==7) + ///
                  0.5*food_days*(food_grp==8) + ///
                  0*food_days*(food_grp==9)

reshape wide food_days food_scores, i(interview__key) j(food_grp)
recode food_days* food_scores* (. = 0)
egen total_score = rowtotal(food_scores*)
label variable total_score "WFP Food Consumption Score"


gen FCS = .
	replace FCS = 1 if total_score>=0 & total_score<21.5
	replace FCS = 2 if total_score>=21.5 & total_score<=35
	replace FCS = 3 if total_score>35

label define FCS 1 "Poor" 2 "Borderline" 3 "Acceptable"
label values FCS FCS
label var FCS "Food Consumption Score - WFP, 'typical thresholds'"


//Dietary diversity score

forvalues fgroup = 1/9 {
	egen temp`fgroup' = max(food_days`fgroup' > 0), by(interview__key)
}
egen dietdiversity = rowtotal(temp1 - temp8)
recode dietdiversity (0/3 = 1 "Low diversity") (4/5 = 2 "Medium diversity") (6/max = 3 "High diversity"), gen(dietdiversity_group)
label variable dietdiversity_group "Dietary diversity score"
label variable dietdiversity "Dietary diversity score"
drop temp1 - temp9


recode dietdiversity (1/4 = 1 "Low diversity") (5/6 = 2 "Medium diversity") (7/max = 3 "High diversity"), gen(dietdiversity_group_v2)
label variable dietdiversity_group_v2 "Dietary diversity score with new thresholds"

drop food_days* food_scores*
save "dta/wfp_indicators_edit.dta", replace
