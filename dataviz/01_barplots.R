#   DataViz workshop 
#       1. barplots
#   2022-01-27

#   Let's first load some data that comes packaged with R. It's a dataset widely
#   used to demonstrate methods for categorical data analysis. It contains data
#   on hair and eye color in a group of male and female students.

data(HairEyeColor)

#   It's a 3-way contingency table
#   rows: Hair color
#   columnss: Eye color
#   layers: Sex 
str(HairEyeColor)

HairEyeColor


#   lets get the one-way marginal distributions
Hair <- apply(HairEyeColor, 1, sum)
Eye <- apply(HairEyeColor, 2, sum)
Sex <- apply(HairEyeColor, 3, sum)

#   let's get some of the 2-way marginals
HairEye <- apply(HairEyeColor, c(1,2), sum)


#   lets plot the Hair marginal
#   the simplest basic barplot

barplot(Hair)

#   not bad, not great
#   first issue to fix: y axis labels are rotated
#   we'll be using las=1 a lot today
barplot(Hair, las=1)

#   next issue to fix: y-axis doesn't reach all the way up above the tallest
#   column; we'll tell R to set the y-axis range from 0 to 300
barplot(Hair, las=1, ylim=c(0, 300)) 

#   next issue: label the x-axis
#   option 1
barplot(Hair, las=1, ylim=c(0, 300), xlab='Hair') 
#   option 2 makes it easier to teak the label
#   we'll place some text at the bottom, R labels sides
#       1 bottom
#       2 left
#       3 top
#       4 right
barplot(Hair, las=1, ylim=c(0, 300)) 
mtext('Hair', side=1, line=3)

#   now we can make the label larger
barplot(Hair, las=1, ylim=c(0, 300)) 
mtext('Hair', side=1, line=3, cex=1.5)
#   or bold
#   R labels fonts
#       1 normal
#       2 bold
#       3 italics
#       4 bold italics
#       5 greek
barplot(Hair, las=1, ylim=c(0, 300)) 
mtext('Hair', side=1, line=3, font=2)

#   suppose say we want to change the color
#   this will change the fill
barplot(Hair, las=1, ylim=c(0, 300), col='lightblue') 

#   we can also add a color using the rgb() function; let's make it 
#   semi-transparent primary blue
barplot(Hair, las=1, ylim=c(0, 300), col=rgb(0,0,1,0.5)) 

#   or we can give each column a different color
#   we have 4 columns so we need 4 colors
barplot(Hair, las=1, ylim=c(0, 300), 
        col=c('blue', 'lightblue', 'pink', 'tomato')) 

#   we could also do something old-school and shade them
#   rarely needed these days
#   density says how close to each those lines are supposed to be
#   angle sets their angle in degrees
barplot(Hair, las=1, ylim=c(0, 300), density=10, angle=45) 


#   to make it properly ugly, we can give each column a different one
barplot(Hair, las=1, ylim=c(0, 300),
        density=c(40, 20, 10, 5),
        angle=c(90, 47.5, 42.5, 0)) 

#   let's change the border instead
barplot(Hair, las=1, ylim=c(0, 300), border='red') 

#   or change it's width
barplot(Hair, las=1, ylim=c(0, 300), border='red', lwd=2) 

#   we can also rotate it sideways
barplot(Hair, las=1, horiz=TRUE) 

#   but now we need to change the x-axis range instead
barplot(Hair, las=1, horiz=TRUE, xlim=c(0, 300)) 

#   let's make it neater
barplot(Hair, las=1, horiz=TRUE, xlim=c(0, 300), 
        border='white', col='lightblue3') 

#   let's remove the x-axis and added tweaked, remember bottom is side 1
#   first shorten the ticks
barplot(Hair, las=1, horiz=TRUE, xlim=c(0, 300), 
        border='white', col='lightblue3', axes=FALSE) 
axis(1, tck=-1e-2) 

#   now we should also move the labels closer 
#   we'll add it twice, once without the labels and the other
#   time without the ticks, but more up
barplot(Hair, las=1, horiz=TRUE, xlim=c(0, 300), 
        border='white', col='lightblue3', axes=FALSE) 
axis(1, tck=-1e-2, labels=FALSE) 
axis(1, lwd=0, line=-0.75) 


#   stack two on top of each other
par(mfrow=c(2,1))
barplot(Hair, las=1, horiz=TRUE, xlim=c(0, 300), border='white', col='lightblue3') 
barplot(Eye, las=1, horiz=TRUE, xlim=c(0, 300), border='white', col='tomato2') 

#   give them titles
par(mfrow=c(2,1))
barplot(Hair, las=1, horiz=TRUE, xlim=c(0, 300), border='white', col='lightblue3') 
mtext('Hair', 3, line=2, cex=1.25, font=2)
barplot(Eye, las=1, horiz=TRUE, xlim=c(0, 300), border='white', col='tomato2') 
mtext('Eye', 3, line=2, cex=1.25, font=2)

#   barplot() is OK for making quick and simple figures, 
#   but we may wish to do more complex graphics, and it's easier if we take
#   more control
#   we can draw bars ourselves, they are just rectangles

#   let's prep a blank canvas
#   mfrow just says we're back to one plot per window
#   mar says how large the margins should be in inches
par(mfrow=c(1,1), mar=c(4,4,4,1))
plot.new()
plot.window(xlim=c(0, 300), ylim=c(0, 5))
rect(xleft=0, 
     ybottom=0.5, 
     xright=Hair[4], 
     ytop=1.5, 
     lwd=0, col='lightblue3')

