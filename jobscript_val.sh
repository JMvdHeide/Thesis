#!/bin/bash
#SBATCH --job-name=OpenNMT
#SBATCH --time=5:00:00
#SBATCH --ntasks=1
#SBATCH --mem=4000
#SBATCH --output=Logs/Peregrine/job-%j.log
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

for struct in SVO_AN SVO_NA SOV_AN SOV_NA
do
	rm -f Models/${struct}/*.pt
	rm -f Results/${struct}*.txt
	rm -f Data/${struct}/*.pt
done

rm -f Logs/OpenNMT/*.log

export CUDA_VISIBLE_DEVICES=0

onmt_preprocess -train_src Data/SVO_AN/src-train.txt -train_tgt Data/SVO_AN/tgt-train.txt -valid_src Data/SVO_AN/src-val.txt -valid_tgt Data/SVO_AN/tgt-val.txt -save_data Data/SVO_AN/prepro

onmt_preprocess -train_src Data/SVO_NA/src-train.txt -train_tgt Data/SVO_NA/tgt-train.txt -valid_src Data/SVO_NA/src-val.txt -valid_tgt Data/SVO_NA/tgt-val.txt -save_data Data/SVO_NA/prepro

onmt_preprocess -train_src Data/SOV_AN/src-train.txt -train_tgt Data/SOV_AN/tgt-train.txt -valid_src Data/SOV_AN/src-val.txt -valid_tgt Data/SOV_AN/tgt-val.txt -save_data Data/SOV_AN/prepro

onmt_preprocess -train_src Data/SOV_NA/src-train.txt -train_tgt Data/SOV_NA/tgt-train.txt -valid_src Data/SOV_NA/src-val.txt -valid_tgt Data/SOV_NA/tgt-val.txt -save_data Data/SOV_NA/prepro

#--------------------------------------------------------------------------------------------------

onmt_train -data Data/SVO_AN/prepro -world_size 1 -gpu_ranks 0 -save_model Models/SVO_AN/SVO_AN_model -log_file Logs/OpenNMT/SVO_AN.log -train_steps 450 -valid_steps 25 -report_every 25 -save_checkpoint_steps 25

onmt_train -data Data/SVO_NA/prepro -world_size 1 -gpu_ranks 0 -save_model Models/SVO_NA/SVO_NA_model -log_file Logs/OpenNMT/SVO_NA.log -train_steps 450 -valid_steps 25 -report_every 25 -save_checkpoint_steps 25

onmt_train -data Data/SOV_AN/prepro -world_size 1 -gpu_ranks 0 -save_model Models/SOV_AN/SOV_AN_model -log_file Logs/OpenNMT/SOV_AN.log -train_steps 450 -valid_steps 25 -report_every 25 -save_checkpoint_steps 25

onmt_train -data Data/SOV_NA/prepro -world_size 1 -gpu_ranks 0 -save_model Models/SOV_NA/SOV_NA_model -log_file Logs/OpenNMT/SOV_NA.log -train_steps 450 -valid_steps 25 -report_every 25 -save_checkpoint_steps 25

#--------------------------------------------------------------------------------------------------

for struct in SVO_AN SVO_NA SOV_AN SOV_NA
do

	for i in {25..450..25}
	do
		model=Models/${struct}/${struct}_model_step_${i}.pt
		echo $model
		onmt_translate -model $model -src Data/${struct}/src-val.txt -output Results/${struct}/${struct}_step_${i}_pred.txt -replace_unk
	done


# onmt_translate -model Models/SVO_NA_model*.pt -src Data/SVO_NA/src-val.txt -output Results/SVO_NA_pred.txt -replace_unk -verbose

# onmt_translate -model Models/SOV_AN_model*.pt -src Data/SOV_AN/src-val.txt -output Results/SOV_AN_pred.txt -replace_unk -verbose

# onmt_translate -model Models/SOV_NA_model*.pt -src Data/SOV_NA/src-val.txt -output Results/SOV_NA_pred.txt -replace_unk -verbose

done