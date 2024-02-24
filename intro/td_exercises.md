
# Econometrics (R) class 2021/2022 exercises with solutions

## Exercise sheet 1

The file “maddison.csv” contains Real GDP per capita in 2011US$ for 172 countries from the research project Maddison Project Database (2018).

#### Initialisation
```
install.packages("car")
library(car)
library(readr)
maddison <- read_csv("maddison.csv")
View(maddison)
maddison->mad
```

#### 1) Give the frequency table of the variables “Entity” and “Year”. For which period do we have data on all the countries?
```
attach(mad)
table(Entity)
table(Year)
```

#### 2) Give the summary of the descriptive statistics for the whole dataset. What does the difference between the mean and the median GDP tell you?
```
summary(mad)
#The mean is more than the double of the median, so we know that the variable GDP is not symmetrical at all.
hist(GDP)
```
#### 3) Draw the boxplots of the variable “GDP”. Are there any outliers? How can you detect the highest outliers, without putting the whole dataset on screen?
```
boxplot(GDP,col="pink")
# We see that there a quite a lot of outliers. If we want to know which datapoints these are, we can use the order command
mad[order(-GDP),]
```
#### 4) Draw the scatterplot with “Year” on the x axis and “GDP” on the y axis. What do you observe?
```
plot(Year,GDP)
plot(Year,GDP,xlim=c(1300,2016))
plot(Year,GDP,xlim=c(1900,2016))
text(Year,GDP,Code,col="blue",pos=1,cex=0.6)
# We see that GDP gets higher in most countries after World War 2 and that there are some few very rich countries
```
#### 5) Create the subset France of all GDP-values for France.
```
France<-subset(mad, subset=(Entity=="France"))
France<-subset(mad, subset=(Code=="FRA"))
```
#### 6) Draw the scatterplot with “Year” on the x axis and “GDP” on the y axis for France only. What do you observe?
```
plot(France$Year,France$GDP)
plot(France$Year,France$GDP,xlim=c(1280,2016))
plot(France$Year,France$GDP,xlim=c(1945,2016))
```
#### 7) Zoom in on the graph by just putting the evolution between 1950 and 2016. Draw a blue line through the points of the graph.
```
lines(France$Year,France$GDP,xlim=c(1945,2016),col="red")
```
#### 8) Repeat questions 5) and 7) for Luxembourg.
```
Luxembourg<-subset(mad, subset=(Code=="LUX"))
lines(Luxembourg$Year,Luxembourg$GDP,xlim=c(1945,2016),col="green")
#Here, the graph is not complete, since the green line exits the graph in the 1990s
plot(Luxembourg$Year,Luxembourg$GDP,xlim=c(1945,2016))
points(France$Year,France$GDP,xlim=c(1945,2016))
lines(France$Year,France$GDP,xlim=c(1945,2016),col="red")
lines(Luxembourg$Year,Luxembourg$GDP,xlim=c(1945,2016),col="green")
plot(Luxembourg$Year,Luxembourg$GDP,xlim=c(1945,2016),ylim=c(0,70000))
points(France$Year,France$GDP,xlim=c(1945,2016))
lines(Luxembourg$Year,Luxembourg$GDP,xlim=c(1945,2016),col="green")
lines(France$Year,France$GDP,xlim=c(1945,2016),col="red")
```
#### 9) Create the subset comp containing only the values for the years 1950 and 2016.
```
Sample2<-subset(mad, subset=((Year>1950)&(Year<2016)))
```
#### 10) Test if GDP is on average significantly higher in 2016 than it was in 1950.
```
NULL
```
#### 11) Analyze the GDP evolution in Burundi.
```
Burundi<-subset(mad, subset=(Entity=="Burundi"))
plot(Burundi$Year,Burundi$GDP)
lines(Burundi$Year,Burundi$GDP,col="black")
```
#### 12) Order the countries in a decreasing order with respect to their GDP in 2016.
```
Y2016<-subset(mad, subset=(Year=2016))
Y2016<-subset(mad, subset=(Year==2016))
Y2016[order(-Y2016$GDP),]
```
#### 13) Create the variable Russia by recoding the variable Entity so that Russia becomes 1 and all other countries 0 and add it to the datafile.
```
Russia<-recode(Entity, '"Russia"=1; else=0;')
```
#### 14) Draw a histogram of the variable GDP. Do you think that it follows a normal distribution?
```
hist(GDP)
```
#### 15) Erase the last line of the dataset by two different methods.
```
mad<-mad[-17703,]
mad<-mad[1:17702,]
savehistory("path/to/file")
```

---

## Exercise sheet 2

The file « happiness.csv » contains the result of a US survey about happiness with 17137 observations. The variables in the file are the following:
```
year gss year for this respondent
workstat work force status
prestige occupational prestige score
divorce ever been divorced or separated
widowed ever been widowed
educ highest year of school completed
reg16 region of residence, age 16
babies household members less than 6 yrs old
preteen household members 6 thru 12 yrs old
teens household members 13 thru 17 yrs old
income total family income
region region of interview
attend how often r attends religious services
happy general happiness
owngun =1 if own gun
tvhours hours per day watching tv
vhappy =1 if 'very happy'
mothfath16 =1 if live with mother and father at 16
black =1 if black
gwbush04 =1 if voted for G.W. Bush in 2004
female =1 if female
blackfemale black*female
gwbush00 =1 if voted for G.W. Bush in 2000
occattend =1 if attend is 3, 4, or 5
regattend =1 if attend is 6, 7, or 8
y94 =1 if year == 1994
y96 =1 if year == 1996
y98 =1 if year == 1998
y00 =1 if year == 2000
y02 =1 if year == 2002
y04 =1 if year == 2004
y06 =1 if year == 2006
unem10 =1 if unemployed in last 10 years
```

