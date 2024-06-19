** The influence of marriage on subjective well-being: Insights from modern Germany **
** 1 May 2024 **

clear all
set maxvar 10000
*capture ssc install estout
*capture ssc install rangestat

global datareg "Your/Path/here"
*use "${datareg}/SOEP_reg_adapted.dta", clear

use "${datareg}/SOEP.dta", clear /* Assuming your dataset is still called like this */

label var never "Never married"
label var married  "Married"
label var widowed "Widow"
label var divorced "Divorced"
label var separated "Separated"

tab plh0184
tab plh0185
tab plh0186
tab plh0187	
clonevar angry=plh0184 if inrange(plh0184,1,5)
clonevar worried=plh0185 if inrange(plh0185,1,5)
clonevar happy=plh0186 if inrange(plh0186,1,5)
clonevar sad=plh0187 if inrange(plh0187,1,5)			
tab angry 
tab worried 
tab happy 
tab sad
summarize plh0184 plh0185 plh0186 plh0187 angry worried happy sad

sort pid wave never
browse pid wave sex age nchild lfsato married never widowed divorced separated i11102 angry worried happy sad

* Descriptive statistics
* Distribution of your main dependent variable (here life satisfaction) *
gen estimation_sample=1 if !mi(lfsato,nchild, married,never,widowed,divorced,separated) & inrange(age,18,85)					
tab lfsato if estimation_sample==1
histogram lfsato if estimation_sample==1, d percent graphregion(color(white)) color(black%50) xlabel(0(1)10)
graph export "${datareg}/histogram_lfsato.png", replace		
histogram lfsato if estimation_sample==1 & never==1, d percent graphregion(color(white)) color(black%50) xlabel(0(1)10) xti("Overall life satisfaction (no partnership)")
graph export "${datareg}/histogram_lfsato_never.png", replace					
histogram lfsato if estimation_sample==1 & married==1, d percent graphregion(color(white)) color(black%50) xlabel(0(1)10) xti("Overall life satisfaction (married individuals)")
graph export "${datareg}/histogram_lfsato_married.png", replace		

* Twoway
twoway  (histogram lfsato if estimation_sample==1 & never==1, percent fcolor(black%20) graphregion(color(white)) xlabel(0(1)10))  || (histogram lfsato if estimation_sample==1 & married==1, percent fcolor(cranberry%30) graphregion(color(white)) xlabel(0(1)10)), legend (lab(1 "No partnership") lab(2 "Married individuals") position(6)) xtitle("Overall life satisfaction") ytitle("Percent")
graph export "${datareg}/histogram_lfsato_twoway_never-married-2.png", replace	

sum lfsato if estimation_sample==1 & widowed==1, detail
sum lfsato if estimation_sample==1 & divorced==1, detail

* lfsato over time
bys wave: su lfsato if estimation_sample==1 & wave>1999
preserve
collapse lfsato if estimation_sample==1 & wave>1999, by(wave)
line lfsato wave if wave>1999
line lfsato wave if wave>1999, graphregion(color(white)) lcolor(black%75) xlabel(2000(4)2016) ylabel(6(.5)8) xtitle(Year) ytitle(Average Life Satisfaction)
graph export "${datareg}/lfsato_over_time.png", as(png) replace
restore


* Tell stata we're using panel data
sort pid wave 
xtset pid wave, yearly
gen lnlfsato=ln(lfsato)
eststo single_over_waves: xtreg lfsato never i.wave if wave>2004, fe

* We might treat divorced or separated equally as not being together anymore
* Unused
gen divorsep=0 
replace divorsep=1 if divorced==1 | separated==1

* Generate dummies for the period that an individual is single
by pid: egen speriod=total(never)
gen n01=0
gen n12=0
gen n23=0
gen n34=0
gen n45=0
*gen n5p=0
replace n01=1 if speriod==1
replace n12=1 if inrange(speriod, 1, 2)
replace n23=1 if inrange(speriod, 2, 3)
replace n34=1 if inrange(speriod, 3, 4)
replace n45=1 if inrange(speriod, 4, 5)
drop speriod
*drop n01 n12 n23 n34 n45


* Generate dummies for the period that an individual has been married
by pid: egen mperiod=total(married)
gen m01=0
gen m12=0
gen m23=0
gen m34=0
gen m45=0
replace m01=1 if mperiod==1
replace m12=1 if inrange(mperiod, 1, 2)
replace m23=1 if inrange(mperiod, 2, 3)
replace m34=1 if inrange(mperiod, 3, 4)
replace m45=1 if inrange(mperiod, 4, 5)
drop mperiod
*drop m01 m12 m23 m34 m45

* Regression with FE creates colinearity errors because a apparently linear combination of the dummies perfectly explain lfsato
xtreg lfsato n01 n12 n34 n45 i.wave if wave>2004, fe

*xtreg lfsato pn01 pn15 pn5 i.wave, fe
xtreg lfsato pn01 pn15 pn5 i.wave, re

