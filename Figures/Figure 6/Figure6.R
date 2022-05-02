#### Figure 6 ####

# Set working directory to project directory


library(RWsearch)
library(lubridate)
library(cranlogs)
library(dplyr)
library(ggplot2)

tvdb_load("Data/saved_TASK_VIEW_snapshots/tvdb-2022-2002.rda")



############################



date = ymd("2022-02-20")
task_views = tvdb_vec()

mnth_dwnloads = vector(length = length(task_views), mode = "list")
names(mnth_dwnloads) = tvdb_vec()


n_taskview_packages_2002 = unlist(lapply(tvdb_pkgs(tvdb_vec()), length))
number_of_pckgs_Task_View_2002 = t(t(n_taskview_packages_2002))
number_of_pckgs_Task_View_2002 = number_of_pckgs_Task_View_2002
colnames(number_of_pckgs_Task_View_2002) = "Number of Packages"




# creates list with number of monthly downloads for each Task View
for(i in tvdb_vec()){
  # i = "Cluster"
  # pkg = tvdb_vec()[i]
  print(i)
  total_dec_21 <- cran_downloads(from = date %m-% months(1), to = date, packages = tvdb_pkgs(i))
  total_dec_21$package = factor(total_dec_21$package)
  
  
  mnth_dwnloads[[i]] = total_dec_21 %>%
    summarise(sum = sum(count))
  
}

total_mnth_downloads_per_task_view = sort(unlist(mnth_dwnloads))
names(total_mnth_downloads_per_task_view) = gsub(x = names(total_mnth_downloads_per_task_view), pattern = ".sum","")
total_mnth_downloads_per_task_view = sort(total_mnth_downloads_per_task_view)
ratio_downloads_per_package = total_mnth_downloads_per_task_view/number_of_pckgs_Task_View_2002[names(total_mnth_downloads_per_task_view),]



dat <- data.frame(`Task Views` = names(sort(ratio_downloads_per_package)),
                  `Number of Downloads in last month` = sort(ratio_downloads_per_package))

dat$Task.Views = factor(names(sort(ratio_downloads_per_package)), levels = names(sort(ratio_downloads_per_package)))


ggplot(data=dat, aes(x=Task.Views, y=Number.of.Downloads.in.last.month)) +
  geom_bar(stat = "identity", fill = "blue")  +
  xlab("Task Views") +
  ylab("Number of Downloads in last month\ndivide by number of packages") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        legend.title = element_blank(),
        legend.text = element_text(size = 14),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14)
  )  +
  scale_y_continuous(limits = c(0,110000), expand = c(0, 0), breaks = round(seq(0, 110000, by = 10000),1))



