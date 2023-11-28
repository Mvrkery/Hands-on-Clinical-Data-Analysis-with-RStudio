##Creating objects in R

#Common types of object

#Numeric object

5
a <- 5
a
b = 5
b
5+5 -> c
d <- 7+8+9

#Display object

a
b
c
d

#class checking

class(a)
class(b)
class(c)
class(d)

#calculate numeric object

e <- a+b+c+d
class(e)

f <- ((a+b)/2)^2

#remove created objects

rm(a,b)
rm(c)
rm(d,e)
rm(f)

#Character/string object

a <- "Trauma"
b <- "Non-Trauma"
c <- "Younger"
d <- "Older"

#Display objects

a
b
c
d

#class checking

class(a)
class(b)
class(c)
class(d)

#remove created objects

rm(a,b,c,d)

#Logical object 
#TRUE or FALSE?

a <- 2
b<- 1+1
a == b

c <- TRUE
d <- FALSE
#class checking

class(c)
class(d)

#Create logical object from logical test

e <- a==b
e

f <- (a==b)==c
f

g <- (a==b)
g

#remove all objects

rm(list=ls()) #delete all variables



