*===============================================================================
*
* NON-FOOD FREQUENT CONSUMPTION EXPENDITURE
*
*===============================================================================



	use "${nfoodf}", clear

 // 1) Deal with outliers
	*get data on location and merge in
		preserve

			use "${extended}", clear

			keep interview__key interview__id ea district subcounty urban parish village

			tempfile ext
			save `ext', replace

		restore

	merge m:1 interview__key using `ext'

			drop _merge

	gen double communications= nfood_freq_spent if nfood_freq_roster__id==7

	gen double transport = nfood_freq_spent if nfood_freq_roster__id==8

	gen double personalcare_fnf = nfood_freq_spent if nfood_freq_roster__id==5

	egen double fuels = sum(nfood_freq_spent) if nfood_freq_roster__id==1 | nfood_freq_roster__id==2 | nfood_freq_roster__id==3 | nfood_freq_roster__id==4 , by(interview__key)

	egen double tobacco = sum(nfood_freq_spent) if nfood_freq_roster__id== 6 , by(interview__key)


	foreach var in communications transport personalcare_fnf fuels tobacco {

	bysort ea: sum `var' if `var'>0 & `var'!=. , d

	gen outlier_`var' = `var'>3*`r(sd)' & `var'!=.
			replace outlier_`var' =2 if `r(sd)'==.
			replace `var'=-. if outlier_`var'>=1 & outlier_`var'!=.

	egen double `var'_p50 = median(`var') if `var'>0, by(ea)
			replace `var' = `var'_p50 if outlier_`var'==1
	egen double `var'_exp_total = sum(`var'), by(interview__key)
		replace `var'_exp_total  = (`var'_exp_total/14)*30
		replace `var'_exp_total  = 0 if `var'_exp_total ==.
	}
//




keep interview__key interview__id *_exp_total

			duplicates drop interview__key, force

		sort interview__key

			save "${dta}/nfoodfreq_exp.dta", replace
