#4-18-13
# start with a data frame, go through ply, get a data frame out; start with "a" -> ply -> "a" 
#if there's an underscore, it means whatever function in "ply" was used, it spit out the function done to the "a" you put in.... maybe (not sure I understand)

#d_ply() d is saying, "I am using a data frame"
#d_ply(tomato #data or thingy to use,.(who) #how to split it, function(x)#what function to use on it)
#
head(E)
?head
#reg head
head(mtcars)
#for one row
head(mtcars,1)

#head is not a function?
d_ply(mtcars, .(mpg), head(mtcars,1))

#does nothing because we didn't tell it to print and _ will only give you what you told it to give you.
d_ply(mtcars, .(mpg), function(x) head(x,1))

#gives everything, split by mpg.
ddply(mtcars, .(mpg), function(x) head(x,1))

Q <- TomatoR2CSHL

#make a new column with the mean of the leaf width divided by the leaf length for each species AND each measurer!

R<- (ddply(Q, .(species,who), transform, len_wid = mean(leafwid / leafleng)))
#original data set, un harmed
head(Q)
#new data set has a new column with all the means printed in it.
head(R)
View(R)
#from http://plyr.had.co.nz/09-user/
bnames <- read.csv("~/Desktop/R club/data sets/plyr-tutorial/examples/bnames.csv")

#there were boys named Susan until 1968 when Shel Silverstein wrote the poem that Johnny Cash turned into A Boy Named Sue

#from bnames-explore.r:
# Whole dataset transformations ---------------------------------------------
letter <- function(x, n = 1#position in the name you want the letter back; we want the first letter (-1 would be last letter as following if loop sets up)) {
  if (n < 0) #e.g. we want to start at the back{
    nc <- nchar(x) #number of characters in the name
    n <- nc + n + 1 #equation to make it start at the back of the name based on simple n's
  }
  tolower#if it's a capital letter, return a lower case 
                   (substr(x #name, n #start substring, n #end substring))
}
vowels <- function(x) {
  nchar(gsub#global substitution ("[^aeiou]", "", x)) #changes NON MATCHING CHARACTERS to nothing. leaves vowels alone
        
}

bnames <- transform(bnames,
                    first = letter(name, 1),
                    last = letter(name, -1),
                    length = nchar(name),
                    vowels = vowels(name)
)

###########

#"challenge : plot by year, proportion of children who have a name in the top 100. 
# me
head(bnames)

top <- (ddply(bnames, .(name), transform, totpercent = sum(percent)))
head(top)
View(top)

sum(bnames$percent) # 230.7736
tippy <- (ddply(top, .(name), transform, totpercentall = (totpercent / 230.7736 )))

View(tippy)