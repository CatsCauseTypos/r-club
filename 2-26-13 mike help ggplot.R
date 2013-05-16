#mike's help w/ ggplot (sans q)
#cheating in ggplot by looking back at qplot homework:
  #2.2b use facets to make a separate plot for the two treatements (and labeing legend)

    qplot( species, totleng, data=TomatoR2CSHL, color=species, geom= "boxplot", facets = who~trt) + labs(color = "PLANTIES")
    #"mapping" is when your data is correlated to the graphical quality (how big is the circle) and "setting" is when you make all of your data points a pretty color.



#must write: aes = aesthetic 
#optional: data and mapping & x & y

ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng))

#having the pluses makes it easy to add layers..
ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng)) + geom_boxplot()
#^ boring and no who
ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng)) + geom_boxplot(mapping=aes(color=species)) 
#^can add color to the specific layer or you can add the color to the aes list at the beginning (see below)

ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng, color = species)) + geom_boxplot()

#mike showed me "jitter" which looks super-cool behind a boxplot!
ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng, color = species)) + geom_jitter() + geom_boxplot()
#changing colors
ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng, color = species)) + geom_jitter(color = "darkgrey") + geom_boxplot()

#with jitter, need to get rid of boxplot outliers otherwise you're plotting the same points more than once:
ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng, color = species)) + geom_jitter(color = "darkgrey") + geom_boxplot(outlier.size=0)
ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng, color = species)) + geom_jitter(color = "darkgrey") + geom_boxplot(outlier.shape=NA)

    #pretty colors with transparency = prettier AND more informative
ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng, color = species)) + geom_jitter(alpha = 1/3) + geom_boxplot(outlier.shape=NA) 

#time for facets!
ggplot(data = TomatoR2CSHL, mapping = aes(x=species,y=totleng, color = species)) +
  geom_jitter(alpha = 1/3) +
  geom_boxplot(outlier.shape=NA) + 
  facet_grid(who~trt) +
  labs(color="PLANTIES")
#^YAY! (remember to select all of the code and run @ once - otherwise you will not get anything)
