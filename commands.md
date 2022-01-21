## Important R commands

### 1) Basic Data Manipulation
**Ask which is the working directory:** _getwd()_

**Set a new working directory:** _setwd()_

Example: ```  setwd("C:/Users/TEMP/Desktop") ```

**Create a data set manually and enter data:** 	data.frame and edit

Example:
```
mydata<-data.frame(name=character(0), age=numeric(0))
Mydata<-edit(mydata) opens an editor to enter the data
```

**Load a data file:** _read.table()_

Example: ```   world<-read.table("C:/Copy/R/world.csv",header=TRUE, sep=",") ```

**Save a data file in csv format:** 	write.csv

Example: ```   write.csv(cola, file="C:/Copy/R/cola.csv") ```

**Upload a data file to the working memory of R:** _attach()_

**Visualise a data file:** _just write its name_

**Analyse the structure of a data file :** _str()_

Example: ```  str(cola) ```

**Rename a variable:** _names()_

Example: ```  names(cola)[3]= "taste for sugar" ```

**Declare a variable to be nominal:** _factor()_

Example: ```  cola$q1<-factor(q1, levels=c(1,2), labels=c("coka-cola","rola-cola")) ```

**Declare a variable to be ordinal:** _factor(, order=TRUE)_

Example: ```  cola$q3<-factor(q3, order=TRUE, levels=c("1","2","3"),labels=c("yes","indifferent","no")) ```

**Declare a variable to be numerical:** _as.numeric()_

Example: ```  Gender<-as.numeric(Gender) ```

**Add a variable to a file:** 	cbind()

Example: ```  cbind(terre,funct)  adds the variable funct at the end of the file terre ```

**Install a package:** _install.packages()_

Example: ```  install.packages("car", dependencies=TRUE) ```

**Load a package into the working memory of R:** _library()_

Example: ```  library(car) ```

**Recode a variable:** _recode() (needs the library car)_

Example: ```  wealth<-recode(region, '"OECD"=1; else=2;') ```

**Order a file:** _order()_

Example: ```  world[order(-population),] orders the file world in a decreasing order with respect to the variable population. ```

**Define a subset of a datafile:** _subset()_

Example: ```  OECD<-subset(world, subset=(region=="OECD")) ```

**Logical operators:**
```
And: &

Or: |

Not equal:  !=
```

---
 
### 2) Descriptive Statistics
**Display a contingency table:** _table()_

Example: ```  table(cola$q4) ```

**Display the frequency table:** _table()/sum(table())_

Example: ```  table(cola$q4) /sum( table(cola$q4)) ```

**Display a two-dimensional contingency table:** _xtabs()_

Example: ```  xtabs(~death_rt+region, data=world) ```

**Display the usual descriptive statistics:** _summary()_

Example: ```  summary(cola$q4) or summary(cola) ```

**Compute the mean:** _mean()_

**Compute the variance :** _var()_

Example: 
```
var(cola$q1)
var(cola) displays the covariance matrix of all the variables from the cola file
 ```

**Compute the standard deviation:** _sd()_

**Compute the skewness:** _skewness() (needs the library agricolae)_

**Compute the kurtosis:** _kurtosis()  (needs the library agricolae)_

**Draw a boxplot:** _boxplot()_

Example: 
```
boxplot(cola$q5)
boxplot(cola$q5~cola$q1)  (draws a boxplot for each group defined by variable q1)
boxplot(cola$q5~cola$q1, xlab="previous purchase", ylab="consumption of chips") (adds moreover the text on the x and y axes)
 ```

**Draw a histogram:** _hist()_

Example: ```  hist(cola$q4, main="Histogram", xlab="Consumption of cola", col="blue")	(main allows to give a title to the graph, col defines the color) ```

**Draw a pie chart:** _pie()_

