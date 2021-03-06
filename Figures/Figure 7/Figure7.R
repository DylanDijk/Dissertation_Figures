#### Figure 7 ####

# Set working directory to project directory


library(RWsearch)
library(plotly)

tvdb_load("Data/saved_TASK_VIEW_snapshots/tvdb-2022-0404.rda")



############################



n_task_views = length(tvdb_vec())
overlap_tsk = matrix(nrow = n_task_views, ncol = n_task_views)


for(i in 1:n_task_views){
  for(j in 1:n_task_views){
    
    # i =38
    # j = 12
    
    # i = 12
    # j = 38
    
    
    tsk_view_i =  tvdb_vec()[i]
    tsk_view_j =  tvdb_vec()[j]
    
    pkg_tsk_i = tvdb_pkgs(tsk_view_i)
    pkg_tsk_j = tvdb_pkgs(tsk_view_j)
    
    unique_comb = unique(c(pkg_tsk_i, pkg_tsk_j))
    
    
    overlap_tsk[i,j] = length(intersect(pkg_tsk_i, pkg_tsk_j))/(length(pkg_tsk_i))
    
    
    
  }
}

rownames(overlap_tsk) = tvdb_vec()
colnames(overlap_tsk) = tvdb_vec()


diag(overlap_tsk) = NA



plot_ly(x=colnames(overlap_tsk), y=rownames(overlap_tsk),
        z = overlap_tsk, type = "heatmap")
