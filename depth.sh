step 7 
#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=depth
#SBATCH --partition=nocona
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-19

#load modules
module load gcc/10.1.0
module load r/4.3.0
R

# Set working directory
workdir=/lustre/scratch/kmenende/camptexa/01_blochmannia

basename_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/basenames.txt | tail -n1 )

# Calculate the depth of coverage per site
~/anaconda3/envs/samtools/bin/samtools depth -a ${workdir}/01_bam_files/${basename_a$

# Isolate the third column with the read counts only to reduce file size
cut -f3 ${workdir}/depth/${basename_array}_depth.txt > ${workdir}/depth/${basename_a$

# Remove the full depth file
rm ${workdir}/depth/${basename_array}_depth.txt

# Make sure to keep the ".R" script in same folder of this "".sh" script

Rscript plot_coverage.R
