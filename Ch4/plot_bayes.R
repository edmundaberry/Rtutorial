#!/usr/bin/env Rscript

#------------------------------------------------------------------------
# First define the number of theta values
# Recall that theta is our model parameter
#------------------------------------------------------------------------

n_theta_values = 63

#------------------------------------------------------------------------
# Now make a sequence of those theta values
#------------------------------------------------------------------------

theta = seq ( from = 1./(n_theta_values+1), to = n_theta_values/(n_theta_values+1), by = 1./(n_theta_values+1))

#------------------------------------------------------------------------
# Now define our priors on theta: p(theta)
# "pmin" makes a triangle distribution
# We have to unit-normalize our priors
#------------------------------------------------------------------------

prior = pmin ( theta, 1 - theta )
prior = prior / sum (prior)

#------------------------------------------------------------------------
# Now for our data.  Also introducing conditional sums.
#------------------------------------------------------------------------

data = c(1,1,1,0,0,0,0,0,0,0,0,0)

n_data  = length ( data )
n_heads = sum ( data == 1 )
n_tails = sum ( data == 0 )

#------------------------------------------------------------------------
# Calculate likelihood sequence: p(data|theta)
# Likelihood sequence = "likelihood of seeing this data, given a value of theta"
#------------------------------------------------------------------------

likelihood = choose(n_data, n_heads) * (theta ^ n_heads) * ((1. - theta ) ^ n_tails)

#------------------------------------------------------------------------
# Calculate the "evidence" scalar: p(data)
# evidence is the sum/integral of "the likelihood for a given prior",
# summed/integrated over all possible priors
#
# This is essentially the "denominator" of Bayes' Law
#------------------------------------------------------------------------

evidence = sum ( likelihood * prior )

#------------------------------------------------------------------------
# Now do Bayes' Law!
#
# Get the posterior sequence: p(theta|data)
# Posterior sequence = "likelihood of this theta being correct, given this data"
#------------------------------------------------------------------------

posterior = likelihood * prior / evidence

#------------------------------------------------------------------------
# Plot everything.  
#------------------------------------------------------------------------

# Make a window first.

pdf("plots/plot_bayes.pdf")
layout( matrix( c(1,2,3), nrow=3, ncol =1, byrow=FALSE))

par(mar=c(3,3,1,0)) # number of margin lines: bottom,left,top,right
par(mgp=c(2,1,0)) # which margin lines to use for labels
par(mai=c(0.5,0.5,0.3,0.1)) # margin size in inches: bottom,left,top,right

# Plot the prior

plot(theta, prior, type="h", lwd=3, main="Prior",
     xlim=c(0,1), xlab=bquote(theta),
     ylim=c(0,1.1*max(posterior)), ylab=bquote(p(theta)),
         cex.axis=1.2, cex.lab=1.5, cex.main = 1.5 )

# Plot the likelihood

plot(theta, likelihood, type="h", lwd=3, main="Likelihood",
     xlim=c(0,1), xlab=bquote(theta),
     ylim=c(0,1.1*max(likelihood)), ylab=bquote(paste("p(D|",theta,")")),
     cex.axis=1.2, cex.lab=1.5, cex.main = 1.5 )

text(0.55, 0.85*max(likelihood), cex=2.0,
     bquote("D=" * .(n_heads) * "H," * .(n_tails) * "T"), adj=c(0,0.5))

# Plot the posterior

plot(theta, posterior, type="h", lwd=3, main="Posterior",
     xlim=c(0,1), xlab=bquote(theta),
     ylim=c(0,1.1*max(posterior)), ylab=bquote(paste("p(",theta,"|D)")),
     cex.axis=1.2, cex.lab=1.5, cex.main = 1.5 )

text(0.55, 0.85*max(posterior), cex=2.0,
     bquote("p(D)=" * .(signif(evidence,3))), adj=c(0,0.5))

graphics.off()
     
