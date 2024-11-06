*===============================================================================
*
* EXPENDITURE MERGE .do
*
*===============================================================================



use "${dta}/rent_exp.dta", clear

	merge 1:1 interview__key using "${dta}/nfood_exp.dta", nogen
	merge 1:m interview__key using "${dta}/nfoodfreq_exp.dta", nogen
	merge 1:m interview__key using "${dta}/health_educ_exp.dta", nogen
	merge 1:m interview__key using "${dta}/food_exp.dta", nogen
	merge 1:m interview__key using "${dta}/foodout_exp.dta", nogen


	egen food_all_exp_total = rowtotal(foodout_exp_total hh_food_exp_total)
	egen housing = rowtotal(utilities_exp_total fuels_exp_total)
	egen personalcare_exp_total = rowtotal(percare_nf_exp_total personalcare_fnf_exp_total)


	*drop outlier_*

		label var food_all_exp_total "Total household food expenditure per month (inside and outside the home)"
		label var housing "Total household expenditure on housing, utilities and fuel per month"
		label var clothing_exp_total "Total household clothing expenditure per month"
		label var recreation_exp_total "Total household recreation expenditure per month"
		label var communications_exp_total "Total household communications expenditure per month"
		label var transport_exp_total "Total household transport expenditure per month"
		label var tobacco_exp_total "Total household tobacco expenditure per month"
		label var personalcare_exp_total "Total household personal care/cleaning expenditure per month"
		label var durables_exp_total "Total household durable items expenditure per month"
		label var health_exp_total_hh "Total household health expenditure per month"
		label var educ_exp_total_hh "Total household education expenditure per month"
		label var rent_exp_total "Total household rent expenditure per month"
		label var flag_1 "FLAG INTERNAL: hh used 'other' as quantity unit in at least one food consumption source"

 egen hh_exp_total = rowtotal(food_all_exp_total housing clothing_exp_total recreation_exp_total communications_exp_total transport_exp_total tobacco_exp_total personalcare_exp_total durables_exp_total health_exp_total_hh educ_exp_total_hh rent_exp_total)

 drop percare_nf_exp_total utilities_exp_total personalcare_fnf_exp_total fuels_exp_total hh_food_exp_total foodout_exp_total

 
 order interview__key interview__id food_all_exp_total housing clothing_exp_total recreation_exp_total communications_exp_total transport_exp_total tobacco_exp_total personalcare_exp_total durables_exp_total health_exp_total_hh educ_exp_total_hh rent_exp_total flag_1

				save "${dta}/hh_expenditure.dta", replace