Example: 
```
results<-c(0.35, 0.325, 0.325)
names(results)<-c("yes","indifferent","no")
pie(results, col=c("purple","yellow","green"))
```   
**Draw a scatterplot:** _plot()_
Example: ```   plot(date,q4, type=”l”) represents  q4 as a function of date, using a line ```

**Draw a line:** 	lines()
Example: ```  lines(x, col="green", lty="dotted") draws a pointed green line through the points defined by vector x. ```

**Draw isolated points :** _points()_
Example: ```  points(x, bg="limegreen", pch=21) draws the points defined by vector x using green dots of size 21. ```

**Draw a matrix of all possible pairs of variables of a data file:** _pairs()_
Example: ``` _pairs(cola)_ ```

**Draw confidence intervals for the mean of a variable in different groups:** _plotmeans  (needs the library gplots)_

Example: `plotmeans(cola$q5~cola$q1, p=0.95) draws the 95% confidence interval of the mean of the variable q5 for the groups defined by the variable q1.`

**Define a variable as label variable:** _row.names()_
Example: ```  row.names(nielsen)<-number ```

**Add labels to a scatterplot:** _text()_
Example: ```  text(price, size, rownames(appart), pos=1) ```

**Display the confidence interval for the mean of a normal variable:** _t.test()$conf.int_
Example: ```  t.test(q5,conf.level=0.95)$conf.int ```

**Display the confidence interval for the mean of a variable in different samples:** _plotmeans (need the librairie gplots)_

Example: ` plotmeans(cola$q5~cola$q1, p=0.95) displays the 95% confidence interval of variable q5 for the groups defined by variable q1.`

---

### 3) Test Theory

**Test if a variable follows a normal law (Shapiro-Wilk test):** _shapiro.test()_

The tested H0 hypothesis is that the variable follows a normal law.

>#: Normally distributed. If p=0, we are 100% sure that they do not follow a normal law. If there are more than 5000 objects then shapiro.test(ex[1:5000, k]) where k = column of the chosen variable 

**Test if the mean of a normally distributed variable equals a given number:** _t.test()_

The tested H0 hypothesis is that the mean equals the given number.
Example: ```   t.test(cola$q1, mu=1.53) ```


**Test if the means of two normally distributed variables  of equal variance are equal:** _t.test()_

The tested H0 hypothesis is that the means are equal.
Example: ```  	t.test(cola$q4, cola$q5) ```


**Test if two variables, at least one of which is not normally distributed, have the same mean:** _wilcox.test()_

>#: "Significant difference". If p=0, we are 100% sure that they are different.

The tested H0 hypothesis is that the means are equal.
Example: ```  wilcox.test(cola$q4, cola$q5) ```

**Test if the mean of a normally distributed variable is the same in two different subgroups of the sample:** _t.test()_

The tested H0 hypothesis is that the means are equal.
Example: ```  	t.test(cola$q4~cola$q1) ```

**Test if the mean of a non normal variable is the same in two (or more) different subgroups of the sample:** _kruskal.test()_

>#: The same as the wilcox test but comparing only one variable to two different subgroups

The tested H0 hypothesis is that the means are equal.
Example: ```  	kruskal.test(cola$q4~cola$q1) ```

**Test if two variables are independent (khi-square independance test):** _chisq.test()_

The tested H0 hypothesis is that the two variables are independent.
Example: `chisq.test(cola$q4, cola$q2) `

>#: If p=0, we are 100% sure that there is a relation
>#: If p is large we fail to reject H0
 
---

### 4) Regression Analysis

>#: Log reg model
`reg<-lm(log(price)~log(size))`
`price = exp(...)*size^(...)`

**Define a linear regression model:** _lm()_
Example: ```  reg<-lm(price~size) ```

>#: `price = ... +/- ... * (size^2)`  

**Define a multiple linear regression model:** _lm()_
Example: ```  reg<-lm(price~size+localisation+age) ```

**Define a quadratic regression model:** _lm()_
>#: parabolic

