###########Exercise 7:
#what does a rep() function do?
## so I asked the internet:
#A related function is rep() which can be used for replicating an object in various complicated ways. The simplest form is
#> s5 <- rep(x, times=5)
#which will put five copies of x end-to-end in s5. Another useful version is
#> s6 <- rep(x, each=5)
#which repeats each element of x five times before moving on to the next.
## but I still cannot figure out why you would WANT to do this.
rep(TomatoR2CSHL)
##### Joe says it's helpful for making data frame thingies. He said I'd understand when I grow up... 

fruit.type <- rep(c("apple","orange"),5)
fruit.dia <- c(4,3,6,4,5,4,5,5,NA,6)
fruit.dia
fruit.type

tapply(fruit.dia,fruit.type,sd,na.rm=T)

by(fruit.dia,fruit.type,sd,na.rm=T)


hist(TomatoR2CSHL$intleng,main="color fun",col="magenta", xlab="I'ma x") 
##############Exercise 8:
#Which species has the longest hypocotyls? 
##so I was trying to get THE longest hypocotyls... which is definitely not what we were supposed to do... so now I will proceed to find the spp with the highest AVERAGE hypocotyl length
#head(TomatoR2CSHL)
#hypocotyl<-print(TomatoR2CSHL[,9])
#print (hypocotyl)

#rank(hypocotyl, ties.method=c("max"))
##PS - you don't have to make a new thing to have only the hypocotyl lengths print
TomatoR2CSHL$hyp
#magic ^

head(TomatoR2CSHL)

tapply(TomatoR2CSHL$hyp,TomatoR2CSHL$species, mean,na.rm=T)

#so it's peruvianum

#Which light treatment causes longer hypocotyls?

tapply(TomatoR2CSHL$hyp,TomatoR2CSHL$trt, mean,na.rm=T)

#so L (low light) beats H (high light)

#Create a new object to hold means calculated using the tapply function:

spp<-print(tapply(TomatoR2CSHL$hyp,TomatoR2CSHL$trt, mean,na.rm=T))
spp
#Plot the means using barplot(HYP.MEAN) where you replace HYP.MEAN with the name of the object holding your means
barplot(spp)
plot(spp, ylim=c(0,40))

#"grouping information" is the column things that split up the data (e.g. spp)

barplot(tapply(TomatoR2CSHL$hyp,list(TomatoR2CSHL$trt,TomatoR2CSHL$species), mean,na.rm=T))

###### Exercise 9

#Calculate mean total internode length for each species/light combination. Do you prefer the output from tapply() or by() better?

#PS- can just do this to get the titles of columns:
names(TomatoR2CSHL)

tapply(TomatoR2CSHL$intleng,list(TomatoR2CSHL$trt,TomatoR2CSHL$species), mean,na.rm=T)

# I prefer tapply

hist(TomatoR2CSHL$intleng,main="histogram of doom")

###### Exercise 10
#the title... I already changed that a bunch - but the "Help" function for "main" is blank. useless.
hist()
hist(TomatoR2CSHL$intleng,main="color fun",col="magenta")
hist(TomatoR2CSHL$intleng,main="color fun",col="blue")
hist(TomatoR2CSHL$intleng,main="color fun",col="steelblue")
hist(TomatoR2CSHL$intleng,main="color fun",col="rainbow")
#shows up as NOTHING!!!
hist(TomatoR2CSHL$intleng,main="color fun",col="sparkely")
# shows up as nothing also =(an X", ylab= "I'm a Y")

#multiple histograms...
histogram(~TomatoR2CSHL$intleng | TomatoR2CSHL$trt * TomatoR2CSHL$species)

###### Exercise 11

#Plot histograms of the petiole data split by the researcher and light treatment.
names(TomatoR2CSHL)
histogram(~TomatoR2CSHL$petleng | TomatoR2CSHL$trt * TomatoR2CSHL$who)

plot(TomatoR2CSHL$leafleng,TomatoR2CSHL$leafwid, col="salmon")
#coincidentally, joe's shirt is salmon colored... 

pairs(TomatoR2CSHL)
#error =(

####### Exercise 12
pairs(TomatoR2CSHL$hyp,TomatoR2CSHL$int1,TomatoR2CSHL$int2,TomatoR2CSHL$int3,TomatoR2CSHL$int4)
#^ yeah, that's not gonna work...

#Susan's sage wisdom pays off again
pairs(TomatoR2CSHL[,9:13])
#which appear correlated?
#int3 & 4 are the only ones that make a pretty line.

#using with prevents having to type out the data frame:

sort(with(TomatoR2CSHL, tapply(hyp,species,max,na.rm=T)), decreasing=FALSE)

#never use attach; but at least remember to detach it!

