library(ggplot2)
library(cowplot)
library(dplyr)

setwd("C:/Users/jhanc/Box/Investigacion/Investigaciones/Side projects/Diversity_lab/MLBioReview")


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
        legend.position = c(.2, .85),
        legend.title = element_text(family="serif", size = 25, face = "bold"),
        plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"))+
  
  scale_x_continuous(breaks = seq(1955, 2025, 10), limit = c(1955, 2025))+
  scale_y_continuous(breaks = seq(0, 200, 20), limit = c(0, 205))+
  
  theme(axis.text.x = element_text(family="serif", size = 27, lineheight = 0.9, vjust = 1, color = "black")) +
  theme(axis.text.y = element_text(family="serif",size = 27, lineheight = 0.9, vjust = 1, color = "black")) +
  theme(axis.title.y = element_text(family="serif",vjust=1, size=30, color = "black")) +
  theme(axis.title.x = element_text(family="serif",vjust=0.3, size=30, color = "black"))

png("Year_Distribution_Nov21-2024.png", height = 15, width = 20, units = "in", res = 300)
plot_all_1955_new
dev.off()


pdf("Year_Distribution_Nov22-2024.pdf", height = 15, width = 20)
plot_all_1955_new 
dev.off()
