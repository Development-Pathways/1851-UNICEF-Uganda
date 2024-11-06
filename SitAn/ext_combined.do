*** This do file combines the raw extended dataset

cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/"


forvalues x = 1/2 {
	use "raw/extended/v`x'/hh_roster.dta", clear
	run "scripts/ext_combined_roster.do"
	save "raw/extended/v`x'/hh_roster.dta", replace
}
*

local dta: dir "raw/extended/v3/" files "*.dta"
foreach f of local dta {
	use "raw/extended/v3/`f'", clear
		append using "raw/extended/v2/`f'"
		append using "raw/extended/v1/`f'"
	save "raw/extended/combined/`f'", replace
}
