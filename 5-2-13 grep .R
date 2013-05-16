#5-2-13
#R club with Mike 
#Grep some more

#can visually see the regular expression:
#http://www.regexper.com/

#default is "greedy" 

sub("M.+?s", "---", "Mississippi")
#get: ---sissippi
sub("Mis?", "---", "Mississippi")
#get: ---sissippi
sub("Mis??", "---", "Mississippi")
#get: --ssissippi

#i still don't understand how this is different from just using {n} or saying '??' = "give me 0" or with '+?' = "give me 1" - but I suck at this so it's probably super logical.

unique(grep("Stace?y", bnames$name, value=T))

#magic about capture groups: '?:' ahead of the capture group = ignores the capture group (so you can focus on the one you really want) 

# online cheat sheet : http://mfcovington.github.io/r_club/downloads/regular-expressions-cheat-sheet-v2.pdf
