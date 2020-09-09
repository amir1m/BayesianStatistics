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
  //int K;
  real murder[N];
  real car[N];
  int<lower=0, upper=1> law[N];
  int state[N];
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters{
  real alpha;
  real beta;
  real gamma;
  real<lower=0> sigma;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model{
  for(i in 1:N)
    murder[i] ~ normal(alpha + beta * law[i] + gamma * car[i], sigma);
    
  alpha ~ normal(0, 1);
  beta ~ normal(0, 1);
  gamma ~ normal(0, 1);
  sigma ~ normal(0, 1);
}

generated quantities{
  real logLikelihood[N];
  for(i in 1:N)
    logLikelihood[i] = normal_lpdf(murder[i] | alpha + beta * law[i] + gamma * car[i], sigma);
}



