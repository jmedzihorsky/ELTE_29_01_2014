data {
    int<lower=2> K;     // categories
    int<lower=1> J;     // experts
    int<lower=1> C;     // country
    int<lower=1> N;     // country-years
    int<lower=1> n_obs; // observations
    int<lower=1, upper=C> expert_country[J];  // country ids for J experts
    int<lower=1, upper=K> y[n_obs];         // data
    int<lower=1, upper=J> j_id[n_obs];      // expert ids
    int<lower=1, upper=C> c_id[n_obs];      // country ids
    int<lower=1, upper=N> sy_id[n_obs];     // country-year ids
    real<lower=0> gsigmasq;  // expert gamma sd around country gamma
    real<lower=0> gsigmasqc; // country gamma sd around world gamma
    vector[N] mc;   // prior means
}
parameters {
    vector[N] Z_star;                               // country-year positions
    vector<lower=-1.0>[J] beta_raw;                 // expert reliability shifted by -1
    vector<lower=-6.0, upper=6.0>[K-1] gamma_mu;    // world cutpoints
    vector[K-1] gamma_c[C];                         // country cutpoints
    ordered[K-1] gamma[J];                          // expert cutpoints
}
transformed parameters {
    vector[N] Z = mc + Z_star;
    vector[J] beta = beta_raw + 1.0;
}
model {
    vector[n_obs] lp = Z[sy_id] .* beta[j_id];
    vector[n_obs] p;
    vector[K+1] tau[J];                      
    for (j in 1:J) {
        tau[j,1] = -1000000.0;
        tau[j,K+1] = 1000000.0;
    }
    tau[,2:K] = gamma[,];
    for (obs in 1:n_obs) {    
        p[obs] = Phi_approx(tau[j_id[obs], y[obs]+1] - lp[obs])-
                 Phi_approx(tau[j_id[obs], y[obs]] - lp[obs]);
    }
    Z_star ~ std_normal();
    beta_raw ~ std_normal(); 
    for (c in 1:C) 
        gamma_c[c] ~ normal(gamma_mu, gsigmasqc);
    for (j in 1:J)  
        gamma[j] ~ normal(gamma_c[expert_country[j]], gsigmasq);
    target += sum(log(p));
} 