Example:
```  reg2<-lm(price~size+I(size^2)) (the I is necessary because inside a model definition * and ^ are just working inside I()) ```

>#: `price = ... +/- ... * (size^2)`  


**Testing a linear hypothesis:** _linearHypothesis() (needs the library car)_

The tested H0 hypothesis is that the parameter is indeed the value we test for.
Example: ```  linearHypothesis(reg2, c("Futures=1")) ```


**Compute the confidence intervals for the parameters of a regression model:** _confint()_
Example: ```  confint(reg, level=0.99) ```

**Draw the result of a non linear model:** _lines()_
Example: 
``` 
x<-0:300 
y<-predict(reg2,list(size=x))
plot(size,price)
lines(x,y)  (draws the line y=reg2(x)for x between 0 and 300, as well as the scatterplot of the size as a function of price_eur)
```

**Add points to a scatterplot:** _points()_
Example:
``` 
plot(sales~semester, col="blue")
lines(sales~semester, col="blue")
lines(prediction~semester, col="red")
points(prediction~semester, col="red ")
 ```
**Add a legend to a scatterplot:** _legend()_
Example: ```  legend("topright", c("SP500", "Ford"), col=c("red", "blue"), lty=1, cex=1.5) ```

**Test if a more complicated model is better:** _anova()_

Example: ```  anova(reg,reg2)    ```

The H0 hypothesis is that the two models are equivalent.

>#: If p=0, the two models are not equivalent.

**Display the variance decomposition of a regression model:** _anova()_
Example: ```  anova(reg)    ```

**Give the results of a linear regression:** _summary()_
Example: ```  summary(reg) ```

**Add the regression line to a scatterplot:** _abline()_
Example: ```  abline(reg) ```

**Compute the residuals of a regression models:** _residuals()_
Example: ```  residuals<-residuals(reg) ```

**Compute the studentised residuals:** _rstudent()_
Example: ```  resid_stud<-rstudent(reg) ```

**Compute the standardised residuals:** _rstandard()_
Example: ```  resid_stand<-rstandard(reg) ```

**Draw the standardised residuals with horizontal lines in -2 and 2 :**
Example: ```  plot(res~number, ylim=c(-3,3))  (ylim defines the vertical limits of the graph) ```
abline(h=c(-2,0,2),lty=c(2,1,2))   

**Compute previsions for the observations in a regression model:** _fitted()_
Example: ```  fitted(reg) ```

>#: _predicted_

**Compute previsions for out of sample points:** _predict()_
Example: ```  predict(reg,list(size=c(35,67,93))) ```
predict(reg,list(size=35))

**Draw the linear regression with confidence and prediction intervals:** _plotCI() (needs the library asbio)_
Example: ```  plotCI.reg(size,price, conf=0.97) ```

**Compute the correlation coefficient:** _cor()_
Example:
```
cor(size, price)
cor(mtcars)
```

**Test if a correlation is significative:** _cor.test()_
Example:
```
cor.test(price, size) 
cor.test(q3, q4, method="spearman")
H0 is that the correlation is not significant.
```

**Perform a stepwise regression:** _step()_
Example:
```
reg2<-lm(ermsoft~1, data=macro[-2,])  defines a starting model with just intercept
step(reg2,direction="forward",scope=formula(reg1)) does a stepwise forward regression up to the full model reg1
```

**Redo a model for a subset of the data:** _update()_
Example: ```  reg2<-update(reg,subset=(number!=4)) takes out observation number 4 from the sample ```

**Verify the hypotheses of a linear model graphically:** _plot ()_

Example:
```
par(mfrow=c(2,2))  (creates a 2x2 window to put the 4 graphs )
plot(reg)
dev.off()  (goes back to a single graphic window)
```

**Verify the normality hypothesis graphically:** _qqPlot()    (needs the library car)_
Example: ```  qqPlot(reg, id.method="identify") ```

