*===============================================================================
*
* FOOD CONSUMPTION EXPENDITURE
*	substituting conversion factors to standardise
*
*===============================================================================

	keep interview__key interview__id food_roster__id food_quant food_purch_quant ///
	food_purch_spent food_prod_quant food_gift_quant new_food_unit ///
	new_food_purch_unit new_food_prod_unit ///
	new_food_gift_unit flag_1 food_purch_unit

// DA: made changes here. We should avoid as best as possible to use merge m:m
{
	rename food_quant quant_total
	rename food_purch_quant quant_purch
	rename food_purch_unit unit_purch
	rename food_purch_spent spent_purch
	rename food_prod_quant quant_prod
	rename food_gift_quant quant_gift
	rename new_food_unit new_unit_total
	rename new_food_purch_unit new_unit_purch
	rename new_food_prod_unit new_unit_prod
	rename new_food_gift_unit new_unit_gift

	reshape long quant_ unit_ spent_ new_unit_, i(interview__key interview__id food_roster__id) j(type, string)
	drop if quant_ ==0 | quant_ == . | quant_==.a

	merge m:1 interview__key using "${extended}", keep(3) nogenerate keepusing(ea district subcounty urban parish village)
	gen region = floor(district/100)

	order interview__key interview__id ea district subcounty urban parish village

	merge m:1 food_roster__id new_unit_ using "${conversion}", keep(1 3) nogenerate
}
	//drop if _merge==2

	// 	1) create unit groups:

	*KG - Heap, Bunch, Grams, Pound, Ounce, Bunch
gen kgfactor =.
			replace kgfactor = 1 if new_unit_==1  //Kg
			replace kgfactor = 0.001 if new_unit_==2 //grams
			replace kgfactor = 0.4535929094 if new_unit_==3  //pounds
			replace kgfactor = 0.02834949254 if new_unit_==4  //ounce
			replace kgfactor = conversion if new_unit_==16  //bunch (medium) from conversion
			replace kgfactor = 25 if (new_unit_==16) & kgfactor==. //bunch (medium) from conversion
			replace kgfactor = 1 if new_unit_==21  //bundle (unspecified) generic
			replace kgfactor = conversion if new_unit_==22  //bundle (unspecified)
			replace kgfactor = conversion if new_unit_==24  //heap (unspecified) from conversion
			replace kgfactor = conversion if new_unit_==25  //sack (unspecified) from conversion
			replace kgfactor= 27.21 if new_unit_==11  //bushel generic
			replace kgfactor= 6.80389 if new_unit_==10  //peck generic

	*UNITS - pieces, dozens, Other(?)
gen unitfactor =.
			replace unitfactor = 1 if new_unit_==13  //pieces
			replace unitfactor = 0.08333333333 if new_unit_==14  //dozens

	*LITRES - Millitres, Cups, Gallons, Pint/Quart, Bottles, Tin(?)
gen lfactor =.
			replace lfactor= conversion if new_unit_==7  //cup from conversion
			replace lfactor= 0.236588 if new_unit_==7 & lfactor==.
			replace lfactor= conversion if new_unit_==12  //tin from conversion
			replace lfactor= conversion if new_unit_==23  //basin from conversion
			replace lfactor= 1 if (new_unit_==5 ) & lfactor==. //litres
			replace lfactor= 0.001 if new_unit_==6  //mililitres
			/*replace lfactor=  if new_unit_==7  //cup generic
			replace lfactor=  if new_unit_==7  //cup Maize(flour)
			replace lfactor=  if new_unit_==7 //cup Peas
			replace lfactor= if new_unit_==7 //cup groundnuts
			replace lfactor=  if new_unit_==7  //cup simsim
			replace lfactor=  if new_unit_==7 //cup milk
			replace lfactor=  if new_unit_==7  //cup tea */
			replace lfactor= 3.7854125343 if (new_unit_==8) & lfactor==. //gallon
			replace lfactor= 0.568261 if (new_unit_==9) & lfactor==. //pint
			replace lfactor= 0.5 if (new_unit_==15) & lfactor==. //Bottle (assume 500ml)
			replace lfactor= 0.04286326618 if (new_unit_==12) & food_roster__id<=4 & food_roster__id>=2 & lfactor==. //Tin Maize
			replace lfactor= 0.04830917874 if (new_unit_==12) & food_roster__id==11 & lfactor==. //Tin Irish Potatoes
			replace lfactor= 0.04140786749 if (new_unit_==12) & food_roster__id==12 & lfactor==. //Tin Sweet potatoes
			replace lfactor= 0.05 if (new_unit_==12) & (food_roster__id!=12 | food_roster__id!=11 | food_roster__id<2 | (food_roster__id>4 & food_roster__id<11)) & lfactor==. // Tin generic
	*PECK & BUSHEL

