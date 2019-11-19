#!/usr/bin/python3

#arguments:
	# 'svo_an': makes rules for SVO structure with adjectives preceding nouns
	# 'svo_na': makes rules for SVO structure with nouns preceding adjectives
	# 'sov_an': makes rules for SOV structure with adjectives preceding nouns
	# 'sov_na': makes rules for SOV structure with nouns preceding adjectives
	# 'all': makes different files for all of the above

import sys

def construct_rules(structures):
	svo = 'vp ---> [{}], np // [{}], 1.'
	sov = 'vp ---> np, [{}] // [{}], 1.'
	an = 'np ---> [{}], adj, [{}] // [{}], 1, [{}].'
	na = 'np ---> [{}], [{}], adj // [{}], 1, [{}].'

	adj = 'adj ---> [{}] // [{}].'

	for structure in structures:
		if structure in {'sov_an', 'sov_na'}:
			vp_rules_list = vp_rules(sov)
		else:
			vp_rules_list = vp_rules(svo)

		if structure in {'svo_an', 'sov_an'}:
			np_rules_list = np_rules(an)
		else:
			np_rules_list = np_rules(na)

		adj_rules_list = adj_rules(adj)

		all_rules = [np_rules_list, vp_rules_list, adj_rules_list]

		construct_file(structure, all_rules)

def construct_file(structure, all_rules):
	with open('Rules/scfg_{}.pl'.format(structure), 'w') as file:
		file.write(':- use_module(compile_scfg).\n\n:- op(1050, xfy, \'--->\').\n:- op(1040, xfy, \'//\'   ).\n\n')
		file.write('s ---> np, vp // 1, 2.\n\n')
		for rule_set in all_rules:
			for rule in rule_set:
				file.write(rule + '\n')
			file.write('\n')


def vp_rules(vp_structure):
	vp_rules_list = []

	with open('Words/verbs.txt') as verbs:
		for verb_pair in verbs:
			verb_pair = verb_pair.rstrip().split('\t')
			verb_en = verb_pair[0]
			verb_nl = verb_pair[1]

			vp_rules_list.append(vp_structure.format(verb_en, verb_nl))

		return vp_rules_list

def np_rules(np_structure):

	np_rules_list = []

	det_en = 'the'
	dets_nl = ['de','het']

	with open('Words/nouns.txt') as nouns:
		for noun_pair in nouns:
			noun_pair = noun_pair.rstrip().split('\t')
			noun_en = noun_pair[0]
			noun_nl = noun_pair[1]
			
			if noun_nl[-1] == '1':
				det_nl = dets_nl[0]
			else:
				det_nl = dets_nl[1]

			noun_nl = noun_nl[:-1]

			np_rules_list.append(np_structure.format(det_en, noun_en, det_nl, noun_nl))

		return np_rules_list

def adj_rules(adj_structure):
	adj_rules_list = []

	with open('Words/adj.txt') as adj:
		for adj_pair in adj:
			adj_pair = adj_pair.rstrip().split('\t')
			adj_en = adj_pair[0]
			adj_nl = adj_pair[1]

			adj_rules_list.append(adj_structure.format(adj_en, adj_nl))

		return adj_rules_list

def main():
	if len(sys.argv) == 2:
		structure = sys.argv[1]
		if structure in {'svo_an', 'svo_na', 'sov_an', 'sov_na', 'all'}:
			if structure == 'all':
				construct_rules(['svo_an', 'svo_na', 'sov_an', 'sov_na'])
			else: 
				construct_rules([structure])

		else: 
			print('Not a valid argument, please use \'svo_an\', \'svo_na\', \'sov_an\', \'sov_na\' or \'all\'.')
	else:
		print('Please use \'svo_an\', \'svo_na\', \'sov_an\', \'sov_na\' or \'all\' as an argument.')
	



if __name__ == '__main__':
	main()