#### 1) Open the file (declare the variables prestige, educ, babies and tvhours to be numerical variables), attach it and have a look at its structure.
```
library(readr)
happiness <- read_csv("happiness.csv", col_types = cols(prestige = col_number(),
educ = col_number(), babies = col_number(),
tvhours = col_number()))
View(happiness)
happiness->hap
attach(hap)
```
#### 2) Delete the last 10 variables of the datafile.
```
hap<-hap[,1:24]
hap<-hap[,-c(25:34)]
# Two ways of deleting the last 10 lines.
```
#### 3) Delete the lines 17 and 25.
```
hap2<-hap[-c(17,25),]
hap3<-hap[-25,]
hap3<-hap3[-17,]
# Two ways of deleting lines 25 and 17
```
#### 4) Display the basic descriptive s tatistics and draw the boxplots of the variables “prestige”, “tvhours” and “educ”. Are there any outliers?
```
summary(hap)
boxplot(prestige,tvhours,educ)
boxplot(hap[,c(4,7,17)])
# 2 ways of doing this
# There are quite a lot of outliers for all 3 variables, which is not astonishing in such a big dataset.
```
#### 5) Order the sample in a decreasing order with respect to the variable “prestige”. Which line is the outlier of that variable?
```
hap[order(-prestige),c(1,4)]
# We see that there are quite a lot of people with a prestige of 86, the first being line 81
hprest<-subset(hap, subset=(prestige==86))
# We see in the environment that there are actually 62 people with a prestige of 86.
# Another possibility to count the people is table(prestige).
```
####" "6) Create the variable “morons” with a value of 1 for people who voted for George Bush in 2000 and in 2004 and 0 for all others and add it to the database.
```
morons<-gwbush00*gwbush04
#Other solution
help<-gwbush00+gwbush04
library(car)
morons2<-recode(help, '2=1;NA=NA;else=0')
hap<-cbind(hap,morons)
summary(morons)
table(morons)
```
#### 7) Create the variable “Bush” with a value of 1 for people who voted for George Bush either in 2000 or in 2004 and 0 for all others and add it to the database.
```
Bush<-recode(help, '0=0;NA=NA;else=1')
#Other solution:
Bush<-gwbush00+gwbush04-gwbush00*gwbush04
```
#### 8) Create the variable “highprestige” with a value of 1 for people with a prestige larger and 60 and 0 for the others and add it to the database.
```
highprestige<-recode(prestige, 'prestige>60=1;NA=NA;else=0')
table(highprestige)
cbind(hap,highprestige)->hap
```
#### 9) Draw the histogram of the variable prestige. Does it look like a normal distribution? Do the statistical test to control that impression.
```
hist(prestige,col="darkred")
#It does not really look symmetrical
shapiro.test(prestige)
# The Shapiro-Wilk test in R just works for samples with less then 5000 lines.
ha<-hap[1:5000,]
shapiro.test(ha$prestige)
#p=0, hence we are 100% sure that the variable does not follow a normal distribution.
# In general, for any statistical test, we are (1-p)*100% sure that H0 is wrong
```
#### 10) Test if the average prestige is different for men and women.
```
kruskal.test(prestige~female)
#p=0.0138, so we are 98.62% sure that the average prestige of men and women is significantly different.
boxplot(prestige~female)
# Here, for once, the boxplot does not help us tp determine which subsample has the higher prestige.
# If we want to know, we have to define the subsets of men and women and compute the average prestige for both subsets in order to compare.
```
#### 11) Create the frequency tables for the variables happy and gwbush04, as well as the crosstable for these 2 variables.
```
table(happy)
table(gwbush04)
xtabs(~gwbush04+happy)
```
#### 12) Test if happiness and voting for George Bush in 2004 are independant.
```
chisq.test(happy,gwbush04)
# p<2.2*10^-16, which means p=0.
# Hence we are 100% sure that H0 is wrong
# This means that we are 100% sure that there is some relationship between the 2 variables.
# Looking at the crosstabs it seems that people voting for Bush were happier than people not voting for Bush
```
#### 13) Create the subset “Teens” of people with at least 2 teens in their household.
```
Teens<-subset(hap, subset=(teens>1))
```
#### 14) Test if the number of hours watching tv is higher for the people in that subset than in the whole population.
```
wilcox(tvhours,Teens$tvhours)
wilcox.test(tvhours,Teens$tvhours)
#p=2.9*10^-6=0, so we are 100% sure that there is a significant difference.
mean(tvhours)
summary(tvhours)
summary(Teens$tvhours)
#Parents with at least 2 teens watch significantly less tv.
```
#### 15) Draw the scatterplot of the prestige as a function of education.
```
plot(educ,prestige)
```
#### 16) Test if the correlation between these 2 variables is significant.
```
cor.test(educ,prestige)
#p=0, so we are 100% sure that the correlation is significant.
```
#### 17) Define the linear regression model explaining the prestige as a function of the education and add the regression line in red to the scatterplot. What is the model equation?
```
reg1<-lm(prestige~educ)
abline(reg1,col="red")
summary(reg1)
# The model equation is: Prestige = 11.09 + 2.45*Education
```
#### 18) Test if the slope of the equation in the whole population is equal to 2.5.
```
linearHypothesis(reg1, c("educ=2.5"))
#p=0.13, so we cannot reject H0.
#This means that it is possible that the real value of the slope is 2.5
```
#### 19) Save the dataset as an excel file.
```
# write.csv(hap, file="C:/Copy/R/hap.csv")
savehistory("path/to/file")

```

