#!/bin/bash
#SBATCH --job-name=onmt_test
#SBATCH --time=20:00
#SBATCH --ntasks=1
#SBATCH --mem=2000
#SBATCH --output=job-%j.log
#SBATCH --partition=short

module restore

source VirtualEnv/bin/activate

onmt_preprocess -train_src Data/SVO_AN/src-train.txt -train_tgt Data/SVO_AN/tgt-train.txt -valid_src Data/SVO_AN/src-val.txt -valid_tgt Data/SVO_AN/tgt-val.txt -save_data Data/SVO_AN/prepro

# onmt_preprocess -train_src Data/SVO_NA/src-train.txt -train_tgt Data/SVO_NA/tgt-train.txt -valid_src Data/SVO_NA/src-val.txt -valid_tgt Data/SVO_NA/tgt-val.txt -save_data Data/SVO_NA/prepro

# onmt_preprocess -train_src Data/SOV_AN/src-train.txt -train_tgt Data/SOV_AN/tgt-train.txt -valid_src Data/SOV_AN/src-val.txt -valid_tgt Data/SOV_AN/tgt-val.txt -save_data Data/SOV_AN/prepro

# onmt_preprocess -train_src Data/SOV_NA/src-train.txt -train_tgt Data/SOV_NA/tgt-train.txt -valid_src Data/SOV_NA/src-val.txt -valid_tgt Data/SOV_NA/tgt-val.txt -save_data Data/SOV_NA/prepro


onmt_train -data Data/SVO_AN/prepro -save_model Models/SVO_AN_model

# onmt_train -data Data/SVO_AN/prepro -early_stopping 3 -valid_steps 1000 -save_model Results/SVO_AN_model

# onmt_train -data Data/SVO_NA/prepro --early_stopping 3 -valid_steps 1000 -save_model Results/SVO_NA_model

# onmt_train -data Data/SOV_AN/prepro --early_stopping 3 -valid_steps 1000 -save_model Results/SOV_AN_model

# onmt_train -data Data/SOV_NA/prepro --early_stopping 3 -valid_steps 1000 -save_model Results/SOV_NA_model