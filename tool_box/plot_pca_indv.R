# Description: show samples names on PCA graphs

library(ggplot2)
library(ggrepel)  

# Set
WORD_D <- "/Scratch/jill/alignment_results_angsd"
INPUT <- "final.cov"
OUTPUT <- "pca_indv"
setwd(WORD_D)
file_path <- file.path(WORD_D, INPUT)

# Read
pop <- read.table("/Scratch/jill/tools/sample_color.txt", header = FALSE, stringsAsFactors = FALSE) # individual_name, color
cov <- as.matrix(read.table(file_path))
e <- eigen(cov)
var_explained <- e$values / sum(e$values)

# Prepare data
names <- pop[, 1]
colors <- pop[, 2]
pc_data <- data.frame(Individual = names, PC1 = e$vectors[, 1], PC2 = e$vectors[, 2], Color = colors)

# Generate PCA plot
result_file <- paste(OUTPUT, "pc1_pc2.pdf", sep = "_")
g <- ggplot(pc_data, aes(x = PC1, y = PC2, label = Individual, color = Color)) +
  geom_point() +
  geom_text_repel(size = 3, box.padding = unit(0.35, "lines"), 
                  point.padding = unit(0.3, "lines"), max.overlaps = Inf) + 
  scale_color_identity() +  
  xlab(paste("PC1 (", round(var_explained[1] * 100, 2), "% variance)", sep = "")) +
  ylab(paste("PC2 (", round(var_explained[2] * 100, 2), "% variance)", sep = "")) +
  theme_minimal() +
  ggtitle("PCA Plot")

ggsave(filename = result_file, plot = g, width = 10, height = 8)

