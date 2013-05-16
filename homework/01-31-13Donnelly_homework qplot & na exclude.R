# formula for the SEM is the standard deviation divided by the
# square root of the number of samples.  You can determine the number of
# items by using length().  i.e.
# 
# > myData <- c(93,45,67,23)
# > length(myData)
# [1] 4

#get some fake numbers:
x <- c(1,4,6,9,15,29,30,200,60009)
#check that they print thusly:
x
#create a function like we did last week:
SEM<- function(x){ 
  sd(x)/sqrt(length(x))
}
#removing NA values
SEM2<- function(x, na.rm=F){ 
  sd(x)/sqrt(length(x))
}
#so assigns DEFAULT VALUE of na.rm to FALSE so that it won't care about NA

SEM2(TomatoR2CSHL$intleng)

SEM(TomatoR2CSHL$int3)
summary(TomatoR2CSHL$int3)
#OR

SEM3<- function (x,na.rm=F) { 
  if(na.rm==T) {
    x <- x[!is.na(x)]
  }
  sd(x)/sqrt(length(x))
}

#extract the parts of my data that ARE NA
x[is.na(x)]

#extact parts of my data that are NOT NA
x[!is.na(x)] # DO NOT DO THAT IN A DATA FRAME!

#test the function:
SEM(x)
#eat ice cream.


#chp 2

#figure out qplot arguments:
?qplot #omg terrifying

#using the pre-loaded data set:
head(diamonds)
#grab a subsample, just for funsies:
dsmall <- diamonds[sample(nrow(diamonds), 100), ]
#check if it's there:
head(dsmall)

#graph some aspects:
qplot(log(carat), log(price), data = diamonds)
qplot(log(carat),x*y*z, data = diamonds)

#graph with pretty colors/legends!
qplot(carat, price, data = dsmall, colour = color)
#graph with cool symbols!
qplot(carat, price, data = dsmall, shape = cut)

#change transparencies:
qplot(carat, price, data = diamonds, alpha = I(1/10), color=I("red"))
qplot(carat, price, data = diamonds, alpha = I(1/100),color=I("red"))
qplot(carat, price, data = diamonds, alpha = I(1/200),color=I("red"))

#trying plots outside of scattered...
qplot(carat, price, data = diamonds, alpha = I(1/10), color=I("red"), geom = "smooth")
#gives you an ugly/useless legend
qplot(carat, price, data = diamonds, alpha = I(1/10), color="red", geom = "smooth")
#what's this do?:
qplot(carat, price, data = diamonds, color=I("red"), geom = "smooth")
#^ makes the little e-collar look darker
#print out: geom_smooth: method="auto" and size of largest group is >=1000, so using gam with formula: y ~ s(x, bs = "cs"). Use 'method = x' to change the smoothing method.
#^what does THAT mean?

qplot(carat, price, data = dsmall, color=I("blue"), geom="path")

#can do more than ONE!
qplot(carat, price, data = dsmall, geom = c("point", "smooth"))
#confidence interval shown in grey(THE 'E-COLLAR'!). If you want to turn the confidence interval off, use se = FALSE.

qplot(carat, price, data = dsmall, geom = c("point", "smooth"), se= FALSE)

#pretty rainbow charts!!!
qplot(carat, data = diamonds, geom = "density", colour = color) 
qplot(carat, data = diamonds, geom = "histogram", fill = color)

head(TomatoR2CSHL)

#2.1a From the tomato data set (available on SmartSite under Resources) use qplot to plot totleng as a function of altitude.

qplot( alt, totleng, data=TomatoR2CSHL, color=I("GREEN"))


#can write x=alt y=totleng, but default is 1st = x, 2nd = y

#can make alt a discrete value:
qplot( factor(alt), totleng, data=TomatoR2CSHL, color=I("blue"))
#much prettier
#for bins, use "cut"
#2.1b Add a linear regression line to this plot

qplot( alt, totleng, data=TomatoR2CSHL, color=I("GREEN"), geom = c("point","smooth"), method = "lm")

#order of geomes is the order they get plotted in... line in front of dots vs line behind dots
qplot(totleng, alt, data=TomatoR2CSHL, color=I("GREEN"), geom = c("point","smooth"))
qplot(totleng, alt, data=TomatoR2CSHL, color=I("GREEN"), geom = c("smooth", "point"))

#2.1c Add a locally smoothed line instead.
qplot(totleng, alt, data=TomatoR2CSHL, color=I("GREEN"), geom = c("point","smooth"))


      #2.1d color the dots by light condition ("trt")
qplot(y=totleng, x=factor(alt), data=TomatoR2CSHL, color = trt, geom = c("point","smooth"))

#2.1e make the plot symbol correspond to species

qplot(totleng, alt, data=TomatoR2CSHL, color = trt, shape = species, geom = c("point","smooth"), se=FALSE)
