# Description: generete file column as Name, Color
# Distinct samples should be colored as green on PCA
# Samples south is blue
# Samples north is yellow  

import pandas as pd

bamlist = pd.read_csv("sample_gps", delimiter='\t', header=None, names=['Name', 'Lat', 'Long'])

# Convert 'Long' and 'Lat' to numeric, coercing errors
bamlist['Long'] = pd.to_numeric(bamlist['Long'], errors='coerce')
bamlist['Lat'] = pd.to_numeric(bamlist['Lat'], errors='coerce')

# SN samples (green)
green_samples = [
    "1049A", "1049B", "1049C", "1049D",
    "1050A", "1050B", "1050C", "1050D",
    "1051A"
]

# Southern samples (red)
southern_samples = [
    "1048D", "1048A", "1048C", "1048B",
    "1047A", "1047B", "1047C",
    "1046A", "1046C", "1046B", "1046D",
    "1029C", "1029A", "1029B",
    "1030A", "1030C", "1030B"
]

golden_gate_lat = 37.8199  # Reference latitude to differentiate north and south

bamlist['Color'] = bamlist.apply(lambda row: 'green' if row['Name'] in green_samples 
                                 else ('red' if row['Name'] in southern_samples
                                       else ('blue' if row['Lat'] < golden_gate_lat else 'yellow')), axis=1)

name_color_df = bamlist[['Name', 'Color']]

name_color_df.to_csv("sample_color.txt", sep='\t', index=False)