#   ok, let's loop through the columns and add all
par(mfrow=c(1,1), mar=c(4,4,4,1))
plot.new()
plot.window(xlim=c(0, 300), ylim=c(0, 5))
for (i in 1:4) {
    rect(0, 5-i-0.5, Hair[i], 5-i+0.5, lwd=0, col='lightblue3')
}

#   too crammed, let's make them thinner
par(mfrow=c(1,1), mar=c(4,4,4,1))
plot.new()
plot.window(xlim=c(0, 300), ylim=c(0, 5))
for (i in 1:4) {
    rect(0, 5-i-0.4, Hair[i], 5-i+0.4, lwd=0, col='lightblue3')
}

#   add y-labels
text(x=0, y=4:1, names(Hair), pos=2)
#   something ain't right: we need to allow them to be outside the main field of the plot
#   which we can see with box()
box()

#   so another try
par(mfrow=c(1,1), mar=c(4,4,4,1))
plot.new()
plot.window(xlim=c(0, 300), ylim=c(0, 5))
for (i in 1:4) {
    rect(0, 5-i-0.4, Hair[i], 5-i+0.4, lwd=0, col='lightblue3')
}
text(x=0, y=4:1, names(Hair), pos=2, xpd=T)


#   okay, how about background vertical lines where the x-axes ticks are?
#   if we have the plot open, we can see their values with axTicks(1)
axTicks(1)

par(mfrow=c(1,1), mar=c(4,4,4,1))
plot.new()
plot.window(xlim=c(0, 300), ylim=c(0, 5))
abline(v=axTicks(1), col='grey', lty=3)
for (i in 1:4) {
    rect(0, 5-i-0.4, Hair[i], 5-i+0.4, lwd=0, col='lightblue3')
}
text(x=0, y=4:1, names(Hair), pos=2, xpd=T)

#   and add the axis, but without the horizontal line
axis(1, lwd=0, lwd.ticks=1)

#   we can also add the numbers onto the bars
#   let's try bold white text
text(x=Hair, y=4:1, Hair, font=2, pos=2, col='white')
#   we can also add the percentages below in italics
#   if we have the plot open, we can see how tall the letters are
strheight('M', font=2)
#   we just need to adjust for this, say 1.5 times, to get a neat line spacing
#   but let's first prep the labels, with one digit after the decimal
hair_percent <- paste0( round( 100 * Hair/sum(Hair), 1), '%')
#   lets add it
text(x=Hair, y=4:1-1.5*strheight('M', font=2), hair_percent, font=3, pos=2, col='white')
#   doesn't look optimal, we could shift both so that it's centered later

#   let's try something else, remember the 2-way maring
HairEye

#   let's make a stacked barplot in this way with Hair bars segmented by Eye
#   first lets make a vector with 4 colors for each Eye color
eye_vec <- c('lightblue4', 'lightblue3', 'lightblue2', 'lightblue1')
#   now the trick is to start with the full sum and then move backwards

par(mfrow=c(1,1), mar=c(4,4,4,1))
plot.new()
plot.window(xlim=c(0, 300), ylim=c(0.4, 4.4))
sapply(axTicks(1), function(i) abline(v=i, col='grey', lty=3))
for (i in 1:4) {
    for (j in 4:1) { # going backwards!
        rect(0, 5-i-0.4, sum(HairEye[i,1:j]), 5-i+0.4, lwd=0, col=eye_vec[j])
    }
}
text(x=0, 4:1, rownames(HairEye), pos=2, xpd=TRUE)
axis(1, lwd=0, lwd.ticks=1)


#   we're done with barplots for now, but let's check one more way of plotting
#   2-way cross tabs, one that looks neat, but isn't easier to read
#   it's also known as mosaic plot
plot(as.table(HairEye))

#   las again, still didn't help completely
plot(as.table(HairEye), las=1)


#   this is better, but we shift the label a bit to the left with line=
plot(as.table(HairEye), las=1, ylab='')
mtext('Eye', side=2, las=1, line=+0.5)

#   now add colors by row
#   automatically n greyscale
plot(as.table(HairEye), las=1, ylab='', color=TRUE)
mtext('Eye', side=2, las=1, line=+0.5)

#   or from a supplied vector
plot(as.table(HairEye), las=1, ylab='', color=paste0('lightblue', 4:1))
mtext('Eye', side=2, las=1, line=+0.5)

#   make the border go away, looks neater, but not easier to read
plot(as.table(HairEye), las=1, ylab='', color=paste0('lightblue', 4:1), border=FALSE)
mtext('Eye', side=2, las=1, line=+0.5)


#   remove that ugly title
#   and the x-axis labels down
plot(as.table(HairEye), las=1, ylab='', main='',
     color=paste0('lightblue', 4:1), border=FALSE)
mtext('Eye', side=2, las=1, line=+0.5)
#   and add a better one
mtext(paste0('Hair and Eye Color in ', sum(HairEyeColor), ' Students'),
      side=3, cex=1.25, line=1)

#   it's a puzzling default to place the column labels on top, but the column
#   name on the bottom, but such are R defaults sometimes

#   THE END, histograms, density plots, and rugs next
