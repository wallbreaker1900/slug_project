import numpy as np
import matplotlib.pyplot as plt

sfs_1d = np.loadtxt('/Scratch/jill/tools/northern_santa_cruz.folded.2dsfs')
normalized_sfs = sfs_1d / sfs_1d.sum()
log_normalized_sfs = np.log(normalized_sfs + 1e-10)
n1 = (54+1)*2  # the number of allele frequencies in population 1
m1 = (48+1)*2  # the number of allele frequencies in population 2
sfs_2d_1 = log_normalized_sfs.reshape((n1+1, m1+1))

sfs_1d = np.loadtxt('/Scratch/jill/tools/northern_southern.folded.2dsfs')
normalized_sfs = sfs_1d / sfs_1d.sum()
log_normalized_sfs = np.log(normalized_sfs + 1e-10)
n2 = (54+1)*2  # the number of allele frequencies in population 1
m2 = (16+1)*2  # the number of allele frequencies in population 2
sfs_2d_2 = log_normalized_sfs.reshape((n2+1, m2+1))

sfs_1d = np.loadtxt('/Scratch/jill/tools/southern_santa_cruz.folded.2dsfs')
normalized_sfs = sfs_1d / sfs_1d.sum()
log_normalized_sfs = np.log(normalized_sfs + 1e-10)
n3 = (16+1)*2  # the number of allele frequencies in population 1
m3 = (48+1)*2  # the number of allele frequencies in population 2
sfs_2d_3 = log_normalized_sfs.reshape((n3+1, m3+1))

new_sfs_2d_1 = sfs_2d_1
new_sfs_2d_2 = sfs_2d_2
new_sfs_2d_3 = sfs_2d_3

# Find global min and max for shared color scale
vmin = min(np.min(new_sfs_2d_1), np.min(new_sfs_2d_2), np.min(new_sfs_2d_3))
vmax = max(np.max(new_sfs_2d_1), np.max(new_sfs_2d_2), np.max(new_sfs_2d_3))

fig, axs = plt.subplots(nrows=2, ncols=2, figsize=(10, 10))

# Set aspect ratio and adjustable parameter
aspect_ratio = 'auto'  # or use a specific ratio like 'equal' or a numeric value

# Plot the first heatmap
cax1 = axs[0, 0].imshow(new_sfs_2d_1, cmap='hot', interpolation='nearest', origin='lower', vmin=vmin, vmax=vmax, aspect=aspect_ratio)
axs[0, 0].set_title('Northern vs Santa Cruz')
axs[0, 0].set_xlabel('Santa Cruz Allele Frequency')
axs[0, 0].set_ylabel('Northern Allele Frequency')

# Turn off the top right subplot
axs[0, 1].axis('off')

# Plot the second heatmap
cax2 = axs[1, 0].imshow(new_sfs_2d_2, cmap='hot', interpolation='nearest', origin='lower', vmin=vmin, vmax=vmax, aspect=aspect_ratio)
axs[1, 0].set_title('Northern vs Southern')
axs[1, 0].set_xlabel('Southern Allele Frequency')
axs[1, 0].set_ylabel('Northern Allele Frequency')

# Plot the third heatmap
cax3 = axs[1, 1].imshow(new_sfs_2d_3, cmap='hot', interpolation='nearest', origin='lower', vmin=vmin, vmax=vmax, aspect=aspect_ratio)
axs[1, 1].set_title('Southern vs Santa Cruz')
axs[1, 1].set_xlabel('Santa Cruz Allele Frequency')
axs[1, 1].set_ylabel('Southern Allele Frequency')

# Add a colorbar to the figure
fig.colorbar(cax3, ax=axs, orientation='vertical', fraction=.1)
plt.savefig('/Scratch/jill/tools/sfs_heatmaps.png', dpi=300, bbox_inches='tight')
