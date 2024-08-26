#!/bin/bash

# Define source and target directories
source_dir="/scratch/markop/WORK/_p_ExtAnalysis/_I_SecoveljskeSoline/_S_DNA_seq/_A_02_ShotgunMeta-IlluminaSeq/input/fq"
target_dir="/scratch/markop/WORK/_p_ExtAnalysis/_I_SecoveljskeSoline/_S_DNA_seq/_A_02_ShotgunMeta-IlluminaSeq/input/fq_cat"

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory $source_dir not found."
    exit 1
fi

# Check if target directory exists, if not create it
if [ ! -d "$target_dir" ]; then
    mkdir -p "$target_dir" || { echo "Failed to create target directory $target_dir"; exit 1; }
fi


# Change to the source directory
cd "$source_dir" || { echo "Failed to change to source directory $source_dir"; exit 1; }


# Find unique prefixes and suffixes
#prefixes=$(ls | cut -d "_" -f1 | sort -u)
#suffixes=$(ls | rev | cut -d "_" -f1 | rev | sort -u)

prefixes=$(find . -maxdepth 1 -type f -printf '%f\n' | cut -d "_" -f1 | sort -u)
suffixes=$(find . -maxdepth 1 -type f -printf '%f\n' | rev | cut -d "_" -f1 | rev | sort -u)




# Concatenate files
for prefix in $prefixes; do
    for suffix in $suffixes; do
        files=$(find . -maxdepth 1 -type f -name "${prefix}_*${suffix}" -printf '%f\n'| sort -u)
        if [ -n "$files" ]; then
            echo "Writing: ${target_dir}/${prefix}_${suffix}"
            cat $files > "${target_dir}/${prefix}_${suffix}"
        fi
    done
done

