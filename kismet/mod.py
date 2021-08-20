import json

tracery_files = ['../tracery/edwardian.tracery']
tracery_grammar = {}
for f in tracery_files:
    grammar = json.load(open(f,'r'))
    for key in grammar:
        if key not in tracery_grammar:
            tracery_grammar[key] = []
        tracery_grammar[key] = grammar[key]