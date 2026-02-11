
* quick sims

do "~/Documents/GitHub/1851-UNICEF-Uganda/DISABILITY_2024.do"

keep if !missing(pc_exp) 

gen cpi2025 = 137.442
gen cpi2019 = 107.612
gen cpi2009 = 57.673

gen need_care = (has_passistance==1 | need_passistance==1) if !missing(has_passistance)

gen gets_cdb = dislevel_4==1 // & need_care==1 // age 2-17

gen tv_cdb = 100000 * cpi2019/cpi2025 if gets_cdb==1 

egen tv_cdb_hh = total(tv_cdb), by(hhid) 

gen tv_cdb_hh_ae = tv_cdb_hh/ae 

egen exp_cdb_ae = rowtotal(ae_exp tv_cdb_hh_ae) 

* gen poor_2019 = ae_exp09<spline

gen spline19 = spline*(pc_exp/pc_exp09)

gen pov_2019 = ae_exp<spline19

assert poor_2019==pov_2019

gen pov_cdb = exp_cdb_ae<spline19

su pov_2019 pov_cdb [aw=wgt2] if gets_cdb==1

egen hh_cdb = max(gets_cdb), by(hhid)

su pov_2019 pov_cdb [aw=wgt2] if hh_cdb==1 & relation==1
