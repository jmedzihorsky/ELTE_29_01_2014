#   DataViz workshop 
#       0. fonts
#   2022-01-27


#   normally I would use library(extrafont)
#   https://github.com/wch/extrafont
#   but we don't have time to install etc
#   so let's use library(showtext)
#   https://cran.rstudio.com/web/packages/showtext/vignettes/introduction.html

#   gotta install it first if you don't have it
#   install.packages('showtext')

library(showtext)

#   this loads the fonts from google.fonts.com
font_add_google("Fira Sans", "fira")
font_add_google("Fira Sans Condensed", "fira c")
font_add_google("Fira Sans Extra Condensed", "fira xc")


#   this allows us to use those fonts
showtext_auto()

TXT <- paste(LETTERS, collapse='')
txt <- paste(letters, collapse='')
num <- paste(0:9, collapse='')
a <- paste0(TXT, '\n', txt, '\n', num)


dev.new(width=12, height=5)
par(mar=c(1,1,1,1), mfrow=c(1,3))
#
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
mtext('Fira Sans', line=-3, cex=1)
text(0, 0.75, a, pos=4, cex=2, font=2, family='fira')
text(0, 0.50, a, pos=4, cex=2, font=1, family='fira')
text(0, 0.25, a, pos=4, cex=2, font=3, family='fira')
#
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
mtext('Fira Sans Condensed', line=-3, cex=1)
text(0, 0.75, a, pos=4, cex=2, font=2, family='fira c')
text(0, 0.50, a, pos=4, cex=2, font=1, family='fira c')
text(0, 0.25, a, pos=4, cex=2, font=3, family='fira c')
#
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
mtext('Fira Sans Extra Condensed', line=-3, cex=1)
text(0, 0.75, a, pos=4, cex=2, font=2, family='fira xc')
text(0, 0.50, a, pos=4, cex=2, font=1, family='fira xc')
text(0, 0.25, a, pos=4, cex=2, font=3, family='fira xc')


#   if we save this as a pdf, we better embed the fonts

pdf('fira_demo.pdf', width=12, height=5)
par(mar=c(1,1,1,1), mfrow=c(1,3))
#
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
mtext('Fira Sans', line=-3, cex=1)
text(0, 0.75, a, pos=4, cex=2, font=2, family='fira')
text(0, 0.50, a, pos=4, cex=2, font=1, family='fira')
text(0, 0.25, a, pos=4, cex=2, font=3, family='fira')
#
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
mtext('Fira Sans Condensed', line=-3, cex=1)
text(0, 0.75, a, pos=4, cex=2, font=2, family='fira c')
text(0, 0.50, a, pos=4, cex=2, font=1, family='fira c')
text(0, 0.25, a, pos=4, cex=2, font=3, family='fira c')
#
plot.new()
plot.window(xlim=c(0,1), ylim=c(0,1))
mtext('Fira Sans Extra Condensed', line=-3, cex=1)
text(0, 0.75, a, pos=4, cex=2, font=2, family='fira xc')
text(0, 0.50, a, pos=4, cex=2, font=1, family='fira xc')
text(0, 0.25, a, pos=4, cex=2, font=3, family='fira xc')
#
dev.off()
embedFonts('fira_demo.pdf')

#   that's it, it's that easy, just load the fonts,
#   set them using the family= argument
#   and if you're saving a pdf, embed to be safe

#   THE END
