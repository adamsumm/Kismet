from antlr4 import *
from . import kismetLexer
from . import kismetParser
import numpy as np

import json
import collections
import subprocess
import random
import sys

from antlr4.error.ErrorListener import ErrorListener

class MyErrorListener( ErrorListener ):
    def __init__(self):
        super()
        self.errors = []
    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        self.errors.append(str(line) + ":" + str(column) + ": syntax ERROR, " + str(msg))

    def reportAmbiguity(self, recognizer, dfa, startIndex, stopIndex, exact, ambigAlts, configs):
        self.errors.append( "Ambiguity ERROR, " + str(configs))

    def reportAttemptingFullContext(self, recognizer, dfa, startIndex, stopIndex, conflictingAlts, configs):
        self.errors.append( "Attempting full context ERROR, " + str(configs))


    def reportContextSensitivity(self, recognizer, dfa, startIndex, stopIndex, prediction, configs):
        self.errors.append( "Context ERROR, " + str(configs))
class kismetListener(ParseTreeListener):
    def __init__(self):
        self.locations = []
        self.traits = {}
        self.trait_oppositions = []
        self.actions = []
        self.patterns = []
        self.str2query = {}
        self.currentArguments = None
        self.currentOpposition = None
        self.currentTrait = None
        self.currentModifier = None
        self.currentQuery = None
        self.currentAction = None
        self.currentHas = None
        self.currentAdd = None
        self.currentRemove = None
        self.currentLocation = None
        self.currentAt = None
        self.currentGoto = None
        self.currentPattern = None

    def enterName(self, ctx):
        if self.currentAt != None:
            self.currentAt.append(ctx.getText())
        elif self.currentTrait:
            self.currentTrait['name'] = ctx.getText()
        elif self.currentAction:
            self.currentAction['name'] = ctx.getText()
        elif self.currentLocation != None:
            self.currentLocation['name'] = ctx.getText()
        elif self.currentOpposition != None:
            self.currentOpposition.append(ctx.getText())
        elif self.currentPattern:
            self.currentPattern['name'] = ctx.getText()
    # Exit a parse tree produced by kismetParser#simulation.
    def exitName(self, ctx):
        pass
    def enterComparison(self,ctx):
        print('Comparison >')
        pass
    def exitComparison(self,ctx):
        print('Comparison <')
        pass

    def enterComparator(self,ctx):
        print('Comparator >')
        pass
    def exitComparator(self,ctx):
        print('Comparator <')
        pass
