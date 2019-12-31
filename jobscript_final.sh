#!/bin/bash
#SBATCH --job-name=OpenNMT_final
#SBATCH --time=5:00:00
#SBATCH --ntasks=1
#SBATCH --mem=4000
#SBATCH --output=Logs/Peregrine/job-%j-final.log
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:1
#SBATCH --mail-user=jmvdheide96@gmail.com
#SBATCH --mail-type=BEGIN,END,FAIL

module load Python
source VirtualEnv/bin/activate
# pip install --upgrade pip
# pip install torch
# pip install torchvision
# pip install torchtext
# pip install configargparse
# pip install OpenNMT-py

export CUDA_VISIBLE_DEVICES=0

for struct in SVO_AN SVO_NA SOV_AN SOV_NA
do
	onmt_preprocess -train_src Data/${struct}/src-train.txt -train_tgt Data/${struct}/tgt-train.txt -valid_src Data/${struct}/src-val.txt -valid_tgt Data/${struct}/tgt-val.txt -save_data Data/Final/${struct}/prepro

	onmt_train -data Data/Final/${struct}/prepro -world_size 1 -gpu_ranks 0 -save_model Models/Final/${struct}/${struct}_model -log_file Logs/OpenNMT/Final/${struct}/${struct}.log -train_steps 450 -valid_steps 25 -report_every 25 -save_checkpoint_steps 25

	for i in {25..450..25}
	do
		model=Models/${struct}/${struct}_model_step_${i}.pt
		echo $model
		onmt_translate -model $model -src Data/${struct}/src-test.txt -output Results/Final/${struct}/${struct}_step_${i}_pred.txt -replace_unk
	done
done