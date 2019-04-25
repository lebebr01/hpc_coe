# load packages
library(readr)
library(dplyr)
library(broom)
library(xtable)

# read in data
type1error <- read_csv("~/hpc_coe/real_ex1/data/type1errors.csv")

# Logistic Regression
mod_t1e_log <- glm(t1e ~ (factor(n)+factor(p)+rand.dist+gensercor+fitcorstr+Term)^3,
                   data = type1error, family = "binomial")

log_est <- tidy(mod_t1e_log) %>% 
  filter(abs(statistic) > 3.0) %>%
  mutate(conf.low = estimate - 3*std.error,
         conf.high = estimate + 3*std.error) %>%
  mutate(odds = exp(estimate), odds_low = exp(conf.low), odds_high = exp(conf.high)) %>%
  select(term, odds, odds_low, odds_high)


etaCombI.xt <- xtable(log_est, digits = 4,
                      caption = "Parameter estimates")
print(etaCombI.xt, booktabs=TRUE, floating=FALSE,include.rownames=FALSE,
      tabular.environment = "longtable", caption.placement="top",
      file = "~/hpc_coe/real_ex1/table/log_t1e.tex")
