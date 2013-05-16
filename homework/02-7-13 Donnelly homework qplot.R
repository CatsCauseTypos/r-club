#2.2a Plot a box plot of intleng for each species in the data set

qplot( species, totleng, data=TomatoR2CSHL, color=trt, geom= "boxplot")


#2.2b use facets to make a separate plot for the two treatements (and labeing legend)

qplot( species, totleng, data=TomatoR2CSHL, color=species, geom= "boxplot", facets = who~trt) + labs(color = "PLANTIES")



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
summary(T1$leafnum)
#there aren't supposed to be NAs.... but i have green dots... =(
tapply(T1$leafnum, list( T1$species), summary)

#2.4 Reproduce the plot in the attachment
qplot( int4, data=T1, color = trt, xlab= "Internode 4", ylab="count", facets = species~who, binwidth=.5)

# I have no idea why it's black with colored trim, but it looks cool and I want to know how to get it to do that on purpose.
# i should've used "fill" not "color"
qplot( int4, data=T1, fill = trt, xlab= "Internode 4", ylab="count", facets = species~who, binwidth=.5)



#2.5 Reproduce the plot in the file "PastedGraphic-3.pdf"

qplot( main= "Yet Another Graph", petleng, geom = ("density"), data=T1, color = who, xlab= "Petiole Length (mm)", ylab="density", facets = date~species)



# Read chapter 3.  It is a little abstract but I think it is worth starting to become familiar with these terms.
#Execute the chapter 3 code.
qplot(displ, hwy, data = mpg, colour = factor(cyl))

#good to know:
# Named plot  Geom	Other features
# scatterplot	point
# bubblechart	point	size mapped to a variable 
# barchart	bar 
# box-and-whisker plot boxplot 
# line chart	line

qplot(displ, hwy, data = mpg, colour = factor(cyl), geom=c("smooth", "point"), method = lm)

#I got half way through section 3.4 and they stopped speaking english =/

#Answer the following questions, using 1 - 2 sentences each:

#3.1 Define aesthetics as they are used in ggplot2.

#attributes are called aesthetics; almost anything can be thought of as an aesthetic: a horizontal position, a vertical position, a size of a line or point, a color and a
#shape. these are things that can be seen on the graph. Each aesthetic can be either a variable or a constant.

#3.2 What does it mean to "map" an aesthetic?

# it just means defined by ("the horizontal position maps to displ" just means that the x-axis relates to displ )

#3.3 Explain scales as they relate to data and aesthetics

#changing stuff from data units (e.g., litres, miles per gallon and number of cylinders, hwy) to physical units (e.g., pixels and colours) that the computer can display. 

#3.4 What are geoms? email the above to me and Mike, include your name in the filename of any attached files.
#"geoms" determine the way the graph looks (histograms, scatterplots, etc)