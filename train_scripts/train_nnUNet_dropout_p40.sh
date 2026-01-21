#!/bin/bash
#SBATCH --mem=64G
#SBATCH -c 32
#SBATCH -t 00:10:00
#SBATCH --error=/home/chrysochod/DRP_REPLICATION_FOR_GIT_PUBLISHING/logs/err_%j.err
#SBATCH --output=/home/chrysochod/DRP_REPLICATION_FOR_GIT_PUBLISHING/logs/out_%j.out
#SBATCH -p gpuq
#SBATCH --gres=gpu:a100:1
#SBATCH --job-name=drp_p40

module load cuda11.8/toolkit/11.8.0
nvidia-smi
date

# Activate the Miniconda base environment
source /home/chrysochod/miniconda3/bin/activate

conda activate dropout_nnunet
export PYTHONNOUSERSITE=1


cd /home/chrysochod/DRP_REPLICATION_FOR_GIT_PUBLISHING/dropout-nnunet-flair-t1

export nnUNet_raw="/scr1/users/chrysochod/multimodal_scr/segmentation_replication_for_npj_git/data/raw"
export nnUNet_preprocessed="/scr1/users/chrysochod/multimodal_scr/segmentation_replication_for_npj_git/data/preprocessed"
export nnUNet_results="/scr1/users/chrysochod/multimodal_scr/segmentation_replication_for_npj_git/data/results"

nnUNetv2_train Dataset001_BrainTumor 3d_fullres 0 -tr nnUNetTrainerDropout_p40