# Enter a parse tree produced by kismetParser#trait.
    def enterTrait_oppositions(self, ctx):
        self.currentOpposition = []

    # Exit a parse tree produced by kismetParser#trait.
    def exitTrait_oppositions(self, ctx):
        self.trait_oppositions.append(self.currentOpposition)
        self.currentOpposition = None

    # Enter a parse tree produced by kismetParser#trait.
    def enterTrait(self, ctx):
        self.currentTrait = {
            'name':'',
            'modifiers':[],
            'gotos':[],
            'support':[]
        }

    # Exit a parse tree produced by kismetParser#trait.
    def exitTrait(self, ctx):
        self.traits[self.currentTrait['name']] = self.currentTrait
        self.currentTrait = None


    # Enter a parse tree produced by kismetParser#modifier.
    def enterModifier(self, ctx):
        self.currentModifier = {
                'valence':'',
                'tags':[],
                'query':[],
            }
        self.currentTrait['modifiers'].append(
            self.currentModifier
        )

    # Exit a parse tree produced by kismetParser#modifier.
    def exitModifier(self, ctx):
        self.currentModifier = None

    def enterGoto(self, ctx):
        self.currentModifier = {
                'valence':'',
                'tags':[],
                'query':[],
            }
        self.currentTrait['gotos'].append(
            self.currentModifier
        )

    # Exit a parse tree produced by kismetParser#modifier.
    def exitGoto(self, ctx):
        self.currentModifier = None

    def enterArguments(self,ctx):
        self.currentArguments = []
        if self.currentAction:
            self.currentAction['support'] = self.currentArguments
        elif self.currentPattern:
            self.currentPattern['support'] = self.currentArguments
        elif self.currentTrait:
            self.currentTrait['support'] = self.currentArguments
    def exitArguments(self,ctx):
        self.currentArguments = None

    # Enter a parse tree produced by kismetParser#valence.
    def enterValence(self, ctx):
        self.currentModifier['valence'] = ctx.getText()

    # Enter a parse tree produced by kismetParser#tags.
    def enterTags(self, ctx):
        if self.currentQuery:
            self.currentQuery['tags'].append(ctx.getText())
        elif self.currentModifier:
            self.currentModifier['tags'].append(ctx.getText())
        elif self.currentHas:
            self.currentHas['tags'].append(ctx.getText())


    # Enter a parse tree produced by kismetParser#relationship.
    def enterRelationship(self, ctx):
        if self.currentQuery:
            self.currentQuery['relationship'] = ctx.getText()

    # Enter a parse tree produced by kismetParser#query.
    def enterQuery(self, ctx):
        self.currentQuery = {
            'relationship':'',
            'tags':[]
        }
        if self.currentModifier:
            self.currentModifier['query'].append(
                self.currentQuery
            )
        elif self.currentAdd:
            self.currentAdd['query'].append(
                self.currentQuery
            )
        elif self.currentRemove:
            self.currentRemove['query'].append(
                self.currentQuery
            )
        elif self.currentAction:
            if 'query' not in self.currentAction:
                self.currentAction['query'] = []
            self.currentAction['query'].append(
                self.currentQuery
            )

        elif self.currentPattern:
            if 'query' not in self.currentPattern:
                self.currentPattern['query'] = []
            self.currentPattern['query'].append(
                self.currentQuery
            )
    # Exit a parse tree produced by kismetParser#query.
    def exitQuery(self, ctx):
        relationship = self.currentQuery['relationship']
        q_str = [relationship, '(']
        for t in self.currentQuery['tags']:
            q_str.append(t)
        q_str.append(')')
        self.str2query[''.join(q_str)] = self.currentQuery
        self.currentQuery = None


    # Enter a parse tree produced by kismetParser#action.
    def enterAction(self, ctx):
        self.currentAction = {
            'name':'',
            'support':[]
        }
        self.actions.append(self.currentAction)

    # Exit a parse tree produced by kismetParser#action.
    def exitAction(self, ctx):
        self.currentAction = None

    def enterHas(self, ctx):
        self.currentHas = {
            'tags':[]
        }
        self.currentAction['is'] = self.currentHas

    def exitHas(self, ctx):
        self.currentHas = None


    def enterLocation(self, ctx):
        self.currentLocation = {}
        self.locations.append(self.currentLocation)

    def exitLocation(self, ctx):
        self.currentLocation = None

    def enterCount(self, ctx):
        num = int(ctx.getText())
        if self.currentLocation != None:
            self.currentLocation['support'] = num


    def enterVar(self, ctx):
        if self.currentArguments != None:
            self.currentArguments.append(ctx.getText())

    def enterAt(self, ctx):

        self.currentAt = []
        if self.currentAction:
            self.currentAction['at'] = self.currentAt
        else:
            self.currentTrait['at'] = self.currentAt

    def exitAt(self, ctx):
        self.currentAt = None

    def enterAdd(self, ctx):

        self.currentAdd = {
            'query':[]
        }
        self.currentAction['add'] = self.currentAdd

    def exitAdd(self, ctx):
        self.currentAdd = None

    def enterRemove(self, ctx):
        self.currentRemove = {
            'query':[]
        }
        self.currentAction['del'] = self.currentRemove
    def exitRemove(self, ctx):
        self.currentRemove = None
    def enterPattern(self,ctx):
        self.currentPattern = {'name':''}
        self.patterns.append(self.currentPattern)
    def exitPattern(self,ctx):
        self.currentPattern = None
import re

