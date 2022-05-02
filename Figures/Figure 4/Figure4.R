#### Figure 4 ####

# Set working directory to project directory

date = "2022-02-20"

load(paste0("Data/taskviews_sub_graphs/",date,"/taskviews_author_sub_graphs_",date,".RData"))

library(RWsearch)
library(tibble)
library(tidyr)
library(ggplot2)

tvdb_load("Data/saved_TASK_VIEW_snapshots/tvdb-2022-2002.rda") 



############################



fun1 = function(x){
  
  length(x$nodes$author)
  
}

n_taskview_authors_2002 = unlist(lapply(taskviews_author_sub_graphs, fun1)) 

n_taskview_packages_2002 = unlist(lapply(tvdb_pkgs(tvdb_vec()), length))



############################



authors = sort(unlist(n_taskview_authors_2002))
pkgs = n_taskview_packages_2002
x = sort(n_taskview_packages_2002)
pkgs = pkgs[names(authors)]
data1 = rbind(authors,pkgs)

data1 = as_tibble(data1)
data1 = rownames_to_column(data1, "type")
data1$type = c("Authors", "Packages")
data1 = gather(data1, `Task View`, value, -c(type))
data1$`Task View` = factor(data1$`Task View`, levels = names(authors))



ggplot(data=data1, aes(x=`Task View`, y=value, fill=type)) +
  geom_bar(stat="identity", position ="identity")  +
  xlab("Task Views") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        legend.title = element_blank(),
        legend.text = element_text(size = 14),
        axis.title.x = element_text(size = 14)
  )  +
  scale_y_continuous(limits = c(0,800), expand = c(0, 0)) 
