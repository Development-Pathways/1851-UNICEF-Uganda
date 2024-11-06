*===============================================================================
* 
* RENT (AND ESTIMATED RENT) EXPENDITURE 
*
*===============================================================================

use "${extended}", clear

		keep interview__key interview__id ea district urban rent rent_exp rent_utils rent_utils_value rent_period rent_est ///
				rent_est_period dwelling_type dwelling_rooms roof_type wall_type floor_type drinking_water toilet_facility ///
				share_toilet cooking_fuel int_consent interview__status

		keep if int_consent==1
	keep if interview__status==130
	//			drop int_consent interview__status

	*housing and utility costs
gen double rent_final = .
		replace rent_final = rent_exp if rent_utils==2 & rent==1 // if utils is not included in the rent price
		replace rent_final = rent_utils_value if rent_utils==1 & rent==1 & rent_final==. & rent_utils_value!=999999998
		replace rent_final = rent_exp if rent_utils==1 & rent==1 & rent_final==. & rent_utils_value!=999999998
		replace rent_final = rent_est if rent==2 & rent_est!=999999998 // estimated rent price
		replace rent_final = . if rent_final==0
		
	*standardise values to one month	
		replace rent_final = (rent_final/365)*30 if rent_period==6 | rent_est_period==6 //year
		replace rent_final = (rent_final/7)*30 if rent_period==2 | rent_est_period==2 //week
		replace rent_final = rent_final*30 if rent_est_period==1 //day
		replace rent_final = (rent_final/3) if rent_period==4 | rent_est_period==4 //every 3 months
		replace rent_final = (rent_final/6) if rent_period==5 | rent_est_period==5 // twice a year

gen temp_ = roof_type==.a | wall_type==.a | floor_type==.a | drinking_water==.a | toilet_facility==.a | share_toilet==.a | district==.a | urban==.a | rent==. | rent==.a | dwelling_type==.a | dwelling_rooms==.a | dwelling_rooms==.

gen double rent_final_log = log(rent_final)


 reg rent_final_log /*i.rent*/ i.dwelling_type dwelling_rooms i.roof_type i.wall_type ///
	i.floor_type i.drinking_water i.toilet_facility i.share_toilet i.district ///
	i.urban if temp_==0 , nocons robust
	
	
	*estimate housing rents
 predict rent_new if temp_==0
 
 gen double temp_rent_new = exp(rent_new)
 
 gen double rent_exp_total = rent_final
		replace rent_exp_total = temp_rent_new if rent_final==.
 
	*
	bysort urban: sum rent_exp_total
	gen outlier = rent_exp_total>3*`r(sd)' & rent_exp_total!=. //43 outliers and all are those that have been imputed by the respondent - set to missing 
	
	egen median_rent = median(rent_exp_total) if rent_exp_total!=. , by(urban)
	
	replace rent_exp_total = median_rent if outlier==1
 
 keep interview__key interview__id rent_exp_total
 
	sort interview__key
 
				save "${dta}/rent_exp.dta", replace
