********************************************************************************
/*******************************************************************************

								Disability analysis

********************************************************************************

author: Diloá Bailey-Athias
email: diloaj@gmail.com
start date: 22/07/2016
country: South Africa

This file: extcos.do - estimates the extra cost associated with disability 

sheet A.10

*******************************************************************************/


*NEED TO IMPROVE COMMENTS ON THIS DO-FILE

cap drop hh_kid no_adults_wa no_a_wa no_kid no_eld hh_FunctionalDifficulty hh_k_FunctionalDifficulty no_k_FunctionalDifficulty hh_a_FunctionalDifficulty no_a_FunctionalDifficulty hh_e_FunctionalDifficulty no_e_FunctionalDifficulty hh_ProfoundDifficulty hh_k_ProfoundDifficulty no_k_ProfoundDifficulty hh_a_ProfoundDifficulty no_a_ProfoundDifficulty hh_e_ProfoundDifficulty no_e_ProfoundDifficulty ln_hhinc ln_hhexp sq_hhinc ln_pchinc CAI banked own_anyland simpleCAI ln_pcexp ln_pchinc ln_aeexp depratio2 simpleCAI2

egen hh_kid = max(age<18 & age!=.), by(hhid)
egen no_adults_wa = sum(age>=18 & age<65), by(hhid)
egen no_a_wa = sum(age>=18 & age!=.), by(hhid)
egen no_kid = sum(age<18 & age!=.), by(hhid)
egen no_eld = sum(age>=65 & age!=.), by(hhid)



foreach dis in FunctionalDifficulty ProfoundDifficulty {
egen hh_`dis' = max(`dis'==1), by(hhid) // households with disabled kids

egen hh_k_`dis' = max(`dis'==1 & age<18 & age!=.), by(hhid) // households with disabled kids
egen no_k_`dis' = sum(`dis'==1 & age<18 & age!=.), by(hhid) // number of disabled kids in hh

egen hh_a_`dis' = max(`dis'==1 & age>=18 & age!=.), by(hhid) // households with disabled adults
egen no_a_`dis' = sum(`dis'==1 & age>=18 & age!=.), by(hhid) // number of disabled adults in hh

egen hh_e_`dis' = max(`dis'==1 & age>=65 & age!=.), by(hhid) // households with disabled elderly
egen no_e_`dis' = sum(`dis'==1 & age>=65 & age!=.), by(hhid) // number of disabled elderly in hh
}
*
replace hh_a_ProfoundDifficulty= . if hh_a_FunctionalDifficulty==1 & hh_a_ProfoundDifficulty==0

** variables

gen ln_hhinc = log(hh_income+1)
gen ln_hhexp = log(hh_exp_total+1)
gen ln_pcexp = log(pc_exp+1)
gen ln_aeexp = log(ae_exp+1)
gen sq_hhinc = sqrt(hh_income)
gen ln_pchinc = log((hh_income+1)/hhsize)

gen CAI = assetindex
egen simpleCAI = rowtotal(assets_household__1 assets_household__2 assets_household__3 assets_household__4 assets_household__5 assets_household__6 assets_household__7 assets_household__8 assets_household__9 assets_household__10 assets_household__11 assets_household__12 assets_household__13 assets_members__1 assets_members__2 assets_members__3 assets_members__4 assets_members__5 assets_members__6 assets_members__7 assets_members__8)
egen simpleCAI2 = rowtotal(assets_household__1 assets_household__2 assets_household__3 assets_household__4 assets_household__5 assets_household__6 assets_household__7 assets_household__8 assets_household__9 assets_household__10 assets_household__11 assets_household__12 assets_household__13)
gen banked = assets_bank ==1 if assets_bank!=.
gen own_anyland = min(land_nonagri, land_agri)
gen depratio2 = depratio<=1 | depratio==.
**regressions

local controls "i.region hhsize no_kid i.age_adults_head i.own_anyland urban sex_head i.depratio2 i.hhtype3" // controls 

putexcel set "~/OneDrive - Development Pathways Ltd/DevPath/Uganda/sitan_disability/quantitative analysis 2.xlsx", modify sheet("5.4")


