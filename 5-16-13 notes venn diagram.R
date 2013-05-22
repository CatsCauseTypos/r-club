library(VennDiagram)

#Miguel's suggested venn creator = http://www.cmbi.ru.nl/cdd/biovenn/

#exercisese from github
#1
grid.newpage()
venn.plot <- draw.pairwise.venn(100, 70, 30, c("First", "Second"))
grid.draw(venn.plot)


#2
grid.newpage()
venn.plot <- draw.pairwise.venn(area1        = 100,
                                area2        = 70,
                                cross.area   = 68,
                                scaled       = T,
                                category     = c("First", "Second"),
                                fill         = c("blue", "red"),
                                alpha        = 0.3,
                                lty          = "blank",
                                cex          = 2,
                                cat.cex      = 2,
                                cat.pos      = c(285, 105),
                                cat.dist     = 0.09,
                                cat.just     = list(c(-1, -1), c(1, 1)),
                                ext.pos      = 30,
                                ext.dist     = -0.05,
                                ext.length   = 0.85,
                                ext.line.lwd = 2,
                                ext.line.lty = "dashed")
grid.draw(venn.plot)

#3
grid.newpage()
venn.plot <- draw.triple.venn(65, 75, 85, 35, 15, 25, 5, c("First", "Second", "Third"))
grid.draw(venn.plot)

#4
grid.newpage()
venn.plot <- draw.triple.venn(area1    = 65,
                              area2    = 75,
                              area3    = 85,
                              n12      = 35,
                              n23      = 15,
                              n13      = 25,
                              n123     = 5,
                              category = c("First", "Second", "Third"),
                              cat.pos  = c(0, 40, 250),
                              cat.dist = c(0.05, 0.05, 0.05),
                              fill     = c("blue", "red", "green"),
                              alpha    = 0.3,
                              lty      = "blank",
                              cex      = 2,
                              cat.cex  = 2,
                              cat.col  = c("blue", "red", "green"))
grid.draw(venn.plot)

# #Exercise 5: Now that you have a sense for how the package works,
# load the 'mtcars' dataset from the ggplot2 package. 
# Generate at least one two-way and one three-way 
# Venn diagram comparing different automobile traits.




#start by copying one that worked
#remember what is in mtcars:
head(mtcars)

k<-mtcars[order(mtcars$mpg), ] #susan reminds how to order

#let's say we want to compare cars which have less than 20mpg and cars with 6 cylinders 

#first, get only cars which have less than 20mpg:
mpg20 <- subset(mtcars, mpg<20) #subset
l #yay
m<- unique(rownames(mpg20)) #get just their names. since the "car names" are not "titled", they are the actual names of the rows = rownames
# the actual number of cars with <20mpg
length(m)     

#Now, cylinders = 6 
cyl6<- subset(mtcars, cyl>=6)
cyl6
m2<- rownames(cyl6)
length(m2)

#see how many overlap:
length(intersect(m,m2))

grid.newpage()

venn.cars <- draw.pairwise.venn(area1        = 18,
                                area2        = 21,
                                cross.area   = 18,
                                scaled       = F,
                                category     = c("mpg<20", "cyl> or =6"),
                                fill         = c("purple", "green"),
                                alpha        = 0.3,
                                lty          = "blank",
                                cex          = 2,
                                cat.cex      = 2,
                                cat.pos      = c(285, 105),
                                cat.dist     = 0.09,
                                cat.just     = list(c(-1, -1), c(1, 1)),
                                ext.pos      = 30,
                                ext.dist     = -0.05,
                                ext.length   = 0.85,
                                ext.line.lwd = 2,
                                ext.line.lty = "dashed")

#time for a three way


mpg21 <- subset(mtcars, mpg>20) #subset
m3<- rownames (o)
length(m3) #14

length(intersect(m,m2)) #18
length(intersect(m2,m3)) #3
length(intersect(m,m3)) #0
m4<-intersect(m,m2)

length(intersect(m4,m3))

grid.newpage()

venn.car.triple <- draw.triple.venn(area1    = 18,
                              area2    = 21,
                              area3    = 14,
                              n12      = 18,
                              n23      = 3,
                              n13      = 0,
                              n123     = 0,
                              category = c("mpg>20", "cyl>=6", "mpg<20"),
                              cat.pos  = c(0, 40, 250),
                              cat.dist = c(0.05, 0.05, 0.05),
                              fill     = c("blue", "red", "green"),
                              alpha    = 0.3,
                              lty      = "blank",
                              cex      = 2,
                              cat.cex  = 2,
                              cat.col  = c("blue", "red", "green"))

# Exercise 6: Write a function that allows you to generate a 
# three-way Venn diagram without first manually calculating the 
# sizes of the various groups and overlaps.
# 
# Hint: You will likely need to use functions described in the setdiff help page to do this.
# 
# Bonus point: If you can figure out how
# to write the function so that you don't
# have to manually input the category names 
# each time you run it, you get a gold star for the day.

?setdiff
#so you have to make a function to calculate the lengths and then the intersections and name them the same as the variables in the venndiagram plot thingy

threeway <- function(A,B,C) { 
  area1 <- length(A)
  area2 <- length(B)
  area3 <- length(C)
  n12 <- length(intersect(rownames(A),rownames(B)))
  n23 <- length(intersect(rownames(B),rownames(C)))
  n13 <- length(intersect(rownames(A),rownames(C)))
  n123 <- length(intersect((intersect(rownames(A),rownames(B))), rownames(C)))
  grid.newpage()
venn.plot <-  draw.triple.venn(
                   area1    = area1,
                   area2    = area2,
                   area3    = area3,
                   n12      = n12,
                   n23      = n23,
                   n13      = n13,
                   n123     = n123,
                   category = c("A", "B", "C"),
                   cat.pos  = c(0, 40, 250),
                   cat.dist = c(0.05, 0.05, 0.05),
                   fill     = c("blue", "red", "green"),
                   alpha    = 0.3,
                   lty      = "blank",
                   cex      = 2,
                   cat.cex  = 2,
                   cat.col  = c("blue", "red", "green"));
grid.draw(venn.plot);  
}

threeway(mpg20,cyl6,mpg21)
length(intersect(rownames(mpg20),rownames(cyl6)))

## stacey try

threeway <- function(A,B,C) { 
  area1 <- length(A)
  area2 <- length(B)
  area3 <- length(C)
  n12 <- length(intersect(rownames(A),rownames(B)))
  n23 <- length(intersect(rownames(B),rownames(C)))
  n13 <- length(intersect(rownames(A),rownames(C)))
  n123 <- length(intersect((intersect(rownames(A),rownames(B))), rownames(C)))
  grid.newpage()
  venn.car.triple <- draw.triple.venn(area1    = area1,
                                      area2    = area2,
                                      area3    = area3,
                                      n12      = n12,
                                      n23      = n23,
                                      n13      = n13,
                                      n123     = n123,
                                      category = c("mpg>20", "cyl>=6", "mpg<20"),
                                      cat.pos  = c(0, 40, 250),
                                      cat.dist = c(0.05, 0.05, 0.05),
                                      fill     = c("blue", "red", "green"),
                                      alpha    = 0.3,
                                      lty      = "blank",
                                      cex      = 2,
                                      cat.cex  = 2,
                                      cat.col  = c("blue", "red", "green"))
  grid.draw(venn.car.triple);  
}
