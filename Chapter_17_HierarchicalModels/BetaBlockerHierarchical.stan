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

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;
  int<lower=0> nt[N];
  int<lower=0> rt[N];
  int<lower=0> nc[N];
  int<lower=0> rc[N];
}
parameters {
  real d;
  real<lower=0> sigma;
  vector[N] mu;
  vector[N] delta;
}
model {
  rt ~ binomial_logit(nt, mu + delta);
  rc ~ binomial_logit(nc, mu);
  delta  ~ normal(d, sigma);
  mu ~ normal(0, 10);
  d ~ normal(0, 10);
  sigma ~ cauchy(0, 2.5);
}

generated quantities {
  real delta_new = normal_rng(d, sigma);
}





