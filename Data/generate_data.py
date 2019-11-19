#!/usr/bin/python3

from os import listdir
from random import shuffle

def clean(line):

	line = line.strip('[\[\]]').replace(',', ' ').capitalize() #strip brackets, replace commas with spaces and capitalize first letter
	line = '{} .'.format(line) #period et end of line

	return line


def main():
	
	path = "SCFG/Compiled"

	for filename in listdir(path):
		file_path = "{}/{}".format(path, filename)
		with open(file_path) as file:
			language_pairs = []
			for line in file:
				line = line.rstrip().split(" ")
				source = clean(line[0])
				target = clean(line[1])
				language_pair = (source, target)
				language_pairs.append(language_pair)
		# print(language_pairs)		
		shuffle(language_pairs)
		
				


if __name__ == '__main__':
	main()