#   DataViz workshop 
#       2. histograms, density plots, rugs
#   2022-01-27

#   let's use mtcars ...
data(mtcars)

str(mtcars)

#   check the distribution of mpg
table(mtcars$mpg)

table(round(mtcars$mpg))

#   option 1:
#   round-and-barplot
barplot(table(round(mtcars$mpg)), las=1, border=FALSE, col='lightblue3')

#   option 2:
#   histogram with automatic lumping, R looks for lumping that's optimal in
#   some sense
hist(mtcars$mpg, 
     border='white', col='lightblue3', 
     las=1, xlab='MPG', ylab='', main='')

# how about we add vertical lines at y-axis ticks, in white on top
# not that great
abline(h=axTicks(2), col='white', lty=3)

#   what if we use a different number of breaks?
#   something ain't right with the x-axis, let's fix it
hist(mtcars$mpg, breaks=10, 
     border='white', col='lightblue3', 
     las=1, xlab='MPG', ylab='', main='')

#   first lets set up our own ticks
range(mtcars$mpg)
#   ok so 10 to 35, let's say by 5
x_ticks <- seq(10, 35, by=5)

hist(mtcars$mpg, breaks=10, xaxt='n', xlim=c(10,35),
     border='white', col='lightblue3', 
     las=1, xlab='MPG', ylab='', main='')
axis(1, x_ticks)

#   option 3:
#   density plot
#   everyone likes density plots, right?
plot(density(mtcars$mpg))

#   not that nice
#   let's unpack it
#   density() gives a non-parametric estimate, it's model
d_mpg <- density(mtcars$mpg)

#   it's a set of 512 xy coordinates that is plotted as a line
str(d_mpg)

#   let's plot it on blank canvas
plot.new()
plot.window(xlim=range(d_mpg$x), ylim=c(0, max(d_mpg$y)))
lines(d_mpg, col='lightblue4')
#   add the axes
axis(1)
axis(2, las=1)
#   again, R didn't do a good job with the x-axis, but we can fix it later
#   for now, let's add 
#   option 4:
#   rugplot
#   we've got a bit of an issue here that some values of mpg appear twice
#   so we can try making the rug color transparent to make the ticks of those values darker
rug(mtcars$mpg, side=1, col=rgb(1,0,0,0.5), lwd=2)

#   a bit ugly how the rugs get into the x axis, now comes the lend=
plot.new()
plot.window(xlim=range(d_mpg$x), ylim=c(0, max(d_mpg$y)))
lines(d_mpg, col='lightblue4')
axis(1)
axis(2, las=1)
rug(mtcars$mpg, side=1, col=rgb(1,0,0,0.5), lwd=2, lend='butt')
#   in short, the sample is small and the density estimate may be misleading
#   it looks more sciency though

#   let's see what removing each single observation will do to the density 
#   estimate

d_list <- lapply(1:nrow(mtcars),
                 function(i) density(mtcars$mpg[-i]))

length(d_list)
str(d_list[[1]])

#   let's plot them in semi-transparent color
plot.new()
plot.window(xlim=range(d_mpg$x), ylim=c(0, max(d_mpg$y)))
invisible(sapply(d_list, lines, col=rgb(0.2,0.2,1,0.5), xpd=TRUE)) # supress command output
axis(1)
axis(2, las=1)
rug(mtcars$mpg, side=1, col=rgb(1,0,0,0.5), lwd=2, lend='butt')
#   could have been worse

#   option 5:
#   empirical cummulative density function
plot(ecdf(mtcars$mpg), las=1)

#   let's clean it up a bit
plot(ecdf(mtcars$mpg), las=1, 
     ylab='', main='', xlab='MPG', 
     frame=FALSE, 
     do.points=FALSE, 
     verticals=TRUE, 
     col='lightblue4', lwd=3)

#   and a bit more 
plot(ecdf(mtcars$mpg), las=1, 
     xaxt='n', yaxt='n',
     ylab='', main='', xlab='', 
     frame=FALSE, 
     do.points=FALSE, 
     verticals=TRUE, 
     col='lightblue4', lwd=3)
axis(1, tck=-1e-2, labels=FALSE, lwd=0.5)
axis(1, lwd=0, line=-0.8)
axis(2, tck=-1e-2, labels=FALSE, lwd=0.5)
axis(2, lwd=0, line=-0.6, las=1)
mtext('MPG', side=1, line=1.2)

#   close it
dev.off()

#   open new device, to see what it would look like saved
#   and crop the margins
dev.new(width=10, height=6, units='in')
par(mar=c(3,3,1,1))
plot(ecdf(mtcars$mpg), las=1, 
     xaxt='n', yaxt='n',
     ylab='', main='', xlab='', 
     frame=FALSE, 
     do.points=FALSE, 
     verticals=TRUE, 
     col='lightblue4', lwd=3)
#   add the rug while we're at it
rug(mtcars$mpg, side=1, col=rgb(1,0,0,0.5), lwd=2, lend='butt')
axis(1, tck=-1e-2, labels=FALSE, lwd=0.5)
axis(1, lwd=0, line=-0.8)
axis(2, tck=-1e-2, labels=FALSE, lwd=0.5)
axis(2, lwd=0, line=-0.6, las=1)
mtext('MPG', side=1, line=1.2)


#   THE END for univariate vizualizations, scatterplots next
