// Person listing dataset
*************************************
*************************************

*/ This do file cleans the raw listing dataset and constructs basic demographic variables all in one person level dta

*************************************
***** HH ID *************************
*************************************

cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019"

use "raw/listing/hh_roster.dta", clear

rename interview__key interview_key_list
rename interview__id interview_id_list

merge n:1 interview_key_list using "dta/hhid.dta", nogenerate keep(3)

order hhid, first

gen sampled = interview_key_ext!=""
order sampled interview_key_ext interview_id_ext, after(hhid)

*Person id number
sort interview_key_list hh_roster__id
egen pid = seq(), by(interview_key_list)
order pid, before(hh_roster__id)

run "scripts/roster_demographics.do"

compress
save "dta/per_listing.dta", replace
label data "Person listing dataset, UCLDS 2019"

** Dwarfism and Albinism

use "raw/listing/listing.dta", clear
keep interview__key albinism__* hh_albinism
rename interview__key interview_key_list
reshape long albinism__, i(interview hh_albinism) j(pid)
drop if albinism__==. | albinism__==.a
drop pid
gen has_albinism = 1
label variable has_albinism "Household member has albinism"
rename albinism__ hh_roster__id


merge 1:1 interview_key_list hh_roster__id using "dta/per_listing.dta", nogenerate
replace has_albinism = 0 if has_albinism!=1

compress
save "dta/per_listing.dta", replace
label data "Person listing dataset, UCLDS 2019"

use "raw/listing/listing.dta", clear
keep interview__key dwarfism__*
rename interview__key interview_key_list
reshape long dwarfism__ , i(interview) j(pid)
drop if dwarfism__==. | dwarfism__==.a
drop pid
gen has_dwarfism = 1
label variable has_dwarfism "Household member has dwarfism"
rename dwarfism__ hh_roster__id

merge 1:1 interview_key_list hh_roster__id using "dta/per_listing.dta", nogenerate
replace has_dwarfism = 0 if has_dwarfism!=1

compress
label data "Person listing dataset, UCLDS 2019"
save "dta/per_listing.dta", replace

// Household listing dataset

use "raw/listing/listing.dta", clear

// Remove interviews rejected by supervisors (likely to be repeated so they are duplicated)
drop if interview__status == 65

// Corrections
replace listing_result = 2 if listing_result ==.a
replace consent = 2 if consent == . | consent == .a


keep interview__key interview__id district subcounty urban parish village ea gps__Latitude ///
	 gps__Longitude gps__Accuracy gps__Altitude gps__Timestamp supervisor ///
	 visit_int laguange_int listing_date consent reschedule hh_list__0 hh_albinism ///
	 hh_dwarfism end_time_listing listing_result interview__status assignment__id revisit_consent reason_nocons_list

rename interview__key interview_key_list
rename interview__id interview_id_list

*Name of household head
rename hh_list__0 head_name
label variable head_name "Name of household head"

** Fix subcounty code for replacement EAs (Rutabo I, Nyakagongo, Kirima)
replace subcounty = 413103 if ea == "Rutabo I"
replace subcounty = 405301 if ea == "Nyakagongo"

label define subcounty 413103 "Bwizi" 405301 "Eastern Division", add

** create hhousehold id variable
merge 1:1 interview_key_list using "dta/hhid.dta", nogenerate keep(3)

order hhid, first

gen sampled = interview_key_ext!=""
order sampled interview_key_ext interview_id_ext, after(hhid)

** Compress and save hh_listing.dta
order hhid, first
compress
label data "Household listing dataset, UCLDS 2019"
save "dta/hh_listing.dta", replace

merge 1:n hhid using "dta/per_listing.dta", nogenerate keep(3)

merge n:1 hhid using "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/dta/weights.dta", nogenerate
drop if wgt1==.

order has_dwarfism has_albinism hh_albinism hh_dwarfism, after(hh_disab)
order __DEMOGRAPHICS__, before(sex)
order age, after(age5yrs)
order hh_nodifficulty hh_moddisab hh_sevdisabled hh_sevdisabled_grp hh_max_disability_score order pik distance, after(hh_dwarfism)
order sample_status - region, after(hhid)
drop interview__status

** Label variables and values

label define yesno 1 "Yes" 0 "No"

label values hh_nodifficulty hh_moddisab hh_sevdisabled yesno

compress
label data "Listing dataset, UCLDS 2019"
save "dta/listing.dta", replace
*
