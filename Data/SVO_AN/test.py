#!/usr/bin/python3

def main():
	with open('src-test.txt', 'r') as test:
		test_data = []
		for line in test:
			line = line.strip()
			test_data.append(line)
			
	with open('src-train.txt', 'r') as train:
		train_data = []
		for line in train:
			line = line.strip()
			train_data.append(line)
	
	with open('src-val.txt', 'r') as val:
		val_data = []
		for line in val:
			line = line.strip()
			val_data.append(line)


		list(set(val_data) & set(train_data))

if __name__ == '__main__':
	main()