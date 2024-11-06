*===============================================================================
*
* FOOD CONSUMPTION EXPENDITURE
*	unit values from comments for "other" responses
*
*===============================================================================



use "${food_roster}", clear

	//food_unit - other replace
preserve
{
use "${interview_comment}", clear

sort interview__id id1
keep if role==1
keep if roster=="food_roster" & variable=="food_unit" & order<=2
duplicates drop interview__id id1 order, force

rename id1 food_roster__id

keep interview__key interview__id food_roster__id comment

replace comment  = subinstr(comment, char(34), "", .)
replace comment  = subinstr(comment, "  ", " ", .)
replace comment  = subinstr(comment, "'", " ", .)
replace comment  = subinstr(comment, char(64), "", .)
replace comment  = subinstr(comment, "/", "", .)
replace comment  = subinstr(comment, "(", "", .)
replace comment  = subinstr(comment, ")", "", .)
replace comment  = subinstr(comment, ",", "", .)
replace comment  = subinstr(comment, ".", "", .)

rename comment comment_food
tempfile foodunit
save `foodunit', replace
}
restore

		merge m:1 interview__key food_roster__id using `foodunit'
		//drop if _merge ==2

		//String manipulation and search
gen comment_food_unit = comment_food if inrange(length(comment_food), 1,50)
strgroup comment_food if food_unit==96, gen(non_standard_food) threshold(0.25)
drop _merge

		preserve

		contract non_standard_food, freq(a)
		tempfile count_test
		save `count_test', replace

		restore

merge m:1 non_standard_food using `count_test', nogen

replace non_standard_food= . if a<5

//to allocate non_standard==19 (tea leaves), 41 (small heap), 53 (??), 55(??)
//for 57 it's 10 litres equivalnt non_standard_food==39(one chicken)

gen unit_1 = .
		replace unit_1 = 21 if unit_1==. & (strpos(comment_food_unit, "bundle") | strpos(comment_food_unit, "Bundle") | strpos(comment_food_unit, "bandle") | strpos(comment_food_unit, "bindle") | strpos(comment_food_unit, "bundles") | strpos(comment_food_unit, "Bundles") | strpos(comment_food_unit, "bunf") | strpos(comment_food_unit, "bund"))
		replace unit_1 = 22 if unit_1==. & (strpos(comment_food_unit, "cluster") | strpos(comment_food_unit, "Cluster") | strpos(comment_food_unit, "clusters") | strpos(comment_food_unit, "Clusters"))
		replace unit_1 = 20 if unit_1==. &  (strpos(comment_food_unit, "Sachet") | strpos(comment_food_unit, "sachet") | strpos(comment_food_unit, "Sachets") | strpos(comment_food_unit, "sachets") | strpos(comment_food_unit, "sacket") | strpos(comment_food_unit, "sackets"))
		replace unit_1 = 23 if unit_1==. &  (strpos(comment_food_unit, "Basin") | strpos(comment_food_unit, "basin") | strpos(comment_food_unit, "Basins") | strpos(comment_food_unit, "basins"))
		replace unit_1 = 24 if unit_1==. &  (strpos(comment_food_unit, "Heap") | strpos(comment_food_unit, "heap") | strpos(comment_food_unit, "Heaps") | strpos(comment_food_unit, "heaps"))
		replace unit_1 = 25 if unit_1==. &  (strpos(comment_food_unit, "Sack") | strpos(comment_food_unit, "sack") | strpos(comment_food_unit, "Sacks") | strpos(comment_food_unit, "sacks"))
		replace unit_1 = 26 if unit_1==. &  (strpos(comment_food_unit, "Spoon") | strpos(comment_food_unit, "spoon") | strpos(comment_food_unit, "Spoons") | strpos(comment_food_unit, "spoons"))
		replace unit_1 = 27 if unit_1==. &  (strpos(comment_food_unit, "nomi") | strpos(comment_food_unit, "nomis"))
		replace unit_1 = 28 if unit_1==. &  (strpos(comment_food_unit, "packet") | strpos(comment_food_unit, "Packet") | strpos(comment_food_unit, "pack") | strpos(comment_food_unit, "Pack"))
		replace unit_1 = 29 if unit_1==. &  (strpos(comment_food_unit, "Bucket") | strpos(comment_food_unit, "bucket"))
		replace unit_1 = 30 if unit_1==. &  (strpos(comment_food_unit, "plate") | strpos(comment_food_unit, "Plate"))
		replace unit_1 = 1 if unit_1==. &  (strpos(comment_food_unit, "kilo") | strpos(comment_food_unit, "Kilo"))
		replace unit_1 = 13 if unit_1==. &  (strpos(comment_food_unit, "Piece") | strpos(comment_food_unit, "piece") | strpos(comment_food_unit, "Pieces") | strpos(comment_food_unit, "pieces"))
		replace unit_1 = 1 if unit_1==. &  (strpos(comment_food_unit, "chicken")) //convert to approx 1.7kg
		replace unit_1 = 1 if unit_1==. &  (strpos(comment_food_unit, "Half")) //convert to kilo since these are applied to things like rice and flour (this will always need to be second to the explicit assignment of kilos)
		replace unit_1 = 33 if unit_1==. &  (strpos(comment_food_unit, "Basket") | strpos(comment_food_unit, "basket") | strpos(comment_food_unit, "baskets") | strpos(comment_food_unit, "Baskets"))
		replace unit_1 = 34 if unit_1==. &  (strpos(comment_food_unit, "bowl") | strpos(comment_food_unit, "bowls") | strpos(comment_food_unit, "Bowl") | strpos(comment_food_unit, "Bowls"))
		replace unit_1 = 35 if unit_1==. &  (strpos(comment_food_unit, "sack"))


		replace unit_1 = 20 if unit_1 == . & non_standard_food==1 // sachet
		replace unit_1 = 21 if unit_1 == . & (non_standard_food==2 | non_standard_food==6 | non_standard_food==8 | non_standard_food==14 )  // bundle
		replace unit_1 = 22 if unit_1 == . & non_standard_food==3  // cluster
		replace unit_1 = 23 if unit_1 == . & non_standard_food==5 //basin


	//food_purch_unit - other replace
preserve
{
use "${interview_comment}", clear
sort interview__id id1
keep if roster=="food_roster" & variable=="food_purch_unit" & order<=3
keep if role==1

duplicates drop interview__id id1 order, force

gen food_roster__id = id1

keep interview__key interview__id food_roster__id comment

replace comment  = subinstr(comment, char(34), "", .)
replace comment  = subinstr(comment, "  ", " ", .)
replace comment  = subinstr(comment, "'", " ", .)
replace comment  = subinstr(comment, char(64), "", .)
replace comment  = subinstr(comment, "/", "", .)
replace comment  = subinstr(comment, "(", "", .)
replace comment  = subinstr(comment, ")", "", .)
replace comment  = subinstr(comment, ",", "", .)
replace comment  = subinstr(comment, ".", "", .)

rename comment comment_purch
tempfile foodpurchunit
save `foodpurchunit', replace
}
restore

//drop _merge
merge 1:m interview__key food_roster__id using `foodpurchunit'


gen comment_purch_unit = comment_purch if inrange(length(comment_purch), 1,50)
strgroup comment_purch if food_purch_unit==96, gen(non_standard_purch) threshold(0.25)

drop _merge

		preserve

		contract non_standard_purch, freq(b)
		tempfile count_purch
		save `count_purch', replace

		restore

merge m:1 non_standard_purch using `count_purch', nogen

replace non_standard_purch= . if b<3


//to allocate non_standard==19 (tea leaves), 41 (one chicken), 53 (??), 55(??)
//for 57 it's 10 litres equivalnt

gen unit_2 = .


replace unit_2 = 21 if unit_2==. & (strpos(comment_purch_unit, "bundle") | strpos(comment_purch_unit, "Bundle") | strpos(comment_purch_unit, "bandle") | strpos(comment_purch_unit, "bindle") | strpos(comment_purch_unit, "bundles") | strpos(comment_purch_unit, "Bundles") | strpos(comment_purch_unit, "bunf") | strpos(comment_purch_unit, "bund"))
replace unit_2 = 22 if unit_2==. & (strpos(comment_purch_unit, "cluster") | strpos(comment_purch_unit, "Cluster") | strpos(comment_purch_unit, "clusters") | strpos(comment_purch_unit, "Clusters"))
replace unit_2 = 20 if unit_2==. &  (strpos(comment_purch_unit, "Sachet") | strpos(comment_purch_unit, "sachet") | strpos(comment_purch_unit, "Sachets") | strpos(comment_purch_unit, "sachets") | strpos(comment_purch_unit, "sacket") | strpos(comment_purch_unit, "sackets"))
replace unit_2 = 23 if unit_2==. &  (strpos(comment_purch_unit, "Basin") | strpos(comment_purch_unit, "basin") | strpos(comment_purch_unit, "Basins") | strpos(comment_purch_unit, "basins"))
replace unit_2 = 24 if unit_2==. &  (strpos(comment_purch_unit, "Heap") | strpos(comment_purch_unit, "heap") | strpos(comment_purch_unit, "Heaps") | strpos(comment_purch_unit, "heaps"))
replace unit_2 = 25 if unit_2==. &  (strpos(comment_purch_unit, "Sack") | strpos(comment_purch_unit, "sack") | strpos(comment_purch_unit, "Sacks") | strpos(comment_purch_unit, "sacks"))
replace unit_2 = 26 if unit_2==. &  (strpos(comment_purch_unit, "Spoon") | strpos(comment_purch_unit, "spoon") | strpos(comment_purch_unit, "Spoons") | strpos(comment_purch_unit, "spoons"))
replace unit_2 = 27 if unit_2==. &  (strpos(comment_purch_unit, "nomi") | strpos(comment_purch_unit, "nomis"))
replace unit_2 = 28 if unit_2==. &  (strpos(comment_purch_unit, "packet") | strpos(comment_purch_unit, "Packet") | strpos(comment_purch_unit, "pack") | strpos(comment_purch_unit, "Pack"))
replace unit_2 = 29 if unit_2==. &  (strpos(comment_purch_unit, "Bucket") | strpos(comment_purch_unit, "bucket"))
replace unit_2 = 30 if unit_2==. &  (strpos(comment_purch_unit, "plate") | strpos(comment_purch_unit, "Plate"))
replace unit_2 = 1 if unit_2==. &  (strpos(comment_purch_unit, "kilo") | strpos(comment_purch_unit, "Kilo"))
replace unit_2 = 13 if unit_2==. &  (strpos(comment_purch_unit, "Piece") | strpos(comment_purch_unit, "piece") | strpos(comment_purch_unit, "Pieces") | strpos(comment_purch_unit, "pieces"))
replace unit_2 = 1 if unit_2==. &  (strpos(comment_purch_unit, "chicken")) //convert to approx 1.7kg
replace unit_2 = 1 if unit_2==. &  (strpos(comment_purch_unit, "Half")) //convert to kilo since these are applied to things like rice and flour (this will always need to be second to the explicit assignment of kilos)
replace unit_2 = 33 if unit_2==. &  (strpos(comment_purch_unit, "Basket") | strpos(comment_purch_unit, "basket") | strpos(comment_purch_unit, "baskets") | strpos(comment_purch_unit, "Baskets"))
replace unit_2 = 34 if unit_2==. &  (strpos(comment_purch_unit, "bowl") | strpos(comment_purch_unit, "bowls") | strpos(comment_purch_unit, "Bowl") | strpos(comment_purch_unit, "Bowls"))
replace unit_2 = 35 if unit_2==. &  (strpos(comment_purch_unit, "sack"))


replace unit_2 = 20 if unit_2 == . & non_standard_purch==1 // sachet
replace unit_2 = 21 if unit_2 == . & (non_standard_purch==7 | non_standard_purch==9 | non_standard_purch==3)  // bundle
replace unit_2 = 22 if unit_2 == . & (non_standard_purch==2 | non_standard_purch==14)  // cluster
replace unit_2 = 23 if unit_2 == . & non_standard_purch==4 //basin


	//food_prod_unit - other replace
preserve
{
use "${interview_comment}", clear

sort interview__id id1
keep if roster=="food_roster" & variable=="food_prod_unit" & order<=2
keep if role==1

duplicates drop interview__id id1 order, force

gen food_roster__id = id1

keep interview__key interview__id food_roster__id comment

replace comment  = subinstr(comment, char(34), "", .)
replace comment  = subinstr(comment, "  ", " ", .)
replace comment  = subinstr(comment, "'", " ", .)
replace comment  = subinstr(comment, char(64), "", .)
replace comment  = subinstr(comment, "/", "", .)
replace comment  = subinstr(comment, "(", "", .)
replace comment  = subinstr(comment, ")", "", .)
replace comment  = subinstr(comment, ",", "", .)
replace comment  = subinstr(comment, ".", "", .)

rename comment comment_prod
tempfile foodprodunit
save `foodprodunit', replace
}
restore

merge 1:m interview__key food_roster__id using `foodprodunit'

//drop if _merge==2

gen comment_prod_unit = comment_prod if inrange(length(comment_prod), 1,50)
strgroup comment_prod if food_prod_unit==96, gen(non_standard_prod) threshold(0.25)

drop _merge

		preserve

		contract non_standard_prod, freq(c)
		tempfile count_prod
		save `count_prod', replace

		restore

merge m:1 non_standard_prod using `count_prod', nogen

replace non_standard_prod= . if c<3


//to allocate non_standard==19 (tea leaves), 41 (one chicken), 53 (??), 55(??)
//for 57 it's 10 litres equivalnt

gen unit_3 = .


replace unit_3 = 21 if unit_3==. & (strpos(comment_prod_unit, "bundle") | strpos(comment_prod_unit, "Bundle") | strpos(comment_prod_unit, "bandle") | strpos(comment_prod_unit, "bindle") | strpos(comment_prod_unit, "bundles") | strpos(comment_prod_unit, "Bundles") | strpos(comment_prod_unit, "bunf") | strpos(comment_prod_unit, "bund"))
replace unit_3 = 22 if unit_3==. & (strpos(comment_prod_unit, "cluster") | strpos(comment_prod_unit, "Cluster") | strpos(comment_prod_unit, "clusters") | strpos(comment_prod_unit, "Clusters"))
replace unit_3 = 20 if unit_3==. &  (strpos(comment_prod_unit, "Sachet") | strpos(comment_prod_unit, "sachet") | strpos(comment_prod_unit, "Sachets") | strpos(comment_prod_unit, "sachets") | strpos(comment_prod_unit, "sacket") | strpos(comment_prod_unit, "sackets"))
replace unit_3 = 23 if unit_3==. &  (strpos(comment_prod_unit, "Basin") | strpos(comment_prod_unit, "basin") | strpos(comment_prod_unit, "Basins") | strpos(comment_prod_unit, "basins"))
replace unit_3 = 24 if unit_3==. &  (strpos(comment_prod_unit, "Heap") | strpos(comment_prod_unit, "heap") | strpos(comment_prod_unit, "Heaps") | strpos(comment_prod_unit, "heaps"))
replace unit_3 = 25 if unit_3==. &  (strpos(comment_prod_unit, "Sack") | strpos(comment_prod_unit, "sack") | strpos(comment_prod_unit, "Sacks") | strpos(comment_prod_unit, "sacks"))
replace unit_3 = 26 if unit_3==. &  (strpos(comment_prod_unit, "Spoon") | strpos(comment_prod_unit, "spoon") | strpos(comment_prod_unit, "Spoons") | strpos(comment_prod_unit, "spoons"))
replace unit_3 = 27 if unit_3==. &  (strpos(comment_prod_unit, "nomi") | strpos(comment_prod_unit, "nomis"))
replace unit_3 = 28 if unit_3==. &  (strpos(comment_prod_unit, "packet") | strpos(comment_prod_unit, "Packet") | strpos(comment_prod_unit, "pack") | strpos(comment_prod_unit, "Pack"))
replace unit_3 = 29 if unit_3==. &  (strpos(comment_prod_unit, "Bucket") | strpos(comment_prod_unit, "bucket"))
replace unit_3 = 30 if unit_3==. &  (strpos(comment_prod_unit, "plate") | strpos(comment_prod_unit, "Plate"))
replace unit_3 = 1 if unit_3==. &  (strpos(comment_prod_unit, "kilo") | strpos(comment_prod_unit, "Kilo"))
replace unit_3 = 13 if unit_3==. &  (strpos(comment_prod_unit, "Piece") | strpos(comment_prod_unit, "piece") | strpos(comment_prod_unit, "Pieces") | strpos(comment_prod_unit, "pieces"))
replace unit_3 = 1 if unit_3==. &  (strpos(comment_prod_unit, "chicken")) //convert to approx 1.7kg
replace unit_3 = 1 if unit_3==. &  (strpos(comment_prod_unit, "Half")) //convert to kilo since these are applied to things like rice and flour (this will always need to be second to the explicit assignment of kilos)
replace unit_3 = 33 if unit_3==. &  (strpos(comment_prod_unit, "Basket") | strpos(comment_prod_unit, "basket") | strpos(comment_prod_unit, "baskets") | strpos(comment_prod_unit, "Baskets"))
replace unit_3 = 34 if unit_3==. &  (strpos(comment_prod_unit, "bowl") | strpos(comment_prod_unit, "bowls") | strpos(comment_prod_unit, "Bowl") | strpos(comment_prod_unit, "Bowls"))
replace unit_3 = 35 if unit_3==. &  (strpos(comment_prod_unit, "sack"))


//replace unit_3 = 20 if unit_3 == . & non_standard_prod==1 // sachet
replace unit_3 = 21 if unit_3 == . & (non_standard_prod==1 | non_standard_prod==2)  // bundle
replace unit_3 = 22 if unit_3 == . & non_standard_prod==5  // cluster
replace unit_3 = 23 if unit_3 == . & non_standard_prod==3 //basin



	//food_gift_unit - other replace
preserve
{
use "${interview_comment}", clear

sort interview__id id1
keep if roster=="food_roster" & variable=="food_gift_unit"
keep if role==1

duplicates drop interview__id id1 order, force

gen food_roster__id = id1

keep interview__key interview__id food_roster__id comment

replace comment  = subinstr(comment, char(34), "", .)
replace comment  = subinstr(comment, "  ", " ", .)
replace comment  = subinstr(comment, "'", " ", .)
replace comment  = subinstr(comment, char(64), "", .)
replace comment  = subinstr(comment, "/", "", .)
replace comment  = subinstr(comment, "(", "", .)
replace comment  = subinstr(comment, ")", "", .)
replace comment  = subinstr(comment, ",", "", .)
replace comment  = subinstr(comment, ".", "", .)

rename comment comment_gift
tempfile foodgiftunit
save `foodgiftunit', replace
}
restore

merge 1:m interview__key food_roster__id using `foodgiftunit'

gen comment_gift_unit = comment_gift if inrange(length(comment_gift), 1,50)
strgroup comment_gift if food_gift_unit==96, gen(non_standard_gift) threshold(0.25)

drop _merge


//to allocate non_standard==19 (tea leaves), 41 (one chicken), 53 (??), 55(??)
//for 57 it's 10 litres equivalnt

gen unit_4 = .


replace unit_4 = 21 if unit_4==. & (strpos(comment_gift_unit, "bundle") | strpos(comment_gift_unit, "Bundle") | strpos(comment_gift_unit, "bandle") | strpos(comment_gift_unit, "bindle") | strpos(comment_gift_unit, "bundles") | strpos(comment_gift_unit, "Bundles") | strpos(comment_gift_unit, "bunf") | strpos(comment_gift_unit, "bund"))
replace unit_4 = 22 if unit_4==. & (strpos(comment_gift_unit, "cluster") | strpos(comment_gift_unit, "Cluster") | strpos(comment_gift_unit, "clusters") | strpos(comment_gift_unit, "Clusters"))
replace unit_4 = 20 if unit_4==. &  (strpos(comment_gift_unit, "Sachet") | strpos(comment_gift_unit, "sachet") | strpos(comment_gift_unit, "Sachets") | strpos(comment_gift_unit, "sachets") | strpos(comment_gift_unit, "sacket") | strpos(comment_gift_unit, "sackets"))
replace unit_4 = 23 if unit_4==. &  (strpos(comment_gift_unit, "Basin") | strpos(comment_gift_unit, "basin") | strpos(comment_gift_unit, "Basins") | strpos(comment_gift_unit, "basins"))
replace unit_4 = 24 if unit_4==. &  (strpos(comment_gift_unit, "Heap") | strpos(comment_gift_unit, "heap") | strpos(comment_gift_unit, "Heaps") | strpos(comment_gift_unit, "heaps"))
replace unit_4 = 25 if unit_4==. &  (strpos(comment_gift_unit, "Sack") | strpos(comment_gift_unit, "sack") | strpos(comment_gift_unit, "Sacks") | strpos(comment_gift_unit, "sacks"))
replace unit_4 = 26 if unit_4==. &  (strpos(comment_gift_unit, "Spoon") | strpos(comment_gift_unit, "spoon") | strpos(comment_gift_unit, "Spoons") | strpos(comment_gift_unit, "spoons"))
replace unit_4 = 27 if unit_4==. &  (strpos(comment_gift_unit, "nomi") | strpos(comment_gift_unit, "nomis"))
replace unit_4 = 28 if unit_4==. &  (strpos(comment_gift_unit, "packet") | strpos(comment_gift_unit, "Packet") | strpos(comment_gift_unit, "pack") | strpos(comment_gift_unit, "Pack"))
replace unit_4 = 29 if unit_4==. &  (strpos(comment_gift_unit, "Bucket") | strpos(comment_gift_unit, "bucket"))
replace unit_4 = 30 if unit_4==. &  (strpos(comment_gift_unit, "plate") | strpos(comment_gift_unit, "Plate"))
replace unit_4 = 1 if unit_4==. &  (strpos(comment_gift_unit, "kilo") | strpos(comment_gift_unit, "Kilo"))
replace unit_4 = 13 if unit_4==. &  (strpos(comment_gift_unit, "Piece") | strpos(comment_gift_unit, "piece") | strpos(comment_gift_unit, "Pieces") | strpos(comment_gift_unit, "pieces"))
replace unit_4 = 1 if unit_4==. &  (strpos(comment_gift_unit, "chicken")) //convert to approx 1.7kg
replace unit_4 = 1 if unit_4==. &  (strpos(comment_gift_unit, "Half")) //convert to kilo since these are applied to things like rice and flour (this will always need to be second to the explicit assignment of kilos)
replace unit_4 = 33 if unit_4==. &  (strpos(comment_gift_unit, "Basket") | strpos(comment_gift_unit, "basket") | strpos(comment_gift_unit, "baskets") | strpos(comment_gift_unit, "Baskets"))
replace unit_4 = 34 if unit_4==. &  (strpos(comment_gift_unit, "bowl") | strpos(comment_gift_unit, "bowls") | strpos(comment_gift_unit, "Bowl") | strpos(comment_gift_unit, "Bowls"))
replace unit_4 = 35 if unit_4==. &  (strpos(comment_gift_unit, "sack"))


//replace unit_4 = 20 if unit_4 == . & non_standard_gift==1 // sachet
//replace unit_4 = 21 if unit_4 == . & (non_standard_gift==1 | non_standard_gift==2)  // bundle
replace unit_4 = 22 if unit_4 == . & non_standard_gift==2  // cluster
//replace unit_4 = 23 if unit_4 == . & non_standard_gift==3 //basin



//Flag those that have at least one unit value as "other" by households

egen flag_1 = max(food_unit==96 | food_purch_unit==96 | food_prod_unit==96 | food_gift_unit==96), by(interview__key)

gen new_food_unit = unit_1 if food_unit==96 & unit_1!=.
	replace new_food_unit = food_unit if new_food_unit==. &  food_unit!=.

		label define food_unit 17 "Pinch" 20 "Sachet" 21 "Bundle" 22 "Cluster" 23 "Basin" 24 "Heap" 25 "Sack" 26 "Spoon" 27 "Nomi" 28 "Packet" 29 "Bucket" 30 "Plate" 33 "Basket" 34 "Bowl", add
			label values new_food_unit food_unit

gen new_food_purch_unit = unit_2 if food_purch_unit==96 & unit_2!=.
	replace new_food_purch_unit = food_purch_unit if new_food_purch_unit==. &  food_purch_unit!=.
		label define food_purch_unit 20 "Sachet" 21 "Bundle" 22 "Cluster" 23 "Basin" 24 "Heap" 25 "Sack" 26 "Spoon" 27 "Nomi" 28 "Packet" 29 "Bucket" 30 "Plate" 33 "Basket" 34 "Bowl", add
			label values new_food_purch_unit food_purch_unit

gen new_food_prod_unit = unit_3 if food_prod_unit==96 & unit_3!=.
	replace new_food_prod_unit = food_prod_unit if new_food_prod_unit==. &  food_prod_unit!=.
		label define food_prod_unit 20 "Sachet" 21 "Bundle" 22 "Cluster" 23 "Basin" 24 "Heap" 25 "Sack" 26 "Spoon" 27 "Nomi" 28 "Packet" 29 "Bucket" 30 "Plate" 33 "Basket" 34 "Bowl", add
			label values new_food_prod_unit food_prod_unit

gen new_food_gift_unit = unit_4 if food_gift_unit==96 & unit_4!=.
	replace new_food_gift_unit = food_gift_unit if new_food_gift_unit==. & food_gift_unit!=.
		label define food_gift_unit 20 "Sachet" 21 "Bundle" 22 "Cluster" 23 "Basin" 24 "Heap" 25 "Sack" 26 "Spoon" 27 "Nomi" 28 "Packet" 29 "Bucket" 30 "Plate" 33 "Basket" 34 "Bowl", add
			label values new_food_gift_unit food_gift_unit


	replace new_food_unit = new_food_purch_unit if new_food_unit==96 & new_food_purch_unit!=96 & new_food_purch_unit!=.
	replace new_food_unit = new_food_prod_unit if new_food_unit==96 & new_food_prod_unit!=96 & new_food_prod_unit!=.
	//replace new_food_unit = new_food_gift_unit if new_food_unit==96 & new_food_gift_unit!=96 & new_food_gift_unit!=.

	replace new_food_purch_unit = new_food_unit if new_food_purch_unit==96 & new_food_unit!=96 & new_food_unit!=.
	//drop if new_food_unit==96
