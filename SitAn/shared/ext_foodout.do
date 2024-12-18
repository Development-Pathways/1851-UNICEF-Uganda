*===============================================================================
*
* FOOD OUTSIDE THE HOME CONSUMPTION EXPENDITURE
*
*===============================================================================


use "${food_out}", clear

 // 1) Deal with outliers
	*get data on location and merge in
		preserve

			use "${extended}", clear

			keep interview__key interview__id ea district subcounty urban parish village

			tempfile ext
			save `ext', replace

		restore

	merge m:1 interview__key using `ext'

			//drop if _merge==2
			drop _merge

	*create group based on district and non-food item (OLD)
  gen region = floor(district/100)

	egen item_reg_group = group(region urban food_out_roster__id) if food_out_roster__id!=. & district!=.
		replace item_reg_group= 0 if item_reg_group==.

    egen medspent = median(food_out_spent), by(item_reg_group)
    egen sdspent = sd(food_out_spent), by(item_reg_group)

    gen outlier_spent = food_out_spent>=3*sdspent & food_out_spent!=.
    replace food_out_spent = medspent if outlier_spent==1

	egen food_out_hh = sum(food_out_spent), by(interview__key)


	// sum food_out_hh if food_out_hh>0 & food_out_hh!=. , d
	// 	gen outlier_indic = food_out_hh>3*`r(sd)' & food_out_hh!=. & `r(sd)'!=.
	// 			replace food_out_hh =. if outlier_indic==1
	// 			replace food_out_hh =. if food_out_hh==0


	// *replace missing values with median amount spent in each EA for each good
	// egen price_med = median(food_out_hh) if food_out_hh>0, by(food_out_roster__id)
	// 			replace food_out_hh = price_med if outlier_indic==1

	// 2) Create monthly household non-food expenditure
				gen foodout_exp_total =((food_out_hh)/7)*30



	keep interview__key interview__id foodout_exp_total
    duplicates drop
		sort interview__key


				save "${dta}/foodout_exp.dta", replace
