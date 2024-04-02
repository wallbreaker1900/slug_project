# Description: Generates a barplot representing admixture proportions for a given experiment using pcangsd output.

# Change
WORD_D <- "/Scratch/jill/alignment_results_ngs/"
INPUT <- "K3.5"

setwd(WORD_D)

# Create a PDF for the plot
pdf(paste(INPUT, "pdf", sep = "."), width = 20, height = 6)

# Read estimated admixture proportions
q <- read.table(paste(INPUT, "qopt", sep = "."))

# SORT OPTION1: Order according to PC1
# To create input.txt: 
# col1: the name of the experiment name in order
# col2: need to extract the first column of pcangsd_out.cov
pop <- read.table("/Scratch/jill/tools/sample_pc1")
ord <- order(pop$V2)

barplot(t(q)[, ord],
        col = 1:3,
        names = pop$V1[ord],
        las = 2,
        space = 0,
        border = NA,
        xlab = "Individuals",
        ylab = "Admixture proportions for K=3",
        cex.names = 0.8)
