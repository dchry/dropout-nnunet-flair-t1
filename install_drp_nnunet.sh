#!/bin/bash
#SBATCH --mem=32G
#SBATCH -c 16
#SBATCH -t 02:00:00
#SBATCH --error=/home/chrysochod/DRP_REPLICATION_FOR_GIT_PUBLISHING/logs/make_nnUNet_v2.err
#SBATCH --output=/home/chrysochod/DRP_REPLICATION_FOR_GIT_PUBLISHING/logs/make_nnUNet_v2.out
#SBATCH -p gpuq
#SBATCH --gres=gpu:a100:1

set -e

echo "Job started on $(hostname)"
date

module load cuda11.8/toolkit/11.8.0
nvidia-smi

source /home/chrysochod/miniconda3/bin/activate

REPO_DIR="/home/chrysochod/dropout-nnunet-flair-t1"
cd "$REPO_DIR"

ENV_NAME=$(grep "^name:" requirements.yml | awk '{print $2}')

# If you want it to be reproducible each time, nuke + recreate:
conda env remove -n "$ENV_NAME" -y 2>/dev/null || true
conda env create -f requirements.yml

conda activate "$ENV_NAME"

cd nnUNet
pip install -e .
cd ../batchgeneratorsv2
pip install -e .
cd ..

echo "Setup complete"
date
