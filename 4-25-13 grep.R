#4-25-13 R-club, searching
#grep(pattern (what to search for), text (where to search)

#so in the example, we want the d. - because that indicates a bin. So Julin has written: grep("^d\\.", colnames(data2), value = T) 

#search and replace is the "sub" function, data2$chromosome# <- sub("IL([0-9]+)\\..*","\\1",data2$X))

#character classes. \\w = all word characters, \\s is all space characters, \\d is all decimal characters


#using the info from R-club website...

#http://mfcovington.github.io/r_club/exercises/2013/04/21/Text-Searches-Regular-Expressions/

# for example: which state names have 'i' in them?

data(state)

state.name
#??

# in its basic form, grep returns the position (index) of the items that match the pattern.
grep(pattern != "i", x = state.name, ignore.case = T)

# you can also ask grep to return the values that match
grep(pattern = "i", x = state.name, ignore.case = T, value = T)

#The variant grepl() returns a logical vector of TRUE and FALSE indicating whether or not a match occurred.

grepl(pattern = "i", x = state.name, ignore.case = T)
# recalling that TRUE = 1 and FALSE = 0, when can use grepl to quickly determine the number of states that have 'i' in them.
sum(grepl(pattern = "i", x = state.name, ignore.case = T))

#Exercise 1: Can you figure out how to count the number of states that do not have an i in their name (without changing the search pattern)?
#There are at least two easy ways.
sum(grepl(pattern != "i", x = state.name, ignore.case = T)) #this does not work... Julin tried to explain it, but ???

sum(!grepl(pattern = "i", x = state.name, ignore.case = T)) #palmer figured this out
?grepl
#so grepl is returning trues and falses, and any function that does that can be inverted by using the !grepl

#Use match() when you have two sets of values (lets call them Set A and Set B) and you want to know the (first) positions in Set B that match something that is in Set A. Match only finds exact matches and can not be used with regular expressions.

# we have a list of favorite fruits AND a list of citrus.  Which of the favorites are citrus?
favorites <- c("peach", "banana", "blueberry", "orange", "plum", "strawberry", "mandarin")
citrus <- c("kumquat", "grapefruit", "orange", "mandarin", "orange", "tangerine","tangelo", "lemon", "lime")
match(favorites, citrus) 
#what do the numbers returned refer to?
#the position of the fruit in the favorite list

#Match has an alternative form which I find more convenient: %in%.
#This form returns Trues or Falses indicating whether or not Set A is in Set B.
favorites %in% citrus
# most useful is to use this in combination with square brackets to extract
favorites[favorites %in% citrus]

#it's kinda like: favorites[1]
#sub() performs text substitutions. Think of it as find and replace.
# lets say that we wanted to replace 'W' with the phrase '_DoubleU_'
sub("w", "_DoubleU_", state.name, ignore.case = T)

#Excerise 2: Try replacing all of the is with ys. Are results what you expected? Why or why not?
sub("is", "ys", state.name, ignore.case = T)

#sub() only replaces the first occurrence of pattern. gsub() will replace all occurrences.
gsub("i", "y", state.name, ignore.case = T)
# compare to just using sub()
sub("i", "y", state.name, ignore.case = T)
#Regular expressions (regexp) are a way of specifying wild cards in the search operations described above. The same syntax (with some modifications) is used in many computer languages including Unix/Linux command line tools, Perl, python, and very helpfully SublimeText2.

# Character classes I
# 
# Regexp have codes to match certain classes of characters.
# 
# . Matches any single character
# \w Matches any character that would be found in a "word" including digits (excludes punctuation and white space)
# \W Is the opposite of \w and matches any non-word character
# \d Matches any digit character
# \D Matches any non-digit character
# \s Matches any white space character
# \S Matches any non space character
# The following match specific characters or locations but are worth mentioning here:
#   
#   ^ Matches the beginning of a line
# $ Matches the end of a line
# \t tab character
# \n return character
# Unless you use additional modifications described below, these match a single character.

#How would we find state names that have two a's separated by a single additional character?
data(state)
grep("a.a", state.name, value = T, ignore.case = T)

#Exercise 3: Find state names that have a space in their names.
grep("\\s", state.name, value = T, ignore.case = T)

#Exercise 4: Find state names that begin with M
grep("^M", state.name, value = T, ignore.case = F)

# Character classes II
# 
# An alternative way of specifying character classes is to enclose them in square brackets.
# 
# For example, to find all of the state names that end with a vowel:

grep("[aeiou]$", state.name, value = T)

#The ^ sign inside of square brackets inverts the search.

#Exercise 5: Find state names that begin with non-vowels.

grep("^[^aeiou]", state.name, value = T, ignore.case=T)

# You can specify ranges of characters inside square brackets:
# [0-9] : all digits
# [a-j] : the first 10 (lowercase) letters of the alphabet
# There are also a number of predefined character classes. For example:
#   [:punct:] Punctuation characters: ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~.
# 
# See ?regex for additional classes.
# 
# Perhaps confusingly these classes must themselves be placed within square brackets
grep("[[:space:]]", state.name, value = T)

# Specifying repeats
# 
# You can specify the number of times that a character or character class is repeated. ? The preceding item is optional and will be matched at most once.
# 
# * The preceding item will be matched zero or more times.
# + The preceding item will be matched one or more times.
# {n} The preceding item is matched exactly n times.
# {n,} The preceding item is matched n or more times.
# {n,m} The preceding item is matched at least n times, but not more than m times.

