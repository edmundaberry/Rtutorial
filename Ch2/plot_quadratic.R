#!/usr/bin/env Rscript

# Define a sequence
x = seq ( from = -2, to = 2, by = 0.1 )

# Define another sequence with a relationship to x
y = x^2

# Make a canvas to save the plot
pdf("plots/plot_quadratic.pdf")

# Plot the relationship between the two sequences
# Plot the line connecting the points, not just points
plot(x, y, type="l")

# Close the canvas
graphics.off()