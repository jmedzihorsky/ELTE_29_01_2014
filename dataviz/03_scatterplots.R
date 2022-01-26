#   DataViz workshop 
#       3. scatterplots
#   2022-01-27

#   let's use mtcars ...
data(mtcars)

str(mtcars)


#   let's start by displacement and mpg
#   yikes
plot(mtcars$disp, mtcars$mpg)

#   a bit better
plot(mtcars$disp, mtcars$mpg, 
     las=1, frame=FALSE,
     xlab='Displacement', ylab='MPG')


#   now the axes
range(mtcars$disp) # suggest 50-500
range(mtcars$mpg) # suggest 10-35

x_ticks <- seq(50, 500, by=50)
y_ticks <- seq(10, 35, by=5)

dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=c(10, 35))
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, y_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(2, y_ticks, lwd=0, line=-0.4, las=1)
mtext('MPG', side=2, las=1, line=2.4)
#   now the points, first in semi-transparent blue circles
points(mtcars$disp, mtcars$mpg, pch=16, col=rgb(0,0,1,0.5))


#   now let's do the same, but with point shape by am (american)
am_pch <- ifelse(mtcars$am%in%1, 16, 15)
#
dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=c(10, 35))
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, y_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(2, y_ticks, lwd=0, line=-0.4, las=1)
mtext('MPG', side=2, las=1, line=2.4)
#   now the points, first in semi-transparent blue circles
points(mtcars$disp, mtcars$mpg, pch=am_pch, col=rgb(0,0,1,0.5)) # <----

#   change the point color by cyl
table(mtcars$cyl)

cyl_col <- character(length=nrow(mtcars))
cyl_col[mtcars$cyl%in%4] <- rgb(0.9, 0.4, 0.3, 0.7) 
cyl_col[mtcars$cyl%in%6] <- rgb(0, 0.7, 1, 0.7) 
cyl_col[mtcars$cyl%in%8] <- rgb(0.4, 0.5, 0.6, 0.7)
#
dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=c(10, 35))
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, y_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(2, y_ticks, lwd=0, line=-0.4, las=1)
mtext('MPG', side=2, las=1, line=2.4)
#   now the points, first in semi-transparent blue circles
points(mtcars$disp, mtcars$mpg, pch=am_pch, col=cyl_col) # <----

#   we can also use point size (cex)
#   let's try by wt
summary(mtcars$wt)
wt_cex <- 0.5 * mtcars$wt
#
dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=c(10, 35))
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, y_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(2, y_ticks, lwd=0, line=-0.4, las=1)
mtext('MPG', side=2, las=1, line=2.4)
#   now the points, first in semi-transparent blue circles
points(mtcars$disp, mtcars$mpg, pch=am_pch, col=cyl_col, cex=wt_cex) # <----


#   we've got 5 dimensions there, but we can still push it in different ways
#   let's say we would make some points full and some hollow based on vs, which
#   is binary
#   pch 15 (full) corresponds to pch 0 (hollow) and 16 to 1
#   or we could use pch 21 and 22, and use a fill color
new_pch <- numeric(nrow(mtcars))
new_pch[(mtcars$am%in%1)&(mtcars$vs%in%1)] <- 15
new_pch[(mtcars$am%in%1)&(mtcars$vs%in%0)] <- 0
new_pch[(mtcars$am%in%0)&(mtcars$vs%in%1)] <- 16
new_pch[(mtcars$am%in%0)&(mtcars$vs%in%0)] <- 1

table(new_pch)

dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=c(10, 35))
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, y_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(2, y_ticks, lwd=0, line=-0.4, las=1)
mtext('MPG', side=2, las=1, line=2.4)
#   now the points, first in semi-transparent blue circles
points(mtcars$disp, mtcars$mpg, pch=new_pch, col=cyl_col, cex=wt_cex, lwd=1) # <----

#   and we can still more dimensions to the 6
#   easiest by adding text
#   let's do the names rownames(mtcars)
text(mtcars$disp, mtcars$mpg, rownames(mtcars), pos=3, col=cyl_col, cex=0.75, font=2)

#   some of the labels are too close, bc their points are big, we can adjust the offset
dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=c(10, 35))
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, y_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(2, y_ticks, lwd=0, line=-0.4, las=1)
mtext('MPG', side=2, las=1, line=2.4)
#   now the points, first in semi-transparent blue circles
points(mtcars$disp, mtcars$mpg, pch=new_pch, col=cyl_col, cex=wt_cex, lwd=1)
text(mtcars$disp, mtcars$mpg, rownames(mtcars), pos=3, col=cyl_col, cex=0.75,
     font=2, offset=0.25*mtcars$wt) #<----

#   now making a legend for a plot with this complex encoding is a chore
#   let's put one top right, not a great placement, but there's empty space
#   it's gonna be one for color
legend('topright',
       bty='n',     # no border around
       title='Cylinders',
       pch=rep(18,3), 
       pt.cex=rep(2, 3),
       legend=c(8,6,4),
       col=c(rgb(0.4, 0.5, 0.6, 0.7),
             rgb(0, 0.7, 1, 0.7),
             rgb(0.9, 0.4, 0.3, 0.7)))


