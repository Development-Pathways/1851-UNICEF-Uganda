

use "~/Development Pathways Ltd/UGA_UNICEF_2024_Disability Grant - Technical/Data/Processed data/uclds2019.dta", clear

* children 2-4 * 

* SEEING DOMAIN *
gen SEE_IND_2to4 = child2to4_seeing2
replace SEE_IND_2to4 = child2to4_seeing3 if child2to4_seeing2 == .

* HEARING DOMAIN *
gen HEAR_IND_2to4 = child2to4_hearing2
replace HEAR_IND_2to4 = child2to4_hearing3 if child2to4_hearing2 == .

* WALKING DOMAIN *
gen WALK_IND_2to4 = child2to4_walking2
replace WALK_IND_2to4 = child2to4_walking4 if child2to4_walking2 == .

* FINE MOTOR DOMAIN * 
gen MOT_IND_2to4 = child2to4_finemotor if child2to4_finemotor>0 & child2to4_finemotor<=4

* COMMUNICATING DOMAIN *
gen COM_IND_2to4 = 0
replace COM_IND_2to4 = 4 if (child2to4_communic1 == 4 | child2to4_communic2 == 4)
replace COM_IND_2to4 = 3 if (COM_IND_2to4 != 4 & (child2to4_communic1 == 3 | child2to4_communic2 == 3))
replace COM_IND_2to4 = 2 if (COM_IND_2to4 != 4 & COM_IND_2to4 != 3 & (child2to4_communic1 == 2 | child2to4_communic2 == 2))
replace COM_IND_2to4 = 1 if (COM_IND_2to4 != 4 & COM_IND_2to4 != 3 & COM_IND_2to4 != 1 & (child2to4_communic1 == 1 | child2to4_communic2 == 1))
replace COM_IND_2to4 = . if ((COM_IND_2to4 == 2 | COM_IND_2to4 == 1) & (child2to4_communic1 == . | child2to4_communic2 == .))

replace COM_IND_2to4 = . if COM_IND_2to4 == 0

* LEARNING DOMAIN *
gen LEARN_IND_2to4 = child2to4_learning if child2to4_learning>0 & child2to4_learning<=4

* PLAYING DOMAIN *
gen PLAY_IND_2to4 = child2to4_playing if child2to4_playing>0 & child2to4_playing<=4

* BEHAVIOUR DOMAIN *
gen BEH_IND_2to4 = child2to4_behaviour if child2to4_behaviour>0 & child2to4_behaviour<=4

* more severe disability (DISABILITY4): any one domain is coded CANNOT DO AT ALL
* moderate disability (DISABILITY3):  any 1 domain/question is coded A LOT OF DIFFICULTY or CANNOT DO AT ALL
* milder disability (DISABILITY1) : at least one domain/question is coded SOME DIFFICULTY or A LOT OF DIFFICULTY or CANNOT DO AT ALL

gen SSHD_2to4 = 0
replace SSHD_2to4 = . if SEE_IND_2to4==. & HEAR_IND_2to4 ==. & WALK_IND_2to4 ==. & MOT_IND_2to4==. & COM_IND_2to4==. & LEARN_IND_2to4==. & PLAY_IND_2to4==. & BEH_IND_2to4==. 
replace SSHD_2to4 = 2 if SEE_IND_2to4==2 | HEAR_IND_2to4 ==2 | WALK_IND_2to4 ==2 | MOT_IND_2to4==2 | COM_IND_2to4==2 | LEARN_IND_2to4==2 | PLAY_IND_2to4==2 | BEH_IND_2to4==2
replace SSHD_2to4 = 3 if SEE_IND_2to4==3 | HEAR_IND_2to4 ==3 | WALK_IND_2to4 ==3 | MOT_IND_2to4==3 | COM_IND_2to4==3 | LEARN_IND_2to4==3 | PLAY_IND_2to4==3 | BEH_IND_2to4==3
replace SSHD_2to4 = 4 if SEE_IND_2to4==4 | HEAR_IND_2to4 ==4 | WALK_IND_2to4 ==4 | MOT_IND_2to4==4 | COM_IND_2to4==4 | LEARN_IND_2to4==4 | PLAY_IND_2to4==4 | BEH_IND_2to4==4
replace SSHD_2to4 = 1 if SSHD_2to4 ==0

label define sshdlb 1 "None" 2 "Mild" 3 "Moderate" 4 "Severe"
label values SSHD_2to4 sshdlb

* children 5-17 * 

* SEEING DOMAIN *
gen SEE_IND = child5to17_seeing2
replace SEE_IND = child5to17_seeing3 if child5to17_seeing2 == .

* HEARING DOMAIN *
gen HEAR_IND = child5to17_hearing2
replace HEAR_IND = child5to17_hearing3 if child5to17_hearing2 == .

* WALKING DOMAIN *
gen WALK_IND1 = child5to17_walking2
replace WALK_IND1 = child5to17_walking3 if child5to17_walking2 == 2

gen WALK_IND2 = child5to17_walking6
replace WALK_IND2 = child5to17_walking7 if (child5to17_walking6 == 1 | child5to17_walking6 == 2)

