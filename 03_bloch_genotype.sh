###############################
###   03_bloch_genotype.sh  ###
###############################
#!/bin/bash
#SBATCH --chdir=.
#SBATCH --job-name=genotype
#SBATCH --partition=nocona
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --array=1-19


# Prepend bcftools path to PATH
source activate vcftools

# define main working directory
workdir=/lustre/scratch/kmenende/camptexa/01_blochmannia

# base name of fastq files, intermediate files, and output files
basename_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/basenames.txt | tail -n1 )

# define the reference genome
refgenome=/lustre/work/kmenende/ref/bloch/C354_texanus.fasta

# run bcftools to genotype
bcftools mpileup --skip-indels -C 0 -d 200 --min-MQ 10 --threads 4 -f ${refgenome} $$

# bgzip
~/anaconda3/bin/bgzip ${workdir}/02_vcf/${basename_array}.vcf

# tabix
~/anaconda3/bin/tabix ${workdir}/02_vcf/${basename_array}.vcf.gz

# filter individual vcf files
bcftools view -i 'MIN(DP)>5' ${workdir}/02_vcf/${basename_array}.vcf.gz > ${workdir}$

# bgzip
~/anaconda3/bin/bgzip ${workdir}/03_vcf/${basename_array}.vcf

# tabix
~/anaconda3/bin/tabix ${workdir}/03_vcf/${basename_array}.vcf.gz
