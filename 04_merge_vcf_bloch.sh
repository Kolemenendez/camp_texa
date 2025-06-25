step 5
#!/bin/bash
#SBATCH --chdir=.
#SBATCH --job-name=merge
#SBATCH --partition=nocona
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1

# Prepend bcftools path to PATH


# define main working directory
workdir=/lustre/scratch/kmenende/camptexa/01_blochmannia

# define variables
region_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/scaffolds.txt  | tail -n1 )

# run bcftools to merge the vcf files
~/anaconda3/envs/bcftools/bin/bcftools merge -m id --regions ${region_array} ${workd$
