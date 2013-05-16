#first, let's get rid of movies without mpaa's and without ratings:
mymov3 <- subset(x=movies, year>1990 & mpaa !="")

ggplot(data = mymov3, mapping = aes( x = year, fill = mpaa ) ) + 
  geom_density(alpha=0.4) +
  labs(title="oh for heaven's sakes") +
  theme(legend.position = "bottom")
#good.

#remembering what's there:
head(movies)
#Mike C's recommendation to check what's there:
names(movies)

#if I want to watch a funny animated movie with my college friends OR my friends' kids which has been highly rated:
ggplot(data = mymov3, mapping = aes( x = year, fill = mpaa ) ) + 
  geom_density(alpha=0.4) +
  labs(title="Excellent Animated Comedies Appropriate for Kids or Adults" ) +
  theme(legend.position = "bottom") +
  facet_grid(Comedy~Animation)

#that 1/0 crap is not useful for categories...

#Mike C's method of getting the titles to have meaning:

mymov3$Comedy2 <- factor(mymov3$Comedy, labels = c("Not Funny", "Hilarity Ensues"))
mymov3$Animation2 <- factor(mymov3$Animation, labels = c("Real Humans", "Drawn Together"))
mymov3$rating2 <- round(mymov3$rating)



# ? mymov3$rating2 <- c(1, 3, 4)

# mymov3$rating2 <- as.factor(mymov3$rating2)

#trying out mike c's labels...
ggplot(data = mymov3, mapping = aes( x = year,  fill = mpaa, linetype = as.factor(rating2) ) ) + 
  geom_density(alpha=0.4) +
  labs(title="Excellent Animated Comedies Appropriate for Kids or Adults" ) +
  theme(legend.position = "bottom") +
  facet_grid(Comedy2~Animation2)
#ok, but what's the error from? and what does it mean? and why are there dotted lines and no more animated comedies?

#i have no idea how to proceed.
#I wanted to make a visual representation of what my best google search criteria would be for a good animated comedy that was age-appropriate for a wide variety of audiences (e.g. me and college frieds vs children)
#from this graph I could deduce what years had the highest densities of highly regarded movies in those areas. 

#questions:
#Describe (in your own words) the different purposes of layers in a ggplot.
#Layers are supposed to allow a lot of flexibility in graphing and a streamlined organization. Layers enable customization of everything individually. 

#Woe is me, I have too much data and my plots are overwhelming to look at. Give me 7 tips (in your own words) for dealing with my problem.
#smaller points, hollow (vs filled) things, transparency, jitter, colors, use bins, fracturing the graph (those cool hexagons)






#Susan / Sharon to the rescue!


ggplot(data = mymov3, aes( x= as.factor(rating2), y = mpaa, color= as.factor(year))) +
  geom_jitter() +
  facet_grid(Comedy2~Animation2) +
  theme(legend.position = "bottom") +
  scale_colour_hue(h.start= 5)
  
