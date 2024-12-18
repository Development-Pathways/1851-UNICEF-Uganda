
// Svy settings for analysing data from in-depth questionnaire
svyset psu [pw=wgt2], strata(strata_psu) fpc(fpc_psu) singleunit(scaled) || ssu, fpc(fpc_ssu) || tsu, strata(strata_tsu) fpc(fpc_tsu)


foreach var of varlist seeing hearing walking communicating remembering_5plus learning_2to17 selfcare {
egen `var'_hh = max(`var'), by(hhid)
}
*



mat stat= J(1, 3, .)

local if "if pid==1 & hh_disab==1"
foreach var in FCS {
foreach strat of varlist sex_head age_adults_head region urban quints hhtype2 {
tab `strat' `var' `if' [iw = wgt2], matcell(mat1)
tab `strat' `if' & `var'!=. [iw = wgt2], matcell(mattot)
mat mattot = mattot , mattot, mattot
matewd mat1 mattot matper
mat matper = matper*100
mat stat =  stat \ matper
}
}
*
tab FCS [aw = wgt2] if pid==1 & hh_disab==0, matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[2..., 1] ), (matper[1,2] \ stat[2..., 2] ), (matper[1,3] \ stat[2..., 3])

tab FCS [aw = wgt2] if pid==1 & hh_disab==1, matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[1..., 1] ), (matper[1,2] \ stat[1..., 2] ), (matper[1,3] \ stat[1..., 3])

tab FCS [aw = wgt2] if pid==1, matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[1..., 1] ), (matper[1,2] \ stat[1..., 2] ), (matper[1,3] \ stat[1..., 3])


mat stat= J(1, 3, .)

local if "if pid==1 & hh_disab==1"
foreach var in dietdiversity_group {
foreach strat of varlist sex_head age_adults_head region urban quints hhtype2 {
tab `strat' `var' `if' [iw = wgt2], matcell(mat1)
tab `strat' `if' & `var'!=. [iw = wgt2], matcell(mattot)
mat mattot = mattot , mattot, mattot
matewd mat1 mattot matper
mat matper = matper*100
mat stat =  stat \ matper
}
}
*
tab dietdiversity_group [aw = wgt2] if pid==1 & hh_disab==0, matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[2..., 1] ), (matper[1,2] \ stat[2..., 2] ), (matper[1,3] \ stat[2..., 3])

tab dietdiversity_group [aw = wgt2] if pid==1 & hh_disab==1, matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[1..., 1] ), (matper[1,2] \ stat[1..., 2] ), (matper[1,3] \ stat[1..., 3])

tab dietdiversity_group [aw = wgt2] if pid==1, matcell(mat1)
mat matper = mat1'*100/r(N)

mat stat = (matper[1,1] \ stat[1..., 1] ), (matper[1,2] \ stat[1..., 2] ), (matper[1,3] \ stat[1..., 3])



mat stat= J(1, 1, .)

local if "if pid==1 & hh_disab==1"
foreach var in food_share {
foreach strat of varlist sex_head age_adults_head region urban assetindex_quintile hhtype2 {
svy: mean `var' `if', over(`strat')
mat matper = r(table)'
mat matper = matper[1...,1]
mat stat =  stat \ matper
}
}
*
svy: mean  food_share if pid==1 & hh_disab==0, over(`strat')
mat matper = r(table)'
mat matper = matper[1...,1]

mat stat = (matper[1,1] \ stat[2..., 1] )

svy: mean  food_share if pid==1 & hh_disab==1, over(`strat')
mat matper = r(table)'
mat matper = matper[1...,1]


mat stat = (matper[1,1] \ stat[1..., 1] )

svy: mean food_share if pid==1, over(`strat')
mat matper = r(table)'
mat matper = matper[1...,1]

mat stat = (matper[1,1] \ stat[1..., 1] )