local m = 0
foreach dis in FunctionalDifficulty ProfoundDifficulty {
 
local c = 3

local sample1 "no_k_FunctionalDifficulty==0 & pid==1 & age_head>17" // at least two working age adults, with children but no disabled (moderate and severe) children
local sample2 "no_a_`dis' <= 2 & no_k_FunctionalDifficulty==0 & no_a_wa<=2 & pid==1 & age_head>17" // at least two working age adults, with children but no disabled (moderate and severe) children
local sample3 "no_k_FunctionalDifficulty==0 & pid==1 & age_head>17 & quints<=2" 
local sample4 "no_k_FunctionalDifficulty==0 & pid==1 & age_head>17 & quints>=4" 

forvalues x = 1/2 {

foreach dep in simpleCAI2 CAI {

reg `dep' ln_hhinc hh_a_`dis' `controls' [iw = wgt2] ///
 if `sample`x'', vce(cluster psu)
 
di "Disab: `dis', Sample `x', dep: `dep', N = `e(N)'"

nlcom (Income: _b[ln_hhinc]) (Disab: _b[hh_a_`dis']) (EC: - _b[hh_a_`dis']/_b[ln_hhinc])

*
mat b = r(b)
mat V = r(V)

local clr = 19 + `m'

forvalues z = 1/3{

local clc: word `c' of `c(alpha)'

local t = abs(b[1,`z']/sqrt(V[`z', `z']) )
local se = sqrt(V[`z', `z'])

if `t'>=2.58 {
putexcel `clc'`clr' = b[1,`z'] , font(Calibri, 12, black) nformat(#,###.00\*\*\*)
local ++clr
}
else if `t'>=1.96 & abs(`t')<=2.58 {
putexcel `clc'`clr' = b[1,`z'] , font(Calibri, 12, black) nformat(#,###.00\*\*)
local ++clr
}
else if `t'>=1.65 & abs(`t')<=1.96 {
putexcel `clc'`clr' = b[1,`z'] , font(Calibri, 12, black) nformat(#,###.00\*)
local ++clr
}

else {
putexcel `clc'`clr' = b[1,`z'] , font(Calibri, 12, black) nformat(#,###.00)
local ++clr
}

putexcel `clc'`clr' = `se' , font(Calibri, 12, black) nformat((#,###.00))
local ++clr

}
local ++c
}
local ++c
}
local m = `m' + 9
}
*
stop

local m = 20
foreach dis in FunctionalDifficulty ProfoundDifficulty {
 
local c = 3

local sample1 "no_k_FunctionalDifficulty==0 & pid==1 & age_head>17" // at least two working age adults, with children but no disabled (moderate and severe) children
local sample2 "no_a_`dis' <= 2 & no_k_FunctionalDifficulty==0 & no_a_wa<=2 & pid==1 & age_head>17" // at least two working age adults, with children but no disabled (moderate and severe) children
local sample3 "no_k_FunctionalDifficulty==0 & pid==1 & age_head>17 & quints<=2" 
local sample4 "no_k_FunctionalDifficulty==0 & pid==1 & age_head>17 & quints>=4" 

forvalues x = 1/4 {

foreach dep in simpleCAI CAI {



qui reg `dep' ln_hhexp hh_a_`dis' `controls' [iw = wgt2] ///
 if `sample`x'', vce(cluster psu)
 
di "Disab: `dis', Sample `x', dep: `dep', N = `e(N)'"

nlcom (Income: _b[ln_hhexp]) (Disab: _b[hh_a_`dis']) (EC: - _b[hh_a_`dis']/_b[ln_hhexp])

*
mat b = r(b)
mat V = r(V)

local clr = 19 + `m'

forvalues z = 1/3{

local clc: word `c' of `c(alpha)'

local t = abs(b[1,`z']/sqrt(V[`z', `z']) )
local se = sqrt(V[`z', `z'])

if `t'>=2.58 {
qui putexcel `clc'`clr' = b[1,`z'] , font(Calibri, 12, black) nformat(#,###.00\*\*\*)
local ++clr
}
else if `t'>=1.96 & abs(`t')<=2.58 {
qui putexcel `clc'`clr' = b[1,`z'] , font(Calibri, 12, black) nformat(#,###.00\*\*)
local ++clr
}
else if `t'>=1.65 & abs(`t')<=1.96 {
qui putexcel `clc'`clr' = b[1,`z'] , font(Calibri, 12, black) nformat(#,###.00\*)
local ++clr
}

else {
qui putexcel `clc'`clr' = b[1,`z'] , font(Calibri, 12, black) nformat(#,###.00)
local ++clr
}

qui putexcel `clc'`clr' = `se' , font(Calibri, 12, black) nformat((#,###.00))
local ++clr

}
local ++c
}
local ++c
}
local m = `m' + 10
}
*


reg ln_educ i.FunctionalDifficulty i.sex c.age##c.age i.current_grade i.school_manag i.school_type i.urban i.quints i.region if educ_total_cost>0 [aw = wgt2], vce(cluster psu)
reg ln_educ i.ProfoundDifficulty i.sex c.age##c.age i.current_grade i.school_manag i.school_type i.urban i.quints i.region if educ_total_cost>0 [aw = wgt2], vce(cluster psu)

reg ln_health i.FunctionalDifficulty i.sex c.age##c.age i.consult_illness i.major_sympton1 i.urban i.quints i.region if health_exp_total>0 [aw = wgt2], vce(cluster psu)
reg ln_health i.ProfoundDifficulty i.sex c.age##c.age i.consult_illness i.major_sympton1 i.urban i.quints i.region if health_exp_total>0 [aw = wgt2], vce(cluster psu)

gen ln_house = log(housing) 
gen ln_rec = log(recreation_exp_total) 
gen ln_comms = log(communications_exp_total)
gen ln_trans = log(transport_exp_total)

foreach var of varlist ln_house ln_rec ln_comms ln_trans {
reg `var' i.hh_disab hhsize i.sex_head c.age_head##c.age_head i.urban i.assetindex_quintile i.region if  pid==1 [aw = wgt2], vce(cluster psu)
reg `var' i.hh_ProfoundDifficulty hhsize i.sex_head c.age_head##c.age_head i.urban i.assetindex_quintile i.region if pid==1 [aw = wgt2], vce(cluster psu)
}

