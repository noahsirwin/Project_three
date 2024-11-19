---
title: Introduction to Posterior Prediction
subtitle: Assessing the fit of Normal distributions to trait data
authors: Jeremy M. Brown and Christina L. Kolbmann
level: 2
order: 1.0
redirect: false
bibliography: references.bib
---

## Overview 

This tutorial introduces the basic principles of posterior predictive model checking. The goal of posterior prediction is to assess the fit between a model and data by answering the following question: __Could the model we've assumed plausibly have produced the data we observed?__

To perform posterior prediction, we simulate datasets using parameter values drawn from a posterior distribution. We then quantify some characteristic of both the simulated and empirical datasets using a test statistic (or a suite of test statistics), and we ask if the value of the test statistic calculated for the empirical data is a reasonable draw from the set of values calculated for the simulated data. If the empirical test statistic value is very different from the simulated ones, our model is not doing a good job of replicating some aspect of the process that generated our data.


## Introduction

A good statistical model captures important features of observed data using relatively simple mathematical principles. However, a model that fails to capture some important feature of the data can mislead us. Therefore, it is important to not only compare the relative performance of models (i.e., model selection), but also to test the absolute fit of the best model [@Bollback2002; @Brown2014; @Brown2014a;  @Hoehna2018a; @BrownThomson2018]. If the best available model could not have plausibly produced our observed data, we should be cautious in interpreting conclusions based on that model.

Posterior prediction is a technique to assess the absolute fit of a model in a Bayesian framework [@Bollback2002; @BrownThomson2018]. Posterior prediction relies on comparing the observed data to data simulated from the model. If the simulated data are similar to the observed, the model could reasonably have produced our observations. However, if the simulated data consistently differ from the observed, the model is not capturing some feature of the data-generating process.

## An Example 

To illustrate the steps involved in posterior prediction, we'll begin with a simple example. Here, we will examine a hypothetical dataset of trait values sampled from a sexually dimorphic population. However, for the purposes of our tutorial, we will say that we do not yet realize that sexual dimorphism exists. This example is discussed further in [@BrownThomson2018].

<img src="figures/populationTraits.png"/>
A set of trait values sampled from a population with sexual dimorphism.

## A Single-Normal Model 

In this tutorial, we have a set of observations made of a body size index in birds. 

<img src="figures/postDensSurface_wSamples.png"/>
Samples of the mean and standard deviation for a single Normal distribution.


Based on one set of sampled parameter values (one of the dots in Figure 2), Figure 3 shows the resulting Normal distribution compared to the population trait data:

<img src="figures/SingleNormal.png"/>
A single Normal distribution fit to the population trait values.


In this case, it is visually obvious that there are some important differences between the model we've assumed and the trait data. However, we'd like a quantitative method to assess this fit. Also, in the case of more complicated models and data like we typically encounter in phylogenetics, visual comparisons are often not possible.

## Distribution Comparisons

Now that we've fit our single-normal model, we need to simulate posterior predictive datasets. Remember that these are datasets of the same size as our observed data, but simulated using means and standard deviations drawn from our posterior distribution. 

<img src="figures/posteriorPredictiveSimulation.png"/>
Simulation of posterior predictive datasets (shown in light gray) by drawing samples of means and standard deviations from the posterior distribution.


The code for this simulation with the single-normal model can be found in **pps_SingleNormal.rev**.

## Test Statistics

To quantitatively compare our empirical and simulated data, we need to use some test statistic (or suite of test statistics). These statistics numerically summarize different aspects of a dataset. We can then compare the empirical test statistic value to the posterior predictive distribution. For the case of our trait data, we will try four possible test statistics: the 1st percentile, mean, median, and 90th percentile. 

<img src="figures/testStatistics.png"/>
Four possible test statistics to summarize particular characteristics of a dataset of trait values.

## P-values and Effect Sizes 

We typically summarize the comparison of test statistic values between empirical and posterior predictive datasets using either a posterior predictive p-value or an effect size.

