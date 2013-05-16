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
       #ugh - no bueno
       head(myR2)
       #the in-class version:
       mymov3 <- subset(x=movies, year>1990 & mpaa !="")
head(mymov3)       

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
      #finally:
       ggplot(data = mymov3, mapping = aes( x = year, fill = mpaa ) ) + 
         geom_density(alpha=.4) +
         labs(title="Density Distribution of MPAA Rated Films from 1990-2006") +
         theme(legend.position = "bottom")
       #theme has replaced opts (that's why the book talks about opts and they don't work)


#kaisa's fix for not knowing how to omit blanks as NA's: movies3 <- movies2[movies2$mpaa=="R" | movies2$mpaa=="PG" | movies2$mpaa=="PG-13" | movies2$mpaa=="NC-17", ] 

       
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
       
       ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum, label=species) ) + geom_text() + facet_grid( . ~ who) + labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS") 
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
       
       #using line break for clarity
       ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) ) +
         geom_text(aes(label=species)) +
         facet_grid( . ~ who) + 
         labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS") 
       
       #still infinite loop - works for Kaisa, not for me or Neelima. r u srs?!
       
       #let's try it in pieces like Mike suggests:
       basic <- ggplot(data = TomatoR2CSHL, mapping = aes( x = alt, y = hyp, color = trt, size=leafnum) )
       text <- geom_text(value=TomatoR2CSHL$species, aes(label=species)) 
       facet <- facet_grid( . ~ who) 
       labels <- labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS")       
       basic + facet + labels + geom_jitter() #this works, because it's not text
       
       
#let's do this again just for principle (ok - susan jumped in and it seems like it's the data frame and not the code. see below):
tom <- na.omit(TomatoR2CSHL)

ggplot(tom, aes(x = alt, y = hyp, color = trt, size = leafnum)) +
  geom_text(aes(label = species))+
  facet_grid( . ~ who) + 
  labs(x="ALTITUDE", y="HYPOCOTYL LENGTH", title="TOMATO DATA IN (THEORY) WORDS")

       
       #Trying Stacy's:
d <- ggplot(movies, aes(year,rating)) + opts(legend.position="density")
      d2<- d+stat_binhex() 
       d2 + scale_color_gradient(limit=c(.0025, .01), low="red", high = "white")
       #why doesn't this work?!
       
#the real answer:
       ggplot(movies)+
         stat_binhex(aes(x=year,
                     y=rating,
                     fill= ..density..),
       color = "black") +
         scale_fill_gradientn(colours=rainbow(7))
       
       
       
#Ok, let's try the next one! Cody's
       
       head(TomatoR2CSHL)
ggplot(TomatoR2CSHL, aes(leafwid, leafleng, color=who)) + geom_point() + geom_linerange(aes(ymin=0,ymax=5)) + labs(y="Leaf Length (mm)", x= "Leaf Width (mm)") 
       
# in class:
ggplot(TomatoR2CSHL, aes(leafwid, leafleng, color=who)) +
  geom_point() +
  geom_rug() +
  labs(y="Leaf Length (mm)", x= "Leaf Width (mm)") +
  theme(aspect.ratio=1)
       
       
       
       #Jessica's (she sits next to me, so WHEN I could not do it, she helped)
head(mpg)
       ggplot(mpg, aes(class,hwy, fill=manufacturer, color=manufacturer)) + geom_dotplot(stackdir="center", binaxis="y") + theme(aspect.ratio = .5, axis.text.x= element_text(angle=45))  

#trying jessica's just for funsies:       
       ggplot(mpg, aes(class,hwy, fill=manufacturer, color=manufacturer)) +
         geom_dotplot(stackdir="center", binaxis="y") + 
         theme(aspect.ratio = .5, axis.text.x= element_text(angle=45), legend.position = "bottom")
       
       
#PS - here's an explanation of aspect ratios
       p1 <- ggplot(TomatoR2CSHL, aes(leafleng, leafwid))
       p1 <- p1 + layer(geom = "point",
                        ylab  = "Leaf width",
                        xlab  = "Leaf length")+ 
                          geom_density2d() +
                          theme(aspect.ratio = 1)
       
       
#maps... 
       map <- get_map(location = c(lon = -75, lat = -16),
                      zoom     = 5,
                      maptype  = 'satellite')
       ggmap(map)
       
       #usage for the map thing shows different types of maps. e.g. "watercolor" - woo!
       
       ggmap(map) +
         geom_point(aes(x      = lon,
                        y      = lat,
                        colour = alt),
                    data = tom,
                    size = 2) +
                      facet_grid(. ~ species) +
                      scale_colour_continuous(low  = "white",
                                              high = "red")
       
       #other map:
       
       #just making a world map:
       world <- map_data("world")
       worldmap <- ggplot(world, aes(x     = long,
                                     y     = lat,
                                     group = group)) +
                                       geom_polygon(fill   = "white",
                                                    colour = "black")
       worldmap
       #with the tomato data
       worldmap +
         geom_point(aes(x     = lon,
                        y     = lat,
                        group = NULL),
                    data  = tom,
                    size  = 2,
                    color = "red")
       #group= NULL here because tomato data has no group (whereas map does, and it will try to use the default group=group and get upset)
       #other uses for world plots (MUHAHAHA):
       worldmap2<- ggplot(world, aes(x=long, y=lat, group=group, fill=region))+geom_polygon(colour="black")
       worldmap2 
       #pretty
       