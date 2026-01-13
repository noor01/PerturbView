#!/bin/bash
#SBATCH --job-name=process_p65_plate1
#SBATCH --partition=hai
#SBATCH --account=cadd
#SBATCH --time=72:00:00
#SBATCH --cpus-per-task=16
#SBATCH --mem=100G
#SBATCH --gres=gpu:1
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=noor01@stanford.edu
#SBATCH --output=slurm_%j_p65_plate1.out
#SBATCH --error=slurm_%j_p65_plate1.err

# Print job info
echo "Job ID: $SLURM_JOB_ID"
echo "Running on node: $HOSTNAME"
echo "Starting at: $(date)"

# Set Python path to include project directory
export PYTHONPATH=/afs/.ir/users/n/o/noor01/projects/PerturbView:$PYTHONPATH

# Set BaSiC DCT backend to suppress warning
export BASIC_DCT_BACKEND=JAX

# Run the snakemake pipeline using mamba run
mamba run -n PerturbView snakemake --snakefile snakefile_p65_hai \
    --cores 4 \
    --printshellcmds

# Print completion time
echo "Finished at: $(date)"
