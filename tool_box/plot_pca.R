# Set the working directory to where your data files are located
work_dir <- "/Scratch/jill/alignment_results_angsd"
setwd(work_dir)

# Confirm the working directory change
print(getwd())

# Assuming pca_out.cov is in the working directory
cov <- as.matrix(read.table("final.cov"))

# Compute the eigenvalues from our covariance matrix with the function eigen
e <- eigen(cov)

# Basic plot in base R for visualization
# plot(e$vectors[, 1:2])

# Check how much variance the first two components explain
percent_variance_explained <- e$values / sum(e$values)
print(percent_variance_explained)

# Reading the sample name and color mapping directly from sample_color.txt
sample_color_file <- "/Scratch/jill/tools/sample_color.txt"
sample_colors <- read.table(sample_color_file, header = FALSE, stringsAsFactors = FALSE)

# Create a named vector of colors for plotting, using sample names as keys and their colors as values
color_mapping <- setNames(sample_colors$V2, sample_colors$V1)

# If your cov matrix rows are named with the sample names, this step ensures the row names match the sample names
# This is crucial for correctly mapping colors to samples in the plot
# Update the row names of the covariance matrix to match the sample names (if they aren't already)
rownames(cov) <- sample_colors$V1

# Update the plot with colors
plot(e$vectors[, 1:2], col=color_mapping[as.factor(rownames(cov))], pch=16)
