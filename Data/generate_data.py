#!/usr/bin/python3

from os import listdir
from random import shuffle

def clean_line(line):

	line = line.strip('[\[\]]').replace(',', ' ').capitalize() #strip brackets, replace commas with spaces and capitalize first letter
	line = '{} .'.format(line) #period et end of line

	return line

def generate_data(language_pairs, filename):

	dirs = {"data_svo_an.txt": "SVO_AN",
			"data_svo_na.txt": "SVO_NA",
			"data_sov_an.txt": "SOV_AN",
			"data_sov_na.txt": "SOV_NA"
	}
	directory = dirs[filename]

	split = round(len(language_pairs)/10)

	#Generate training data
	train_data = language_pairs[(2*split):]
	src_train = open("{}/src-train.txt".format(directory), "a+")
	tgt_train = open("{}/tgt-train.txt".format(directory), "a+")
	for pair in train_data:
		src_train.write(pair[0] + "\n")
		tgt_train.write(pair[1] + "\n")
	src_train.close()
	tgt_train.close()

	#Generate validation data
	val_data = language_pairs[split:(2*split)]
	src_val = open("{}/src-val.txt".format(directory), "a+")
	tgt_val = open("{}/tgt-val.txt".format(directory), "a+")
	for pair in val_data:
		src_val.write(pair[0] + "\n")
		tgt_val.write(pair[1] + "\n")
	src_val.close()
	tgt_val.close()

	#Generate test data
	test_data = language_pairs[:split]
	src_test = open("{}/src-test.txt".format(directory), "a+")
	tgt_test = open("{}/tgt-test.txt".format(directory), "a+")
	for pair in test_data:
		src_test.write(pair[0] + "\n")
		tgt_test.write(pair[1] + "\n")
	src_test.close()
	tgt_test.close()

def main():
	
	path = "SCFG/Compiled"

	for filename in listdir(path):
		file_path = "{}/{}".format(path, filename)
		with open(file_path) as file:
			language_pairs = []
			for line in file:
				line = line.rstrip().split(" ")
				source = clean_line(line[0])
				target = clean_line(line[1])
				language_pair = (source, target)
				language_pairs.append(language_pair)
		# print(language_pairs)		
		shuffle(language_pairs)
		generate_data(language_pairs, filename)				


if __name__ == '__main__':
	main()