**Present the results of a multiple regression in table form:** _stargazer() (needs the library stargazer)_
Example: ```  stargazer(reg1, reg2, reg3, reg4,type = "text") ```

**Compute the variance inflation factor:** _vif() (needs the library car)_
Example: ```  vif(reg) ```

**Graph illustrating the influence of the sample points in the parameter estimation:** _influencePlot_
Example: ```  influencePlot(reg2,id.method="identify") ```

**Test if a regression model is heteroskedastic:** _bptest() (needs the library lmtest)_
The tested H0 hypothesis is that the model is homoscedastic.
Example: ```  bptest(reg1) ```

**Using White’s modified standard error estimates in presence of heteroskedasticity:** _coeftest() (needs the libraries lmtest and sandwich)_

Example: ```  coeftest(reg1,vcov.=vcovHC(reg1,type="HC1")) ```

**Test if a regression model has autocorrelation problems:** _dwtest() (needs the library lmtest)_

The tested H0 hypothesis is that the model does not suffer from first order autocorrelation.
Example: ```  dwtest(reg1) ```

---
 
### 5) Principal component and cluster analysis 

**Do a star graph:** _stars()_
Example: ```  stars(auto[, 3:8], key.loc = c(14, 1.5)) ```

> A1: `rownames(temp)<-City`

**Perform a principal component analysis:** _PCA() (needs the library FactoMineR)_
> A2: Example: ```  res.pca<-PCA(auto[,3:8], scale.unit=TRUE, ncp=6, graph=T)      ```

Here ncp=number of factors

**To get the results of a PCA:**


> A3: `res.pca$eig  give the eigenvalues of the principal components and the percentage of the explained variance`

> The eigenvalues > 1 and the model has to explain 80%

> A5: `res.pca$ind$coord gives the coordinates of the subjects with respect to the factors `

> `temp<-cbind(temp,res.pca$ind$coord)`

`res.pca$var$cor give the correlations between the variables and the factors` (*Strikethrough in notes*)

> A6-A7: detach, attach

> A8: plot(Dim.1,Dim.2) & text

**Determine the number of principal components graphically:** _barplot()_
Example: ```  barplot(res.pca$eig[,1])     ```

**Interpret the principal components:** _dimdesc()_
> A4: Example: ```  dimdesc(res.pca, axes=c(1:3))    analyses the first three dimensions ```
> Positive and negative correlations

**Perform a cluster analysis:** _HCPC()_ (Hierarchical ascendant classification)
> B1: Example: ```  res.hcpc<-HCPC(res.pca) ```

**To get the result of a cluster analysis :**

> B2: `res.hcpc$desc.var helps to give an interpretation of the clusters` (Composure of each group)

`res.hcpc$data.clust  gives the file with a variable containing the group to which the subjects belong`

> B3: `str(res.hcpc$data.clust)  gives the file with a variable containing the group to which the subjects belong`

> B4: `res.hcpc$data.clust[,lastvariable]->group`
> B5: `temp<-cbind(temp, group)`
> B6: `str(temp)`

**Do a scatterplot with differently coloured subgroups:** _scatterplot()            (needs the library car)_
Example: ```  scatterplot(Dim.2~Dim.1|Region, smooth=FALSE, regLine=FALSE)      ```

---

### 6) Time Series Modeling 

**Plot an autocorrelation function:** _acf()_
Example: ```  acf(UKHP$dhp, lag.max=12) ```

**Plot a partial autocorrelation function:** _pacf()_
Example: ```  pacf(UKHP$dhp, lag.max=12) ```

**Estimate ARMA model coefficients:** _arima()_
Example: ```  arima(UKHP$dhp, order = c(1,0,2)) estimates an ARMA(1,2) model for the variable dhp ```

**Dynamic Forecasting of ARMA models:** _predict()_
Example: ```  predict(ar2, n.ahead=27)  forecasts the next 27 values of the model ar2  ```

