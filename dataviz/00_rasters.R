#   DataViz workshop 
#       0. rasters
#   2022-01-27

library(png)
library(jpeg)


#   let's start with a plain raster

#   first, prep a canvas
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
box()
axis(1)
axis(2, las=1)

#   rasterImage() is the workhorse here

#   lets prep a simple matrix, 2 rows, 10 cols, both rows are the same
#   sequence from 1 to 0
a1 <- matrix(nrow=2, ncol=10)
a1[1,] <- a1[2,] <- seq(1, 0, length.out=10)

a1

#   now lets add a raster as a horizontal strip,
#   with interpolation
rasterImage(a1, xleft=0, ybottom=0.6, xright=1, ytop=0.8, interpolate=TRUE)
#   and another below, without
rasterImage(a1, xleft=0, ybottom=0.2, xright=1, ytop=0.4, interpolate=FALSE)


#   what happend was rasterImage() interpreted the input as a greyscale raster image
#   let's try color

#   clean the canvas
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
box()
axis(1)
axis(2, las=1)

#   make a 3-way array, now the layers will be red, green blue
a2 <- array(dim=c(2,10,3))
#   red goes from 1 to 0
a2[1,,1] <- a2[2,,1] <- seq(1, 0, length.out=10)
#   green is all 0
a2[,,2] <- 0
#   blue goes from 0 to 1 in one row and 1 to 0 in the other
a2[1,,3] <- seq(0, 1, length.out=10)
a2[2,,3] <- seq(1, 0, length.out=10)

#   again, with interpolation and without
#   yikes
rasterImage(a2, xleft=0, ybottom=0.6, xright=1, ytop=0.8, interpolate=TRUE)
rasterImage(a2, xleft=0, ybottom=0.2, xright=1, ytop=0.4, interpolate=FALSE)

#   one more try, with transparency, which will be the fourth layer
#   now everything is simple blue
a4 <- array(dim=c(2,10,4))
a4[,,1] <- 0
a4[,,2] <- 0
a4[,,3] <- 1
a4[1,,4] <- a4[2,,4] <- seq(1, 0, length.out=10)


#   clean the canvas
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
box()
axis(1)
axis(2, las=1)

rasterImage(a4, xleft=0, ybottom=0.6, xright=1, ytop=0.8, interpolate=TRUE)
rasterImage(a4, xleft=0, ybottom=0.2, xright=1, ytop=0.4, interpolate=FALSE)


#   now let's try loading an image

img1 <- readJPEG('mondrian.jpg') # the big red square is top left

#   no alpha-layer here
dim(img1)
str(img1)

#   canvas
par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 
# first try
rasterImage(img1, 0, 0, 1, 1)

#   not bad
#   if we wanted to use it as a background, we could overlay it with a rectangle
#   of transparent white
#   being lazy here
rect(-2, -2, 2, 2, col=grey(1, 0.5))


#   refresh canvas
par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 

#   another thing we can do is add the alpha layer, and make some parts semi-transparent
img2 <- array(dim=c(nrow(img1), ncol(img1), 4))
img2[,,1:3] <- img1
img2[,,4] <- 0.28
#   everything is now semitranspraent
#   so let's make a square somewhere opaque
img2[70:400, 70:400,4] <- 1
# first try
rasterImage(img2, 0, 0, 1, 1)

#   let's try something more elaborate: 
#   create a greyscale image in png
#   as a kind of cutout

par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 
#
text(0.5,0.5, 'R', font=2, cex=32)

#   we'll save this
png('R.png', ncol(img1), nrow(img1))
par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 
#
text(0.5,0.5, 'R', font=2, cex=40)
dev.off()

#   now we import it
img0 <- readPNG('R.png')

#   it's rgb: 3 layers
str(img0)

#   convert to greyscale by taking the average of the three value per cell
img0bw <- apply(img0, c(1,2), mean)

#   and we're done
dim(img0bw)


#   test it
par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 
rasterImage(img0bw, 0, 0, 1, 1)

#   alright, time to cut out the 'R' from mondrain
#   we do this by cloning the 4-layer mondrian
#   then wherever 'R' is black, mondrian will be opaque
#   and wherever 'R' is white, mondrian will be transparent
#   since black is 0 and opaqueness 1, we will have to flip the numbers

#   clone
b <- img2
#   replace the alpha layer with the flipped greyscale 'R'
b[,,4] <- (1-img0bw)


#   woohoo
par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 
rasterImage(b, 0, 0, 1, 1)

#   let's try cutting out the opposite
b2 <- img2
b2[,,4] <- img0bw

#   easy
par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 
rasterImage(b2, 0, 0, 1, 1)


# add the cut out R back, but make the surround greyscale and mute it
# muting means mixing with white
gs <- array(dim=c(nrow(img0), ncol(img0), 4))
gs[,,1] <- gs[,,2] <- gs[,,3] <- apply(img1, c(1,2), mean)*0.5 + 0.5
gs[,,4] <- b2[,,4]

par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 
rasterImage(gs, 0, 0, 1, 1)
rasterImage(b, 0, 0, 1, 1)


#   for completeness sake, let's just place them side-by-side, stretched vertically
par(mar=rep(1,4))
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1), asp=1) # fixing the aspect ratio at 1 
rasterImage(gs, 0, 0, 0.5, 1)
rasterImage(b, 0.5, 0, 1, 1)



#   that's it, really
#   as long as you have the source images, you can do whatever
#   although doing color filters, cropping, etc, might be easier
#   doing in an image editing software with a GUI, like GIMP, which is free

#   THE END on rasters
