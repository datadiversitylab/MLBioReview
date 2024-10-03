library(ggplot2)
library(cowplot)
library(dplyr)

setwd("C:/Users/jhanc/Box/Investigacion/Investigaciones/Side projects/Diversity_lab/MLBioReview")

#Read the dataset
all_results_mod <- read.csv("all_results_mod_Oct2.csv")

#Keep only unique papers (not shared across multiple models)
unique_mod <- all_results_mod[!duplicated(all_results_mod[,c('Title')]),]

#Generate distributions (time-based)
plot_all_1955 <- ggplot(unique_mod, aes(x = Year, fill = Model)) + 
  
  geom_histogram(position = "stack", alpha = 0.6, binwidth = 1, colour = "white") +  # Use alpha to control transparency
  geom_vline(xintercept = 2019, linetype = "dashed", color = "#252422", linewidth = 2) +  # Vertical line at 2019
  
  labs(x = "Year of publication", y = "Number of papers published") + 
  
  scale_fill_manual(values=c("#084c61", "#db3a34", "#ffc857", "#323031"), name  = "Model",
                    breaks = c("gradient boosted trees", "linear regression", "random forest", "support vector machine"),
                    labels = c("Gradient Boosted Trees", "Linear Regression", "Random Forest", "Support Vector Machine")) +
  
  theme_classic() +
  
  theme(legend.key = element_rect(colour = "white"), 
        legend.background = element_rect(colour = "white"), 
        legend.text = element_text(family="serif", size = 22),
        legend.position = c(.15, .85),
        legend.title = element_text(family="serif", size = 25, face = "bold"),
        plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"))+
  
  scale_x_continuous(breaks = seq(1955, 2025, 10), limit = c(1955, 2025))+
  scale_y_continuous(breaks = seq(0, 70, 10), limit = c(0, 65))+
  
  theme(axis.text.x = element_text(family="serif", size = 27, lineheight = 0.9, vjust = 1, color = "black")) +
  theme(axis.text.y = element_text(family="serif",size = 27, lineheight = 0.9, vjust = 1, color = "black")) +
  theme(axis.title.y = element_text(family="serif",vjust=1, size=30, color = "black")) +
  theme(axis.title.x = element_text(family="serif",vjust=0.3, size=30, color = "black"))

png("Year_Distribution_all_1955_Old.png", height = 15, width = 20, units = "in", res = 300)
plot_all_1955
dev.off()






#Read the dataset
all_results_mod_2 <- read.csv("all_results_mod_2_Oct2.csv")

#Keep only unique papers (not shared across multiple models)
unique_mod_2 <- all_results_mod_2[!duplicated(all_results_mod_2[,c('Title')]),]

#Generate distributions (time-based)
plot_all_1955_new <- ggplot(unique_mod_2, aes(x = Year, fill = Model)) + 
  
  geom_histogram(position = "stack", alpha = 0.6, binwidth = 1, colour = "white") +  # Use alpha to control transparency
  geom_vline(xintercept = 2019, linetype = "dashed", color = "#252422", linewidth = 2) +  # Vertical line at 2019
  
  labs(x = "Year of publication", y = "Number of papers published") + 
  
  scale_fill_manual(values=c("#084c61", "#db3a34", "#ffc857", "#323031"), name  = "Model",
                    breaks = c("gradient boosted trees", "linear regression", "random forest", "support vector machine"),
                    labels = c("Gradient Boosted Trees", "Linear Regression and Ordinary Least Squares", "Random Forest", "Support Vector Machine")) +
  
  theme_classic() +
  
  theme(legend.key = element_rect(colour = "white"), 
        legend.background = element_rect(colour = "white"), 
        legend.text = element_text(family="serif", size = 22),
        legend.position = c(.25, .85),
        legend.title = element_text(family="serif", size = 25, face = "bold"),
        plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"))+
  
  scale_x_continuous(breaks = seq(1955, 2025, 10), limit = c(1955, 2025))+
  scale_y_continuous(breaks = seq(0, 70, 10), limit = c(0, 65))+
  
  theme(axis.text.x = element_text(family="serif", size = 27, lineheight = 0.9, vjust = 1, color = "black")) +
  theme(axis.text.y = element_text(family="serif",size = 27, lineheight = 0.9, vjust = 1, color = "black")) +
  theme(axis.title.y = element_text(family="serif",vjust=1, size=30, color = "black")) +
  theme(axis.title.x = element_text(family="serif",vjust=0.3, size=30, color = "black"))

png("Year_Distribution_all_1955_OLS.png", height = 15, width = 20, units = "in", res = 300)
plot_all_1955_new
dev.off()





#Read the dataset
all_ols_lr_results_mod <- read.csv("ols_comb_subset_post2019_Oct2.csv")

#Keep only unique papers (not shared across multiple models)
unique_ols_lr_2 <- all_ols_lr_results_mod[!duplicated(all_ols_lr_results_mod[,c('Title')]),]

#Generate distributions (time-based)
plot_all_1955_OLS_LR <- ggplot(unique_ols_lr_2, aes(x = Year, fill = Model)) + 
  
  geom_histogram(position = "stack", alpha = 0.6, binwidth = 1, colour = "white") +  # Use alpha to control transparency
  geom_vline(xintercept = 2019, linetype = "dashed", color = "#252422", linewidth = 2) +  # Vertical line at 2019
  
  labs(x = "Year of publication", y = "Number of papers published") + 
  
  scale_fill_manual(values=c("#084c61", "#db3a34", "#ffc857"), name  = "Model",
                    breaks = c("linear regression", "ordinary least squares", "OLS_Linear"),
                    labels = c("Linear Regression", "Ordinary Least Squares", "Linear Regression and Ordinary Least Squares")) +
  
  theme_classic() +
  
  theme(legend.key = element_rect(colour = "white"), 
        legend.background = element_rect(colour = "white"), 
        legend.text = element_text(family="serif", size = 22),
        legend.position = c(.25, .85),
        legend.title = element_text(family="serif", size = 25, face = "bold"),
        plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"))+
  
  scale_x_continuous(breaks = seq(1955, 2025, 10), limit = c(1955, 2025))+
  scale_y_continuous(breaks = seq(0, 70, 10), limit = c(0, 65))+
  
  theme(axis.text.x = element_text(family="serif", size = 27, lineheight = 0.9, vjust = 1, color = "black")) +
  theme(axis.text.y = element_text(family="serif",size = 27, lineheight = 0.9, vjust = 1, color = "black")) +
  theme(axis.title.y = element_text(family="serif",vjust=1, size=30, color = "black")) +
  theme(axis.title.x = element_text(family="serif",vjust=0.3, size=30, color = "black"))

png("Year_Distribution_OLS_LR.png", height = 15, width = 20, units = "in", res = 300)
plot_all_1955_OLS_LR
dev.off()



png("Year_Distribution_All_Models.png", height = 20, width = 15, units = "in", res = 300)
plot_grid(plot_all_1955, plot_all_1955_new, plot_all_1955_OLS_LR,
          ncol = 1, nrow = 3, label_fontfamily = "serif", label_size = 20,
          align = "h", label_x = 0, label_y = 1.009, label_fontface = "bold")
dev.off()


