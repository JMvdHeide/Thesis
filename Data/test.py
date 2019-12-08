#!/usr/bin/python3

from os import listdir
from random import shuffle, sample

def clean_line(line):

	line = line.strip('[\[\]]').replace(',', ' ').capitalize()
	line = '{} .'.format(line)

	return line

def list_targets(file_path):

		with open(file_path) as file:
			targets = []
			for line in file:
				line = line.rstrip().split(" ")
				target = clean_line(line[1])
				targets.append(target)
		return targets

def main():
	
	path = "SCFG/Compiled"

	file_paths = []
	for filename in listdir(path):
		file_path = "{}/{}".format(path, filename)
		file_paths.append(file_path)

	targets1 = list_targets(file_paths[0])
	targets2 = list_targets(file_paths[1])
	targets3 = list_targets(file_paths[2])
	targets4 = list_targets(file_paths[3])

	# targets4.append("wut")

	targets = [targets1, targets2, targets3, targets4]

	# identical = True
	# while identical == True:
	# 	for i in targets:
	# 		for j in targets:
	# 			if i != j:
	# 				identical = False
	# 				print('Not all target lists are identical.')
	# 	identical = False
	# 	print('All target lists are identical.')

	for i in targets:
		for j in range(len(targets)):
			if i == targets[j+1]:
				print('True')

if __name__ == '__main__':
	main()