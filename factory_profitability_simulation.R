# Factory Profitability & Automation Analysis
# Monte Carlo Simulation
#
# Objective:
# Evaluate how uncertainty in demand, production rates, and operating
# costs affects factory profitability. The analysis compares staffing
# levels and evaluates whether an automation scenario improves
# profitability and risk.

set.seed(1)

# Number of simulated operating scenarios
n_simulations <- 10000

# Generate uncertain operating variables
demand <- rnorm(n_simulations, 139, 14.61)
demand <- round(demand, digits = 0)
productionRate <- sample(31:41, n_simulations, replace = TRUE)
productionRate <- round(productionRate, digits = 0)
materialCost <- rnorm(n_simulations, 11.50, 2) 
materialCost <- round(materialCost, digits = 2)
oilPrice <- rnorm(n_simulations,3.50,1.5)
oilPrice <- round(oilPrice, digits = 0)

# Baseline business assumptions
price <- 50
overheadCost <- 800
wageCost <-700

# Calculate profit for a given staffing level

calculate_profit <- function(staffLvl, priceLvl, overhead, wage, demandLvl, productionLvl, material, oilPrice){
  priceLvl * pmin(demandLvl, productionLvl * staffLvl) - overhead - (wage * staffLvl) - 
    (productionLvl * staffLvl * material) - oilPrice
}

# Simulate baseline profit across staffing levels
profitResults <- sapply(3:7, calculate_profit, price, overheadCost, wageCost, demand, productionRate, materialCost, oilPrice) #applies the function (fixed and random variables) and plug into the function to solve scenarios

# Summarize profitability and risk for each staffing level

staffingLevels <- 3:7

baselineSummary <- data.frame(
  Staff = staffingLevels,
  MeanProfit = apply(profitResults, 2, mean),
  MedianProfit = apply(profitResults, 2, median),
  StdDev = apply(profitResults, 2, sd),
  ProbabilityOfLoss = apply(profitResults, 2, function(x) mean(x < 0)),
  FifthPercentile = apply(profitResults, 2, function(x) quantile(x, 0.05)),
  NinetyFifthPercentile = apply(profitResults, 2, function(x) quantile(x, 0.95))
)

baselineSummary

# Evaluate possible increasing automation
set.seed(1)
overheadCost <- 900
wageCost <- 550
productionRate <- sample(36:41, n_simulations, replace = TRUE)
productionRate <- round(productionRate, digits = 0)

# Recalculate profit under automation scenario
profitResultsAutomation <- sapply(1:6, calculate_profit, price, overheadCost, wageCost, demand, productionRate, materialCost, oilPrice)
summary(profitResultsAutomation)

# Summarize profitability and risk under automation

automationStaffingLevels <- 1:6

automationSummary <- data.frame(
  Staff = automationStaffingLevels,
  MeanProfit = apply(profitResultsAutomation, 2, mean),
  MedianProfit = apply(profitResultsAutomation, 2, median),
  StdDev = apply(profitResultsAutomation, 2, sd),
  ProbabilityOfLoss = apply(profitResultsAutomation, 2, function(x) mean(x < 0)),
  FifthPercentile = apply(profitResultsAutomation, 2, function(x) quantile(x, 0.05)),
  NinetyFifthPercentile = apply(profitResultsAutomation, 2, function(x) quantile(x, 0.95))
)

automationSummary

# Compare average profit by staffing level

plot(baselineSummary$Staff, baselineSummary$MeanProfit,type = "b", pch = 19,
  xlab = "Staffing Level", ylab = "Average Profit ($)", main = "Average Profit by Staffing Level"
)

lines(automationSummary$Staff, automationSummary$MeanProfit,
  type = "b", pch = 19,lty = 2
)

abline(h = 0, lty = 3)

legend(
  "bottomleft",
  legend = c("Baseline", "Automation"),
  lty = c(1, 2),
  pch = c(19, 19)
)

# Interpretation:
# Average profit increases as staffing approaches four workers under both
# scenarios before declining as additional staffing costs outweigh the
# benefits of increased production capacity.
#
# The baseline scenario reaches its highest average profit at four staff,
# with an average simulated profit of approximately $1,412.
#
# The automation scenario also reaches its highest average profit at four
# staff, but increases average simulated profit to approximately $1,995.
# Under the assumptions of the simulation, automation therefore improves
# expected profitability at the optimal staffing level.

# Compare probability of loss by staffing level

plot(baselineSummary$Staff, baselineSummary$ProbabilityOfLoss * 100, type = "b", pch = 19, xlim = c(1,7),
  ylim = c(0, 100), xlab = "Staffing Level", ylab = "Probability of Loss (%)", main = "Probability of Loss by Staffing Level"
)

lines(automationSummary$Staff, automationSummary$ProbabilityOfLoss * 100,
  type = "b",pch = 19,lty = 2
)

legend(
  "bottomleft",
  legend = c("Baseline", "Automation"),
  lty = c(1, 2),
  pch = c(19, 19)
)
# Interpretation:
# The probability of experiencing a loss increases substantially when
# staffing moves beyond the most profitable levels in both scenarios.
#
# In the baseline scenario, the probability of loss increases from 1.82%
# with four staff to 24.33% with five staff and 73.08% with six staff.
#
# Under automation, four staff produces the highest average profit while
# maintaining a simulated probability of loss of only 0.59%.
# This suggests that automation improves the risk-return tradeoff under
# the assumptions used in the simulation.

# Compare profit distributions at four staff

plot(
  density(profitResults[, 2]),
  xlim = range(profitResults[, 2], profitResultsAutomation[, 4]),
  xlab = "Profit ($)",
  ylab = "Density",
  main = "Profit Distribution at Four Staff",
  lwd = 2
)

lines(
  density(profitResultsAutomation[, 4]),
  lty = 2,
  lwd = 2
)

abline(v = 0, lty = 3)

legend(
  "topleft",
  legend = c("Baseline", "Automation"),
  lty = c(1, 2),
  lwd = c(2, 2)
)
# Interpretation:
# At four staff, the automation scenario shifts the distribution of
# simulated profits toward higher values compared with the baseline.
#
# Average simulated profit increases from approximately $1,412 under
# the baseline scenario to approximately $1,995 under automation.
#
# The probability of a loss also decreases from 1.82% under the
# baseline scenario to 0.59% under automation. Under the assumptions
# of the simulation, automation therefore provides a stronger
# combination of expected profitability and downside risk.

# Final Conclusion:
# The Monte Carlo simulation demonstrates how staffing and automation
# decisions can affect both factory profitability and financial risk.
#
# Under the baseline scenario, four staff produces the highest average
# simulated profit of approximately $1,412, with a 1.82% probability
# of experiencing a loss.
#
# Under the automation scenario, four staff also produces the highest
# average simulated profit at approximately $1,995, while reducing the
# probability of loss to 0.59%.
#
# Based on the assumptions used in this simulation, automation at four
# staff provides the strongest combination of expected profitability
# and downside risk among the scenarios evaluated.