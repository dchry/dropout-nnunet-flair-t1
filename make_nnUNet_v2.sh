#!/bin/bash
#SBATCH --mem=32G
#SBATCH -c 16
#SBATCH -t 02:00:00
#SBATCH --error=/home/chrysochod/HPC_Errors/make_nnUNet_v2
#SBATCH --output=/home/chrysochod/HPC_Outputs/make_nnUNet_v2
#SBATCH -p gpuq
#SBATCH --gres=gpu:a100:1

# Load CUDA module
module load cuda11.8/toolkit/11.8.0
nvidia-smi
date

# Activate the Miniconda base environment
source /home/chrysochod/miniconda3/bin/activate

# Create environment if it doesn't exist
if ! conda info --envs | grep -q drp_nnUNet_v3; then
    conda create -n drp_nnUNet_v3 python=3.9 -y
fi

# Activate environment
conda activate drp_nnUNet_v3

# Install PyTorch with CUDA support
if ! python -c "import torch" &>/dev/null; then
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
fi

# Define base directory for installations
BASE_DIR="/home/chrysochod/dropout_nnUNet_v2"

# Clone and install nnUNet in editable mode
NNUNET_DIR="$BASE_DIR/nnUNet"
if [ ! -d "$NNUNET_DIR" ]; then
    git clone https://github.com/MIC-DKFZ/nnUNet.git "$NNUNET_DIR"
fi
cd "$NNUNET_DIR"
pip install -e .

# Clone and install batchgeneratorsv2 in editable mode
BATCHGENV2_DIR="$BASE_DIR/batchgeneratorsv2"
if [ ! -d "$BATCHGENV2_DIR" ]; then
    git clone https://github.com/MIC-DKFZ/batchgeneratorsv2.git "$BATCHGENV2_DIR"
fi
cd "$BATCHGENV2_DIR"
pip install -e .

# Set required environment variables for nnUNet
export nnUNet_raw="/home/chrysochod/dropout_nnUNet_data/raw"
export nnUNet_preprocessed="/home/chrysochod/dropout_nnUNet_data/preprocessed"
export nnUNet_results="/home/chrysochod/dropout_nnUNet_data/results"

# Verify installation
# echo "Checking nnUNet and batchgeneratorsv2 installation..."
# python -c "import nnunet; print('nnUNet installed successfully')"
# python -c "import batchgeneratorsv2; print('batchgeneratorsv2 installed successfully')"

hostname
date
