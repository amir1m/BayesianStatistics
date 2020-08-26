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
  vector[N] Y;
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  real mu;
  real<lower=0> sigma;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  for(i in 1:N)
    Y[i] ~ normal(mu, sigma);
  mu ~ normal(1.7, 0.3)  ;
  sigma ~ cauchy(0,1);
}

// PPC
generated quantities{
  int aMax_indicator;
  int aMin_indicator;
  
  {
    vector[N] lSimData;
  //Generate Posterioe predictive samples
    for(i in 1:100){
      lSimData[i] = normal_rng(mu, sigma);
    }
    
    //Compare with real data
    aMax_indicator = max(lSimData) > max(Y);
    aMin_indicator = min(lSimData) < min(Y);
  }
}
