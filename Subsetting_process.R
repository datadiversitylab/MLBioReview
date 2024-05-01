library(ggplot2)

#Read the dataset
all_results_mod <- read_csv("all_results_mod.csv")

#Keep only unique papers (not shared across multiple models)
unique_mod <- all_results_mod[!duplicated(all_results_mod[,c('Title')]),]

#Generate distributions (time-based)
p1 <-ggplot(unique_mod, aes(Year)) + geom_histogram()+ geom_vline(xintercept = 2019) + facet_wrap(~Model, scales = "free")
p1_1 <-ggplot(unique_mod, aes(Year, fill = Model)) + geom_histogram()+ geom_vline(xintercept = 2019) + facet_wrap(~Model + Bio_term, scales = "free")

#Subset for those 2019+
all_results_mod2 <- unique_mod[unique_mod$Year >= 2019, ]
all_results_mod2 <- na.omit(all_results_mod2)

#Export model-based CSV files
for(model in unique(all_results_mod2$Model)){
  t1 <- all_results_mod2[all_results_mod2$Model == model,]
  t2 <- t1[order(t1$Citations, decreasing = T),]
  write.csv(t2, paste0(model,"subset.csv"))
}

#Plot citations based on the filtered dataset
p2 <-ggplot(all_results_mod2, aes(Citations)) + geom_histogram() + facet_wrap(~Model, scales = "free")
p2_2 <-ggplot(all_results_mod2, aes(Citations, fill = Model)) + geom_histogram() + facet_wrap(~Model+ Bio_term, scales = "free")

#Export visuals
pdf("year_dist.pdf")
print(p1)
dev.off()

pdf("year_term_dist.pdf", 30, 30)
print(p1_1)
dev.off()


pdf("citation_dist.pdf")
print(p2)
dev.off()


pdf("citation_term_dist.pdf", 30, 30)
print(p2_2)
dev.off()

