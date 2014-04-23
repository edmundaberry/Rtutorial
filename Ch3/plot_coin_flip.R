#!/usr/bin/env Rscript

#------------------------------------------------------------------------
# How many trials?
#------------------------------------------------------------------------

N = 5000
probability_heads = 0.5

#------------------------------------------------------------------------
# Create the sample using the "sample" function:
# http://www.inside-r.org/r-doc/base/sample
#
# "replace = TRUE"  means that an item can appear more than once
# "replace = FALSE" means that an item can appear only once, and sample size can't be larger than the population
# 
# "c" is the concatenate function. c(x,y,...,z) combines its arguments to form a vector
#
# We're defining heads = 1, tails = 0
#------------------------------------------------------------------------

flip_sequence = sample ( x = c(0,1), prob = c(1.0 - probability_heads, probability_heads), size = N, replace = TRUE )

#------------------------------------------------------------------------
# Get a new vector that is the cumulative sum of the sequence using "cumsum"
# http://www.inside-r.org/r-doc/base/cumsum
#
# e.g. cumsum ( 1 0 1 1 ) would yield 1 1 2 3
#------------------------------------------------------------------------

cumulative_sum = cumsum ( flip_sequence )

#------------------------------------------------------------------------
# Define a vector of integers that increase by ones from 1 to N
# e.g. 1:3 gives you the vector 1 2 3
#------------------------------------------------------------------------

n = 1:N

#------------------------------------------------------------------------
# Calculate the running proportion
# vector division is entry-by-entry division
#------------------------------------------------------------------------

running_proportion = cumulative_sum / n

#------------------------------------------------------------------------
# Plot: x-axis is flip number, y-axis is proportion heads
#------------------------------------------------------------------------

pdf("plots/plot_coinflip.pdf")

plot(n, running_proportion, type="o", log="x", xlim=c(1,N), ylim=c(0.0,1.0), cex.axis=1.5,
	xlab="Flip Number", ylab="Proportion Heads", cex.lab=1.5,
	main="Running Proportion of Heads", cex.main=1.5)

#------------------------------------------------------------------------
# Make a horizontal line at probability_heads just to show we were right all along
#------------------------------------------------------------------------

lines(c(1,N), c(probability_heads,probability_heads), lty=3)

#------------------------------------------------------------------------
# Turn the graphics off
#------------------------------------------------------------------------

graphics.off()
