import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import Normalize

file_paths = [
    '/Scratch/jill/alignment_results_angsd/nothern.newres',
    '/Scratch/jill/alignment_results_angsd/sierra_nevada.newres',
    '/Scratch/jill/alignment_results_angsd/santa_cruz.newres',
    '/Scratch/jill/alignment_results_angsd/southern.newres'
]
names_paths = [
    '/Scratch/jill/tools/name_northern.txt',
    '/Scratch/jill/tools/name_sierra_nevade.txt',
    '/Scratch/jill/tools/name_santa_cruz.txt',
    '/Scratch/jill/tools/name_southern.txt'
]

# Initialize subplots
fig, axs = plt.subplots(nrows=2, ncols=2, figsize=(10, 10), dpi=300)
norm = Normalize(vmin=0, vmax=1)  # Normalize the color scale

# Plot each relatedness data set in its respective subplot
for ax, file_path, name_path in zip(axs.flat, file_paths, names_paths):
    # Read the relatedness data
    df = pd.read_csv(file_path, sep='\t')
    
    # Read the names and create a mapping from indices to names
    with open(name_path, 'r') as file:
        names = file.read().splitlines()
    name_dict = {i: name for i, name in enumerate(names)}
    
    # Create the relatedness matrix
    matrix_size = len(names)
    relatedness_matrix = np.full((matrix_size, matrix_size), np.nan)
    for _, row in df.iterrows():
        a, b, rab = int(row['a']), int(row['b']), row['rab']
        relatedness_matrix[a, b] = rab
        relatedness_matrix[b, a] = rab  # Symmetric matrix
    
    # Plot the heatmap
    im = ax.imshow(relatedness_matrix, cmap='hot', norm=norm)
    ax.set_xticks(range(matrix_size))
    ax.set_yticks(range(matrix_size))
    ax.set_xticklabels([name_dict[i] for i in range(matrix_size)], rotation=90, fontsize=6)
    ax.set_yticklabels([name_dict[i] for i in range(matrix_size)], fontsize=6)

# Create an axis for the colorbar on the right side of the grid
cbar_ax = fig.add_axes([0.93, 0.3, 0.02, 0.4])
fig.colorbar(im, cax=cbar_ax)
cbar_ax.set_ylabel('Relatedness')

plt.subplots_adjust(right=0.9, hspace=0.4, wspace=0.4)
plt.savefig('/Scratch/jill/tools/relatedness_heatmaps.png', bbox_inches='tight')
