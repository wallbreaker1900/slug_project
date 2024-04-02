# Description: Generates a barplot representing admixture proportions for a given experiment using pcangsd output, with sorting option based on latitude.

# Set working directory
WORD_D <- "/Scratch/jill/alignment_results_ngs/"
INPUT <- "K3.1"
setwd(WORD_D)

# Create a PDF for the plot
pdf(paste(INPUT, "pdf", sep = "."), width = 20, height = 6)

# Read estimated admixture proportions
q <- read.table(paste(INPUT, "qopt", sep = "."))

# Read population info including latitude
# name_location.txt has 2nd column as latitude
pop <- read.table("/Scratch/jill/tools/sample_gps")

# SORT OPTION2: Order according to latitude
# Ensure that latitude is numeric for sorting
pop$V3 <- as.numeric(pop$V2)
ord_lat <- order(pop$V2)

# Plotting the barplot sorted by latitude
barplot(t(q)[, ord_lat],
        col = 1:3,
        names = pop$V1[ord_lat],
        las = 2,
        space = 0,
        border = NA,
        xlab = "Individuals",
        ylab = "Admixture proportions for K=3",
        cex.names = 0.8)

dev.off()
