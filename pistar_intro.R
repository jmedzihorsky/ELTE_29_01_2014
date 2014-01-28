#	Intro to pistar 
#		@ ELTE TATK
#	Juraj Medzihorsky
#	29 January 2014


#	---------------
#		Install
#	---------------


#	To install pistar directly from GitHub we need devtools

install.packages('devtools')

library(devtools)


#	Now we can install pistar

install_github("pistar", username="jmedzihorsky")

library(pistar)


#	Basic info and help:

citation("pistar")

help('pistar-package')


#	-------------
#		Usage	
#	-------------


#	(1)		

#	Let simulate a data that comes from a mixture of Poissons.
#	83% from Poisson(2) and 17% from Poisson(5).


set.seed(1989)                          


e <- c(rpois(1e3, 2), rpois(2e2, 5))


hist(e)


#	we can summarize also with freq.table() from pistar	


te <- freq.table(e)


te


#	The model will be truncated Poisson from 0 to 5


md <- 
	function(x, l, lo=0, up=5)
	{
        z <- dpois(x, l)
        z[x<lo] <- 0
        z[x>up] <- 0
        z <- z/sum(z)
        return(z)
	}


#	Now let's see how well does it fit the data in terms of pi*
#	we will use the function pistar()
#	proc="uv"	stands for univariate
#	dfn 		is the function that contains our model
#	n_par		stands for the no of 'movable' parameters, here 1 (lambda)
#	discrete	TRUE, our data is discrete
#	freq		FALSE, since our data is not a frequency table


pe <- pistar(proc="uv", data=e, dfn=md, n_par=1, discrete=TRUE, freq=FALSE)


#	A summary:


pe


#	a somewhat more elegant summary:


summary(pe)


#	and a plot:


plot(pe)



#	(2)

#	A similar example, but with continous data.


set.seed(1989)


#	The data will come from a mixture of N(0, 2) [83%] and U(-1, 1) [17%]


y <- c(rnorm(1e2, 0, 2), runif(2e1, -1, 1))


hist(y)


#	Our model will be normal distribution, see ?dnorm


#	same as previously pistar(), but now proc="uv" for UniVariate
#	2 'movable' parameters, so n_par=2
#	data is continuous, so discrete=FALSE
#	dfn is the model function, dnorm

py <- pistar(proc="uv", data=y, dfn=dnorm, n_par=2, discrete=FALSE) 


#	Summaries


summary(py)


plot(py)        


#	(3)

#	Let's move to an example with two observed variables.

#	Famous political science data from a 1990 Political Analysis article by 
#	Barbara Geddes on case selection


Geddes1990 <- array(dim=c(2, 2), data=c(1, 2, 7, 67))


dimnames(Geddes1990) <- list('war'=c('defeated','undefeated'), 
							 'rev'=c('revolution', 'norevolution'))

#	Cases:	 	countries 
#	rows: 		defeat in a war
#	columns:	revolution	


Geddes1990


#	let's check the cross-product ratio


cpr <-
	function(x)
	{
		(x[1]*x[2])/(x[2]*x[3])	
	}


cpr(Geddes1990)


#	cpr=0.14, far from 1, let's do Chi^2 test


chisq.test(Geddes1990)


#	p > conventional thresholds (0.05, 0.01, 0.001)


#	And what happens if we have data with the same structure, but 100 times as
#	many cases?

G2 <- Geddes1990*100


cpr(G2)

#	cross product stays the same; what about the Chi^2?


chisq.test(G2)


#	p < conventional thresholds (0.05, 0.01, 0.001)
#	Same structure, different conclusion: the test depends on the sample size.
#	Also, we do not have a stochastic sample: our data is the complete
#	observable population.


#	Let's see how does independence (defined as cpr=1) fit in terms of pi*

#	again pistar(), now proc='2by2' (option for cpr in a 2x2 table)


s1 <- pistar(proc='2by2', data=Geddes1990)


plot(s1)


#	Where are the residuals?


str(s1, max.level=2)


#	@pred contains the three distributions shown on the above plot:
#		1)	model	...	model	
#		2)	unres	...	unrestricted
#		3)	combi	...	combined

#	The residuals are here:


round(s1@pred$unres)


#	If we remove a single case from cell (1, 1) the rest will have a 
#	CPR=1.  It is a different question whether the CPR is in a given
#	context a good measure of independence.


#	Now let's check the 100 times larger version of the data:


s2 <- pistar("2by2", G2)


#	The same value of pi*


round(s2@pred$unres)


#	What if we want to take the sample size into account?
#	Then the sample size will be reflected in the width of the confidence
#	interval for pi*.

#	We can obtain the SE and CI for pi* using jackknife, by simply declaring
#	jack=TRUE for pistar()


#	Let's check the 100 times larger version of the data first:


i2 <- pistar('2by2', G2, jack=TRUE)


summary(i2)


#	The interval is remarkably narrow.


#	What about the original data?  
#	One cell contains only a single observation, let' add 1e-2
#	to each cell to be able to perform the jackknife


i1 <- pistar('2by2', Geddes1990+0.01, jack=TRUE)


summary(i1)


#	The resulting interval is much wider



#	(4)	loglinear models


#	A dataset on Hair and Eye color of 592 U. of Delaware stats students.


data(HairEyeColor)


#	check if the data is an "array" as required by pistar() for loglinear
#	models


is(HairEyeColor, "array")


#	it is not, so it first needs to be converted:

HEC <- array(HairEyeColor, dim=dim(HairEyeColor), dimnames=dimnames(HairEyeColor))


HEC


#	pi* for inependence in a 3-way table (i.e. no interactions).
#	pistar() as before, but with procedure for loglinear models,
#	proc="ll"
#	the model is specified the same way as for loglin()


p0 <- pistar(proc="ll", data=HEC, margin=list(1, 2, 3)) 


summary(p0)



#	hardly a good fit


#	Where are the residuals?


round(p0@pred$unres)


#	Lets check how hair & eye color interaction will improve the fit

p1 <- pistar(proc="ll", data=HEC, margin=list(1, 2, 3, c(1, 2)))


#	14% is not described as opposed to 40% for the previous model
#	where are the residuals?


round(p1@pred$unres)


#	Main cells with residuals are (Brown, Blue, Male) and 
#	(Blonde, Blue, Female)

#	let's try to add Hair Gender interaction

p2 <- pistar(proc="ll", data=HEC, margin=list(1, 2, 3, c(1, 2), c(1, 3)))


#	Even better, only 9% not described


round(p2@pred$unres)


#	Still 21 indviduals are not described in (Blue, Brown, Male)
#	let's add also Eye x Gender interaction


p3 <- pistar(proc="ll", data=HEC, margin=list(1, 2, 3, c(1,2), c(1,3), c(2,3)))


#	7%, still some improvement

round(p3@pred$unres)



#	(5)
#	the pistar package allows to obtain pi* for any model that inputs and
#	outputs contingency tables by selecting proc="ct" (for Contingency
#	Table) or using directly pistar.ct


?pistar.ct


#	load data (included in the pistar package)


data(Fienberg1980a)


Fienberg1980a


#	define a function: log-linear model of independence in a 2-way table

mf <- function(x){
	loglin(table=x, margin=list(1,2), fit=TRUE, print=FALSE)
}


#	find pi*

pc <- pistar(proc="ct", data=Fienberg1980a, fn=mf) 


summary(pc)


plot(pc)

#	Further examples with real-life data.

