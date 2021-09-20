#!/bin/bash

#SBATCH --job-name=train
#SBATCH --gres=gpu:2
#SBATCH --output=/home/utah/jiecao/dgx_jobs/fairseq/train.txt
#SBATCH --ntasks=1
#SBATCH --time=80:40:00
#SBATCH --mem=20G
pushd $CODE_BASE/fairseq/data_scripts/
echo "assign gpus ids:"$CUDA_VISIBLE_DEVICES
./train_roberta_256.sh
popd