#Exercise 6: Find the state names that have two consecutive vowels in them.

grep("[aeiou]{2}", state.name, value = T)
#gives Hawaii 

grep("[aeiou]{2,2}", state.name, value = T, ignore.case=T)
#still gives Hawaii - so, turns out....
# the little function is going "does it match? YUP! ON THE LIST!!" and the "ai" matches, so it goes on the list. Doesn't matter that there's an i after ai, because we didn't specify in the "search criteria" that the double vowel should be followed by a consonant/space; the limit is used to say "grab a pattern that goes consonant/1-3 vowels/consonant or space by saying {1,3}

#Exercise 7: Using last weeks data set, count the number of babys with the name Stacey or Stacy. Bonus 1: count Stacey, Stacy, or Staci. Bonus 2 list the unique set of names that start with Stac.
sum(grepl("Stacey", bnames$name), grepl("Stacy", bnames$name), grepl("Staci", bnames$name)) #, grepl("Stac", bnames$name)) #this doubles it hahaha


sum(grepl("Stac", bnames$name)) # this returns Stacie also (as does "Staci")

grep("Stac",bnames$name,value=T) # checking up on what it's actually seeking out.

grep("Staci$", bnames$name, value=T)
grep("Stacey", bnames$name, value=T)

sum(grepl("Staci$", bnames$name), grepl("Stacey", bnames$name), grepl("Stacy", bnames$name))
#this is cheating - muhahaha. 

new<-unique(grep("Stac",bnames$name, value=T))
new
#julin said this "new" business is totes legit!!
# 
# Alternates
# 
# The | character can be read as "or" and can be used to specify alternates.
# Example: change the path below to point to 'bnames.csv' on your computer
bnames[grep("Stac(y|i)", bnames$name), ]
bnames[grep("Stac(y|i)$", bnames$name), ]

#Exercise 8: Pull out the names "Jonathan" "Jonnie" and "Johnathon" but not other Jon names.
#Bonus: Only have Jon listed once in your search string.
uhoh<-unique(grep("Jo(nnie|hnathon|natha)", bnames$name, value=T))
uhoh

#Escapes

#What if you want to match a . or other special character?
#The following characters have special meaning in regular expressions: . \ | ( ) [ { ^ $ * + ? 
#and if you want to search for them you have to do something special.

# say you want all Chrom one ILs
ILs <- c("IL.1.1", "IL.2.2", "IL.1.3", "IL.2.1", "IL.11.1", "IL.11.3", "IL.12.1","IL.12.2")
# the following seems logical at first:
grep("IL.1.", ILs, value = T)

#What happened? Remember that . matches any character. We need to tell grep that the . is just a regular character, not a wildcard. To do this we "escape" it by preceding it with a \. However, since \ itself is a special character it must also be escaped. So we use two backslashes.

grep("IL\\.1\\.", ILs, value = T)
# an alternative, if you don't need any "regular expression" functionality is to use the argument 'fixed=T' [Turns off the crazy extra functions]
grep("IL.1.", ILs, value = T, fixed = T)

# Back references
# 
# One of the powerful tools in regular expressions is the ability to refer back to a previous match. The item that you want to refer back to is enclosed in parentheses.
#You backreference with a backslash and a digit. 
# A 1 would indicate the first group enclosed in a parentheses, a 2 would refer to the second group, etc.
# 
# Suppose we want to find all state names that have letters repeated twice in a row.
grep("(.)\\1", state.name, value = T)

# the '.' matches any character.  Enclosing that in parentheses designates it as an item that we want to refer back to.  The \\1 refers back to it.

#Exercise 9: Find all state names that have two vowels repeated.

grep("([aeiou])\\1", state.name, value = T)

#I find back references particularly helpful in combination with sub(), because you can use them in your replacement string.
 
# Exercise 10: For all two-worded state names reverse the order of the two words and add a comma between the words. ("North Carolina" should become "Carolina, North")
#grep("\\s", state.name, value = T, ignore.case = T)
#data2$chromosome# <- sub("IL([0-9]+)\\..*","\\1",data2$X))

#data2$chromosome# <- sub("IL([0-9]+)\\..*"<- regular expression ,"\\1"<-refer back to first parenthesis regular expression,data2$X))

grep("(.*)\\s(.*)", state.name, value = T, ignore.case = T)

sub()


Commas <- sub("(.*)\\s(.*)", "\\2, \\1" , state.name)
Commas

# Exercise 11: For all two-worded state names, abbreviate the first word to be the first letter, followed by a . ("North Carolina" becomes "N. Carolina").

Abbrev <- sub("(.*)\\s(.*)", "^.\\1 \\2" , state.name)
Abbrev <- sub("(.*)\\s(.*)", "^ \\1. \\2" , state.name)

Abbrev <- sub("(.*)\\s(.*)", "\w\\1. \\2" , state.name)

Abbrev <- sub("(.*)\\s(.*)", "[\w]\\1. \\2" , state.name)

Abbrev <- sub("(.*)\\s(.*)", "\\w\\1. \\2" , state.name)

Abbrev <- sub("(.)(.*)\\s(.*)", "\\1. \\3" , state.name)

Abbrev
# help
