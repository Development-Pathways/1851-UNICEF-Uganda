**This do file creates unique household id numbers across listing and extended data files

cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/"

use "raw/listing/listing.dta", clear

**interviewer responsible and system duration
merge 1:1 interview__key using "raw/listing/interview__diagnostics.dta", nogenerate
drop rejections__sup rejections__hq entities__errors questions__comments

rename responsible interviewer_list
label variable interviewer_list "Interviewer's login for listing"
order interviewer_list, before(supervisor)

** generate unique hhid numbers
egen hhid = group(interview__key)
order hhid, first
replace hhid = hhid + 10000

rename interview__key interview_key_list
rename interview__id interview_id_list

preserve
keep hhid interview_key_list
compress
save "dta/hhid.dta", replace
label data "Unique household id across listing and extendend datasets"
restore

**drop unanswered consent questions or not approved by HQ
keep if consent==1
drop if interview__status==65
drop if revisit_consent!=1

** Fix subcounty code for replacement EAs (Rutabo I, Nyakagongo, Kirima)
replace subcounty = 413103 if ea == "Rutabo I"
replace subcounty = 405301 if ea == "Nyakagongo"

**reduce size of tempfiles
keep hhid - reschedule hh_list__0 hh_list__1 hh_list__2 hh_list__3 hh_list__4 hh_list__0 revisit_consent - reason_nocons_list has__errors - assignment__id
gen name_head = hh_list__0

rename has__errors has_errors_list
rename interview__status interview_status_list
rename assignment__id assignment_id_list

