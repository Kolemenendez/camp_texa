step 6 
#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=nocona
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G


# define main working directory\
workdir=/lustre/scratch/kmenende/camptexa/01_blochmannia


#run vcftools with SNP output spaced 20kbp\
#for PCA, EEMS, IBD \
#Filter 1 (in 04_vcf folder)\

~/anaconda3/envs/vcftools/bin/vcftools --vcf ${workdir}/04_vcf/blochmannia_camptexa.$
 --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/bloch_camptexa_final
