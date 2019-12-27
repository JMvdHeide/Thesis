#!/bin/bash
#SBATCH --job-name=OpenNMT
#SBATCH --time=1:00:00
#SBATCH --ntasks=1
#SBATCH --mem=4000
#SBATCH --output=Logs/Peregrine/job-%j.log
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:1
#SBATCH --mail-user=jmvdheide96@gmail.com
#SBATCH --mail-type=BEGIN,END

module load Python
source VirtualEnv/bin/activate
# pip install --upgrade pip
# pip install torch
# pip install torchvision
# pip install torchtext
# pip install configargparse
# pip install OpenNMT-py

rm -f Models/*
rm -f Results/*

export CUDA_VISIBLE_DEVICES=0

# sbatch Jobscripts/SVO_AN.sh
# sbatch Jobscripts/SVO_NA.sh
# sbatch Jobscripts/SOV_AN.sh
# sbatch Jobscripts/SOV_NA.sh


onmt_preprocess -train_src Data/SVO_AN/src-train.txt -train_tgt Data/SVO_AN/tgt-train.txt -valid_src Data/SVO_AN/src-val.txt -valid_tgt Data/SVO_AN/tgt-val.txt -save_data Data/SVO_AN/prepro

onmt_preprocess -train_src Data/SVO_NA/src-train.txt -train_tgt Data/SVO_NA/tgt-train.txt -valid_src Data/SVO_NA/src-val.txt -valid_tgt Data/SVO_NA/tgt-val.txt -save_data Data/SVO_NA/prepro

onmt_preprocess -train_src Data/SOV_AN/src-train.txt -train_tgt Data/SOV_AN/tgt-train.txt -valid_src Data/SOV_AN/src-val.txt -valid_tgt Data/SOV_AN/tgt-val.txt -save_data Data/SOV_AN/prepro

onmt_preprocess -train_src Data/SOV_NA/src-train.txt -train_tgt Data/SOV_NA/tgt-train.txt -valid_src Data/SOV_NA/src-val.txt -valid_tgt Data/SOV_NA/tgt-val.txt -save_data Data/SOV_NA/prepro

#--------------------------------------------------------------------------------------------------

onmt_train -data Data/SVO_AN/prepro -world_size 1 -gpu_ranks 0 -save_model Models/SVO_AN_model -log_file Logs/OpenNMT/SVO_AN.log -early_stopping 3 -train_steps 1000 -valid_steps 50

onmt_train -data Data/SVO_NA/prepro -world_size 1 -gpu_ranks 0 -save_model Models/SVO_NA_model -log_file Logs/OpenNMT/SVO_NA.log -early_stopping 3 -train_steps 1000 -valid_steps 50

onmt_train -data Data/SOV_AN/prepro -world_size 1 -gpu_ranks 0 -save_model Models/SOV_AN_model -log_file Logs/OpenNMT/SOV_AN.log -early_stopping 3 -train_steps 1000 -valid_steps 50

onmt_train -data Data/SOV_NA/prepro -world_size 1 -gpu_ranks 0 -save_model Models/SOV_NA_model -log_file Logs/OpenNMT/SOV_NA.log -early_stopping 3 -train_steps 1000 -valid_steps 50

#--------------------------------------------------------------------------------------------------

onmt_translate -model Models/SVO_AN_model*.pt -src Data/SVO_AN/src-test.txt -output Results/SVO_AN_pred.txt -replace_unk -verbose

onmt_translate -model Models/SVO_NA_model*.pt -src Data/SVO_NA/src-test.txt -output Results/SVO_NA_pred.txt -replace_unk -verbose

onmt_translate -model Models/SOV_AN_model*.pt -src Data/SOV_AN/src-test.txt -output Results/SOV_AN_pred.txt -replace_unk -verbose

onmt_translate -model Models/SOV_NA_model*.pt -src Data/SOV_NA/src-test.txt -output Results/SOV_NA_pred.txt -replace_unk -verbose