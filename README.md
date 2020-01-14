# Thesis
A repository for the thesis of Jarik van der Heide

The Data/SCFG folder contains all the basics for data generation.
    Data/SCFG/Words contain the vocabulary to build the SCFG rules.
    scfg_rules.py takes the vocabulary and makes the SCFG rules for every data set and puts them in in the SCFG/Rules folder.
    By using compile_scfg.pl in the Rules folder (commands are in commands.txt in the main folder), the rules get compiled into the           unprocessed language pairs in the SCFG/Compiled folder.
    Generated compiled sentences from prolog > files should be 13,5 MB and contain 161051 lines.
    generate_data.py takes these unprocessed rules, cleans the lines and splits them in source and target, aswell as in training,             validation and test data.
    
To run the experiments on Peregrine a jobscript is needed. This is in the main Thesis folder.
    jobscript_final.sh is the final jobscript for my thesis.
    jobscript_val.sh was used for testing.
    
    for every test and the final run logs are in the Logs folder. This contains logs from OpenNMT and Peregrine. From this I have             extracted the intermediate validation accuracy scores from OpenNMT.

The results, or predictions, from the models are in the Results folder.
accuracy.py in the main folder takes these predictions and determines an accuracy score per saved checkpoint of the models. (the models are not in the repository, because it takes up too much space.)
