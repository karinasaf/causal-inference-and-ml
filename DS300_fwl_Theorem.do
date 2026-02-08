* *********************************************

* FWL Theorem

* Part 1 Paper 3 regression
* Facuklty of Economics, University of Cambridge

* Dr. M. Weeks. 

* Lent 2023

* *********************************************

clear
set seed 10009
set obs 100

gen x1 = rnormal()

* x1: 100 obs from a normal distribution with a mean of 0 and a standard deviation of 1

* Induce positive correlation between x1 and x2

gen x2 = rnormal() + .2*x1

* TRUE data-generating process
gen y = 1 + x1 + 5*x2 + rnormal()

* Step 1: Residualize x2
reg x2 x1 
predict resid_x2, res

* Step 2: Residualize y
reg y x1
predict resid_y, res

reg resid_y resid_x2, noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)


* Correcty specified regression
reg y x1 x2, noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)

* The coef. on x2 is overstated, due to OVB:
reg y x2, noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)


* Just using residualized x2:
reg y resid_x2, noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)

* Plugging in both (Ignore 2023)
* reg y x1 resid_x2, noci cformat(%9.2f) pformat(%5.2f) sformat(%8.2f)



scatter y x2, ///
yscale(r(-10 15)) ///
name(n1, replace) title("Correlation between Y and X2" "(uncontrolled)")

scatter resid_y resid_x2, ///
yscale(r(-10 15)) ///
name(n2, replace) title("FWL" "(controls for X1)") ///
xtitle("x2_residuals") ytitle("y_residuals")
gr combine n1 n2