#### Figure 1 ####

# Set working directory to project directory

load(file = "Data/saved_CRAN_snapshots/built_networks_04_04_2022.rda")

library(cranly)




plot(All_data$pac_network, package = "cranly")
