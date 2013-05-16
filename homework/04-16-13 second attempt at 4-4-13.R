# 4-16-13 second attempt at homework from 4-4-13

OMG <- read.csv("~/Desktop/R club/data sets/ELF3s_bolting_Rclub.csv")

#Q1 : What data types are represented in each column?
#Q2 a) Are there any columns that you think have the wrong data type? b) Which ones? c) Why?
#Yes; diameter, flat, and row are wrong. diameter is not a factor and row is not a measurement!

#Q3 How would you change the columns to their correct types?
#Are there any obvious mistakes in this data frame beyond what you might have found in answering Q3?
str(OMG)
OMG$flat<-(as.factor(OMG$flat))
OMG$row<-(as.factor(OMG$row))
OMG$diameter<-(as.numeric(as.character(OMG$diameter)))

omg <- unique(OMG)
str(omg)
summary(omg)
any(omg$n_leaves==0)

#isolate row
omg[omg$n_leaves==0,]

lol <- (omg[omg$n_leaves!=0,])
str(lol)
summary(lol)

#Q5 Make the "Sha" genotype the reference level for the genotype column
lol$genotype <- relevel(lol$genotype, ref="Sha")

head(lol)
#no obvious difference in head
str(omg)
str(lol)
#using str, it has reordered them... that's probably what I was supposed to do, right?

#Q6 Change order of levels in trasformation to Sh1, Sh2, Sh3, Ba1, Ba3

transformation<-c("Sh1","Sh2","Sh3","Ba1","Ba3")

lol$transformation <- factor(lol$transformation, levels=transformation)
lol[lol$transformation=="Sh1",]
# 4   Sh1.B3.1h    39.41        7             25         h      Sha            Sh1    1   B   3
# 5   Sh1.G1.1h    42.14        7             25         h      Sha            Sh1    1   G   1
# 16  Sh1.A3.1h    38.66       11             31         h      Sha            Sh1    1   A   3
# 17  Sh1.F3.1h    40.72       11             34         h      Sha            Sh1    1   F   3

omg[omg$transformation=="Sh1",]
#definitely the same rows... so that's good - nothing got reassigned by accident

# help - how do I know the order was changed?

#Reshape
#import tomato data:
Cesil <- read.csv("~/Desktop/R club/data sets/TomatoR2CSHL.csv")
#read http://mfcovington.github.io/r_club/resources/2013/03/28/Reshape/
#read chp 9.2

#Q7 What are the id variables and measure variables in the Tomato data set?
#ID variables = shelf, flat, col, row, accession, treatment, days, date, lat, long, alt, species, who, leaf number
#measure variables = hypocotyl, internodes 1-4, int length, total length, petiole length, leaf length, leaf width, ndiv?,  
Cesil <- na.omit(Cesil)
#Q8 Subset the tomato data set to keep the int1-int4 measurements and the relevant metadata.
Cochella<- Cesil[,c(1:8,10:13,19:25)]
head(Cochella)

#Q9 Without melting or casting your new data frame, calculate the mean of each internode. Hint: use apply()
means <- c(mean(Cochella$int1), mean(Cochella$int2),mean(Cochella$int3),mean(Cochella$int4))
means
?apply
wtf<- Cochella[,9:12]
head(wtf)
apply(wtf,c(1,2) , mean)

# help

#Q10 Melt the new data frame.
long <- melt(Cochella, id.vars="species","who","acs")
head(long)
head(Cochella)
View(Cochella)
View(long)
#totally messed up: help

#Q11 Use cast to obtain the mean for each internode.
#Q12 Use cast to obtain the mean for each internode for each species.
#Q13 Use cast to obtain the mean for each internode for each species under each treatment.
# help
#Q14 Create a boxplot for each combination of species, internode, and treatment.
# help