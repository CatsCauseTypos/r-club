#2.2a Plot a box plot of intleng for each species in the data set

qplot( species, totleng, data=TomatoR2CSHL, color=trt, geom= "boxplot")


#2.2b use facets to make a separate plot for the two treatements

qplot( species, totleng, data=TomatoR2CSHL, color=species, geom= "boxplot", facets = who~trt)

#2.2c if your plots in 2.2b are arranged side by side, change them to be on top of one another.  If they are on top of one another, change them to be side-by-side
qplot( species, totleng, data=TomatoR2CSHL, color=species, geom= "boxplot", facets = trt~who)

# 2.3a You have a sneaking suspicion that there is a relationship between leaf width and leaf length. Make a plot showing how width varies as length changes.

T1 <- na.omit(TomatoR2CSHL)
head(T1)
qplot(leafwid, leafleng, data=T1, color=species, geom= c("smooth","point"), se=FALSE, method="lm", facets = trt~.)

# 2.3b Hmmmm. Looks like we are on to something; however, those axis labels look ugly. Change them to be more informative.

qplot(leafwid, leafleng, data=T1, color=species, xlab= "width of leaves (cm)", ylab="length of leaves (cm)",  geom= c("smooth","point"), se=FALSE, method="lm", facets = trt~.)

# 2.3c Do you think that leaf dimensions are correlated with petiole length? Change the color of the points based on petiole length.

qplot(leafwid, leafleng, data=T1, color=petleng, xlab= "width of leaves (cm)", ylab="length of leaves (cm)",  geom= c("smooth","point"), se=FALSE, method="lm", facets = trt~.)



# 2.3d It is a bit difficult to tell what's going on since brightness (rather than hue) seems to be the only thing changing. Use `scale_color_gradientn` or `scale_color_gradient2` to make the color scale use multiple colors (for example, red/darkgray/blue). See documentation at <http://docs.ggplot2.org/> for help on using these scales.

qplot(leafwid, leafleng, data=T1, color=petleng, xlab= "width of leaves (cm)", ylab="length of leaves (cm)",  geom= c("smooth","point"), se=FALSE, method="lm", scale_color_gradient("petiole length"), scale_color_gradient2(limits=c(40,30)))

qplot(leafwid, leafleng, data=T1, color=petleng, xlab= "width of leaves (cm)", ylab="length of leaves (cm)",  geom= c("smooth","point"), se=FALSE, method="lm") + scale_color_gradient("petiole length")

base_graph <- qplot(leafwid, leafleng, data=T1, color=petleng, xlab= "width of leaves (cm)", ylab="length of leaves (cm)",  geom= c("point", "smooth"), se=FALSE, method="lm") + scale_color_gradient("petiole length", limit=c(0,30), low="blue", high="red", na.value = "green") 

# 2.3e You have a talk coming up and you want to impress the audience by making your data look more complex. Use facets to separate the plots into a grid of leaf number by species subplots.
qplot(leafwid, leafleng, data=T1, color=petleng, xlab= "width of leaves (cm)", ylab="length of leaves (cm)",  geom= c("point", "smooth"), se=FALSE, method="lm", facets = species~leafnum) + scale_color_gradient("petiole length", limit=c(0,30), low="blue", high="red", na.value = "green")

#there aren't supposed to be NAs.... but i have green dots... =(

 
#2.4 Reproduce the plot in the attachment
qplot( int4, data=T1, color = trt, xlab= "Internode 4", ylab="count", facets = species~who, binwidth=.5)