#!/usr/bin/env Rscript
# -*- mode: R -*-

#------------------------------------------------------------------------
# Define information about the plot
#------------------------------------------------------------------------

xaxis_low  = 0.0
xaxis_high = 1.0

#------------------------------------------------------------------------
# How thin will the areas that you divide the plot into be?
#------------------------------------------------------------------------

dx = 0.02

#------------------------------------------------------------------------
# Define the plot divisions (x-axis)
#------------------------------------------------------------------------

x = seq ( from = xaxis_low, to = xaxis_high, by = dx )

#------------------------------------------------------------------------
# Define the y-axis, "y"
# "y" is actually a sequence based on x
# Note that R knows about sqrt and exp functions
# Note that R knows about pi constant
#------------------------------------------------------------------------

y = 6.0 * x * (1-x)

#------------------------------------------------------------------------
# Plot the function as a histogram
# type="h" means draw vertical lines
# lwd means "line width"
#------------------------------------------------------------------------

pdf("plots/plot_polynomial.pdf")

plot( x, y, type="h", lwd=1, cex.axis=1.5,
     xlab="x", ylab="p(x)" , cex.lab=1.5,
     main="Polynomial Probability Density", cex.main=1.5)

#------------------------------------------------------------------------
# Draw the smooth bell curve too
#------------------------------------------------------------------------

lines(x, y)

#------------------------------------------------------------------------
# We can approximate the area of the integral using the rectangular method
# Note that we are doing multiple steps here:
# 1. Making a new sequence where every value of "y" is multiplied by the scalar "dx"
# 2. Taking the sum of every entry in that new sequence
#------------------------------------------------------------------------

area = sum(dx * y)

#------------------------------------------------------------------------
# Paste that info onto the graph
# Note new function "max"
#------------------------------------------------------------------------

text(  0.8, 0.9 * max(y), bquote(paste(Delta, "x = ", .(dx        ))), adj = c(0,0.5))
text(  0.8, 0.8 * max(y), bquote(paste(sum(,x,), " ", Delta, "x p(x) = ", .(signif(area,3)))), adj = c(0,0.5))

#------------------------------------------------------------------------
# Turn the graphics off
#------------------------------------------------------------------------

graphics.off()
