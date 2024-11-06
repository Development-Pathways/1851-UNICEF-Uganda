** Mobile and self-care devices
rename adevice_mobiltype__* temp_type_*
rename adevice_mobilneed__* temp_need_*
rename no_mdevice_need__*	temp_no_need_*

forvalues x = 1/13 {
	gen adevice_mobiltype__`x' = 0 if adevice_mobil!=.
	gen adevice_mobilneed__`x' = 0 if adevice_mobil!=.
	gen no_mdevice_need__`x' = 0 if no_adevice_mobil!=.
}
	gen no_mdevice_need__96 = 0 if no_adevice_mobil!=.

foreach var of varlist temp_type_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
		
	} 
	else {
	forvalues x = 1/13 {
		replace adevice_mobiltype__`x' = 1 if `var' ==`x'
		}
	}
}

foreach var of varlist temp_need_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
	} 
	else {
	forvalues x = 1/13 {
		replace adevice_mobilneed__`x' = 1 if `var' ==`x'
		}
	}
}
*

foreach var of varlist temp_no_need_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
	} 
	else {
	forvalues x = 1/12 {
		replace no_mdevice_need__`x' = 1 if `var' ==`x'
		}
		replace no_mdevice_need__96 = 1 if `var' ==96
	}
}
*

drop temp_*

order adevice_mobiltype__* adevice_mobilneed__*, after(adevice_mobil)
order no_mdevice_need__*, after(no_adevice_mobil)


** HEARING & COMMUNICATION
rename adevice_heartype__* temp_type_*
rename adevice_hearneed__* temp_need_*
rename no_hdevice_need__*	temp_no_need_*

forvalues x = 1/10 {
	gen adevice_heartype__`x' = 0 if adevice_hear!=.
	gen adevice_hearneed__`x' = 0 if adevice_hear!=.
	gen no_hdevice_need__`x' = 0 if no_adevice_hear!=.
}

	gen adevice_heartype__96 = 0 if adevice_hear!=.
	gen adevice_hearneed__96 = 0 if adevice_hear!=.
	gen no_hdevice_need__96 = 0 if no_adevice_hear!=.

foreach var of varlist temp_type_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
		
	} 
	else {
	forvalues x = 1/10 {
		replace adevice_heartype__`x' = 1 if `var' ==`x'
		}
		replace adevice_heartype__96 = 1 if `var' ==96
	}
}

foreach var of varlist temp_need_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
	} 
	else {
	forvalues x = 1/10 {
		replace adevice_hearneed__`x' = 1 if `var' ==`x'
		}
		replace adevice_hearneed__96 = 1 if `var' ==96

	}
}
*

foreach var of varlist temp_no_need_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
	} 
	else {
	forvalues x = 1/10 {
		replace no_hdevice_need__`x' = 1 if `var' ==`x'
		}
		replace no_hdevice_need__96 = 1 if `var' ==96
	}
}
*

drop temp_*

order adevice_heartype__* adevice_hearneed__*, after(adevice_hear)
order no_hdevice_need__*, after(no_adevice_hear)


** SEEING
rename adevice_seetype__* temp_type_*
rename adevice_seeneed__* temp_need_*
rename no_sdevice_need__*	temp_no_need_*

forvalues x = 1/10 {
	gen adevice_seetype__`x' = 0 if adevice_see!=.
	gen adevice_seeneed__`x' = 0 if adevice_see!=.
	gen no_sdevice_need__`x' = 0 if no_adevice_see!=.
}

	gen adevice_seetype__96 = 0 if adevice_see!=.
	gen adevice_seeneed__96 = 0 if adevice_see!=.
	gen no_sdevice_need__96 = 0 if no_adevice_see!=.

foreach var of varlist temp_type_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
		
	} 
	else {
	forvalues x = 1/10 {
		replace adevice_seetype__`x' = 1 if `var' ==`x'
		}
		replace adevice_seetype__96 = 1 if `var' ==96
	}
}

foreach var of varlist temp_need_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
	} 
	else {
	forvalues x = 1/10 {
		replace adevice_seeneed__`x' = 1 if `var' ==`x'
		}
		replace adevice_seeneed__96 = 1 if `var' ==96

	}
}
*

foreach var of varlist temp_no_need_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
	} 
	else {
	forvalues x = 1/10 {
		replace no_sdevice_need__`x' = 1 if `var' ==`x'
		}
		replace no_sdevice_need__96 = 1 if `var' ==96
	}
}
*

drop temp_*

order adevice_seetype__* adevice_seeneed__*, after(adevice_see)
order no_sdevice_need__*, after(no_adevice_see)


** HOME MODIFICATIONS
rename home_modtype__* temp_type_*

forvalues x = 1/12 {
	gen home_modtype__`x' = 0 if home_modifications!=.
}

	gen home_modtype__96 = 0 if home_modifications!=.
	gen home_modtype__98 = 0 if home_modifications!=.

foreach var of varlist temp_type_* {
	qui tab `var'
	if `r(N)'==0 {
		drop `var'
		
	} 
	else {
	forvalues x = 1/10 {
		replace home_modtype__`x' = 1 if `var' ==`x'
		}
		replace home_modtype__96 = 1 if `var' ==96
		replace home_modtype__98 = 1 if `var' ==98
	}
}
*

drop temp_*

order home_modtype__*, after(home_modifications)
