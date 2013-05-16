#trying out long vs wide data frames
wide <- data.frame(
  colors=c("red","orange","yellow","green","blue","indigo","violet"),
  rank =(1:7),
  weight=rnorm(7,4),
  height=rnorm(7,4),
  length=rnorm(7,4))

head(wide)
#it worked!!
#qplot( species, totleng, data=TomatoR2CSHL, color=trt, geom= "boxplot")
qplot(height, length, data=wide, color=colors, geom="boxplot")
#ok, box plots are pathetic
qplot(height, length, data=wide, color=colors, geom="histogram")
#what just happened?!

#ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng, color = species)) + geom_jitter(color = "darkgrey") + geom_boxplot(outlier.size=0)

#getting visualization on data
ggplot(data=wide, mapping=aes(x=colors, y=length)) +
  geom_jitter(color="purple") 

#scatterplot
ggplot(data=wide, mapping=aes(x=weight, y=height)) +
geom_point()

#so the linear model is supposed to be affected by the wide vs long phenomena...
lm(data=wide)
#but I don't know how to use it. help.
library(reshape)
wide
long <- melt(wide)
#doesn't work help
head(long)
