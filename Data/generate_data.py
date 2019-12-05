#!/usr/bin/python3

from os import listdir
from random import shuffle, sample

def clean_line(line):

	line = line.strip('[\[\]]').replace(',', ' ').capitalize()
	line = '{} .'.format(line)

	return line

def generate_data(language_pairs, filename, keys, split):

	dirs = {"data_svo_an.txt": "SVO_AN",
			"data_svo_na.txt": "SVO_NA",
			"data_sov_an.txt": "SOV_AN",
			"data_sov_na.txt": "SOV_NA"
	}
	directory = dirs[filename]

	#Generate test data
	print("Generating test data...")
	test_data = [language_pairs.pop(key) for key in keys]
	src_test = open("{}/src-test.txt".format(directory), "a+")
	tgt_test = open("{}/tgt-test.txt".format(directory), "a+")
	for pair in test_data:
		src_test.write(pair[0] + "\n")
		tgt_test.write(pair[1] + "\n")
	src_test.close()
	tgt_test.close()

	#Convert remaining dict values to list and shuffle
	language_pairs = list(language_pairs.values())
	shuffle(language_pairs)

	#Generate validation data
	print("Generating validation data...")
	val_data = language_pairs[:split]
	src_val = open("{}/src-val.txt".format(directory), "a+")
	tgt_val = open("{}/tgt-val.txt".format(directory), "a+")
	for pair in val_data:
		src_val.write(pair[0] + "\n")
		tgt_val.write(pair[1] + "\n")
	src_val.close()
	tgt_val.close()

	#Generate training data
	print("Generating training data...")
	train_data = language_pairs[split:]
	src_train = open("{}/src-train.txt".format(directory), "a+")
	tgt_train = open("{}/tgt-train.txt".format(directory), "a+")
	for pair in train_data:
		src_train.write(pair[0] + "\n")
		tgt_train.write(pair[1] + "\n")
	src_train.close()
	tgt_train.close()

def main():
	
	path = "SCFG/Compiled"

	check = 0
	for filename in listdir(path):
		print("Current file: {}".format(filename))
		file_path = "{}/{}".format(path, filename)
		with open(file_path) as file:
			language_pairs = dict()
			key = 0
			for line in file:
				line = line.rstrip().split(" ")
				source = clean_line(line[0])
				target = clean_line(line[1])
				language_pair = (source, target)
				language_pairs[key] = language_pair #Put pairs in a numbered dict
				key += 1

		if check == 0: #Only generates the keys for test data once
			split = round(len(language_pairs)/10)
			keys = sample(range(0,len(language_pairs)), split)
			check += 1

		generate_data(language_pairs, filename, keys, split)
		print("\n")
		
if __name__ == '__main__':
	main()