##Vector
##Another type of R object
##Create vector by combining (concatenating) multiple objects of the same type together

##Numeric vector

a <- c(1,2,3,4,5)
a <- c(1,5,4,2,3)
b <- c(1:5)
a==b
c <- seq(from=1,to=5,by=1)
c
d <- seq(1,5,1)
d
e <- seq(0,100,10)
e
f <- rnorm(30,mean=0,sd=1)
f
g <- rnorm(30,30,1)
g
h <- rnorm(30,30,5)
h
g==h

#Perform Mathematics calculation on numerical vectors

c
c+10
c-10
c*2
c/2

#Call upon the data within vector by its position

c
c[3]
c[5]
c[c(1,3,5)]

x <- c[c(1,3,5)]
x
class(x)

##Character/string vector

i <-c("Mild","Moderate","Severe")
i
class(i)

j <- c("mild","Moderate",1)
j

i==j

##Logical vector
k <- c(TRUE,FALSE,TRUE,FALSE)
k

l <- c(T,F,T,F)
l

class(k)

##Check if it is vector
is.vector(a)
is.vector(k)

m <- 8
is.vector(m)
help(is.vector)

data <- data.frame(a,b,c)
is.vector(data)
class(data)