replace address = subinstr(address, `"""', "", .)
replace sn_map = subinstr(sn_map, `"""', "", .)
replace other_location = subinstr(other_location, `"""', "", .)

duplicates report address other_location sn_map ea name_head

compress
save "dta/auxiliary/temphhid.dta", replace

preserve
duplicates drop ea contact_number, force
compress
save "dta/auxiliary/temphhidcontact.dta", replace
restore

preserve
duplicates drop ea contact_number name_head, force
compress
save "dta/auxiliary/temphhidcontactname.dta", replace
restore

duplicates drop address other_location sn_map ea, force

compress
save "dta/auxiliary/temphhid2.dta", replace

drop if gps__Latitude==.a
duplicates drop gps__T listing_date, force
compress
save "dta/auxiliary/temphhidgps.dta", replace

duplicates drop ea hh_list__0 hh_list__1 hh_list__2 hh_list__3 hh_list__4, force
compress
save "dta/auxiliary/temphhidlist.dta", replace

duplicates drop ea listing_date interviewer, force
compress
save "dta/auxiliary/temphhiddate.dta", replace



use "raw/extended/combined/extended.dta", clear

// **drop unanswered consent questions or not approved by HQ
// keep if int_consent==1
// keep if interview__status==130

**drop 5 duplicate assignments (3 of which were rejected by supervisor or headquarters and 1 did not give consent)
duplicates tag assignment__id, gen(dup)
drop if dup==1 & interview__status!=130
drop if dup==1 & int_consent==2
tab end_time assignment__id if dup==1
drop if dup==1 & end_time=="2019-10-11T16:36:01" & assignment__id==2287
// there are two interviews with the same identifying questionas and household listing questionnaire answers, kept the latest interview
drop dup

* remove tripple quotes from string variables in extended for merge
replace address = subinstr(address, `"""', "", .)
replace sn_map = subinstr(sn_map, `"""', "", .)
replace other_location = subinstr(other_location, `"""', "", .)

rename interview__key interview_key_ext
rename interview__id interview_id_ext

**merge
local matchvars address other_location sn_map ea listing_date
merge 1:1 `matchvars' using "dta/auxiliary/temphhid.dta"

preserve
keep if _m==3
keep hhid interview_key* interview_id*
save "dta/auxiliary/hhid.dta", replace
restore

keep if _m==1
drop _m hhid interview_key_list interview_id_list
local matchvars address other_location sn_map ea name_head
merge 1:1 `matchvars' using "dta/auxiliary/temphhid.dta"

preserve
keep if _m==3
keep hhid interview_key* interview_id*
append using "dta/auxiliary/hhid.dta"
save "dta/auxiliary/hhid.dta", replace
restore

keep if _m==1
drop _m hhid interview_key_list interview_id_list
local matchvars ea hh_list__0 hh_list__1 hh_list__2 hh_list__3 hh_list__4
merge 1:1 `matchvars' using "dta/auxiliary/temphhidlist.dta"

preserve
keep if _m==3
keep hhid interview_key* interview_id*
append using "dta/auxiliary/hhid.dta"
save "dta/auxiliary/hhid.dta", replace
restore

keep if _m==1
replace sn_map = "01" if sn_map=="1"
drop _m hhid interview_key_list interview_id_list
local matchvars address other_location sn_map ea listing_date
merge 1:1 `matchvars' using "dta/auxiliary/temphhid.dta"

preserve
keep if _m==3
keep hhid interview_key* interview_id*
append using "dta/auxiliary/hhid.dta"
save "dta/auxiliary/hhid.dta", replace
restore

keep if _m==1
replace sn_map = "01" if sn_map=="1"
drop _m hhid interview_key_list interview_id_list
local matchvars address other_location sn_map ea
merge 1:1 `matchvars' using "dta/auxiliary/temphhid2.dta"

preserve
keep if _m==3
keep hhid interview_key* interview_id*
append using "dta/auxiliary/hhid.dta"
save "dta/auxiliary/hhid.dta", replace
restore

keep if _m==1
replace sn_map = "01" if sn_map=="1"
drop _m hhid interview_key_list interview_id_list
local matchvars name_head listing_date
merge 1:1 `matchvars' using "dta/auxiliary/temphhid.dta"

preserve
keep if _m==3
keep hhid interview_key* interview_id*
append using "dta/auxiliary/hhid.dta"
save "dta/auxiliary/hhid.dta", replace
restore

use "dta/auxiliary/hhid.dta", clear
order hhid, first
merge 1:1 hhid interview_key_list using "dta/hhid.dta", nogenerate

compress
save "dta/hhid.dta", replace
label data "Unique household id across listing and extendend datasets"

** missing assignments

import excel "dta/auxiliary/missing_assignments.xlsx", sheet("misssing assignments") firstrow clear

foreach var of varlist parish village ea sn_map address other_location interviewer supervisor contact_number name_head {
replace `var' = strtrim(`var')
}
*

gen interview_key_list = sn_map
merge n:1 interview_key_list using "dta/auxiliary/temphhidcontact.dta", keepusing(hhid hh_list__* interview_key_list)

preserve
keep if _m==3
gen sampled_ext = 1
keep interview_key_list sampled_ex
label variable sampled_ext "Sampled for extended interview"
save "dta/auxiliary/missing_ext.dta", replace
restore

keep if _m==1
drop hh_list__* _m interview_key_list

merge 1:1 contact_number name_head ea using "dta/auxiliary/temphhidcontact.dta", keepusing(hhid interview_key_list)

preserve
keep if _m==3
gen sampled_ext = 1
keep interview_key_list sampled_ex
label variable sampled_ext "Sampled for extended interview"
append using "dta/auxiliary/missing_ext.dta"
save "dta/auxiliary/missing_ext.dta", replace
restore

keep if _m==1
drop interview_key_list hhid _m

merge 1:1 sn_map address other_location ea using "dta/auxiliary/temphhid2.dta", keepusing(hhid interview_key_list contact_number)

preserve
keep if _m==3
gen sampled_ext = 1
keep interview_key_list sampled_ex
label variable sampled_ext "Sampled for extended interview"
append using "dta/auxiliary/missing_ext.dta"
save "dta/auxiliary/missing_ext.dta", replace
restore

keep if _m==1
drop interview_key_list hhid _m

merge 1:1 sn_map contact_number name_head using "dta/auxiliary/temphhidcontact.dta", keepusing(hhid interview_key_list contact_number)

preserve
keep if _m==3
gen sampled_ext = 1
keep interview_key_list sampled_ex
label variable sampled_ext "Sampled for extended interview"
append using "dta/auxiliary/missing_ext.dta"
save "dta/auxiliary/missing_ext.dta", replace
restore

keep if _m==1
keep sn_map contact_number ea name_head

gen interview_key_list ="49-57-23-04" if contact_number=="0701184028"
replace interview_key_list ="45-55-80-63" if contact_number=="0789500543"
replace interview_key_list ="02-51-57-30" if contact_number=="0756546779"
replace interview_key_list ="14-78-25-95" if contact_number=="0778708118"
replace interview_key_list ="17-18-20-04" if contact_number=="no contact"
replace interview_key_list ="05-44-85-85" if contact_number=="0784493442"

merge 1:1 interview_key_list using "dta/auxiliary/temphhidcontact.dta", keepusing(hhid interview_key_list contact_number)

keep if _m==3
gen sampled_ext = 1
keep interview_key_list sampled_ext
label variable sampled_ext "Sampled for extended interview"
append using "dta/auxiliary/missing_ext.dta"
save "dta/auxiliary/missing_ext.dta", replace

merge 1:1 interview_key_list using "dta/hhid.dta", nogenerate

gen interview__key = interview_key_ext

merge n:1 interview__key using "raw/extended/combined/extended.dta", keep(1 3) nogenerate keepusing(interview__status int_consent assignment__id)

replace sampled_ext = 2 if interview_key_ext!="" & int_consent==1 & interview__status==130
replace sampled_ext = 0 if interview_key_ext=="" & sampled_ext==.
replace sampled_ex = 1 if sampled_ext==. & interview_key_ext!=""

label define sampled_ext 0 "Not sampled for in-depth interviews" ///
						 1 "Sampled but not completed" ///
						 2 "Sampled and completed"

drop interview__key interview__status int_consent assignment__id


label values sampled_ext sampled_ext
label variable sampled_ext "Sampled for extended interview"

compress

order hhid
sort hhid interview_key_list interview_id_list sampled_ext interview_key_ext interview_id_ext
save "dta/hhid.dta", replace
label data "Unique household id across listing and extendend datasets"

** sampling weights from matching algorithm
import delimited "/Users/dathias/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/dta/auxiliary/rsampling.tab", encoding(ISO-8859-1) clear

replace pik = . if score==. & pik==0
replace pik = 1 if score!=. & pik==0

drop score

rename id order
label variable order "R Sampling: order of hh with disabled members"
label variable pik "R Sampling: probability of inclusion"
label variable distance "R Sampling: nearest neighbour distance (predicted values"
label variable hh_nodifficulty "R Sampling: hh with no difficulty"
label variable hh_moddisab "R Sampling: hh with moderate difficulty"
label variable hh_sevdisabled "R Sampling: hh with severe difficulty"
label variable hh_sevdisabled_grp "R Sampling: hh difficulty group"
label define hh_sevdisabled_grp 0 "HH with no or moderate difficulty" ///
								1 "HH with adults and children with sev difficulty" ///
								2 "HH with only children with sev difficulty" ///
								3 "HH with only adults with sev difficult"
label variable pair "R sampling: interview_key_list of match"
label variable hh_max_disability_score "R sampling: hh maximum disability score"

rename interview__key interview_key_list


preserve
keep interview_key_list pair
keep if pair!=""
rename interview_key_list pair2
rename pair interview_key_list
save "dta/auxiliary/pair.dta", replace
restore

merge 1:1 interview_key_list using "dta/hhid.dta", nogenerate

merge 1:1 interview_key_list using "dta/auxiliary/pair.dta", nogenerate

replace pair = pair2 if pair2!=""

drop pair*

order hhid
order  interview_key_list, before(interview_id_list)
sort hhid interview_key_list interview_id_list sampled_ext interview_key_ext interview_id_ext
save "dta/hhid.dta", replace
label data "Unique household id across listing and extendend datasets"


erase "dta/auxiliary/pair.dta"
erase "dta/auxiliary/temphhiddate.dta"
erase "dta/auxiliary/temphhidlist.dta"
erase "dta/auxiliary/temphhidgps.dta"
erase "dta/auxiliary/temphhid2.dta"
erase "dta/auxiliary/temphhid.dta"
erase "dta/auxiliary/temphhidcontact.dta"
erase "dta/auxiliary/temphhidcontactname.dta"
