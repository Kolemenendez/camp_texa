step 8
#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=pca
#SBATCH --partition=nocona
#SBATCH --nodes=1 --ntasks=4
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=4G


cd /lustre/scratch/kmenende/camptexa/01_blochmannia/05_filtered_vcf


#for PCA 
#plink --vcf bloch_camplaevi_20kbp_final.recode.vcf --allow-extra-chr --double-id --set-missing-var-ids @:#  --pca --out camptexa_bloch_pca_ingroup

# run the same thing but for the out[put with the ref genome  name camptexa_bloch_pca_out_group
plink --vcf bloch_camptexa_final.recode.vcf --allow-extra-chr --double-id --set-missing-var-ids @:#  --pca --out camptexa_bloch_pca_outgroup