---

## Exercise sheet 3

The file « houses.csv » provides data on 462 houses in the USA. The variables in the file are the following:
```
Number: Number of the house
Price: Price of the house
Baths: Number of bathrooms
Rooms: Number of rooms
Heating: Existence of central heating (1 = yes; 2 = no)
Floors: Number of floors
Parking: Number of parking slots in the garage
Size: Size of the house
Toilets: Number of toilets
We want to explain the price of the houses as a function of the other variables.
```

#### 1) Open the file and attach it to the working memory of R.
```
library(readr)
houses <- read_csv("houses.csv")
View(houses)
library(car)
library(FactoMineR)

attach(houses)
```
#### 2) Draw the pairwise scatterplot of all the quantitative variables. What do you observe?
```
plot(houses[,2:9])
# Most of these variables are not continous random variables, so the scatterplots are not very useful.
```
#### 3) Compute the correlation matrix of the quantitative variables (variables 2 to 9). Which are the variables significantly correlated to the price?
```
cor(houses[,2:9])
2/sqrt(462)
# Hence, all correlations larger than 0.09 in absolute value are significant.
# All variables, except parking, are significantly correlated to the price.
# Since the number of parking opportunities does not influence the price of the houses, the sample is not from a big city.
```
#### 4) Define the variable « Flat » by recoding the variable « Floors » to 1 for houses with just one floor and to 2 for all other houses and test if there is a significant price difference between these two categories.
```
Flat<-recode(Floors, '1=1; else=2')
kruskal.test(Price~Flat)
# p=0.00005, so we are 100% sure that there is a price difference between the 2 groups.
boxplot(Price~Flat)
# Hence we are 100% sure that houses with more than 1 floor are significantly more expensive.
# We need to be careful though. Actually this price difference is mostly explained by the fact that on average houses with more floors are larger and so the bigger size actually explains the higher price and not the number of floors.
```
#### 5) Define a multiple regression to explain the price of the houses as a function of all other variables. What is the model equation and which percentage of the house price does it explain?
```
reg1<-lm(Price~Baths+Rooms+Heating+Floors+Parking+Size+Toilets)
summary(reg1)
# The model equation is  Price=6400+7256*Baths+5132*Rooms+7544*Heating-9868*Floors+440*Parking+5411*Toilets
# The model explains about 74% of the price.
```
#### 6) Perform a backward regression method if necessary to eliminate variables with no explaining power. Which variable(s) do we take out? What does that tell us about our sample? What is the final model and what percentage of the price does it explain?
```
reg2<-lm(Price~Baths+Rooms+Heating+Floors+Size+Toilets)
summary(reg2)
# The final model explains 73.84% of the price.
# The model equation : Price= 7328 + 7404*Baths+5026*Rooms+ 7414*Heating - 9959*Floors + 296*Size + 5400*Toilets
```
#### 7) Compare this to the result obtained with a forward stepwise regression procedure that starts with only a constant term.
```
reg3<-lm(Price~1)
step(reg3,direction="forward",scope=formula(reg1))

# The library stargazer allows to present the results of a multiple regression model in a professional manner.
# Here below an example of how to use it.
reg4<-lm(Price~Size)
reg5<-lm(Price~Size+Toilets)
reg6<-lm(Price~Size+Toilets+Heating)
reg7<-lm(Price~Size+Toilets+Heating+Floors)
library(stargazer)
stargazer(reg4, reg5, reg6, reg7,type = "text")
```
#### 8) Compute the total sum of squares of the final regression model. Estimate the standard deviation of the error term in the model.
```
anova(reg2)
# The total sum of squares is the sum of the numbers in the Sum Sq column.
# Otherwise, the total sum of squares is just 462*Var(Price)
462*var(Price)

# s=sqrt(RSS/T-k)
sqrt((5.1853*10^10)/455)
# The estimation of s is . That's the number appearing in the summary
summary(reg2)
```
#### 9) Test the hypothesis that each room adds 5000$ and that a central heating adds 7500$ to the price.
```
linearHypothesis(reg2, c("Rooms=5000","Heating=7500"))
# p=0.9976 so we cannot reject H0, which means that it is possible that these are the real values of the parameters.
```
#### 10) Compute the value of the test statistics used in the previous test without the use of the linearHypothesis command. To which quantile do he have to compare it to take the rejection decision?
```
# The restrictive model takes Price-5000*Rooms-7500*Heating) as variable to explain and the other variables as explanatory variables.
reg8<-lm(Price-5000*Rooms-7500*Heating~Baths+Floors+Size+Toilets)
anova(reg8)
# Unfortunately R gives the same value for the URSS and the RRSS. So in this example we cannot compute the test statistics by hand
# Here we would get ((5.1853*10^10-5.1853*10^10)/5.1853*10^10)*(455/2)=0
# If our test statistics is 0, we cannot of course not reject H0.
```
#### 11) Which of the regressor variables describes the house prices best? Do the scatterplot of the two variables and add the linear regression line of the price with respect to this variable in red to the graph.
```
# The highest correlated variable to Price is Size (or the ine with the lowest AIC in the forward stepwise regression)
plot(Size,Price)
abline(reg4,col="red")
```
#### 12) Define the exponential regression model Y = a * X^b, where Y denotes the price and X the previously found variable and add the model curve in blue to the previous scatterplot. Which of the two simple regression models is the best?
```
# Price=a*Size^b ie. ln(Price)=ln(a)+b*ln(Size)
reg9<-lm(log(Price)~log(Size))
summary(reg9)
# The model equation is  ln(Price)=7.16+0.83*ln(Size)
# Hence Price=exp(7.16)*Size^0.83
x<-0:550
y<-exp(7.16)*x^0.83
lines(x,y,col="blue")
#The R square for the exponential model is higher than the one for the linear model. Hence the exponential model is better.
```
#### 13) Perform a principal component analysis of the explanatory variables of our model (variables 3 to 9). How many components should we keep according to the 2 criteria seen in class.
```
res.pca<-PCA(houses[,3:9], scale.unit=TRUE, ncp=7, graph=F)
res.pca$eig
# We have 2 eigenvalues larger than 1 and we need 4 factors to explain at least 80% of the variability of the data
```
#### 14) Give an interpretation of the 2 first principal components and add them to the dataset.
```
# We rerun the PCA with just 2 components.
res.pca<-PCA(houses[,3:9], scale.unit=TRUE, ncp=2, graph=T)
dimdesc(res.pca, axes=c(1:2))
#The first principal component is the size of the house and the second is the number of parking slots.
cbind(houses,res.pca$ind$coord)->houses
```
#### 15) Perform a linear regression model to explain the Price as a function of the 2 principal components found above. Compare this model to the previous regression model.
```
reg10<-lm(Price~houses$Dim.1+houses$Dim.2)
summary(reg10)
# This model with just 2 factors explains 63.23% of the price.
```

