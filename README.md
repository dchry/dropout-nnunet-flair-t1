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
This repository is based on the nnUNet v2 model (https://github.com/MIC-DKFZ/nnUNet), so we follow their data convention for model training 
