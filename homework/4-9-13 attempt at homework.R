# 4-9-13 attempt at homework from 4-4-13

#import the new data set:
ELF3s_bolting_Rclub <- read.csv("~/Desktop/R club/data sets/ELF3s_bolting_Rclub.csv")
   View(ELF3s_bolting_Rclub)

#Q1 : What data types are represented in each column?

class(ELF3s_bolting_Rclub)

head(ELF3s_bolting_Rclub)

summary(ELF3s_bolting_Rclub)
#^that's the one!

#Plant, diameter, treatment, genotype, transformation and column are factors. #flat, row, flowering time, and n leaves are numbers. 

#Ciera suggested "str()"

str(ELF3s_bolting_Rclub)

#Q2 a) Are there any columns that you think have the wrong data type? b) Which ones? c) Why?
#Yes; diameter, flat, and row are wrong. diameter is not a factor and row is not a measurement!

#Q3 How would you change the columns to their correct types?
#first, make a copy of the data so as not to mess up the original 
ELF<-(ELF3s_bolting_Rclub)
#then, try to convert the flat into a factor while removing pesky na values
ELF$flat<-(as.factor(ELF$flat, na.rm=TRUE))
#error message. ok... I might need help with this in person. 
ELF$flat<-(as.factor(ELF$flat))
str(ELF)
#what if I got rid of na values first..
ELF1<-(ELF3s_bolting_Rclub, na.rm=TRUE)

#search for them?
any(is.na(ELF3s_bolting_Rclub))
#are any of these true? it says, "FALSE" so that means there are NO NA values
#julin:
?read.csv
#na.strings will allow you to tell R what in the data is an NA value (e.g.A for absent value can be transformed into NA )

#Are there any obvious mistakes in this data frame beyond what you might have found in answering Q3?
head(ELF3s_bolting_Rclub)
#looks okay?
summary(ELF3s_bolting_Rclub)
#there are 0 leaves somewhere

sum(ELF3s_bolting_Rclub$n_leaves==0)
#find out how many 0 leaves there are... is it a data entry error or one crazy sample?
ELF3s_bolting_Rclub[ELF3s_bolting_Rclub$n_leaves==0,] #this is how we find the row

ELF3s_bolting_Rclub <- ELF3s_bolting_Rclub[ELF3s_bolting_Rclub$n_leaves!=0,] #new data set should have only those rows whose n_leaf doesn't = zero

ELF3s_bolting_Rclub[ELF3s_bolting_Rclub$n_leaves==0,] <-NA #this is one way to eliminate it




#if all the "0" cells in ELF3 should be NA

ELF3no0 <- ELF3s_bolting_Rclub

ELF3no0[ELF3no0==0] <- NA
#so this is replacing all of the cells which contain 0 with NA 

any(ELF3no0==0,na.rm=T)
#this is checking if there are 0 values left, BUT if there's an NA, the computer is all "uuh, I dunno: NA" because it COULD be a 0. it's not NOT a zero. 



#Q5 Make the "Sha" genotype the reference level for the genotype column
#asked the internet...
ELF$genotype <- relevel(ELF$genotype, ref="Sha")

head(ELF)
#looks the same...
str(ELF)

#Q6 Change order of levels in trasformation to Sh1, Sh2, Sh3, Ba1, Ba3
#asked internet...
#df$letters <- reorder(df$letters, new.order=letters[4:1])

ELF$transformation <- reorder(ELF$transformation, new.order=transformation["Sh1","Sh2","Sh3","Ba1","Ba3"])
#error I do not understand. help in RL
#attempting to build a simple data frame to use as an easy example

animals <-c("cat","dog","bird","reptile")

animals

myframe<-data.frame(favorite=1:4, pets = factor(animals))

myframe

#yay!

with(myframe, as.numeric(pets)) 
#this is alphabetizing 

myframe$pets <- factor(myframe$pets, levels=animals)
myframe
with(myframe, as.numeric(pets)) 
#it definitely changed the "levels" and didn't mess up the data frame. it still seems a little like magic.


ELF$transformation <- factor(ELF$transformation, levels=transformation["Sh1","Sh2","Sh3","Ba1","Ba3"])
#nope
ELF$transformation <- factor(ELF$transformation, levels=("Sh1","Sh2","Sh3","Ba1","Ba3"))
#nope
transformation<-c("Sh1","Sh2","Sh3","Ba1","Ba3")
ELF$transformation <- factor(ELF$transformation, levels=transformation)
#no error!!!
with(ELF3s_bolting_Rclub, as.numeric(transformation))
with(ELF, as.numeric(transformation))
#ok... it's definitely different than the orginal... but I have no idea if it's what I was supposed to do. help!

#Reshape
#import tomato data:
TomatoR2CSHL <- read.csv("~/Desktop/R club/data sets/TomatoR2CSHL.csv")
#read http://mfcovington.github.io/r_club/resources/2013/03/28/Reshape/
#get confused.
#read chp 9.2
#continue confusion

#attempt exercises anyhow.

#Q7 What are the id variables and measure variables in the Tomato data set?

T<-TomatoR2CSHL
head(T)
T<-na.omit(T)
T
#ID variables = shelf, flat, col, row, accession, treatment, days, date, lat, long, alt, species, who, leaf number
#measure variables = hypocotyl, internodes 1-4, int length, total length, petiole length, leaf length, leaf width, ndiv?,  

#Q8 Subset the tomato data set to keep the int1-int4 measurements and the relevant metadata.
head(T)
IntT<- T[,c(1:8,10:13,19:25)]

head(IntT)
#holy cow, I think that worked.

#Q9 Without melting or casting your new data frame, calculate the mean of each internode. Hint: use apply()
mean(IntT$int1)
#works!
mean(c(IntT$int1, IntT$2))
#nope
mean((IntT$int1, IntT$int2))
#nope
mean(IntT$[int1:int2])
#nope
mean(IntT$int1)
mean(IntT$int2)
mean(IntT$int3)
mean(IntT$int4)
#i bet there's a faster way, but I have no idea how to use apply to get the mean of a column in a more efficient way. help

#Q10 Melt the new data frame.
#select reshape and reshape2 (just in case)
head(IntT)
#long <- melt(wide, id.vars = "plate")
LongIntT <- melt(IntT, id.vars="species","who","acs")
head(LongIntT)
#works!
LongIntT2 <- melt(IntT, id.vars="species","who","acs","leafnum","date","trt","row","alt","lat","lon","ndiv","shelf","flat","col","row", "days", na.rm=TRUE)
#error - help
LongIntT3<-melt(IntT, measure.vars=c("int1","int2","int3","int4" ))
head(LongIntT3)
# maybe that's ok? help

#Q11 Use cast to obtain the mean for each internode.
?cast
#example provided by the hlp for cast with provided data
airquality

aqm<-melt(airquality, id=c("Month","Day"), na.rm=TRUE)

head(airquality)
head(aqm)
#omg it worked.

acast(aqm, Day~Month~variable)
#I have no idea what that did. help

#Q12 Use cast to obtain the mean for each internode for each species.
acast(LongIntT3, species~mean(LongIntT3$int1))

# help !

acast(LongIntT3, species~mean(LongIntT3$int1)~mean(LongIntT3$int2)~mean(LongIntT3$int3))
#weird - same as int1 so must be something wrong. help

#Q13 Use cast to obtain the mean for each internode for each species under each treatment.
# help

#Q14 Create a boxplot for each combination of species, internode, and treatment.
# help