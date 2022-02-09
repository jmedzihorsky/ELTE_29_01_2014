#   V-Dem MM Demo
#   Juraj Medzihorsky
#   2022-02-10


library(rstan)
options(mc.cores=2)
options(stringsAsFactors=F)

#   first, walk through the model code in vdem_mm.stan

#   load the demo data, check it's structure
demo_data <- readRDS('demo_data.rds')

str(demo_data)

#   List of 13
#    $ K          : num 5   #    5-point item
#    $ J          : num 20  #   20 experts            
#    $ C          : num 17  #   from 17 countries
#    $ N          : num 9   #   9 country-years (out of which 4 are vignettes)
#    $ n_obs      : int 111 #   111 ratings
#    $ rater_state: num [1:20] 3 4 5 13 14 15 14 11 17 6 ...  # id num of each expert's state
#    $ y          : num [1:111] 2 2 4 2 1 2 2 2 3 1 ...       # the ratings
#    $ j_id       : num [1:111] 1 2 3 4 5 6 7 8 9 10 ...      # ids of experts 
#    $ c_id       : num [1:111] 3 4 5 13 14 15 14 11 17 6 ... # ids of experts' countries
#    $ sy_id      : num [1:111] 1 1 1 1 1 1 1 1 1 1 ...       # country-year id nums
#    $ gsigmasq   : num 0.25  # SD of experts' cutpoints around their state cutpoints
#    $ gsigmasqc  : num 0.25  # SD of state cutpoints around the world cutpoints 
#    $ mc         : Named num [1:9] -1.5 -0.5 0.5 1.5 -1.08 ...  # means of the empirical priors
#     ..- attr(*, "names")= chr [1:9] "A 1994-12-31" "B 1994-12-31" 


#   what would the main data look like in the long form?
head(data.frame(rating=demo_data$y, 
                expert=demo_data$j_id, 
                country_year=demo_data$sy_id), 16)


#   test if the model compiles
test_model <- stanc('vdem_mm.stan')


#   compile it
system.time(vdem_mm <- stan_model('vdem_mm.stan'))

#   sample
mm_samp <- sampling(vdem_mm,
                    data=demo_data,
                    iter=2e3,
                    init_r=0.1,
                    chains=4,
                    thin=4,
                    control=list(max_treedepth=2e1, adapt_delta=0.8),
                    seed=4321,
                    pars=c('Z_star', 'gamma_c_z', 'beta_raw'),
                    include=FALSE)

print(mm_samp, pars=c('Z', 'gamma_mu', 'lp__'))

#   another way to plot the estimates
plot(mm_samp, pars='Z')

#   posterior densities
plot(mm_samp, show_density = TRUE, ci_level = 0.5, fill_color = "purple", pars='Z')

#   as histograms
plot(mm_samp, plotfun = "hist", pars = "Z", include = TRUE)

#   joint distributions
stan_scat(mm_samp, pars=c('Z[1]', 'Z[2]'))
stan_scat(mm_samp, pars=c('gamma_mu[1]', 'gamma_mu[2]'))

#   traces of the chains
plot(mm_samp, plotfun = "trace", pars = c("gamma_mu"), inc_warmup = TRUE)

#   distribution of the Rhat statistic
plot(mm_samp, plotfun = "rhat") + ggtitle("Example of adding title to plot")


#   look into the fitting diagnostics
check_hmc_diagnostics(mm_samp)

#   check ess, we got warnings
stan_ess(mm_samp)

#   another way
st <- summary(mm_samp)$summary

head(st)

#   Rhats look OK, but we got some warning
summary(st[, 'Rhat'])

#   for starters, the effective sample size is not good for some parameters
summary(st[, 'n_eff'])

#   there are more diagnostic functions

#   SCRIPT END
