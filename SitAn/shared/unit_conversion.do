*===============================================================================
*
* FOOD CONSUMPTION EXPENDITURE
*	unit conversion from LSMS
*
*===============================================================================


use "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/measurement_conversion/Annex II Uganda - Agricultural Conversion factors.dta", clear

keep if item_name=="Banana food" | item_name=="Banana sweet" | item_name=="Cabbage" | item_name=="Cassava" & (condition_cd==45 | condition_cd==20)  | item_name=="Dodo" | item_name=="Eggplants" | ///
		(item_name=="Sorghum" & condition_cd==45) | (item_name=="Rice" & condition_cd==45) | (item_name=="Simsim" & condition_cd==45) | (item_name=="Groundnuts" & condition_cd==32) | ///
		item_name=="Irish potatoes" | (item_name=="Maize" & (condition_cd==23 | condition_cd==45)) | item_name=="Onions" | (item_name=="Sweet potatoes" & condition_cd==20) | item_name=="Tea" | ///
		item_name=="Beans" | item_name=="Onions" | item_name=="Cabbage" | item_name=="Mango" | item_name=="Avocado" | item_name=="Paw paw" | item_name=="Tomatoes"



gen food_roster__id = .
				replace food_roster__id = 2 if item_name=="Maize" & condition_cd==23
				//replace food_roster__id = 3
				replace food_roster__id = 4 if item_name=="Maize" & condition_cd==45
				replace food_roster__id = 5 if (item_name=="Sorghum" & condition_cd==45) | (item_name=="Finger millet" & condition_cd==45)
				replace food_roster__id = 6 if item_name=="Rice" & condition_cd==45
				//replace food_roster__id = 7 if
				replace food_roster__id = 8 if item_name=="Cassava" & condition_cd==45
				replace food_roster__id = 9 if item_name=="Cassava" & condition_cd==20
				replace food_roster__id = 10 if item_name=="Banana food"
				replace food_roster__id = 11 if item_name=="Irish potatoes"
				replace food_roster__id = 12 if item_name=="Sweet potatoes"
				//replace food_roster__id = 13 if
				//replace food_roster__id = 14 if
				replace food_roster__id = 15 if item_name=="Beans"
				replace food_roster__id = 16 if item_name=="Groundnuts"
				replace food_roster__id = 17 if item_name=="Simsim"
				//replace food_roster__id = 18 if
				replace food_roster__id = 19 if item_name=="Eggplants"
				//replace food_roster__id = 20 if
				replace food_roster__id = 21 if item_name=="Tomatoes" | item_name=="Onions"
				replace food_roster__id = 22 if item_name=="Cabbage"
				//replace food_roster__id = 23 if
				replace food_roster__id = 24 if item_name=="Mango"
				replace food_roster__id = 25 if item_name=="Avocado"
				replace food_roster__id = 26 if item_name=="Banana sweet"
				replace food_roster__id = 27 if item_name=="Paw paw"
				//replace food_roster__id = 28 if
				//replace food_roster__id = 29 if
				//replace food_roster__id = 30 if
				//replace food_roster__id = 31 if
				//replace food_roster__id = 32 if
				//replace food_roster__id = 33 if
				//replace food_roster__id = 34 if
				//replace food_roster__id = 35 if
				//replace food_roster__id = 36 if
				//replace food_roster__id = 37 if
				//replace food_roster__id = 38 if
				//replace food_roster__id = 39 if
				//replace food_roster__id = 40 if
				//replace food_roster__id = 41 if
				replace food_roster__id = 42 if item_name=="Tea"
				//replace food_roster__id = 43 if
				//replace food_roster__id = 44 if
				//replace food_roster__id = 45 if

gen new_food_unit = .
				replace new_food_unit = 7 if unit_name=="Cup/Mug(0.5Lt)"
				replace new_food_unit = 12 if unit_name=="Tin (20 lts)"
				replace new_food_unit = 16 if unit_name=="Bunch (Medium)"
				replace new_food_unit = 21 if unit_name=="Bundle (Unspecified)"
				replace new_food_unit = 22 if unit_name=="Cluster (Unspecified)"
				replace new_food_unit = 23 if unit_name=="Plastic Basin (15 lts)"
				replace new_food_unit = 24 if unit_name=="Heap (Unspecified)"
				replace new_food_unit = 25 if unit_name=="Sack (unspecified)"
				replace new_food_unit = 33 if unit_name=="Basket (5 kg)"

gen new_food_purch_unit = .
				replace new_food_purch_unit = 7 if unit_name=="Cup/Mug(0.5Lt)"
				replace new_food_purch_unit = 12 if unit_name=="Tin (20 lts)"
				replace new_food_purch_unit = 16 if unit_name=="Bunch (Medium)"
				replace new_food_purch_unit = 21 if unit_name=="Bundle (Unspecified)"
				replace new_food_purch_unit = 22 if unit_name=="Cluster (Unspecified)"
				replace new_food_purch_unit = 23 if unit_name=="Plastic Basin (15 lts)"
				replace new_food_purch_unit = 24 if unit_name=="Heap (Unspecified)"
				replace new_food_purch_unit = 25 if unit_name=="Sack (unspecified)"
				replace new_food_purch_unit = 33 if unit_name=="Basket (5 kg)"

gen new_food_prod_unit = .
				replace new_food_prod_unit = 7 if unit_name=="Cup/Mug(0.5Lt)"
				replace new_food_prod_unit = 12 if unit_name=="Tin (20 lts)"
				replace new_food_prod_unit = 16 if unit_name=="Bunch (Medium)"
				replace new_food_prod_unit = 21 if unit_name=="Bundle (Unspecified)"
				replace new_food_prod_unit = 22 if unit_name=="Cluster (Unspecified)"
				replace new_food_prod_unit = 23 if unit_name=="Plastic Basin (15 lts)"
				replace new_food_prod_unit = 24 if unit_name=="Heap (Unspecified)"
				replace new_food_prod_unit = 25 if unit_name=="Sack (unspecified)"
				replace new_food_prod_unit = 33 if unit_name=="Basket (5 kg)"

gen new_food_gift_unit = .
				replace new_food_gift_unit = 7 if unit_name=="Cup/Mug(0.5Lt)"
				replace new_food_gift_unit = 12 if unit_name=="Tin (20 lts)"
				replace new_food_gift_unit = 16 if unit_name=="Bunch (Medium)"
				replace new_food_gift_unit = 21 if unit_name=="Bundle (Unspecified)"
				replace new_food_gift_unit = 22 if unit_name=="Cluster (Unspecified)"
				replace new_food_gift_unit = 23 if unit_name=="Plastic Basin (15 lts)"
				replace new_food_gift_unit = 24 if unit_name=="Heap (Unspecified)"
				replace new_food_gift_unit = 25 if unit_name=="Sack (unspecified)"
				replace new_food_gift_unit = 33 if unit_name=="Basket (5 kg)"

		drop if new_food_unit==.

		gen conversion = ucaconversion
			replace conversion = medconversion if conversion==.


		keep food_roster__id new_food_unit conversion
		order food_roster__id new_food_unit conversion
		drop if food_roster__id==.
		duplicates drop

		collapse (mean) conversion, by(food_roster__id new_food_unit) // i've included this because you had duplicates given the different types of certain food items
		rename new_food_unit new_unit_


		save "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/dta/conversion.dta", replace
