# AI-powered segmentation and prognosis with missing MRI in pediatric brain tumors
Link to the paper: https://doi.org/10.1038/s41698-025-01269-x

To clone the code and install all dependencies, run 

```
git clone https://github.com/dchry/dropout-nnunet-flair-t1.git
cd dropout-nnunet-flair-t1
conda env create -f requirements.yml
cd nnUNet
pip install -e .
cd ../batchgeneratorsv2
pip install -e .

```
This repository is based on the nnUNet v2 model (https://github.com/MIC-DKFZ/nnUNet), so we follow their data convention for model training. The training and test data should be organized as shown below. We are using the following convention: FLAIR=0000, T1w-pre=0001, T1w-post=0002, T2w=0003. A sample dataset.json is included in our repo.

```
data/
├── raw/
│   └── Dataset001_BrainTumor/
│       ├── dataset.json
│       ├── imagesTr/
│       │   ├── Case001_0000.nii.gz
│       │   ├── Case001_0001.nii.gz
│       │   ├── Case001_0002.nii.gz
│       │   ├── Case001_0003.nii.gz
│       │   └── ...
│       ├── labelsTr/
│       │   ├── Case001.nii.gz
│       │   └── ...
│       ├── imagesTs/
│       │   ├── Case101_0000.nii.gz
│       │   ├── Case101_0001.nii.gz
│       │   ├── Case101_0002.nii.gz
│       │   ├── Case101_0003.nii.gz
│       │   └── ...
│       └── labelsTs/
│           ├── Case101.nii.gz
│           └── ...
│
├── preprocessed/
│   └── Dataset001_BrainTumor/
│       └── ...
│
└── results/
    └── Dataset001_BrainTumor/
        └── ...

```
