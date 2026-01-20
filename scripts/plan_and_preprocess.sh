#!/bin/bash
#SBATCH --mem=32G
#SBATCH -c 16
#SBATCH -t 03:00:00
#SBATCH --error=/logs/err_%j.err
#SBATCH --output=/logs/out_%j.out
#SBATCH -p gpuq
#SBATCH --gres=gpu:a100:1

module load cuda11.8/toolkit/11.8.0
nvidia-smi
date

# Activate the Miniconda base environment. Please adjust the path based on your local machine
source ~/miniconda3/bin/activate

conda activate dropout_nnUNet
# pip install blosc2


cd {parent_directory}/dropout-nnunet-flair-t1/nnUNet #Please adjust {parent_directory}

export nnUNet_raw="{parent_directory}/data/raw"
export nnUNet_preprocessed="{parent_directory}/data//preprocessed"
export nnUNet_results="{parent_directory}/data/results"

nnUNetv2_plan_and_preprocess -d 001 --verify_dataset_integrity