---

## Exercise sheet 4

The file « SP500.csv » contains daily prices of 21 stocks from S&P500 over the last 20 years.
#### 1) Open the file, attach it to the working memory of R and ask for its structure.
```
library(readr)
SP500 <- read_csv("SP500.csv")
View(SP500)

attach(SP500)
str(SP500)
```
#### 2) Give the correlation matrix of the quantitative variables. From which value upwards, the correlations are statistically significant? Which variables are significantly correlated to Amazon?
```
cor(SP500[,3:23])
2/sqrt(5218)
# Since we have a lot of lines, here all correlations larger than 0.027 (in absolute) are significant.
# Nearly all correlations in the dataset are significant. In particular, all stocks are significantly correlated to Amazon.
```
#### 3) Create the scatterplot with the line number on the x axis and the prices of Amazon in red on the y axis (use the parameter type="l" to get lines instead of points). Add the prices of Apple to the graph in blue. What do you observe?
```
plot(Number,AMAZON,type="l",col="red")
lines(Number,APPLE,type="l",col="blue")
# We observe that the prices of both stocks have gone mostly up, but the increase of Amazon over the last few years was higher than the one from Apple.
```
#### 4) Create the subset “Old” of all stock prices before June 1, 2011 (the first 3000 lines) and the subset “New” of all stock prices newer than that date.
```
Old<-subset(sp, subset=(Number<3001))
#or Old<-sp[1:3000,]
New<-subset(sp, subset=(Number>3000))
#or New<-sp[3001:5218,]
```
#### 5) Test if the prices of Amazon before June 2011 and after June 2011 are normally distributed. Use the appropriate test to check if the average prices of Amazon were different in the two sub periods.
```
shapiro.test(Old$AMAZON)
shapiro.test(New$AMAZON)
# p=0, so we are 100% sure that the prices of Amazon in the 2 periods are not normally distributed.
wilcox.test(Old$AMAZON,New$AMAZON)
# p=0, so we are 100% sure that the average price of Amazon is higher in the second period.
```
#### 6) Perform a multiple regression to explain the prices of Amazon as a function of the prices of the other stocks (variables 4 to 23). Exclude multicollinearity problems (exclude variables with variance inflation factors larger than 10) and test if there are heteroscedasticity or autocorrelation problems.
```
library(car)
reg1<-lm(AMAZON~ABBOTT+AES+ABIOMED+AMD+ADOBE+AAG+BOSTON.PROPERTIES+HONEYWELL+AMGEN+HESS+AMERICAN.EXPRESS+AFLAC+ANALOG.DEVICES+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+AMETEK+VERIZON)
vif(reg1)
# If there are too many variables, we can write vif(reg1)->vifs   and then order(vifs)

reg2<-lm(AMAZON~ABBOTT+AES+ABIOMED+AMD+ADOBE+AAG+BOSTON.PROPERTIES+AMGEN+HESS+AMERICAN.EXPRESS+AFLAC+ANALOG.DEVICES+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+AMETEK+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~ABBOTT+AES+ABIOMED+AMD+AAG+BOSTON.PROPERTIES+AMGEN+HESS+AMERICAN.EXPRESS+AFLAC+ANALOG.DEVICES+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+AMETEK+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~ABBOTT+AES+ABIOMED+AMD+AAG+BOSTON.PROPERTIES+AMGEN+HESS+AMERICAN.EXPRESS+AFLAC+ANALOG.DEVICES+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+BOSTON.PROPERTIES+AMGEN+HESS+AMERICAN.EXPRESS+AFLAC+ANALOG.DEVICES+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+BOSTON.PROPERTIES+HESS+AMERICAN.EXPRESS+AFLAC+ANALOG.DEVICES+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+BOSTON.PROPERTIES+HESS+AMERICAN.EXPRESS+ANALOG.DEVICES+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+HESS+AMERICAN.EXPRESS+ANALOG.DEVICES+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+HESS+AMERICAN.EXPRESS+ALEXION+VALERO+APACHE+APPLE+AVERY.DENNISON+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+HESS+AMERICAN.EXPRESS+ALEXION+VALERO+APACHE+AVERY.DENNISON+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+HESS+AMERICAN.EXPRESS+ALEXION+VALERO+APACHE+VERIZON)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+HESS+AMERICAN.EXPRESS+ALEXION+VALERO+APACHE)
vif(reg2)
reg2<-lm(AMAZON~AES+ABIOMED+AMD+AAG+HESS+AMERICAN.EXPRESS+VALERO+APACHE)
vif(reg2)
# Now there is no multicolineartiy problem anymore.

library(lmtest)
bptest(reg2)
#p=0, so we are 100% sure that we have a heteroskedasticity problem.
dwtest(reg2)
#p=0, so we are 100% sure that we have autocorrelation problems.
# This is a known problem. We should work with return series and not price series.
```
#### 7) Test if the residuals of the remaining model are normally distributed.
```
hist(residuals(reg2))
# The histogram is not symmetric enough to have a normal distribution.
# Since the Shapiro-Wilk test does only work for samples with at most 5000 lines, we take a subsample of the first 5000 lines.
residuals(reg2)->resid
cbind(SP500,resid)->SP500
Testsample<-SP500[1:5000,]
shapiro.test(Testsample$resid)
# p=0, so we are 100% sure that the residuals are not normally distributed either.
hist(resid)
# We also see that the histogram is not symmetric.
```
#### 8) Do a stepwise backward regression procedure to exclude variables which do not have enough explanatory power if necessary. Which is the final model and how much of the variance of the prices of Amazon does it explain? Is that astonishing?
```
summary(reg2)
# All parameters are significant, so we do not need to do a stepwise backward regression procedure.
# The final model is  Amazon = -9373-7.8*AES+11.1*ABIOMED+1.2*AMD+1.3*AAG+3.6*HESS+4.3*American Express-0.99*Valero-0.3*Apache
# The model explains 96% of the variations of the prices of Amazon.

```
#### 9) Use the subset “Old” and new “New” to check if the parameters of the final model are stable over time.
```
reg3<-lm(Old$AMAZON~Old$AES+Old$ABIOMED+Old$AMD+Old$AAG+Old$HESS+Old$AMERICAN.EXPRESS+Old$VALERO+Old$APACHE)
reg4<-update(reg2,subset=(Number>3000))
summary(reg3)
summary(reg4)
# We see that reg3 and reg4 have different formulas. Hess is not even significant anymore for reg4. So the parameters in reg2 are not stable over time.
```
#### 10) Test the hypothesis that an increase of 1 of the price of AMD adds 1 and that an increase of 1 of the price of AAG adds 2 to the price of Amazon.
```
linearHypothesis(reg2, c("AMD=1","AAG=2"))
# p=0, so we are 100% sure that either AMD=1 or AAG=2 is wrong (or both).
```
#### 11) Compute the value of the test statistics used in the previous test without the use of the linearHypothesis command. To which quantile do he have to compare it to take the rejection decision?
```
reg5<-lm(AMAZON-AMD-2*AAG~AES+ABIOMED+HESS+AMERICAN.EXPRESS+VALERO+APACHE)
anova(reg2)
anova(reg5)
#Let's compute the test statistics F=(RSS-URSS/URSS)*(T-k/m)
((1.4556-1.3981)/1.3981)*((5218-8)/2)
# We find F=107.14
# We have to compare that to the corresponding quantile of F(m-T-k)=F(2,5209)
```
#### 12) Compute the standardized residuals of the linear model and add them to the dataset. Check the descriptive summary statistics of the residuals. Are there outliers to the regression model?
```
rstandard(reg2)->res
summary(res)
# We see that there are outliers on both sides of the spectrum
```
#### 13) Do a principal component analysis of the quantitative variables (variables 3 to 23). How many components should we keep?
```
library(FactoMineR)
res.pca<-PCA(SP500[,3:23], scale.unit=TRUE, ncp=21, graph=T)
res.pca$eig
# We have 3 eigenvalues larger than 1 and need 2 components to explain at least 80% of the data.
```
#### 14) Give an interpretation of the 2 first principal components. Save the first two factors as variables and add them to the data file. What do the points on the scatterplot of the two first factors represent? What special fact do you observe on the plot?
```
dimdesc(res.pca, axes=c(1:2))
# The first component is kind of a market index representing 17 of the 21 stocks (all stocks except AES, Apache, AMD and perhaps Hess)
# The second component is positively correlated to AMD and AES and negatively to Hess and Apache.
# The points on the scatterplot repressent the different trading days in the sample.
# We see that the points form some u-shaped curve
cbind(SP500,res.pca$ind$coord)->SP500
```
#### 15) Perform a hierarchical ascendant cluster analysis on the results of the above principal component analysis. Choose a 4 groups solution, give an interpretation of the groups, save the group membership of the data points and add them to the data file.
```
res.hcpc<-HCPC(res.pca)
# The blue group are the days with high prices, the green group are the days with average prices and the red and black groups are the days with low prices.
# The difference between the 2 last groups is that the red days were good for AES and AMD and the black were good for Hess and Apache.
str(res.hcpc$data.clust)
cbind(SP500,res.hcpc$data.clust[,22])->SP500
```

