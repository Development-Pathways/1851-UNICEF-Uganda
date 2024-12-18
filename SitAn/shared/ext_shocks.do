**Shocks

cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/"

use "raw/extended/combined/extended.dta", clear

keep interview__key interview__id shocks_*

label define shocks_list 0 "No" 1 "Yes"
label values shocks_list__* shocks_list

label variable shocks_list__1 "In last 12 mo, hh affected neg. by Drought"
label variable shocks_list__2	"In last 12 mo, hh affected neg. by Irregular Rains"
label variable shocks_list__3	"In last 12 mo, hh affected neg. by Floods"
label variable shocks_list__4	"In last 12 mo, hh affected neg. by Landslide(s)"
label variable shocks_list__6	"In last 12 mo, hh affected neg. by Earthquakes"
label variable shocks_list__7	"In last 12 mo, hh affected neg. by Agriculture related shocks"
label variable shocks_list__8	"In last 12 mo, hh affected neg. by Unusually High Prices for Food"
label variable shocks_list__9	"In last 12 mo, hh affected neg. by End of regular Assist/Remitt"
label variable shocks_list__10	"In last 12 mo, hh affected neg. by Reduction in the earnings of HH (Non-Ag) Business	"
label variable shocks_list__11	"In last 12 mo, hh affected neg. by Reduction in the Earnings of wage earners"
label variable shocks_list__12	"In last 12 mo, hh affected neg. by Loss of Employ. of wage earners"
label variable shocks_list__13	"In last 12 mo, hh affected neg. by Serious Illness/Accident of HH Member(s)"
label variable shocks_list__14	"In last 12 mo, hh affected neg. by Birth in the Household"
label variable shocks_list__15	"In last 12 mo, hh affected neg. by Death of Income Earner(s)"
label variable shocks_list__16	"In last 12 mo, hh affected neg. by Death of Other HH Member(s)"
label variable shocks_list__17	"In last 12 mo, hh affected neg. by Break-Up of Household"
label variable shocks_list__18	"In last 12 mo, hh affected neg. by Theft"
label variable shocks_list__19	"In last 12 mo, hh affected neg. by Conflict/Violence"
label variable shocks_list__96	"In last 12 mo, hh affected neg. by Other"

rename	shocks_list__1	shocks_drought
rename	shocks_list__2	shocks_rains
rename	shocks_list__3	shocks_floods
rename	shocks_list__4	shocks_landslide
rename	shocks_list__6	shocks_quakes
rename	shocks_list__7	shocks_agriculture
rename	shocks_list__8	shocks_prices
rename	shocks_list__9	shocks_endtransfers
rename	shocks_list__10	shocks_lessbusiness
rename	shocks_list__11	shocks_lesssalaries
rename	shocks_list__12	shocks_lossemploy
rename	shocks_list__13	shocks_illness
rename	shocks_list__14	shocks_birth
rename	shocks_list__15	shocks_deathbreadwinner
rename	shocks_list__16	shocks_deathmember
rename	shocks_list__17	shocks_breakup
rename	shocks_list__18	shocks_theft
rename	shocks_list__19	shocks_conflict
rename	shocks_list__96	shocks_other

reshape long shocks_rank__, i(interview__key interview__id) j(rank)
drop if shocks_rank__==0
drop if shocks_rank__==.

preserve
use "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/raw/extended/combined/shocks1.dta", clear

reshape long shocks2__, i(interview__key interview__id shocks1__id shock_income shock_assets shock_foodprod shock_foodstock shock_foodpurch) j(resilience)
drop if shocks2__ ==0

label define resilience 1	"Relied on own savings" ///
						2	"Received unconditional help from relatives/friends" ///
						3	"Received unconditional help from government" ///
						4	"Received unconditional help from NGO/religious institution" ///
						5	"Changed eating patterns" ///
						6	"Employed household members took on more employment" ///
						7	"Adult household members who were previously not working had to find work" ///
						8	"Household members migrated" ///
						9	"Reduced expenditures on health and/or education" ///
						10	"Obtained credit" ///
						11	"Sold agricultural assets" ///
						12	"Sold durable assets" ///
						13	"Sold land/building" ///
						14	"Sold crop stock" ///
						15	"Sold livestock" ///
						16	"Intensify fishing" ///
						17	"Sent children to live elsewhere" ///
						18	"Engaged in spiritual efforts -prayer, sacrifices, diviner consultations" ///
						19	"Did not do anything" ///
						20	"Other"

gen temp = resilience if shocks2__==1
egen resilience_1 = max(temp), by(interview__key interview__id)
drop temp

gen temp = resilience if shocks2__==2
egen resilience_2 = max(temp), by(interview__key interview__id)
drop temp

gen temp = resilience if shocks2__==3
egen resilience_3 = max(temp), by(interview__key interview__id)
drop temp resilience shocks2__

label value resilience_* resilience
duplicates drop

save "dta/auxiliary/resilience.dta", replace
restore

rename rank shocks1__id
merge 1:1 interview__key interview__id shocks1__id using "dta/auxiliary/resilience.dta", nogenerate

rename shock_* *_sh_
rename resilience_* resi*_sh_
rename shocks1__id sh_rank_
reshape wide sh_rank_ resi1_sh_ resi2_sh_ resi3_sh_ income_sh_ assets_sh_ foodprod_sh_ foodstock_sh_ foodpurch_sh_, i(interview__key interview__id) j(shocks_rank__)

label define shocks 1 "Drought" ///
					2 "Irregular Rains" ///
					3 "Floods" ///
					4 "Landslide(s)" ///
					6 "Earthquakes" ///
					7 "Agriculture related shocks (Crop Pests or disease, livestock disease, low output, high costs, etc)" ///
					8 "Unusually High Prices for Food" ///
					9 "End of Regular Assistance/Aid/Remittances From Outside the Household" ///
					10 "Reduction in the Earnings or business failure of Household (Non-Agricultural) Business (Not due to Illness or Accident)" ///
					11 "Reduction in the Earnings of Currently Salaried Household Member(s) (Not due to Illness or Accident)" ///
					12 "Loss of Employment of Previously Salaried Household Member(s) (Not due to Illness or Accident)" ///
					13 "Serious Illness or Accident of Household Member(s)" ///
					14 "Birth in the Household" ///
					15 "Death of Income Earner(s)" ///
					16 "Death of Other Household Member(s)" ///
					17 "Break-Up of Household" ///
					18 "Theft of Money/Valuables/Assets/Agricultural Output" ///
					19 "Conflict/Violence" ///
					96 "Other"
label value sh_rank_* shocks

forvalues x = 1/3 {
label variable sh_rank_`x' "Shock ranked `x'"
label variable resi1_sh_`x' "First response to shock ranked `x'"
label variable resi2_sh_`x' "Second response to shock ranked `x'"
label variable resi3_sh_`x' "Third response to shock ranked `x'"
label variable income_sh_`x' "Impact on income, as result of shock ranked `x'"
label variable assets_sh_`x' "Impact on assets, as result of shock ranked `x'"
label variable foodprod_sh_`x' "Impact on food production, as result of shock ranked `x'"
label variable foodstock_sh_`x' "Impact on food stocks, as result of shock ranked `x'"
label variable foodpurch_sh_`x'"Impact on food purchases, as result of shock ranked `x'"
}
*

gen __SHOCKS__ = .
order __SHOCKS__, after(interview__id)
order shocks_*, after(__SHOCKS__)
drop __SHOCKS__

rename interview__key interview_key_ext
rename interview__id interview_id_ext

compress
save "dta/ext_shocks.dta", replace

erase "dta/auxiliary/resilience.dta"
