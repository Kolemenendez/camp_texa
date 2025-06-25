step 1 
step 1 # 01a_extract_blochmannia.sh
#!/bin/bash
#SBATCH --chdir=.
#SBATCH --job-name=extract_camptexa
#SBATCH --partition=nocona
#SBATCH --nodes=1 --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1-19

# Define main working directory for camptexa
workdir=/lustre/scratch/kmenende/camptexa

# Define file for array job: Reads the nth line from sequence_names.txt
basename_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/00_fastq/basenames.txt | $

# define the reference genome
bloch=/lustre/work/kmenende/ref/bloch/C354_texanus.fasta

# Run bbsplit to isolate Blochmannia bacterial reads from raw camptexa fastq files
/lustre/work/jmanthey/bbmap/bbsplit.sh in1=${workdir}/00_fastq/${basename_array}_R1.$

# Remove unnecessary intermediate files if they exist
rm -f ${workdir}/01_blochmannia/${basename_array}_R1.fastq.gz
rm -f ${workdir}/01_blochmannia/${basename_array}_R2.fastq.gz

# Extract Blochmannia reads from interleaved file into separate R1 and R2 files
seqtk seq -1 ${workdir}/01_blochmannia/${basename_array}_C354_texanus.fastq.gz > ${w$
seqtk seq -2 ${workdir}/01_blochmannia/${basename_array}_C354_texanus.fastq.gz > ${w$

# Remove any existing compressed files before compression to avoid bgzip error
rm -f ${workdir}/01_blochmannia/01_cleaned/${basename_array}_R1.fastq.gz
rm -f ${workdir}/01_blochmannia/01_cleaned/${basename_array}_R2.fastq.gz

# Compress cleaned fastq files
bgzip ${workdir}/01_blochmannia/01_cleaned/${basename_array}_R1.fastq
bgzip ${workdir}/01_blochmannia/01_cleaned/${basename_array}_R2.fastq
