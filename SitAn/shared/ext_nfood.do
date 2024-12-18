*===============================================================================
*
* NON-FOOD CONSUMPTION EXPENDITURE
*
*===============================================================================


use "${extended}", clear


	keep interview__key interview__id ea personal_exp cleaning_exp utilities_exp clothing_exp leisure_exp linen_exp furniture_exp durable_exp hhware_exp cerimony_exp

	*Furnishings and durables
		egen double durables_exp_total = rowtotal(linen_exp furniture_exp durable_exp hhware_exp)
				replace durables_exp_total = durables_exp_total/12
				replace durables_exp_total = . if durables_exp_total==0
	*Utilities
		gen double utilities_exp_total = utilities_exp/12
				replace utilities_exp_total = . if utilities_exp_total==0
	*Clothing
		gen double clothing_exp_total = clothing_exp
				replace clothing_exp_total= . if clothing_exp_total==0
	*Recreation
		gen double cermi_month =  cerimony_exp/12
		egen double recreation_exp_total = rowtotal(cermi_month leisure_exp)
				replace recreation_exp_total=. if recreation_exp_total==0
	*Personal care/cleaning
		egen double percare_nf_exp_total = rowtotal(personal_exp cleaning_exp)
				replace percare_nf_exp_total = . if percare_nf_exp_total==0

	*Take care of outliers

	foreach var in durables_exp_total utilities_exp_total clothing_exp_total recreation_exp_total percare_nf_exp_total {

	sum(`var') if `var'>0

	gen outlier_`var' = `var'>4*`r(sd)' & `var'!=.
			replace outlier_`var' =2 if `r(sd)'==.
			replace `var'=. if outlier_`var'>=1 & outlier_`var'!=.

	egen double `var'_p50 = median(`var') if `var'>0 & `var'!=.
			replace `var' = `var'_p50 if outlier_`var'==1
			replace `var' = 0 if `var'==.
}
//



	keep interview__key interview__id *_exp_total
		drop outlier_*

		sort interview__key

				save "${dta}/nfood_exp.dta", replace