def parse_query(support,query,query_num,name):

    if '?' in query['relationship'] or '-'in query['relationship']:
        match = re.match(pattern='(\w*)(<?)([\?\-])(>?)(\w*)',string=query['relationship'])

        arg1 = match.group(1)
        if arg1 == '':
            arg1 = support[0]
        arg2 = match.group(5)
        if arg2 == '':
            arg2 = support[1]

        dir1 = match.group(2)
        dir2 = match.group(4)

        wildcard = match.group(3)
        terms = []
        if wildcard == '-':
            if dir1 == '<':
                for tag in query['tags']:
                    pre = ''
                    if '!' in tag:
                        pre = 'not '
                        tag = tag[1:]
                    terms.append(f'{pre}has({tag},{arg2},{arg1})')
            if dir2 == '>':
                for tag in query['tags']:
                    pre = ''
                    if '!' in tag:
                        pre = 'not '
                        tag = tag[1:]
                    terms.append(f'{pre}has({tag},{arg1},{arg2})')
        count = 0
        if wildcard == '?':
            if dir1 == '<':
                for tag in query['tags']:
                    count += 1
                    pre = ''
                    if '!' in tag:
                        pre = 'not '
                        tag = tag[1:]
                    terms.append(f'{pre}has({tag},{arg2},_)')
            if dir2 == '>':
                for tag in query['tags']:
                    count += 1
                    pre = ''
                    if '!' in tag:
                        pre = 'not '
                        tag = tag[1:]

                    terms.append(f'{pre}has({tag},{arg1},_)')
            if dir1 == '<' and dir2 == '>':
                terms = ['1 {'+ ';'.join(terms) +'}']
    else:
        arg = ''
        terms =[]
        wildcards = []
        if 'self' in query['relationship']:
            arg = support[0]
        elif 'other' in query['relationship']:
            arg = support[1]

        else:
            arg = query['relationship'].split(':')[0]
        for tag in query['tags']:
            pre = ''
            if '!' in tag:
                pre = 'not '
                tag = tag[1:]

            terms.append(f'{pre}has({tag},{arg})')
    return terms, []
def parse_pattern(pattern):
    terms = []
    wildcards = []
    for ii,query in enumerate(pattern['query']):
        t, w = parse_query(pattern['support'],query,ii,pattern['name'])
        terms += t
        wildcards += w
    wildcards = [f'person({w})' for w in wildcards]
    people = [f'person({w})' for w in pattern["support"]]
    terms += people
    terms += [str(len(people)) + ' {' + "; ".join(people) +'}']
    terms += wildcards
    delim = ',\n\t'
    return (f'{pattern["name"]}({", ".join(pattern["support"])}) :- \n\t{delim.join(terms)}.')

