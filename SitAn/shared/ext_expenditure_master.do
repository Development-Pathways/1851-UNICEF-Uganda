*===============================================================================
*
* EXPENDITURE MASTER .do - CREATE .dta AND MERGE
*
*===============================================================================

cap cd "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/"


// paths and dataset - setting up global macros
	*paths
global dir "`c(pwd)'"
global script "${dir}/scripts"
global raw "${dir}/raw/extended/combined"
global dta "${dir}/dta"


global food_roster "${raw}/food_roster.dta"
global food_out "${raw}/food_out_roster.dta"
global interview_comment "${raw}/interview__comments.dta"
global hh_roster "${raw}/hh_roster.dta"
global nfoodf "${raw}/nfood_freq_roster.dta"
global extended "${raw}/extended.dta"
global conversion "${dta}/conversion.dta"


// run do files

	*clean datasets
run "${script}/ext_expenditure_units.do"
run "${script}/ext_expenditure.do"
run "${script}/ext_foodout.do"
run "${script}/ext_nfoodf.do"
run "${script}/ext_nfood.do"
run "${script}/exp_healtheduc.do"
run "${script}/ext_rent_exp.do"

	*created merged final consumption expenditure dta

run "${script}/ext_expenditure_merge.do"
