*===============================================================================
*
* EDUCATION AND HEALTH EXPENDITURE
*
*===============================================================================

use "${hh_roster}", clear

	* education expenditure
	gen double educ_exp_total = educ_total_cost/10

	*deal with outliers in educ_exp_total
		sum educ_exp_total if educ_exp_total>0 & educ_exp_total!=. , d
		gen outlier_educ = educ_exp_total>3*`r(sd)' & educ_exp_total!=.
		egen double median_educ = median(educ_exp_total)
					replace educ_exp_total = median_educ if outlier_educ==1


	egen educ_exp_total_hh = sum(educ_exp_total), by(interview__key)


	* health outliers
		sum health_exp_total if health_exp_total>0 & health_exp_total!=. , d
		gen outlier_health = health_exp_total>3*`r(sd)' & health_exp_total!=.
		egen double median_health = median(health_exp_total)
					replace health_exp_total = median_health if outlier_health==1

	egen health_exp_total_hh = sum(health_exp_total), by(interview__key)


	keep interview__key interview__id health_exp_total_hh educ_exp_total_hh
		duplicates drop interview__key, force
		sort interview__key


						save "${dta}/health_educ_exp.dta", replace
