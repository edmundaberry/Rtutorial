#!/usr/bin/env Rscript

x = seq ( from = -3, to = 3, by = 0.1 )
y = x^3
pdf("plots/plot_cubic.pdf")
plot(x,y,type="l")
graphics.off()