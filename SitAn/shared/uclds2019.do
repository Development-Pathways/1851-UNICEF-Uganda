

cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019"

use "dta/listing.dta", clear
keep if sampled_ext==0

append using "dta/extended.dta"


*************************************
***** Final tidy *******************
*************************************

**more wrangling
recode assets_household* assets_members* (.a = 0)
label define assetyesno 0 "No" 1 "Yes"
label values assets_household__* assets_members__* assetyesno

// ds, not(type string)
// recode `r(varlist)' (.a = .)

order sampled_ext sampled, after(sample_status)
label variable sampled "Household sampled for in-depth interview"
order pid, after(hhid)
label variable pid "Person unique ID number within household"
label variable hhid "Houshold unique ID number"
order region regurb, before(district)
label variable regurb "Region/urban identifiers"
label define regurb  1 "Central Urban" ///
                     2 "Central Rural" ///
                     3 "Eastern Urban" ///
                     4 "Eastern Rural" ///
                     5 "Northern Urban" ///
                     6 "Northern Rural" ///
                     7 "Western Urban" ///
                     8 "Western Rural"
label values regurb regurb

drop no_mdevice_need__13 home_modtype__98 interview__key interview__id
drop head_name

compress
label data "UCLDS 2019"
save "dta/uclds2019.dta", replace
