#!/bin/bash
#SBATCH --job-name=onmt_test
#SBATCH --time=20:00
#SBATCH --ntasks=1
#SBATCH --mem=20000
#SBATCH --output=job-%j.log
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:1

module load Python
source VirtualEnv/bin/activate
pip install --upgrade pip
pip install torch
pip install torchvision
pip install torchtext
pip install configargparse


export CUDA_VISIBLE_DEVICES=0

onmt_preprocess -train_src Data/SVO_AN/src-train.txt -train_tgt Data/SVO_AN/tgt-train.txt -valid_src Data/SVO_AN/src-val.txt -valid_tgt Data/SVO_AN/tgt-val.txt -save_data Data/SVO_AN/prepro

# onmt_preprocess -train_src Data/SVO_NA/src-train.txt -train_tgt Data/SVO_NA/tgt-train.txt -valid_src Data/SVO_NA/src-val.txt -valid_tgt Data/SVO_NA/tgt-val.txt -save_data Data/SVO_NA/prepro

# onmt_preprocess -train_src Data/SOV_AN/src-train.txt -train_tgt Data/SOV_AN/tgt-train.txt -valid_src Data/SOV_AN/src-val.txt -valid_tgt Data/SOV_AN/tgt-val.txt -save_data Data/SOV_AN/prepro

# onmt_preprocess -train_src Data/SOV_NA/src-train.txt -train_tgt Data/SOV_NA/tgt-train.txt -valid_src Data/SOV_NA/src-val.txt -valid_tgt Data/SOV_NA/tgt-val.txt -save_data Data/SOV_NA/prepro


onmt_train -data Data/SVO_AN/prepro -world_size 1 -gpu_ranks 0 -train_steps 2014 -early_stopping 3 -valid_steps 50 -save_model Models/SVO_AN_model

# onmt_train -data Data/SVO_AN/prepro -early_stopping 3 -valid_steps 1000 -save_model Results/SVO_AN_model

# onmt_train -data Data/SVO_NA/prepro --early_stopping 3 -valid_steps 1000 -save_model Results/SVO_NA_model

# onmt_train -data Data/SOV_AN/prepro --early_stopping 3 -valid_steps 1000 -save_model Results/SOV_AN_model

# onmt_train -data Data/SOV_NA/prepro --early_stopping 3 -valid_steps 1000 -save_model Results/SOV_NA_model


onmt_translate -model Models/SVO_AN -src Data/SVO_AN/tgt-test.txt -output pred.txt -replace_unk -verbose