#   this will tell us where the legend elements are in the plot
L <- 
    legend('topright',
           bty='n',     # no border around
           title='Cylinders',
           pch=rep(18,3), 
           pt.cex=rep(2, 3),
           legend=c(8,6,4),
           col=c(rgb(0.4, 0.5, 0.6, 0.7),
                 rgb(0, 0.7, 1, 0.7),
                 rgb(0.9, 0.4, 0.3, 0.7)))

#   and another one top right
legend(x=L$rect$left,           # <- same left border as the previous legend
       y=L$rect$top-L$rect$h,   # <- bottom of the previous legende
       bty='n',     
       title='American',
       pch=c(15, 16), 
       pt.cex=rep(1.5, 2),
       legend=c('Yes', 'No'),
       col=rep(grey(0.5), 2))

#   and so on, this can easily get time-consuming if the plot is over-loaded


#   this is already getting too much with the 6 dimensions, so we stop here
#   still, one could add more by for example
#       -- adding more text
#       -- using different font= (normal, bold, italic, etc)
#       -- changing the size and color of the text
#       -- changing the font family of the text


#   let's go back to something else: suppose we are dealing with count variables 
#   and so want to use log scales

#   lets make the y-axis logarithmic
#   we only need to change the y-coordinates wherever they appear
dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=log(c(10, 35))) # <-----
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, log(y_ticks), labels=FALSE, tck=-1e-2, lwd=0.5) # <----
axis(2, log(y_ticks), y_ticks, lwd=0, line=-0.4, las=1) # <---- 
mtext('MPG', side=2, las=1, line=2.4)
#   now the points, first in semi-transparent blue circles
points(mtcars$disp, log(mtcars$mpg), pch=15, col='lightblue4', lwd=1) # <---


#   what it we'd want to fit a regression line and plot it into the background?
#   first let's refresh the plot without the log scale
dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=c(10, 35)) 
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, y_ticks, labels=FALSE, tck=-1e-2, lwd=0.5) 
axis(2, y_ticks, y_ticks, lwd=0, line=-0.4, las=1) 
mtext('MPG', side=2, las=1, line=2.4)
#   let's add rugs
rug(mtcars$disp, side=1, col=rgb(0.9, 0.4, 0.3, 0.7), lend='butt', lwd=2, ticksize=2e-2)
rug(mtcars$mpg, side=2, col=rgb(0.9, 0.4, 0.3, 0.7), lend='butt', lwd=2, ticksize=2e-2)


#   first fit the model (quadratic, to allow for some nonlinearity)
mod <- lm(mpg ~ 1 + disp + I(disp^2), data=mtcars)

#   prep new data
new_data <- data.frame(disp=seq(min(mtcars$disp), max(mtcars$disp), by=1e-2))

#   get a 95% confidence interval for the line
fit <- predict(mod, interval='confidence', level=0.95, newdata=new_data) 
head(fit)

lines(new_data$disp, fit[,1], col=grey(0.3))
lines(new_data$disp, fit[,2], col=grey(0.3), lty=3)
lines(new_data$disp, fit[,3], col=grey(0.3), lty=3)

#   and or a shaded region
polygon(x=c(new_data$disp, rev(new_data$disp)),
        y=c(fit[,2], rev(fit[,3])), 
        border=grey(0,0),               # a hack, completely transparent == invisible black   
        col=grey(0.3, 0.1))



#   or we can leave-one-out
list_mod <- lapply(1:nrow(mtcars), 
                   function(i) lm(mpg ~ 1 + disp + I(disp^2), data=mtcars[-i,]))
list_fit <- lapply(list_mod, function(i) predict(i, newdata=new_data))

#   refresh the plot
dev.off() # close the old window
dev.new(width=8, height=8) # open a new one with the given size
par(mar=c(4,6,3,1))
plot.new()
plot.window(xlim=c(50, 500), ylim=c(10, 35)) 
#   x axis
axis(1, x_ticks, labels=FALSE, tck=-1e-2, lwd=0.5)
axis(1, x_ticks, lwd=0, line=-0.6)
mtext('Displacement', side=1, line=2.0)
#   y axis
axis(2, y_ticks, labels=FALSE, tck=-1e-2, lwd=0.5) 
axis(2, y_ticks, y_ticks, lwd=0, line=-0.4, las=1) 
mtext('MPG', side=2, las=1, line=2.4)
#   let's add rugs
rug(mtcars$disp, side=1, col=rgb(0.9, 0.4, 0.3, 0.7), lend='butt', lwd=2, ticksize=2e-2)
rug(mtcars$mpg, side=2, col=rgb(0.9, 0.4, 0.3, 0.7), lend='butt', lwd=2, ticksize=2e-2)
#
lines(new_data$disp, fit[,1], col=grey(0.3))
invisible(lapply(list_fit, function(i) lines(new_data$disp, i, col=rgb(0,0,1, 0.3))))
#   #   now the points, first in semi-transparent blue circles
#   points(mtcars$disp, mtcars$mpg, pch=15, col=rgb(0.4, 0.5, 0.6, 0.7), lwd=1)


#   THE END for scatterplots, rasters next