A posterior predictive p-value tells us how many of our simulated datasets have test statistic values that are as, or more, extreme than the empirical. While useful, these p-values are unable to distinguish between cases where the observed test statisic falls just a little bit outside the posterior predictive distribution from cases where there is a very big difference between the simulated and empirical values.

Effect sizes allow us to distinguish those different possibilities [@Doyle2015]. An effect size is calculated as the difference between the empirical test statistic value and the median of the posterior predictive distribution, divided by the standard deviation of the posterior predictive distribution. In other words, how many standard deviations away from the median is the observed value?

<img src="figures/PVal_EffectSize.png"/>
The comparison between test statistic values from empirical and posterior predictive datasets can be summarized 
using both posterior predictive p-values and effect sizes. Figure from [@Hoehna2018a].

P-values and effect sizes are calculated in **pps_SingleNormal.rev** with this code

The results should look something like this

```
---> Posterior Prediction Model Assessment Results <---

P-value mean:	0.4973767
P-value median:	0.9632739
P-value 1st percentile:	0.003147954
P-value 90th percentile:	0.3231899

Effect size mean:	0.001805498
Effect size median:	1.860846
Effect size 1st percentile:	2.034433
Effect size 90th percentile:	0.4808086
```

Note that this script only calculates p-values as the percentage of posterior predictive values that are *less* than the empirical value. Formally, this is known as a lower one-tailed p-value. Therefore, p-values near *either 0 or 1* indicate poor fit between our model and our empirical data.

To run this entire posterior predictive analysis at once, you could use this command from inside the `scripts` folder for this tutorial.

```
source(pps_SingleNormal.rev)
```

These results can also be summarized graphically (although not in RevBayes) like this

<img src="figures/PPResults.png"/>
Comparison of empirical and posterior predictive test statistic values. The four test statistics are shown in different rows. Vertical arrows show empirical values, and distributions show simulated values. The lighter distributions were generated by posterior predictive simulation and the darker distributions were generated by parametric bootstrapping (similar to posterior prediction, but using only maximum likelihood parameter estimates for simulation). More detail is available in [@BrownThomson2018].


{% section A Two-Normal Model]

All of the analyses above can be replicated using a model that correctly employs two independent Normal distributions to separately capture the distinct trait values for males and females. The simplest form of a two-normal model is a mixture distribution. The means and standard deviations of two Normal distributions are estimated separately and we calculate a likelihood that averages across the possibility of each individual belonging to each possible group.

If you want to run an MCMC analysis under this two-normal mixture model, you can use the script **MCMC_TwoNormals.rev**. However, the MCMC output from this analysis is already available in **twoNormals_posterior.log**, so you do not need 
to rerun the MCMC if you don't want to. You can perform just the posterior prediction steps using **pps_TwoNormals.rev**.

After running posterior prediction for the two-normal model, compare your results to the one-normal model. Do these results indicate a better fit?

## Interpreting Posterior Predictive Results 

In general, test statistics with intermediate p-values (close to 0.5) indicate good fit and should have relatively small effect sizes. In our results from the one-normal model, both the mean (p-value = 0.49, effect size = 0.03) and the 90th percentile (p-value = 0.68, effect size = 0.51) do not indicate big discrepancies between what we've observed and what we've simulated.

However, the median (p-value = 0.046, effect size = 1.70) and 1st percentile (p-value = 0.996, effect size = 1.93) statistics have small and large p-values, respectively, and correspondingly large effect sizes. These results __do indicate a discrepancy__ between the assumptions of the model and the data we've observed.

__Should we be concerned about our model?__ Two of our test statistics do not indicate poor fit, while two others do indicate poor fit.

__The answer depends on what we want to learn about our population.__ If we are interested in inferring or predicting the average trait value of our population, we seem to be doing fine. However, if we wanted to predict the trait value of any given individual drawn from the population, we will tend to overpredict individuals with intermediate values and underpredict individuals with extreme trait values. If we were interested in understanding an evolutionary process like stabilizing selection, we might also be very concerned. A single-normal model would suggest 
that our population has quite a lot of trait variation between individuals, when in fact most of that difference is between sexes. Individuals within a sex have much more limited variation.

## Simulations Choose Your Own Adventure



# References