class kismet:
    def __init__(self):
        self.temperature = 1.0
        self.printer = kismetListener()
        self.rules = []
        self.locations = []
        self.named_locations = {}
        self.traits = {}
        self.trait_oppositions = []
        self.actions = []
        self.patterns = []
        self.str2query = {}
        self.max_arity = -1
        self.history = []
        self.relationships = {}

    def load_kismet_social_db(self,filename):
        input_stream = FileStream(filename)
        lexer = kismetLexer.kismetLexer(input_stream)
        stream = CommonTokenStream(lexer)
        parser = kismetParser.kismetParser(stream)
        error_listener = MyErrorListener()
        parser._listeners = [ error_listener ]
        ###Run through the thing
        tree = parser.simulation()
        if len(error_listener.errors) > 0:
            return error_listener.errors
        walker = ParseTreeWalker()
        walker.walk(self.printer, tree)
        self.process_social_db()

        for l in self.locations:
            self.named_locations[l['name']] = [None]*l['support']

    def process_social_db(self):
        self.rules = []
        for t in self.printer.traits:
            self.traits[t] = self.printer.traits[t]
        self.locations += self.printer.locations
        self.actions += self.printer.actions
        self.trait_oppositions += self.printer.trait_oppositions
        self.patterns += self.printer.patterns
        for s in self.printer.str2query:
            self.str2query[s] = self.printer.str2query[s]
        ### Do some defaulty stuff
        self.default_traits = {}
        self.traits_ = {}
        for trait in self.printer.traits:
            if 'default' in trait:
                self.default_traits[trait] = self.printer.traits[trait]
            else:
                self.traits_[trait] = self.printer.traits[trait]

        #set up default support
        for action in self.printer.actions:
            if len(action['support']) == 0:
                action['support'] = ['A','B']
        for action in self.actions:
            self.max_arity = max(len(action['support']),self.max_arity)

        #parse all of the actions
        for action in self.actions:
            terms = []
            wildcards = []
            orig_len = len(action["support"] )
            action["support"] += [f'A{i}' for i in range(self.max_arity-len(action['support']))]
            if 'query' not in action:
                action['query'] = []
            for ii,query in enumerate(action['query']):
                t, w = parse_query(action['support'],query,ii,action['name'])
                terms += t
                wildcards += w
            wildcards = [f'person({w})' for w in wildcards]
            people = [f'person({w})' for w in action["support"]]
            terms += people
            terms += [str(orig_len) + ' {' + "; ".join(people) +'}' + str(orig_len) ]
            terms += wildcards
            delim = ',\n\t'
            use_at = False
            terms += [f'at({p},L)' for p in action["support"]]
            if 'at' in action:
                location = action['at']
                location_term = []
                for l in location:
                    location_term += [f'at({p},{l})' for p in action["support"]]
                location_term = str(orig_len)+' {'+ '; '.join(location_term) +'}' + str(orig_len)
                terms.append(location_term)
            action_str = [(f'action({action["name"]},{", ".join(action["support"])}) :- \n\t{delim.join(terms)}.')]

            if 'is' not in action:
                action['is'] = {'tags':[]}
            tags = []
            for tag in action['is']['tags']:
                action_str.append(f'has_tag({action["name"]},{tag}).')
            self.rules.append(('\n'.join(action_str)))
            if 'add' not in action:
                action['add'] = {}
                action['add']['query'] = []
            for query in action['add']['query']:
                for r in parse_query(action['support'],query,0,action['name'])[0]:
                    r = r.replace('has','add')
                    self.rules.append(r + ':-\n\t' + f'occurred({action["name"]},{", ".join(action["support"])}).')

            if 'del' not in action:
                action['del'] = {}
                action['del']['query'] = []
            for query in action['del']['query']:
                for r in parse_query(action['support'],query,0,action['name'])[0]:
                    r = r.replace('has','del')

                    anon = r.split('(')[1].count('_')
                    r = r.split('(')
                    ii = 0
                    newstr = ''
                    for c in r[1]:

                        if c == '_':
                            newstr += f'A{ii}'
                            ii += 1
                        else:
                            newstr += c
                    r[1] = newstr
                    r = r[0] + '(' + r[1]
                    people = [f'person(A{i})' for i in range(anon)]
                    if len(people) != 0:
                        people = ', ' + ','.join(people)
                    else:
                        people = ''
                    self.rules.append(r + ':-\n\t' + f'occurred({action["name"]},{", ".join(action["support"])}){people}.')

        for name,trait in self.traits.items():
            support = trait['support']
            if len(support) == 0:
                for modifier in trait['modifiers']:
                    for query in modifier['query']:
                        if '-' in query['relationship'] or '?' in query['relationship']:
                            support = ['A','B']

            support = support + ['A'+str(i) for i in range(self.max_arity-len(support))]
            for modifier in trait['modifiers']:

                valence = modifier['valence']
                valence = valence.count('+')-valence.count('-')
                for tag in modifier['tags']:
                    propensity = f'propensity({tag},{valence},{name},{", ".join(support)}) :-'
                    queries = [f'has({name},{support[0]})']
                    for ii,query in enumerate(modifier['query']):
                        queries+=parse_query(name=name,query=query,query_num=ii,support=support)[0]
                    queries += [f'person({p})' for p in support]
                    self.rules.append(propensity+'\n\t'+',\n\t'.join(queries)+'.')
        support = ['A'+str(i) for i in range(self.max_arity)]

        self.rules.append('likelihood(A0,N,'+', '.join(["Action"]+support[1:]) +') :-')
        self.rules.append('\t\tN =  #sum{ C,Tag : has_tag(Action,Tag) , propensity(Tag,C,Name,'+', '.join(support)+')},')
        self.rules.append('\t\taction(Action,'+', '.join(support) +').')

        self.rules.append('#defined has/2.')
        self.rules.append('#defined has/3.')
        self.rules.append('#defined has/4.')
        self.rules.append('#defined has/5.')
        self.rules.append('#defined has/6.')
        self.rules.append('#defined has/7.')
        self.rules.append(f'#defined occurred/{self.max_arity+1}.')

    def generate_name(self):
        return self.grammar.flatten(self.mode)

    def generate_population(self,number):
        import random
        max_population = 0
        for l in self.locations:
            max_population += l['support']
        if number > max_population:
            print(f'Warning: The locations only support {max_population}. Limiting population!')
            number = max_population
        self.population = [self.generate_name() for _ in range(number)]
        self.population_traits = {}
        self.location_propensities = {}

        trait_names = list(self.traits_.keys())
        min_traits = 3
        max_traits = 5
        for p in self.population:
            trait_count = random.randint(min_traits,max_traits)
            personal_traits = []
            while len(personal_traits) < trait_count:
                trait = random.choice(trait_names)
                if trait in personal_traits:
                    continue
                good = True
                for t in personal_traits:
                    for opposition in self.trait_oppositions:
                        if t in opposition and trait in opposition:
                            good = False
                            break
                    if not good:
                        break
                if good:
                    personal_traits.append((trait,))
            self.population_traits[p] = personal_traits
            location_propensities = {}
            self.location_propensities[p] = location_propensities
            for trait in personal_traits:
                trait = trait[0]
                modifiers = self.traits[trait]['gotos']
                for m in modifiers:
                    query = m['query']
                    if len(query) == 0:
                        query = 'nil'
                    else:
                        query_string = []
                        for q in query:
                            query_string.append(q['relationship'])
                            query_string.append('(')
                            for tag in q['tags']:
                                query_string.append(tag)
                            query_string.append(')')
                            query_string.append(' ')
                        query = ''.join(query_string).rstrip()

                    for tag in m['tags']:
                        if query not in location_propensities:
                            location_propensities[query] = {}
                        if tag not in location_propensities[query]:
                            location_propensities[query][tag] = 0
                        location_propensities[query][tag] += m['valence'].count('+')
                        location_propensities[query][tag] -= m['valence'].count('-')

        self.name2asp =  {name:name.lower().replace(' ','_') for name in self.population}
        self.asp2name = {asp:name for name,asp in self.name2asp.items()}
        self.set_locations()
    def set_locations(self):
        for l in self.named_locations:
            self.named_locations[l] = [None]*len(self.named_locations[l])
        for p in self.population:
            location_choices = []
            for l in self.named_locations:
                if self.named_locations[l].count(None) > 0:
                    found = False
                    for l_pref,l_prop in self.location_propensities[p].get('nil',{}).items():
                        if l in l_pref:
                            found = True
                            location_choices.append((np.exp(l_prop/self.temperature),l))
                    if not found:
                        location_choices.append((np.exp(0),l))

            total = 0
            for t,_ in location_choices:
                total += t
            location_choices = [(t/total,l) for t,l in location_choices]
            probs = [t for t,_ in location_choices]
            location_id = np.argmax(np.random.multinomial(1, probs, 1))
            l = location_choices[location_id][1]
            self.named_locations[l][self.named_locations[l].index(None)] = p
    def load_names(self,name_files):
        import json
        import tracery
        from tracery.modifiers import base_english
        all_names = []
        for file in name_files:
            with open(file) as data_file:
                all_names.append(json.load(data_file))

        names = { 'names':set(),
                  'firstNames':set(),
                  'lastNames':set()}
        for nameRules in all_names:
            for o in nameRules:
                if o not in names:
                    names[o] = set()
                names[o] |= set(nameRules.get(o,set()))
        for o in names:
            names[o] = list(names[o])
        self.mode = ['names']
        if not names['names']:
            self.mode = []
            for n in ['firstNames','lastNames']:
                if n in names:
                    self.mode.append(n)


        self.grammar = tracery.Grammar(names)
        self.grammar.add_modifiers(base_english)
        self.mode = [f'#{m}#' for m in self.mode]
        self.mode = ' '.join(self.mode)
    def run(self,iterations=1):
        people_traits = []
        persons = [f'person({self.name2asp[p]}).' for p in self.population]
        for iter in range(iterations):
            input = []
            original_traits = []
            for p in self.population:
                original_traits += [f'has({t},{self.name2asp[p]}).' for t in self.default_traits]
                original_traits += [f'has({t[0]},{self.name2asp[p]}).' for t in self.population_traits[p]]
            input += persons
            input += original_traits
            for name,location in self.named_locations.items():
                input += [f'at({self.name2asp[p]},{name}).' for p in location if p]

            flags = ['#show likelihood/4.']
            stop = False

            with open('test.swi','w') as outfile:
                outfile.write('\n'.join(input+people_traits+self.rules+flags))

            predicates =  self.solve(['test.swi','-t','7'])
            likelihoods = {p[0]:[] for p in predicates['likelihood']}
            for p in predicates['likelihood']:
                likelihoods[p[0]].append(p)
            occurred = []
            self.history.append([])

            for p in likelihoods:
                probs = []
                actions = []
                for action in likelihoods[p]:
                    probs.append(np.exp(action[1]/self.temperature))
                    actions.append(action)
                probs /= np.sum(probs)
                action_id = np.argmax(np.random.multinomial(1, probs, 1))
                action = actions[action_id]
                action = [action[2],action[0]] + list(action[3:])
                self.history[-1].append(action)
                occurred.append(f'occurred({", ".join(action)}).')
            with open('iterate.swi','w') as outfile:
                flags = []
                for ii in range(1,self.max_arity+1):
                    args = ','.join(['A'+str(jj) for jj in range(ii)])
                    flags.append(f'has_next(Prop,{args})' + f' :- has(Prop,{args}), not del(Prop,{args}).')
                    flags.append(f'has_next(Prop,{args}) :- add(Prop,{args}).')
                    flags.append(f'#show has_next/{1+ii}.')

                outfile.write('\n'.join(input+people_traits+self.rules+occurred+flags))
            people_traits = []
            self.relationships = {}

            for has in self.solve(['iterate.swi','-t','6'])['has_next']:
                if len(has) == 2:
                    p = has[1]
                    trait = has[0]
                    if 'default' not in trait:
                        self.population_traits[self.asp2name[p]].append((trait,))
                else:
                    relationship  = has[0]
                    p1 = self.asp2name[has[1]]
                    p2 = self.asp2name[has[2]]
                    people = (p1,p2)
                    if people not in self.relationships:
                        self.relationships[people] = set()
                    self.relationships[people].add(relationship)

                people_traits.append(f'has({",".join(has)}).')

            for p in self.population_traits:
                self.population_traits[p] = list(set(self.population_traits[p]))

    def format_action(self,action):
        names = set(action[1:])
        if len(names) == 1:
            return f'{self.asp2name[action[1]]} {action[0].replace("_"," ")}s alone'
        elif len(names) == 2:
            return f'{self.asp2name[action[1]]} {action[0].replace("_"," ")}s {self.asp2name[action[2]]}'
        elif len(names) == 3:
            return f'{self.asp2name[action[1]]}{action[0].replace("_"," ")}s {self.asp2name[action[2]]} about {self.asp2name[action[3]]}'
        else:
            return f'{self.asp2name[action[1]]}{action[0].replace("_"," ")}s with {",".join([self.asp2name[name] for name in action[2:]])}'


    def get_recent_actions(self,location=None):
        history = self.history[-1]
        if location:
            location = self.named_locations[location]
            history = [action for action in history if self.asp2name[action[1]] in location]

        return [self.format_action(action) for action in history]

    def get_relationships(self,location=None):
        relationships = {}

        if location:
            location = self.named_locations[location]
            for pair in self.relationships:
                if pair[0] in location and pair[1] in location:
                    relationships[pair] = self.relationships[pair]
        else:
            relationships = self.relationships
        return relationships

    def solve(self,args):
        """Run clingo with the provided argument list and return the parsed JSON result."""

        print_args = ['clingo'] + list(args) + [' | tr [:space:] \\\\n | sort ']
        args = ['clingo', '--outf=2'] + args + ["--sign-def=rnd","--seed="+str(random.randint(0,1<<30))]
        with subprocess.Popen(
            ' '.join(args),
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            shell=True
        ) as clingo:
            outb, err = clingo.communicate()
        if err:
            print(err)
        out = outb.decode("utf-8")
        return self.parse_json_result(out)


    def parse_json_result(self,out):
        """Parse the provided JSON text and extract a dict
        representing the predicates described in the first solver result."""

        result = json.loads(out)

        assert len(result['Call']) > 0
        assert len(result['Call'][0]['Witnesses']) > 0

        witness = result['Call'][0]['Witnesses'][0]['Value']

        class identitydefaultdict(collections.defaultdict):
            def __missing__(self, key):
                return key

        preds = collections.defaultdict(set)
        env = identitydefaultdict()

        for atom in witness:
            if '(' in atom:
                left = atom.index('(')
                functor = atom[:left]
                arg_string = atom[left:]
                try:
                    preds[functor].add( eval(arg_string, env) )
                except TypeError:
                    pass # at least we tried...

            else:
                preds[atom] = True
        return dict(preds)

    def __getitem__(self, key):
        if key in self.population:
            location = None
            for name in self.named_locations:

                if key in self.named_locations[name]:
                    location = name
                    break
            return f'@{location} ' + ', '.join([t[0].replace('_',' ') for t in self.population_traits[key]])

        elif key in self.named_locations:
            return ', '.join([person for person in self.named_locations[key] if person])
        else:
            return f'No person or location named "{key}"'


if __name__ == '__main__':
    world = kismet()
    world.load_kismet_social_db('test.kismet')
    world.process_social_db()
    world.load_names('names.tracery')
