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
data{ 
  int N;
  int K;
  real murder[N];
  real car[N];
  int<lower=0, upper=1> law[N];
  int state[N];
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters{
  real alpha[K];
  real beta[K];
  real gamma[K];
  real<lower=0> sigma[K];
  real alpha_top;
  real<lower=0> alpha_sigma;
  real beta_top;
  real<lower=0> beta_sigma;
  real gamma_top;
  real<lower=0> gamma_sigma;
}


// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model{
  for(i in 1:N)
    murder[i] ~ normal(alpha[state[i]] + beta[state[i]] * law[i]
                       + gamma[state[i]] * car[i], sigma[state[i]]);
  alpha ~ normal(alpha_top, alpha_sigma);
  beta ~ normal(beta_top, beta_sigma);
  gamma ~ normal(gamma_top, gamma_sigma);
  alpha_top ~ normal(0, 1);
  beta_top ~ normal(0, 1);
  gamma_top ~ normal(0, 1);
  alpha_sigma ~ normal(0, 1);
  beta_sigma ~ normal(0, 1);
  gamma_sigma ~ normal(0, 1);
  sigma ~ normal(0, 1);
}

generated quantities{
  real alpha_average;
  real beta_average;
  real gamma_average;
  real logLikelihood[N];

  alpha_average = normal_rng(alpha_top, alpha_sigma);
  beta_average = normal_rng(beta_top, beta_sigma);
  gamma_average = normal_rng(gamma_top, gamma_sigma);
  
  for(i in 1:N)
    logLikelihood[i] = normal_lpdf(murder[i] | alpha[state[i]] + beta[state[i]] * law[i]
                       + gamma[state[i]] * car[i], sigma[state[i]]);
}