// I'm not sure if we have enough units for this factor 200+ with a positive spent value. Could we make this
gen bushelfactor=.
			replace bushelfactor= 1 if new_unit_==11 //Buchel
			replace bushelfactor= 0.25 if new_unit_==10 //Peck

// DA: I've added another factor: 'otherfactor'.
gen otherfactor = .
			replace otherfactor = 1 if new_unit_==96

	**New weights to standardise prices

	gen standard_quant_ = quant_*kgfactor if kgfactor!=.
		replace standard_quant_ = quant_*unitfactor if unitfactor!=. & standard_quant_==.
		replace standard_quant_ = quant_*lfactor if lfactor!=. & standard_quant_==.
		replace standard_quant_ = quant_*bushelfactor if bushelfactor!=. & standard_quant_==.
		replace standard_quant_ = quant_*otherfactor if otherfactor!=. & standard_quant_==.

gen grp =1 if kgfactor!=.
	replace grp =2 if grp==. & unitfactor!=.
	replace grp =3 if grp==. & lfactor!=.
	replace grp =4 if grp==. & bushelfactor!=.
	replace grp =5 if grp==. & otherfactor!=.

*===============================================================================
*
* FOOD CONSUMPTION EXPENDITURE
*	estimate gift and production values and construct total
*		food household expenditure
*
*===============================================================================


	//	2) Find mean price of food item within metric/unit by subregion(?)

	*create group of food item and unit
	egen item_group = group(food_roster__id grp urban)
	sort item_group
	replace item_group= 0 if item_group==.

	*check price outliers and truncate (bottom x%)

	egen medquant = median(standard_quant_), by(item_group)
	egen sdquant = sd(standard_quant_), by(item_group)

	gen outlier_quant = standard_quant_>=3*sdquant & standard_quant_!=.
	replace standard_quant_ = medquant if outlier_quant==1

	replace spent_ =. if spent_ ==0
	gen item_unit_price = spent_/standard_quant_

	egen medprice = median(item_unit_price), by(item_group)
	egen sdprice = sd(item_unit_price), by(item_group)

	gen outlier_price = item_unit_price>=3*sdprice & item_unit_price!=.
	replace item_unit_price = medprice if outlier_price==1

	gen exp_ =  standard_quant_*item_unit_price if type=="purch"
			replace exp_ = standard_quant_*medprice if type=="prod" | type=="gift"

// DA: not sure what you were you trying here, but I think there should have been a loop here, no? otherwise aren't you getting the SD from the last item group?

	// bysort item_group:  sum item_unit_price if item_unit_price>0 & item_group>0 & item_unit_price!=. , d
	// 		gen outlier_indic = item_unit_price>3*`r(sd)' & item_unit_price!=. & `r(sd)'!=.
	// 			replace item_unit_price =. if outlier_indic==1
	// 			replace item_unit_price =. if item_unit_price==0


	// //winsor2 food_purch_spent if food_purch_spent!=. , cuts(25 75) suffix(_win) by(item_group) trim label
	//
	// *get median price
	// egen price_med = median(item_unit_price) if item_unit_price>0 & item_unit_price!=., by(item_group)
	//
	// *for those truncated (forced missing) make median the price
	// 	replace item_unit_price = price_med if outlier_indic==1

	// *for those that have been gifted or bought create new value vars quant*unit price
	// 	gen prod = 	food_prod_quant>0 & food_prod_quant!=.
	// 	gen gift = 	food_gift_quant>0 & food_gift_quant!=.
	//
	// 	gen prod_value = item_unit_price*standard_prod_quant if prod
	// 	gen gift_value = item_unit_price*standard_gift_quant if gift

	// 3) Household food expenditure

	egen hh_food_exp_week = total(exp_), by(interview__key)

	// egen hh_food_exp = rowtotal(food_purch_spent prod_value gift_value)
	// egen hh_food_exp_total = sum(hh_food_exp), by(interview__key)

	gen hh_food_exp_total = ((hh_food_exp_week)/7)*30

	keep interview__key interview__id hh_food_exp_total flag*

		duplicates drop interview__key, force

			sort interview__key

		save "${dta}/food_exp.dta", replace