---

## Exercise sheet 5

The excel file « ISD.xlsx » contains financial time series from July 1965 till December 2018. The variables in the file are the following:
```
yearmo year and month
SENT investor sentiment index from Baker and Wurgler
pdnd value-weighted dividend premium
ripo first-day returns on IPOs
nipo IPO volume
cefd closed-end fund discount
s equity share in new issues
indpro industrial production index
consdur nominal durables consumption
consnon nominal nondurables consumption
consserv nominal services consumption
recess NBER recession indicator
employ employment
cpi consumer price index
```
We want to explain the investor sentiment index as a function of the other variables.

#### 1) Open the file, attach it to the working memory of R and ask for its structure.
```
library(readxl)
ISD <- read_excel("ISD.xlsx")
View(ISD)

attach(ISD)
```
#### 2) Give the correlation matrix of the quantitative variables. From which value upwards, the correlations are statistically significant? Which variables are significantly correlated to SENT?
```
cor(ISD)
2/sqrt(642)
# All correlations larger than 0.079 (in absolute values) are significant.
# SENT is significantly correlated to all variables, except ripo and the 3 consumption variables.
```
#### 3) Perform a multiple regression to explain the investor sentiment index as a function of the other variables. Exclude multicollinearity problems (exclude variables with variance inflation factors larger than 10) and test if there are heteroscedasticity or autocorrelation problems.
```
reg1<-lm(SENT~pdnd+ripo+nipo+cefd+s+indpro+consdur+consnon+consserv+recess+employ+cpi)
library(car)
vif(reg1)
reg2<-lm(SENT~pdnd+ripo+nipo+cefd+s+indpro+consdur+consserv+recess+employ+cpi)
vif(reg2)
reg2<-lm(SENT~pdnd+ripo+nipo+cefd+s+indpro+consserv+recess+employ+cpi)
vif(reg2)
reg2<-lm(SENT~pdnd+ripo+nipo+cefd+s+indpro+consserv+recess+cpi)
vif(reg2)
reg2<-lm(SENT~pdnd+ripo+nipo+cefd+s+indpro+consserv+recess)
vif(reg2)
reg2<-lm(SENT~pdnd+ripo+nipo+cefd+s+consserv+recess)
vif(reg2)
# Now all variance inflation factors are smaller than 2, so the model with 7 explanatory variables does not present any multicolinearity problems anymore.
library(lmtest)
bptest(reg2)
# p=0, so we are 100% sure that we have a heteroskedasticity problem.
dwtest(reg2)
#p=0, so we are 100% sure that we have autocorrelation problems.
# Since we have both heteroskedasticity and autocorrelation problems, we need to be careful.
# The model equation will still be the best possible for our dataset, but the real standard errors are larger than those indicated by R.
# So, we should not use our model for predictions (or more generally to do inferential statistics on the whole population)
```
#### 4) Test if the residuals of the remaining model are normally distributed.
```
residuals(reg2)->resid
shapiro.test(resid)
# p=0, so we are 100% sure that the residuals are not normally distributed.
```
#### 5) Plot the autocorrelation and partial autocorrelation function of the residuals. What do you observe?
```
acf(resid)
# We see that the autocorrelation coefficients converge to 0 and that the first 14 autocorrelation coefficients are significant. Thus we could use an MA(14) process to modelise the residuals.
pacf(resid)
# We see that the partial autocorrelation coefficients converge more or less to 0 and that the partial autocorrelation coefficients with lag 1, 9 and 23 are significant. Thus we could use an AR(1) process to modelise the residuals.
# As a conclusion, it looks like an ARMA(1,14) should be a good way to modelise the residuals.
# A strategy here would be to compute the AIC for ARMA(1,14), ARMA(1,13)... and also looking at MA(14) and AR(1) and take the one with the best model fit.
```
#### 6) Do a stepwise backward regression procedure to exclude variables which do not have enough explanatory power if necessary. Which is the final model and how much of the variance of the sentiment index does it explain?
```
summary(reg2)
reg3<-lm(SENT~pdnd+ripo+nipo+cefd+s+recess)
summary(reg3)
# Our final model is SENT= -0.026*pdnd-0.004*ripo+0.0094*nipo-0.082*cefd+2.38*s+0.4*recess
# The model explains about 76% of the investor sentiment index.
```
#### 7) Create the subsets “Old” and “New” containing data between 1965 and 2005 and between 2006 and 2018 respectively.
```
Old<-subset(ISD, subset=(yearmo<200600))
New<-subset(ISD, subset=(yearmo>200600))
```
#### 8) Use the subset “Old” and new “New” to check if the parameters of the final model are stable over time.
```
reg4<-update(reg3,subset=(yearmo<200600))
reg5<-update(reg3,subset=(yearmo>200600))
summary(reg4)
summary(reg5)
# We see that for the newer data the old formula does not work that well anymore. In particular, pdnd and ripo are not significant anymore.
# Moreover, the model equation itself changed a lot. s for intance changed the sign.

```
#### 9) Do a principal component analysis of variables 3 to 14. How many components should we keep?
```
library(FactoMineR)
res.pca<-PCA(ISD[,3:14], scale.unit=TRUE, ncp=12, graph=T)
res.pca$eig
# We have 3 eigenvalues larger than 1 and we need 4 components to explain at lest 80% of the data.
# We should probably just go with 3 principal components.
res.pca<-PCA(ISD[,3:14], scale.unit=TRUE, ncp=3, graph=T)
```
#### 10) Give an interpretation of the 2 first principal components. Save the first two factors as variables and add them to the data file.
```
dimdesc(res.pca, axes=c(1:3))
# The first principal component is the health of the economy.
# The second component is positively correlated to the dividend premium and negatively to the IPO volume.
# The third component is positively correlated to recession and negatively to high first-day returns for IPOs
cbind(ISD,res.pca$ind$coord)->ISD
attach(ISD)
plot(Dim.1,Dim.3)
text(Dim.1,Dim.3,yearmo,cex=0.4,pos=2,col="blue")
```
#### 11) Perform a hierarchical ascendant cluster analysis on the results of the above principal component analysis. Give an interpretation of the groups, save the group membership of the data points and add them to the data file.
```
res.hcpc<-HCPC(res.pca)
# The computer indicates to take a 3 group solution.
res.hcpc$desc.var
# Group 1 are the months for which the variables cefd, pdnd, s and ripo have a significantly higher mean than average.
# Group 2 are months for which the variables nipo, ripo and s have a significantly higher mean than average and the other variables a significantly lower mean.
# Group 3 are the months for which the macroeconomical variables have a significantly higher average and ripo, cefd, nipo and s have a significantly lower average.
str(res.hcpc$data.clust)
res.hcpc$data.clust[,13]->group
cbind(ISD,group)->ISD
# Let's do a scatterplot of Dim.3 as a function of Dim.1 with different colors for the 3 groups.
scatterplot(Dim.3~Dim.1|group, smooth=FALSE, regLine=FALSE)
text(Dim.1,Dim.3,yearmo,pos=2,cex=0.5)
```
#### 12) Do a simple linear regression model, as well as an exponential model in order to explain SENT as a function of the first principal component. Which of the 2 model explains better?
```
reg6<-lm(SENT~Dim.1)
reg7<-lm(log(SENT)~log(Dim.1))
summary(reg6)
# The model is quite bad and explains only 0.8% of the sentiment index.
summary(reg7)
# The exponential model explains about 6.5% of the data, but it is of course only calibrated on the months in which SENT and Dim.1 are positive!
```
#### 13) Plot the sentiment index as a function of the first principal component and add the linear model in red and the exponential model in blue.
```
plot(Dim.1,SENT)
abline(reg6, col="red")
x<- -4:6
# The model equation is  log(SENT)=-1.12-0.21*log(Dim.1), hence SENT=exp(-1.12)*Dim.1^-0.21
y<-exp(-1.12)*x^(-0.21)
lines(x,y, col="blue")
# We see also on the plot that the second model can only handle positive values for both variables.
```