* Trying with random effects
eststo singleperiod: xtreg lfsato n01 n12 n23 n34 n45 i.wave if wave>2005, re
eststo marriedperiod: xtreg lfsato m01 m12 n23 n34 n45 i.wave if wave>2005, re

eststo singleperiod: xtreg lfsato n01 n12 n23 n34 n45 i.wave, re
eststo marriedperiod: xtreg lfsato m01 m12 m23 m34 m45 i.wave, re
eststo singleplusmarried: xtreg lfsato n01 n12 n23 n34 n45 m01 m12 m23 m34 m45 i.wave, re

* Descriptive statistics
sum lfsato , detail
* Dataset is skewed towards the left => more people are unsatisfied than satisfied
* Kurtosis > 4 => more peaked distribution


* Printing LaTeX tables
* never, married, nevermarried FE
est clear
quietly: eststo: xtreg lfsato never i.wave if estimation_sample==1, fe
quietly: eststo: xtreg lfsato married i.wave if estimation_sample==1, fe 
quietly: eststo: xtreg lfsato never married i.wave if estimation_sample==1, fe 
esttab using "nevermarried-FE.tex", label replace booktabs star(* 0.10 ** 0.05 *** 0.01) nonotes nomtitle noobs wide

* never, married, nevermarried RE -- NOT USED !!!!
*est clear
*quietly: eststo: xtreg lfsato never i.wave, re
*quietly: eststo: xtreg lfsato married i.wave, re 
*quietly: eststo: xtreg lfsato never married i.wave , re 
*esttab using "nevermarried-RE.tex", label replace booktabs star(* 0.10 ** 0.05 *** 0.01) nonotes nomtitle noobs wide

* n+m Dummies RE
est clear
quietly: eststo: xtreg lfsato n01 n23 n45 i.wave if estimation_sample==1, re
quietly: eststo: xtreg lfsato m01 m23 m45 i.wave if estimation_sample==1, re
*quietly: eststo: xtreg lfsato n01 n23 n45 m01 m23 m45 i.wave if estimation_sample==1 & wave>1998, re
quietly: eststo: xtreg lfsato n01 n23 n45 m01 m23 m45 i.wave if estimation_sample==1, re
esttab using "nmdummies-RE.tex", label replace booktabs star(* 0.10 ** 0.05 *** 0.01) nonotes nomtitle noobs wide


* Children FE
gen hasOneChild=0
gen hasTwoChildren=0
gen hasThreeOrMoreChildren=0
by pid: replace hasOneChild=1 if nchild==1
by pid: replace hasTwoChildren=1 if nchild==2
by pid: replace hasThreeOrMoreChildren=1 if nchild>=3

est clear
quietly: eststo: xtreg lfsato hasOneChild hasTwoChildren hasThreeOrMoreChildren i.wave if estimation_sample==1, fe 
quietly: eststo: xtreg lfsato never married hasOneChild hasTwoChildren hasThreeOrMoreChildren i.wave if estimation_sample==1, fe 
esttab using "nevermarried-children-FE.tex", label replace booktabs star(* 0.10 ** 0.05 *** 0.01) nonotes nomtitle noobs wide

* Divorce/Widowhood
*drop divtime widowtime
gen dp1=0
gen dp2=0
gen dp3=0
gen dp4=0
gen dp5=0
gen wd1=0
gen wd2=0
gen wd3=0
gen wd4=0
gen wd5=0
by pid: egen divtime=total(divorced)
by pid: egen septime=total(separated)
by pid: egen widowtime=total(widowed)
*by pid: replace sexbin=1 if sex == 'Female'
** Why is it so hard for STATA just to accept divtime>0 && divtime<=2
** Oh there's inrange(), nevermind
by pid: replace dp1 = 1 if divtime == 1 
by pid: replace dp2 = 1 if divtime == 2 
by pid: replace dp3 = 1 if divtime == 3 
by pid: replace dp4 = 1 if divtime == 4 
by pid: replace dp5 = 1 if divtime >= 5 
by pid: replace wd1 = 1 if widowtime == 1 
by pid: replace wd2 = 1 if widowtime == 2 
by pid: replace wd3 = 1 if widowtime == 3 
by pid: replace wd4 = 1 if widowtime == 4 
by pid: replace wd5 = 5 if widowtime >= 5
est clear
quietly: eststo: xtreg lfsato dp1 dp2 dp3 dp4 dp5 i.wave if estimation_sample==1, re
quietly: eststo: xtreg lfsato wd1 wd2 wd3 wd4 wd5 i.wave if estimation_sample==1, re
quietly: eststo: xtreg lfsato dp1 dp2 dp3 dp4 dp5 wd1 wd2 wd3 wd4 wd5 i.wave if estimation_sample==1, re
esttab using "divorce-widowhood.tex", label replace booktabs star(* 0.10 ** 0.05 *** 0.01) nonotes nomtitle noobs wide
