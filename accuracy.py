#!/usr/bin/python3

def main():

	final = open("Results/Final/final_results.txt", "a+")

	for struct in ["SVO_AN", "SVO_NA", "SOV_AN", "SOV_NA"]:
		final.write("{}\n".format(struct))
		print(struct)
		tgt_test = "Data/{}/tgt-test.txt".format(struct)
		print(tgt_test)
		gs_lines = open(tgt_test).read().splitlines()

		for step in range(25, 475, 25):
			correct = 0
			pred_file = "Results/Final/{}/{}_step_{}_pred.txt".format(struct, struct, step)
			print(pred_file)
			pred_lines = open(pred_file).read().splitlines()

			for i in range(len(pred_lines)):
				if gs_lines[i] == pred_lines[i]:
					correct += 1
					# print("{}\n{}".format(gs_lines[i], pred_lines[i]))
			acc = round((correct/len(pred_lines))*100, 4)
			print("Accuracy: {}%".format(acc))
			final.write("({},{})\n".format(step, acc))
		final.write("\n")



if __name__ == '__main__':
	main()