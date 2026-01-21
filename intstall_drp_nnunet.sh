#!/bin/bash
#SBATCH --mem=32G
#SBATCH -c 16
#SBATCH -t 02:00:00
#SBATCH --error=/home/chrysochod/DRP_REPLICATION_FOR_GIT_PUBLISHING/logs/make_nnUNet_v2.err
#SBATCH --output=/home/chrysochod/DRP_REPLICATION_FOR_GIT_PUBLISHING/logs/make_nnUNet_v2.out
#SBATCH -p gpuq
#SBATCH --gres=gpu:a100:1

# =========================
# Safety & logging
# =========================
set -e  # exit immediately if any command fails

echo "Job started on $(hostname)"
date

# =========================
# Load CUDA
# =========================
module load cuda11.8/toolkit/11.8.0
nvidia-smi

# =========================
# Activate conda
# =========================
source /home/chrysochod/miniconda3/bin/activate

# =========================
# Clone repo (skip if exists)
# =========================
REPO_DIR="dropout-nnunet-flair-t1"
REPO_URL="https://github.com/dchry/dropout-nnunet-flair-t1.git"

if [ ! -d "$REPO_DIR" ]; then
    git clone "$REPO_URL"
else
    echo "Repo already exists, skipping clone"
fi

cd "$REPO_DIR"

# =========================
# Create conda environment
# =========================
conda env create -f requirements.yml

# Activate the newly created env
# (extract env name automatically)
ENV_NAME=$(grep "^name:" requirements.yml | awk '{print $2}')
conda activate "$ENV_NAME"

# =========================
# Install nnUNet (editable)
# =========================
cd nnUNet
pip install -e .
cd ..

# =========================
# Install batchgeneratorsv2 (editable)
# =========================
cd batchgeneratorsv2
pip install -e .
cd ..

# =========================
# Done
# =========================
echo "Setup complete"
date
