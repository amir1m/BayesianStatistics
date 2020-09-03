//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

data { int N;
  int<lower=0> X[N];
}

parameters {
  real<lower=0> mu;
  real<lower=0> kappa;
}

model {
  X ~ neg_binomial_2(mu, kappa);
  mu ~ lognormal(2, 1);
  kappa ~ lognormal(2, 1);
}

generated quantities{
  int<lower=0> XSim[N];
  for (i in 1:N)
    XSim[i] <- neg_binomial_2_rng(mu, kappa);
}

