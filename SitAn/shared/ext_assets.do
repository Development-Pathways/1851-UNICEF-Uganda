**Assets

cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/"

*************************************
***** Asset index *******************
*************************************

use "raw/extended/combined/extended.dta", clear
gen interview_key_ext  = interview__key
gen interview_id_ext = interview__id

keep interview_key_ext interview_id_ext interview__key interview__id dwelling_type - assets_bank rent

merge 1:m interview_key_ext interview_id_ext using "dta/hhid.dta", nogenerate keep(3)
merge 1:1 hhid using "dta/weights.dta", nogenerate keep(3)


// This do files follows the DHS manual to construct an asset index to measure wealth

** variables

*Asset1 Source of drinking water
qui tab drinking_water, gen(A1_)

*Asset2 Type of toilet facility (own)
qui tab toilet_facility if share_toilet==2, gen(A2_)
recode A2_* (. = 0)

*Asset3 Type of toilet facility (shared)
qui tab toilet_facility if share_toilet==1, gen(A3_)
recode A3_* (. = 0)

*Asset4 Type of cooking fuel
gen cooking_fuel_temp = cooking_fuel
recode cooking_fuel (10 = 9)
qui tab cooking_fuel, gen(A4_)
replace cooking_fuel = 10 if cooking_fuel_temp==10
drop cooking_fuel_temp

*Asset5 - Asset25 Durable assets owned by household or members of the household
recode assets_household* assets_members* (. .a = 0)

*Asset26 Bank account
recode assets_bank (2 = 0), gen(A26)

*Asset27 Type of floor
qui tab floor_type, gen(A27_)

*Asset28 Type of roof
qui tab roof_type, gen(A28_)

*Asset29 Type of wall
qui tab wall_type, gen(A29_)

*Asset30 Domestic staff
preserve
use "dta/listing.dta", clear
egen A30 = max(relation==10), by(interview_id_ext interview_key_ext)
keep interview_key_ext interview_id_ext A30 hhsize
duplicates drop
drop if interview_key_ext==""

save "dta/auxiliary/domestic.dta", replace
restore

merge 1:1 interview_key_ext interview_id_ext using "dta/auxiliary/domestic.dta", nogenerate

*Asset31 Owns house (or does not pay rent)
recode rent (2 = 1) (1 = 0), gen(A31)

*Asset32 Owns Land
recode land_agri (2 = 0), gen(A32)

*Asset33 Owns non-agricultural land
recode land_nonagri (2 = 0), gen(A33)

*Asset34 members per sleeping room
recode dwelling_rooms (0 = 1), gen(sleeping)
gen A34 = hhsize/sleeping
drop sleeping

order hhsize, last

**Construct asset index

pca A* assets_household* assets_members* [aw = wgt2]
predict assetindex, score
xtile assetindex_quintile = assetindex [w=wgt2], n(5)

keep hhid assetindex assetindex_quintile

compress
save "dta/ext_assetindex.dta", replace

erase "dta/auxiliary/domestic.dta"

*************************************
***** Livestock *********************
*************************************


use "raw/extended/combined/livestock.dta", clear

recode livestock1 (99/max = 95)

reshape wide livestock1, i(interview*) j(livestock__id)

rename livestock11 numlivestock_cattle
rename livestock12 numlivestock_excattle
rename livestock13 numlivestock_horses
rename livestock14 numlivestock_goats
rename livestock15 numlivestock_sheep
rename livestock16 numlivestock_poultry
rename livestock17 numlivestock_pig
rename livestock196 numlivestock_other

label variable numlivestock_cattle "Number of livestock: Local cattle"
label variable numlivestock_excattle "Number of livestock: Exotic/crossbreed cattle"
label variable numlivestock_horses "Number of livestock: Horses/donkeys/mules"
label variable numlivestock_goats "Number of livestock: Goats"
label variable numlivestock_sheep "Number of livestock: Sheep"
label variable numlivestock_poultry "Number of livestock: Chickens/poultry"
label variable numlivestock_pig "Number of livestock: Pigs"
label variable numlivestock_other "Number of livestock: Other"

rename interview__key interview_key_ext
rename interview__id interview_id_ext

compress
save "dta/ext_livestock.dta", replace
