#### Figure 7 ####

# Set working directory to project directory

date = "2022-04-04"

load(paste0("Data/taskviews_sub_graphs/",date,"/taskviews_author_sub_graphs_",date,".RData"))
source("Functions/modified_cranly_functions/cranly_D3_plots.R")


############################



plot.cranly_network_D3(taskviews_author_sub_graphs$ExperimentalDesign, D3 = T)
