    #Ciera's
#checking data
head(movies)

#so when I tried to jump right in, I did this.. .which is also wrong (even though I went through many iterations):
ggplot(data = mymovies, mapping = aes( x = mpaa, y = density$year, color = mpaa ) ) + geom_quantile()
ggplot(data = movies, mapping = aes(x=year, y=mpaa, ylab="density", color = mpaa) + geom_smooth(method=x)
       

#visualizing data
qplot(mpaa, year, data=movies)
#trying color
qplot(mpaa, year, data=movies, color=mpaa)

#subset of data..
mymovies <- subset(x=movies, year>1990)

head(mymovies)
#whew~

#total:
length(mymovies)
#24

#separate ratings:
myR <- subset(x=mymovies, mpaa=R, omit.na=TRUE,)
      #trying to get rid of blanks in mpaa - not working HELP!
       myR2 <- subset(x=mymovies, omit.na=TRUE, !all(is.na(movies$mpaa)))
       #ugh
       head(myR2)
       
       
length(myR)  
#well, that's not good. 24 R-rated movies? I think not.
length(movies)
#also 24...
head(movies)
#there are 24 categories in movies. ugh. but I know I actually got mymovies to = 1990 and higher year...

head(myR)
#but I did not get the ratings to sort. 

#ok - so number of movies is actually..
nrow(mymovies)
#23,577

#after adding omit NA = 22678

#then someone told me there's a density FUNCTION - that sounds better... let's ask the internet.

density(mymovies[year])
#yeah, that doesn't work; that's perl.

d<-density(mymovies$year)
#okay
d

qplot(mpaa, density(mymovies$year), data=mymovies)
#nothing but errors. sweet!


qplot(mpaa, year, data=mymovies) 
#thank goodness this works

#ok... so it makes a graph... but density and I cannot work out our issues:
ggplot(data = mymovies, mapping = aes( x = year, y = mpaa, color = mpaa ) ) + geom_jitter()

#how do i get the lines? chp 4 has cool lines using geom lines    
ggplot(data = mymovies, mapping = aes( x = year, y = rating, color = mpaa ) ) + geom_jitter() + geom_line(na.rm=TRUE)
#oh... that is Not the same

       #after begging mike for help: there's a graph, like a histogram, that does density... so all that 1d kernel stuff i did earlier 
ggplot(data = mymovies, mapping = aes( x = year, color = mpaa ) ) + stat_density()   
       
       ggplot(data = mymovies, mapping = aes( x = year, fill = mpaa ) ) + geom_density(alpha=.3)       
       ggplot(data = myR2, mapping = aes( x = year, fill = mpaa ) ) + geom_density(alpha=.3)
       

#kaisa's fix for not knowing how to omit blanks as NA's

       
       #let's try miguel's 
       ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt ) ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH",)   
       #so that makes a plot
ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt ) ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH") + scale_shape_manual(TomatoR2CSHL$species) 
#that does not
       
ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt), scale_size=leafnum ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH") + scale_size_manual(values = TomatoR2CSHL$leafnum, breaks = c("1","2"))
#nor does this nor several dozen iterations        -- apparently scaling is just not doing what i thought it was

ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS")
#thank goodness something finally worked
       
ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS")
       

ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum, alpha=species) ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS")
       #oh yeah.. alpha is transparency; dang
      
       #begging mike for help got me geom_text ... 
       ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS") + geom_text()       
       
       ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum, label=species) ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS") + geom_text()
       #that MAKES A LOOPING ERROR OF DOOM
       
ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) ) + geom_jitter() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS") + geom_text(value=TomatoR2CSHL$species, aes(label=species))
                  #this works for Kaisa and not me???????????????
       
#let's try the example:
ggplot(mtcars, aes(x=wt, y=mpg, label=rownames(mtcars))) + geom_text()
head(mtcars)
       #why would they use a function (rownames) as an example?!
       ggplot(mtcars, aes(x=wt, y=mpg, label=cyl)) + geom_text()
       #but that works...
       
ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) ) + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS") + geom_text(aes(label=species))
#also DOOM LOOP
       #ok. I give. 
       ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) ) + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS") + geom_text(aes(label=species))       
       
#let's do this again
ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) ) +
       geom_text(value=TomatoR2CSHL$species, aes(label=species)) +
       facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS") 
       #still infinite loop - works for Kaisa, not for me or Neelima. r u srs?!
       

       #Trying Stacy's:
d <- ggplot(movies, aes(year,rating)) + opts(legend.position="density")
      d2<- d+stat_binhex() 
       d2 + scale_color_gradient(limit=c(.0025, .01), low="red", high = "white")
       #why doesn't this work?!
       
#Ok, let's try the next one! Cody's
       
       head(TomatoR2CSHL)
ggplot(TomatoR2CSHL, aes(leafwid, leafleng, color=who)) + geom_point() + geom_linerange(aes(ymin=0,ymax=5)) + labs(y="Leaf Length (mm)", x= "Leaf Width (mm)") 
       
       #Jessica's (she sits next to me, so WHEN I could not do it, she helped)
head(mpg)
       ggplot(mpg, aes(class,hwy, fill=manufacturer, color=manufacturer)) + geom_dotplot(stackdir="center", binaxis="y") + theme(aspect.ratio = .5, axis.text.x= element_text(angle=45))  

#PS - here's an explanation of aspect ratios
       p1 <- ggplot(TomatoR2CSHL, aes(leafleng, leafwid))
       p1 <- p1 + layer(geom = "point",
                        ylab  = "Leaf width",
                        xlab  = "Leaf length")+ 
                          geom_density2d() +
                          theme(aspect.ratio = 1)
       