---

## Exercise sheet 6

The excel file « currencies.xls » contains the conversion rate of the US$ for the Euro, the British Pound and the Yen from December 1998 to July 2018. We will try to forecast the conversion rate of the Euro.
#### 1) Open the file and attach it to the working memory of R.
```
library(readxl)
currencies <- read_excel("currencies.xls")
View(currencies)

attach(currencies)
```
#### 2) Plot the three variables as lines as a function of the date in different colours on the same plot.
```
plot(Date,EUR,type="l",col="red")
lines(Date,GBP,col="blue")
lines(Date,JPY,col="green")
# We do actually not see all 3 time series on the graph, since they have different range of values.
summary(currencies)
plot(Date,EUR,type="l",col="red",ylim=c(0,1.4))
lines(Date,GBP,col="blue")
lines(Date,JPY/100,col="green")
legend("bottomright", c("EUR", "GBP","JPY"), col=c("red", "blue","green"), lty=1, cex=1.5)
```
#### 3) Plot the pairwise scatterplot of all quantitative variables. What do you observe?
```
plot(currencies[,2:4])
# There seem to be linear relationships between the Euro and the 2 other currencies.
# The Pound and the Yen seem related, but clearly not in a linear way.
```
#### 4) Give the correlation matrix of the quantitative variables. From which value upwards, the correlations are statistically significant? Which correlations are significant?
```
cor(currencies[,2:4])
2/sqrt(7142)
# All correlations higher than 0.023 (in absolute value) are significant.
# EUR is highly correlated both to GBP and to JPY, but there is no linear relationship between GBP and JPY.
```
#### 5) Define the subset “Old” of lines 1 till 7100 and “New” of the last 42 lines.
```
Old<-currencies[1:7100,]
New<-currencies[7101:7142,]
```
#### 6) Use the subset “Old” to perform a multiple regression to explain the conversion rate of the Euro as a function of the other variables. Exclude multicollinearity problems (exclude variables with variance inflation factors larger than 10) and test if there are heteroscedasticity problems.
```
library(car)
reg1<-lm(Old$EUR~Old$GBP+Old$JPY)
vif(reg1)
# We do not have any multicolinearity problem, which was obvious, since GPD and JPY are uncorrelated.
library(lmtest)
bptest(reg1)
# p=0, so we are 100% sure that we have a heteroscedasticity problem.
```
#### 7) Do a stepwise backward regression procedure to exclude variables which do not have enough explanatory power if necessary. Which is the final model and how much of the variance of the conversion rate of the Euro does it explain? Which are the values for the standard errors of the coefficients that we should use?
```
summary(reg1)
# Both parameters are significant, so reg1 is our final model.
# Since, we have a heteroskedasticity problem, we need to use White's modified formula for the standard errors
# The model explains about 59% of EUR.
library(sandwich)
coeftest(reg1,vcov.=vcovHC(reg1,type="HC1"))
# The model equation is EUR=-0.3+0.912*GBP+0.00539*JPY
```
#### 8) Display the histogram of the residuals and t est if the first 5000 residuals of the model are normally distributed.
```
residuals(reg1)->resid
hist(resid)
# The histogram clearly is not symmetric.
shapiro.test(resid[1:5000])
# p=0, so we are 100% sure that the residuals are not normally distributed.
```
#### 9) Test if there are autocorrelation problems.
```
dwtest(reg1)
# p=0, so we are 100% sure that we have an autocorrelation problem.
# All our model hypotheses are not verified! So we should actually not use this model for forecasting or be aware at least that the forecast risks to be non accurate.
```
#### 10) Plot the autocorrelation and partial autocorrelation function of EUR for the dataset Old. What do you observe? Can we use an ARMA process to modelise EUR?
```
acf(Old$EUR)
# We see that all autocorrelation coefficients are significant and that they are not converging to 0. So we cannot use MA models here.
pacf(Old$EUR)
# The 2 first coefficients are highly significant (plus some more slighlt signifanct with higher lags) and the coefficients become small.
# So we should be able to modilise EUR with an AR(2) model.
```
#### 11) Estimate the model coefficients for AR(1), AR(2), AR(3), as well as MA(1), MA(2), ARMA(1,1), ARMA(1,2), ARMA(1,3), ARMA(2,1), ARMA(2,2) and ARMA(2,3). Which of these models is best suited to modelise EUR?
```
arima(Old$EUR, order = c(1,0,0))
arima(Old$EUR, order = c(2,0,0))
arima(Old$EUR, order = c(3,0,0))
arima(Old$EUR, order = c(0,0,1))
arima(Old$EUR, order = c(0,0,2))
arima(Old$EUR, order = c(1,0,1))
arima(Old$EUR, order = c(1,0,2))
arima(Old$EUR, order = c(1,0,3))
arima(Old$EUR, order = c(2,0,1))
arima(Old$EUR, order = c(2,0,2))
arima(Old$EUR, order = c(2,0,3))
# We see that among the calibrated models, the best (the one with the lowest AIC) is the AR(2) model.
arima(Old$EUR, order = c(2,0,0))->ar2

```
#### 12) Use the AR(2) model to forecast the next 42 days of EUR.
```
predict(ar2, n.ahead=42)
predict(ar2, n.ahead=42)->predi
```
#### 13) Use the multiple regression model found above to forecast the next 42 days of EUR.
```
# To do out of sample forecast for regression models, we should use the command predict. But for this, we need to manually type in the 42 values of GBP and JPY, which is quite some work.
# So we will cheat a little bit and estimate the model on the whole dataset and use the fitted command for the forecast.
reg2<-lm(EUR~GBP+JPY)
summary(reg2)
fitted(reg2)->predict
cbind(currencies,predict)->currencies
New<-currencies[7101:7142,]
# We could also define prediction=-0.3+0.912*GBP+0.00539*JPY on the dataset New and use this for the prediction of the regression model.
New$prediction=-0.3+0.912*New$GBP+0.00539*New$JPY
```
#### 14) Draw the scatterplot of the last 42 lines of EUR as a function of time as a line. Add the AR(2) forecast in red and the forecast obtained by the regression model in blue. What do you observe?
```
plot(New$Date,New$EUR,type="l",ylim=c(0.8,1))
lines(New$Date,predi$pred,col="red")
lines(New$Date,New$predict,col="blue")
lines(New$Date,New$prediction,col="green")
```
