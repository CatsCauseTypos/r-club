hypocotyl.worksheet_PREET <- read.csv("~/Desktop/hypocotyl worksheet_PREET.csv")
View(hypocotyl.worksheet_PREET)

#qplot( species, totleng, data=TomatoR2CSHL, color=trt, geom= "boxplot")
NAfree <- na.omit(hypocotyl.worksheet_PREET)
qplot(treatment, hyp.length, color=Scan, data=NAfree, geom="jitter")
qplot(treatment, hyp.length, color=Scan, data=NAfree, geom="boxplot")
str(NAfree)

#OMG$diameter<-(as.numeric(as.character(OMG$diameter)))
NAfree$hyp.length <-(as.numeric(as.character(NAfree$hyp.length)))

NAfree$Scan

