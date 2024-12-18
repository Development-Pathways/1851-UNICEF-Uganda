*===============================================================================
*
* EXPENDITURE MASTER .do - CREATE .dta AND MERGE
*
*===============================================================================


cap cd "~/Development Pathways Ltd/ESP WFP - Research/quantitative/primary analysis"


// paths and dataset - setting up global macros
	*paths
global dir "`c(pwd)'"
global do "${dir}/do"
global figures "${dir}/workbook"

global uclds "~/Development Pathways Ltd/SEA - Documents/data/uganda/UCLDS2019/dta/uclds2019.dta"

run "${do}/data_uclds.do"

*run "${do}/figures_uclds.do"