gen WALK_IND = WALK_IND1
replace WALK_IND = WALK_IND2 if WALK_IND1 == .

* SELFCARE DOMAIN *
gen SELF_IND = child5to17_selfcare if child5to17_selfcare>0 & child5to17_selfcare<=4

* COMMUNICATING DOMAIN *
gen COM_IND = 0
replace COM_IND = 4 if (child5to17_communic1 == 4 | child5to17_communic2 == 4)
replace COM_IND = 3 if (COM_IND != 4 & (child5to17_communic1 == 3 | child5to17_communic2 == 3))
replace COM_IND = 2 if (COM_IND != 4 & COM_IND != 3 & (child5to17_communic1 == 2 | child5to17_communic2 == 2))
replace COM_IND = 1 if (COM_IND != 4 & COM_IND != 3 & COM_IND != 1 & (child5to17_communic1 == 1 | child5to17_communic2 == 1))
replace COM_IND = . if ((COM_IND == 2 | COM_IND == 1) & (child5to17_communic1 == . | child5to17_communic2 == .))

replace COM_IND = . if COM_IND == 0

* LEARNING DOMAIN *
gen LEARN_IND = child5to17_learning if child5to17_learning>0 & child5to17_learning<=4

* REMEMBERING DOMAIN *
gen REM_IND = child5to17_remember if child5to17_remember>0 & child5to17_remember<=4

* CONCENTRATING DOMAIN *
gen CONC_IND = child5to17_concentrating if child5to17_concentrating>0 & child5to17_concentrating<=4

* ACCEPTING CHANGE DOMAIN *
gen ACC_IND = child5to17_accept if child5to17_accept>0 & child5to17_accept<=4

* BEHAVIOUR DOMAIN *
gen BEH_IND = child5to17_behaviour if child5to17_behaviour>0 & child5to17_behaviour<=4

* MAKING FRIENDS DOMAIN *
gen FRI_IND = child5to17_friends if child5to17_friends>0 & child5to17_friends<=4

* ANXIETY DOMAIN * 
// WG considers "daily" as at least moderate --> treating daily as moderate and the rest as none
recode child5to17_anxiety (1=3 "A lot of difficulty") (2=2 "Some difficulty") (3/5=1 "No difficulty"), gen(ANX_IND)

* DEPRESSION DOMAIN *
recode child5to17_depressed (1=3 "A lot of difficulty") (2=2 "Some difficulty") (3/5=1 "No difficulty"), gen(DEP_IND)

gen SSHD_5to17 = 0
replace SSHD_5to17 = . if SEE_IND==. & HEAR_IND ==. & WALK_IND ==. & SELF_IND==. & COM_IND==. & LEARN_IND==. & REM_IND==. & CONC_IND==. & ACC_IND==. & BEH_IND==. & FRI_IND==. & ANX_IND==. & DEP_IND==.
replace SSHD_5to17 = 2 if SEE_IND==2 | HEAR_IND ==2 | WALK_IND ==2 | SELF_IND==2 | COM_IND==2 | LEARN_IND==2 | REM_IND==2 | CONC_IND==2 | ACC_IND==2 | BEH_IND==2 | FRI_IND==2 | ANX_IND==2 | DEP_IND==2
replace SSHD_5to17 = 3 if SEE_IND==3 | HEAR_IND ==3 | WALK_IND ==3 | SELF_IND==3 | COM_IND==3 | LEARN_IND==3 | REM_IND==3 | CONC_IND==3 | ACC_IND==3 | BEH_IND==3 | FRI_IND==3 | ANX_IND==3 | DEP_IND==3
replace SSHD_5to17 = 4 if SEE_IND==4 | HEAR_IND ==4 | WALK_IND ==4 | SELF_IND==4 | COM_IND==4 | LEARN_IND==4 | REM_IND==4 | CONC_IND==4 | ACC_IND==4 | BEH_IND==4 | FRI_IND==4 | ANX_IND==4 | DEP_IND==4
replace SSHD_5to17 = 1 if SSHD_5to17 == 0

label values SSHD_5to17 sshdlb

tab sex [iw=wgt2] // 41,345,431 people
tab FunctionalDifficulty_5to17 if age>=5 & age<=9 [iw=wgt2] // 457,418 pwd 

tab FunctionalDifficulty_2to4 if age>=2 & age<=4 [aw=wgt1]
tab FunctionalDifficulty_5to17 if age>=5 & age<=17 [aw=wgt1]

tab SSHD_2to4 if age>=2 & age<=4 [aw=wgt1]
tab SSHD_5to17 if age>=5 & age<=17 [aw=wgt1]

mean Seeing_2to4 Hearing_2to4 Walking_2to4 FineMotor_2to4 Communication_2to4 Learning_2to4 Playing_2to4 Behaviour_2to4 if age>=2 & age<=4 [aw=wgt1]
mean Seeing_5to17 Hearing_5to17 Walking_5to17 Selfcare_5to17 Communication_5to17 Learning_5to17 Remembering_5to17 Concentrating_5to17 AcceptingChange_5to17 Behaviour_5to17 MakingFriends_5to17 Anxiety_5to17 Depression_5to17 if age>=5 & age<=17 [aw=wgt1]
