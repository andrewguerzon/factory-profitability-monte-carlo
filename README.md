# factory-profitability-monte-carlo
Monte Carlo simulation in R evaluating factory profitability, staffing decisions, and automation under uncertainty.
# Factory Profitability & Automation Analysis

## Project Overview

This project uses Monte Carlo simulation in R to evaluate factory profitability under uncertain operating conditions. The analysis models variability in demand, production rates, material costs, and oil prices while comparing different staffing levels and an automation scenario.

The goal of the project is to determine how staffing and automation decisions affect both expected profitability and downside risk.

## Tools Used

- R
- Monte Carlo Simulation
- Statistical Analysis
- Scenario Analysis
- Data Visualization

## Business Questions

- How does staffing level affect expected factory profitability?
- How much risk is associated with different staffing decisions?
- At what staffing level is average simulated profit highest?
- How does automation affect expected profitability?
- Does automation improve the tradeoff between expected profit and downside risk?

## Simulation Approach

The analysis uses 10,000 simulated operating scenarios to account for uncertainty in:

- Customer demand
- Production rate
- Material costs
- Oil prices

The simulation combines these uncertain variables with fixed assumptions for selling price, overhead, and wages to calculate potential profit outcomes across multiple staffing levels.

A separate automation scenario increases production capacity while changing overhead and wage costs, allowing the profitability and risk of the two operating strategies to be compared.

## Key Findings

- Under the baseline scenario, four staff produced the highest average simulated profit at approximately **$1,412**.
- The baseline four-staff scenario had a **1.82% probability of experiencing a loss**.
- Under the automation scenario, four staff again produced the highest average simulated profit, increasing expected profit to approximately **$1,995**.
- The probability of loss at four staff decreased to approximately **0.59% under automation**.
- Increasing staffing beyond the most profitable levels reduced expected profitability as additional operating costs outweighed the benefits of increased production capacity.
- Under the assumptions used in the simulation, automation with four staff provided the strongest combination of expected profitability and downside risk among the scenarios evaluated.

## Visualizations

The project includes three primary visualizations:

1. **Average Profit by Staffing Level** — compares expected profitability across baseline and automation scenarios.
2. **Probability of Loss by Staffing Level** — evaluates downside risk associated with different staffing decisions.
3. **Profit Distribution at Four Staff** — compares the distribution of simulated profit outcomes for the highest-profit staffing level under each scenario.

## Limitations

The results depend on the assumptions and probability distributions used for demand, production rates, material costs, oil prices, wages, and overhead.

The simulation is designed as a scenario-based decision-making model rather than a precise forecast of actual factory performance. Real operating environments may include additional costs, constraints, and sources of uncertainty that are not represented in the model.

## Project Files

- `factory_profitability_simulation.R` — complete Monte Carlo simulation, scenario analysis, visualizations, and interpretation

## Author

**Andrew Guerzon**

MBA Candidate  
University of Rhode Island
