
import tracery
from warnings import warn
from tracery.modifiers import base_english
from antlr4.error.ErrorListener import ErrorListener
from itertools import *
import os
from antlr4 import *
import json
from collections import namedtuple, defaultdict
import random 
import itertools
import collections
import subprocess
import random
import sys
import time
import numpy as np
from dataclasses import dataclass
from sys import exit
import re
import inspect
from abc import ABC
from dataclasses import dataclass, field
from collections.abc import Callable

from antlr4.error.ErrorListener import ErrorListener
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kismet_initializationParser import kismet_initializationParser
    from .kismet_initializationLexer import kismet_initializationLexer
    from . import kismetLexer
    from .kismetParser import kismetParser
    from . import mod
else:
    from kismet_initializationParser import kismet_initializationParser
    import kismetLexer
    from kismet_initializationLexer import kismet_initializationLexer
    from kismetParser import kismetParser
    import mod

def process_nesting(text,count=0):
    start = -1
    inside = 0
    output = []
    for index,c in enumerate(text):
        if c == '[':
            if inside == 0:
                count += 1
                start = index
            inside += 1
        elif c == ']':
            inside -= 1
            if inside == 0:
                rules,new_count = process_nesting(text[start+1:index],count)
                
                output.append( (count,text[start:index+1]))
                output += rules
                count = new_count
    return output,count

def random_text_to_tracery(text):
    rules,_ = process_nesting(text)
    rules.append((0,text))
    final_rules = {}
    for c1,rule in rules:
        for cs,subrule in rules:
            if len(subrule) >= len(rule):
                continue
            rule = rule.replace(subrule,f'#{cs}#')
        if rule[0] == '[':
            rule = rule[1:-1].split('|')
        final_rules[str(c1)] = rule
    return final_rules
def parse_predicate(predicate):
    if 'terms' in predicate:
        return f'{predicate["predicate"]}({",".join(pred["predicate"] for pred in predicate["terms"])})'
    else:
        return predicate["predicate"]

def parse_likelihood(likelihood):
        logit = int(likelihood[0]['terms'][1]['predicate'])
        
        action = [parse_predicate(pred) for pred in likelihood[0]['terms'][0]['terms']]
        actor = action[1]
        return logit,action,actor


def solve(args,clingo_exe='clingo'):
    """Run clingo with the provided argument list and return the parsed JSON result."""

    print_args = [clingo_exe] + list(args) + [' | tr [:space:] \\\\n | sort ']
    args = [clingo_exe, '--outf=2'] + args # + ["--sign-def=rnd","--seed="+str(random.randint(0,1<<30))] #No randomness here
    #print(' '.join(args))
    with subprocess.Popen(
        ' '.join(args),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        shell=True
    ) as clingo:
        outb, err = clingo.communicate()
    #if err:
    #    print(err)
    out = outb.decode("utf-8")
    if len(out) == 0:
        print(f'Command "{" ".join(args)}" failed.')
    with open('dump.lp', 'w') as outfile:
        result = json.loads(out)
        witness = result['Call'][0]['Witnesses'][-1]['Value']
        for atom in sorted(witness):
            outfile.write(atom + '\n')
    return parse_json_result(out)   

def parse_terms(arguments):
    terms = []
    while len(arguments) > 0:
        l_paren = arguments.find('(')
        r_paren = arguments.find(')')
        comma = arguments.find(',')
        if l_paren < 0:
            l_paren = len(arguments) - 1
        if r_paren < 0:
            r_paren = len(arguments) - 1
        if comma < 0:
            comma = len(arguments) - 1
        next = min(l_paren, r_paren, comma)
        next_c = arguments[next]
        if next_c == '(':

            pred = arguments[:next]
            sub_terms, arguments = parse_terms(arguments[next + 1:])
            terms.append({'predicate': pred, 'terms': sub_terms})
        elif next_c == ')':
            pred = arguments[:next]
            if pred != '':
                terms.append({'predicate': arguments[:next]})
            arguments = arguments[next + 1:]
            return terms, arguments
        elif next_c == ',':
            pred = arguments[:next]
            if pred != '':
                terms.append({'predicate': arguments[:next]})
            arguments = arguments[next + 1:]
        else:
            terms.append({'predicate': arguments})
            arguments = ''
    return terms, ''


def parse_json_result(out):
    """Parse the provided JSON text and extract a dict
    representing the predicates described in the first solver result."""
    result = json.loads(out)
    assert len(result['Call']) > 0
    assert len(result['Call'][0]['Witnesses']) > 0
    all_preds = []
    ids = list(range(len(result['Call'][0]['Witnesses'])))
    random.shuffle(ids)
    for id in ids[:]:
        witness = result['Call'][0]['Witnesses'][id]['Value']

        class identitydefaultdict(collections.defaultdict):
            def __missing__(self, key):
                return key

        preds = collections.defaultdict(list)
        env = identitydefaultdict()

        for atom in witness:
            parsed, dummy = parse_terms(atom)
            preds[parsed[0]['predicate']].append(parsed)
        all_preds.append(preds)
    return all_preds
class MyErrorListener( ErrorListener ):
    def __init__(self):
        super()
        self.errors = []
        self.recognizer  = None
    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        self.recognizer  =  recognizer
        self.errors.append(str(line) + ":" + str(column) + ": syntax ERROR, " + str(msg) + '---{' + str(offendingSymbol) + '}---'  )

    def reportAmbiguity(self, recognizer, dfa, startIndex, stopIndex, exact, ambigAlts, configs):
        self.errors.append( "Ambiguity ERROR, " + str(configs))

    def reportAttemptingFullContext(self, recognizer, dfa, startIndex, stopIndex, conflictingAlts, configs):
        self.errors.append( "Attempting full context ERROR, " + str(configs))


    def reportContextSensitivity(self, recognizer, dfa, startIndex, stopIndex, prediction, configs):
        self.errors.append( "Context ERROR, " + str(configs))



class KismetVisitor(ParseTreeVisitor):
    def __init__(self):
        self.stuff = []
        
        
    def visitChildren(self,node):
        n = node.getChildCount()
        results = []
        for i in range(n):
            c = node.getChild(i)
            childResult = c.accept(self)
            if childResult:
                results.append(childResult)
        return results
    # Visit a parse tree produced by kismetParser#world.
    def visitWorld(self, ctx:kismetParser.WorldContext):
        
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#opposition.
    def visitOpposition(self, ctx:kismetParser.OppositionContext):
        return ('Opposes',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#trait.
    def visitTrait(self, ctx:kismetParser.TraitContext):
        
        return ('Trait',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#trait_type.
    def visitTrait_type(self, ctx:kismetParser.Trait_typeContext):
        
        return ('TraitType',ctx.getText())


    # Visit a parse tree produced by kismetParser#knowledge.
    def visitKnowledge(self, ctx:kismetParser.KnowledgeContext):
        return ('Knowledge',ctx.getText())

    # Visit a parse tree produced by kismetParser#propensity.
    def visitPropensity(self, ctx:kismetParser.PropensityContext):
        
        return ('Propensity',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#propensity_name.
    def visitPropensity_name(self, ctx:kismetParser.Propensity_nameContext):
        
        return ('PropensityName',ctx.getText())


    # Visit a parse tree produced by kismetParser#modifier.
    def visitModifier(self, ctx:kismetParser.ModifierContext):
        return ('Propensity',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#goto.
    def visitGoto(self, ctx:kismetParser.GotoContext):
        return ('GoToPropensity',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#valence.
    def visitValence(self, ctx:kismetParser.ValenceContext):
        
        return ('Valence',ctx.getText())


    # Visit a parse tree produced by kismetParser#action.
    def visitAction(self, ctx:kismetParser.ActionContext):
        return ('Action',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#.
    def visitAdd(self, ctx:kismetParser.AddContext):
        
        return ('Results',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#change.
    def visitChange(self, ctx:kismetParser.ChangeContext):
        
        return self.visitChildren(ctx)


    def visitPattern(self, ctx):
        return ('Pattern', self.visitChildren(ctx))
    
    # Visit a parse tree produced by kismetParser#visibility.
    def visitVisibility(self, ctx:kismetParser.VisibilityContext):
        
        return ('visibility',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#action_location.
    def visitAction_location(self, ctx:kismetParser.Action_locationContext):
        return ('Locations',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#loc.
    def visitLoc(self, ctx:kismetParser.LocContext):
        return ('LocationAssignments',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#action_item.
    def visitAction_item(self, ctx:kismetParser.Action_itemContext):
        
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#role.
    def visitRole(self, ctx:kismetParser.RoleContext):
        return ('Role',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#extension.
    def visitExtension(self, ctx:kismetParser.ExtensionContext):
        
        return ('Extends', self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#cast_name.
    def visitCast_name(self, ctx:kismetParser.Cast_nameContext):
        
        return ('Cast', self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#arg.
    def visitArg(self, ctx:kismetParser.ArgContext):
        return ('Arguments',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#arg_type.
    def visitArg_type(self, ctx:kismetParser.Arg_typeContext):
        return ('ArgType',ctx.getText())

    # Visit a parse tree produced by kismetParser#tags.
    def visitTags(self, ctx:kismetParser.TagsContext):
        
        ret =  ('Tags',self.visitChildren(ctx))
        
        return ret


    # Visit a parse tree produced by kismetParser#comparison.
    def visitComparison(self, ctx:kismetParser.ComparisonContext):
        
        return ('Conditions',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#condition.
    def visitCondition(self, ctx:kismetParser.ConditionContext):
        
        return ('Conditional',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#cond1.
    def visitCond1(self, ctx:kismetParser.Cond1Context):
        return ('Compare', self.visitChildren(ctx))



    # Visit a parse tree produced by kismetParser#cond3.
    def visitCond3(self, ctx:kismetParser.Cond3Context):
        
        return ('Knows',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#cond4.
    def visitCond4(self, ctx:kismetParser.Cond4Context):
        
        return ('NumCompare1',self.visitChildren(ctx))
    
    # Visit a parse tree produced by kismetParser#cond3.
    def visitCondpattern(self, ctx):
        
        return ('CondPattern',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#inversion.
    def visitInversion(self, ctx:kismetParser.InversionContext):
        
        return ('Inversion', ctx.getText())


    # Visit a parse tree produced by kismetParser#cond5.
    def visitCond5(self, ctx:kismetParser.Cond5Context):
        return ('Bijective',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#cond6.
    def visitCond6(self, ctx:kismetParser.Cond6Context):
        
        return ('Update',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#cond7.
    def visitCond7(self, ctx:kismetParser.Cond7Context):
        children = self.visitChildren(ctx)
        return ('NumCompare2',children)


    # Visit a parse tree produced by kismetParser#operator.
    def visitOperator(self, ctx:kismetParser.OperatorContext):
        
        return ctx.getText()


    # Visit a parse tree produced by kismetParser#location.
    def visitLocation(self, ctx:kismetParser.LocationContext):
        return ('Location',self.visitChildren(ctx))



    # Visit a parse tree produced by kismetParser#each_turn.
    def visitEach_turn(self, ctx:kismetParser.Each_turnContext):
        return  ('EachTurn',self.visitChildren(ctx))

    def visitIs_num(self, ctx):
        
        return  ('Is_Num',[])


    # Visit a parse tree produced by kismetParser#cast.
    def visitCast(self, ctx:kismetParser.CastContext):
        return ('Cast',self.visitChildren(ctx))

    # Visit a parse tree produced by kismetParser#cast.
    def visitFree(self, ctx:kismetParser.CastContext):
        return ('Free',[])

    
    # Visit a parse tree produced by kismetParser#cast.
    def visitDefault(self, ctx):
        return ('Default',[])
    
    # Visit a parse tree produced by kismetParser#cast.
    def visitResponse(self, ctx):
        return ('Response',[])

    # Visit a parse tree produced by kismetParser#random_text.
    def visitRandom_text(self, ctx:kismetParser.Random_textContext):
        return ('RandomText',ctx.getText())
    
    def visitLocWildCard(self,ctx):
        return 'LocWildCard',ctx.getText()

    # Visit a parse tree produced by kismetParser#supports.
    def visitSupports(self, ctx:kismetParser.SupportsContext):
        
        return ('Supports',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#num.
    def visitNum(self, ctx:kismetParser.NumContext):
        
        return ('Num',ctx.getText())


    # Visit a parse tree produced by kismetParser#num.
    def visitPos_num(self, ctx:kismetParser.NumContext):
        
        return ('Num',ctx.getText())
    # Visit a parse tree produced by kismetParser#name.
    def visitName(self, ctx:kismetParser.NameContext):
        
        return ('Name',ctx.getText())


    # Visit a parse tree produced by kismetParser#cost.
    def visitCost(self, ctx):
        return ('Cost',self.visitChildren(ctx))
    
    # Visit a parse tree produced by kismetParser#var.
    def visitVar(self, ctx:kismetParser.VarContext):
        
        return ('Var',ctx.getText())


    # Visit a parse tree produced by kismetParser#comparator.
    def visitComparator(self, ctx:kismetParser.ComparatorContext):
        return ('Comparator',ctx.getText(),self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#num_choice.visi
    def visitNum_choice(self, ctx:kismetParser.Num_choiceContext):
        return ('num_choice',self.visitChildren(ctx))


    def visitTag_compare(self, ctx):
        return ('TagCompare',ctx.getText())
    
    # Visit a parse tree produced by kismetParser#pdf.
    def visitPdf(self, ctx:kismetParser.PdfContext):
        
        return ('PDF', ctx.getText())
    
    def visitSub(self, ctx):
        
        return ('Sub', ctx.getText())

def thing2dict(thing):
    
    if len(thing) == 1 and (type(thing) is tuple or type(thing) is list):
        return thing2dict(thing[0])
    elif len(thing) == 1 or not (type(thing) is tuple or type(thing) is list):
        return thing
    output = {}
    thing = unsqueeze(thing)
    for t in thing:
        name = t[0]
        rest = t[1:]
        if name not in output:
            output[name] = []
        output[name].append(rest)
    for n,v in output.items():
        if len(v) == 1:
            output[n] = v[0]
            
    return output#unsqueeze_dict(output)
        
def unsqueeze(t):
    if (type(t) is list or type(t) is tuple) and len(t) == 1:
        return unsqueeze(t[0])
    elif (type(t) is list or type(t) is tuple):
        return [unsqueeze(s) for s in t]
    return t

def unsqueeze_dict(d):
    return {k:unsqueeze(v) for k,v in d.items()}

def simpleDictify(thing):
    d = {}
    for t in thing:
        if t[0] not in d:
            d[t[0]] = []
        d[t[0]].append(unsqueeze(t[1:]))
    return unsqueeze_dict(d)   


def parseArg(argument):
    if not type(argument[1][0]) is list:
        argument[1] = [argument[1]]
    argument = simpleDictify(argument[1])
    argt = None
    if 'ArgType' in argument:
        argt = argument['ArgType'],
    name = ''
    if 'Var' in argument:
        
        name = argument['Var']
    elif 'Name' in argument:
        name = argument['Name']
    return argt,name

def parseConditional(conditional,conditional_type='Conditional'): 
    comparisonMapping =  {'Conditional':{
        'is missing':'not is(',
        'is not':'not is(',
        'is':'is(',
        'isn\'t':'not is(',
        'isnt':'not is(',
        'aint':'not is(',
        'do not':'not is(',
        'don\'t':'not is(',
        'doesnt':'not is(',
        'doesn\'t':'not is(',
        'missing':'not is(',
        'knows'	:'knows(',
	'hears'	:'heard(',
	'heard'	:'heard(',
	'saw'	:'saw(',		
	'did'	:'did(',	
	'received'	:'received(',		
	'does not know'	:'not knows(', 
	'doesnt know'	:'not knows(',  
	'doesn\'t know'	:'not knows(', 
	'did not hear':'not heard(', 
	'didnt hear':'not heard(', 
	'didn\'t hear':'not heard(',  
	'did not' 'see':'not saw(', 
	'didnt see':'not saw(', 
	'didn\'t see':'not saw(', 
	'did not do':'not did(',
	'didnt do':'not did(',
	'didn\'t do':'not did(',
	'did not receive':'not received(',	
	'didnt receive':'not received(',		
	'didn\'t receive':'not received('
    },
    'Result':{
        'is missing':'del(',
        'is not':'del(',
        'is':'add(',
        'isn\'t':'del(',
        'isnt':'del(',
        'aint':'del(',
        'do not':'del(',
        'dont':'del(',
        'doesnt':'del(',
        'doesn\'t':'del(',
        'don\'t':'del(',
        'missing':'del(',
        'knows'	:'knows(',
	'hears'	:'heard(',
	'heard'	:'heard(',
	'saw'	:'saw(',
        'forgets':'forget(',
        'forgot':'forget(',
        'forget':'forget('}
    }             
    conditional = conditional[1]
    cond_type = conditional[0]
    
    arguments = conditional[1]
    text = ''
    knowledge = ['knows','heard','saw','hears','forgets','forgot','know']
    
    if cond_type == 'Update' and  arguments[1][0] == 'Inversion' and arguments[2][1] in knowledge:
        cond_type = 'Knows'
        arguments[1][1] = arguments[1][1] + ' ' +arguments[2][1]
        arguments[2][1] = arguments[3][1]
    if cond_type == 'Update' and arguments[1][1] in knowledge:
        cond_type = 'Knows'
        
    if cond_type == 'Compare':
        arg1 = parseArg(arguments[0])[1]
        arg2 = arguments[2][1]
        comparison = arguments[1][1]
        text = f'{comparisonMapping[conditional_type][comparison]}{arg1}, {arg2})'
        if conditional_type == 'Result':
            text += ' :- '
            text = [text]
    elif cond_type == 'Update':
        if arguments[-1][0] == 'Num':
            char1 = arguments[0][1][1]
            rel = arguments[1][1]
            char2 = arguments[2][1][1]
            operation = arguments[3][0]        
            val = arguments[4][1]
            text = [f'update({char1},{rel},{char2},Y) :- is({char1},{rel},{char2},X), X {operation} {val} = Y, ']
        else:
            
            char1 = arguments[0][1][1]
            if arguments[1][0] == 'Inversion':
                inv = arguments[1][1]
                rel = arguments[2][1]
                char2 = arguments[3][1][1]
                
            else:       
                inv = 'is'
                rel = arguments[1][1]
                char2 = arguments[2][1][1]
            if conditional_type == 'Result':
                text = [f'{comparisonMapping[conditional_type][inv]}{char1},{rel},{char2}) :-']
            else:
                text = [f'{comparisonMapping[conditional_type][inv]}{char1},{rel},{char2})']
            
    # A and B like each other
    elif cond_type == 'Bijective':
        
        char1 = arguments[0][1][1]
        char2 = arguments[1][1][1]
        
        # A and B dont like each other
        if arguments[2][0] == 'Inversion':
            inv = arguments[2][1]
            rel = arguments[3][1]
        else:       
            inv = 'is'
            rel = arguments[2][1]
        
        # A and B like each other -=5
        if arguments[-1][0] == 'Num':
            operation = arguments[-2][0]        
            val = arguments[-1][1]    
            text = [f'update({char1},{rel},{char2},Y) :- state({char1},{rel},{char2},X), X {operation} {val} = Y,',    
                    f'update({char2},{rel},{char1},Y) :- state({char2},{rel},{char1},X), X {operation} {val} = Y,']
        else:
            text = [f'{comparisonMapping[conditional_type][inv]}{char1},{rel},{char2}) :- ',
                    f'{comparisonMapping[conditional_type][inv]}{char2},{rel},{char1}) :- ']
    elif cond_type == 'Knows':
        char1 = arguments[0][1][1]
        rel = arguments[1][1]
        action = arguments[2][1][1]
        text = f'{comparisonMapping[conditional_type][rel]}{char1},{action})'
        
        if conditional_type == 'Result':
            text += ' :- '
            text = [text]
        
    elif cond_type == 'NumCompare1':
        char1 = arguments[0][1][1]
        stat = arguments[1][1]
        operator = arguments[2][1]
        val = arguments[3][1]

        text = f'is({char1},{stat},V_{char1}_{stat}), V_{char1}_{stat} {operator} {val}'
    elif cond_type == 'NumCompare2':
        char1 = arguments[0][1][1]
        stat = arguments[1][1]
        char2 = arguments[2][1][1]
        operator = arguments[3][1]
        val = arguments[4][1]
        text = f'is({char1},{stat},{char2},V_{char1}_{stat}_{char2}), V_{char1}_{stat}_{char2} {operator} {val}'
    elif cond_type == 'CondPattern':
        name = arguments[0][1]
        args = [name] + [arg[1][1] for arg in arguments[1:]]
        text = f'pattern({",".join(args)})'
    else:
        print(f'UH OH --- Unknown Conditional Type -- missing "{cond_type}"')
    return text

def parseConditions(conditions,conditional_type='Conditional'):
    if type(unsqueeze(conditions)[0]) is list:
        conditions = unsqueeze(conditions)
    return [parseConditional(condition,conditional_type) for condition in conditions]

def parseArguments(thing):
    
    constraints = []
    characters = []
    arguments = []
    for argument in thing['Arguments']:
        argument = simpleDictify(unsqueeze(argument))
        argType = argument['ArgType']
        character = argument['Var']
        arguments.append((argType,character))
        if argType in '><^':
            characters.append((argType,character))
            if 'Sub' in argument:
                role = argument['Name']
                constraints.append(f'is({character},{role},RoleLocation)')
                constraints.append(f'at({character},RoleLocation)')
        elif argType == '@':
            pass
        elif argType == '*':

            pass
    return characters,constraints,arguments

def parseExtension(thing, role=False):
    if 'Extends' in thing:
        extension = thing['Extends'][0]
        extended = ''
        if not role:
            if extension[0][0] == 'Name' :
                extended = extension[0][1]
            else:
                extended = 'cast_' + extension[0][1][1]
        else:
            extended = 'cast_' + extension[0][1]
            
        arguments = [arg[1] for arg in extension[1:]]

        extension = (extended, arguments)
    else:
        extension = None
    return extension

def parseTags(thing):
    tags = []
    if 'Tags' in thing:
        if type(thing['Tags'][0][0]) is list:
            thing['Tags'] = thing['Tags'][0]
        tags = thing['Tags']
        
        tags = [tag[1] for tag in tags]
    return tags



#Action = namedtuple('Action',['constraints','tags','characters','results','text','visibility','extensions','arguments','free','response','is_cast','cost'])

@dataclass
class Action:
    constraints: str
    tags: str
    characters: str
    results: str
    text: str
    visibility: str
    extensions: str
    arguments: str
    free: bool
    response: bool
    is_cast: bool
    cost: int
    
def parseAction(action,action_name):
    text = ''
    constraints = []
    initiator = None
    targets = []
    indirect_objects = []
    actions = []
    characters = []
    cost = -100

    characters, constraints, arguments = parseArguments(action)
    allLocations = []
    wildLocations = []
    namedLocations = set()

    free = 'Free' in action
    response = 'Response' in action
    if 'Cost' in action:
        cost = float(action['Cost'][0][1])
    
    if 'Locations' in action:
        if type(action['Locations'][0][0]) is list:
            action['Locations'] = action['Locations'][0]
            
        for locNum, location in enumerate(action['Locations']):
            named = None
            participants = []
            wildCard = False
            for stuff in location[1]:
                if stuff[0] == 'Name':
                    named = stuff[1]
                elif stuff[0] == 'Arguments':  
                    participants.append(stuff[1][1])
                elif stuff[0] == 'Var':  
                    named = stuff[1]
                elif stuff[0] == 'LocWildCard':
                    wildCard = True
            if not wildCard:
                if named:
                    allLocations.append((named,participants))
                    namedLocations.add(named)
                else:
                    wildLocations.append((participants))
    counter = 0
    if len(allLocations) == 0 and len(wildLocations) == 0:
        for c in characters:
            constraints.append(f'at({c[1]},Location)')    
    
    for location in allLocations:
        name = location[0]
        lType = None
        if name[0].islower():
            lType = name
            name = f'Location_{counter}'
            while name in namedLocations:
                counter += 1
                name = f'Location_{counter}'
            namedLocations.add(name)
        if lType:
            constraints.append(f'is({name},{lType})')
        for c in location[1]:
            constraints.append(f'at({c},{name})')
    for location in wildLocations:
        name = f'Location_{counter}'
        while name in namedLocations:
            counter += 1
            name = f'Location_{counter}'
        namedLocations.add(name)
        for c in location:
            constraints.append(f'at({c},{name})')
    namedLocations = [location for location in sorted(namedLocations) if location[0].isupper()]
    for locCombo in combinations(sorted(namedLocations), 2):
        constraints.append(f'{locCombo[0]} != {locCombo[1]}')
    
    if 'Conditions' in action:
        conditions = action['Conditions']
        constraints += parseConditions(conditions)
        
    tags = parseTags(action)
    results = []
    if 'Results' in action:
        results = action['Results']
        results = parseConditions(results,'Result')
        r_ = []
        for res in results:
            r_ += res
        results = r_
    randomText = ''
    if 'RandomText' in action:
        randomText = action['RandomText'][0][1:-1]
    else:
        char_text = ', '.join([c[1] for c in characters])
        randomText = f'{action_name} {char_text}'
    if 'visibility' in action:
        visibility = action['visibility'][0][1].count('+') - action['visibility'][0][1].count('-')
    else:
        visibility = 0
    extension = parseExtension(action)
    return Action(constraints, tags,
                  characters,results,
                  randomText,visibility,
                  extension,arguments,
                  free,response,False,cost)

Role = namedtuple('Role',['characters','constraints','extension','tags','arguments'])
def parseRole(role,rolename):
    characters, constraints,arguments = parseArguments(role)

    tags = parseTags(role)

    extension = parseExtension(role, True)
    conditions = []
    extends = []
    if 'Conditions' in role:
        conditions = role['Conditions']
        constraints += parseConditions(conditions)
        
    constraints += [f'at({characters[0][1]},Location)', f'castable({rolename},Location)', f'mode(casting)']
    return Role(characters, constraints, extension, tags,arguments)


Propensity = namedtuple('Propensity',['is_propensity','is_goto','valence','constraints','modified_tags'])
def parsePropensity(propensity):
    propensity = unsqueeze(propensity)
    is_propensity = propensity[0] == 'Propensity'
    is_goto = not is_propensity
    propensity = propensity[1]
    
    valence = propensity[0][1].count('+') - propensity[0][1].count('-')
    modified_tags = []
    constraints = []

    
    for thing in propensity[1:]:
        if thing[0] == 'PropensityName':
            modified_tags.append(thing[1])
        elif thing[0] == 'Conditions':
            constraints += parseConditions([thing[1]])
        elif thing[0] == 'Name':
            modified_tags.append(thing[1])
        else:
            print(thing)
            print('ERROR: Expected Name, PropensityName, or Condition but encountered ' + thing[0])
    
    return Propensity(is_propensity,is_goto,valence,constraints,modified_tags)


default_args = {'>':'DEFAULT_INITIATOR',
                '<':'DEFAULT_TARGET',
                '^':'DEFAULT_OBJECT',
                '*':'DEFAULT_ACTION',
                '@':'DEFAULT_LOCATION'}

arg2type = {'>':'person',
            '<':'person',
            '^':'person',
            '*':'event',
            '@':'location'}
@dataclass
class Trait:
    is_default:bool
    is_num:bool
    is_trait:bool
    is_status:bool
    alternative_names:list
    arguments:list
    propensities:list
    propensityASP:str
    opposition:list
    def __repr__(self):
        return self.alternative_names[0]
def parseTrait(trait,traitname):

    
    is_status = trait['TraitType'][0] == 'status'
    is_trait = not is_status
    _, _,arguments =parseArguments(trait)
    if len(trait['Name']) == 1:
        pos_alternative_names =  trait['Name']
    else:
        pos_alternative_names = [name[0] for name in trait['Name']]
    positive_name =pos_alternative_names[0]
    pos_propensities = []
    
    is_default = 'Default' in trait
    is_num = 'Is_Num' in trait
        
    if 'Propensity' in trait:
        pos_propensities = [parsePropensity(prop) for prop in trait['Propensity']]

    pos_propensityASP = []
    arguments = simpleDictify(arguments)
    
    arguments = {arg_type:arguments.get(arg_type,default_args[arg_type]) for arg_type in ['>','<','^','*','@']}
                
    asp_args = ', '.join([arguments.get(arg_type,default_args[arg_type])   for arg_type in ['>','<','^','*','@']])
    
    for is_propensity,is_goto,valence,constraints,modified_tags in pos_propensities:
        for tag in modified_tags:
            if is_goto:
                kind = 'go_to_propensity'
            else:
                kind = 'propensity'

            head = f'{kind}({tag}, {valence}, {traitname},{asp_args} ) '            
            #premises = ['action(ACTION_NAME,'+','.join([f'{arg2type[arg_type]}({arguments[arg_type]})' for arg_type in ['>','<','^','*','@']] ) +')']
            premises = ['action(ACTION_NAME,'+','.join([f'{arguments[arg_type]}' for arg_type in ['>','<','^','*','@']] ) +')']
            premises.append(f'is({arguments[">"]}, {traitname})')
            
            constraints = unsqueeze(constraints)
            if (type(constraints) is list):
                premises += constraints
            else:
                premises.append(constraints)
            premises.append(f'is(ACTION_NAME,{tag})')
            #print(  f'{head} :- {premise}.')
            premise = ',\n\t\t'.join(premises)
            pos_propensityASP.append(f'{head} :- \n\t\t{premise}.')
    if 'Opposes' in trait:
        if type(trait['Opposes'][0][0]) is list:
            trait['Opposes'] = unsqueeze(trait['Opposes'])
        propensityASP = []
        
        if len(trait['Opposes']) == 1:
            alternative_names =  [trait['Opposes'][0][1]]
        else:
            alternative_names = [name[1] for name in trait['Opposes']]
        negative_name =alternative_names[0]
        
        returns = [Trait(is_default,is_num,is_trait, is_status, pos_alternative_names, arguments, pos_propensities,pos_propensityASP,negative_name)]

        traitname = alternative_names[0]
        for is_propensity,is_goto,valence,constraints,modified_tags in pos_propensities:
            for tag in modified_tags:
                if is_goto:
                    kind = 'go_to_propensity'
                else:
                    kind = 'propensity'
                

                head = f'{kind}({tag}, {-valence}, {traitname}, {asp_args} ) '

                premises = ['action(ACTION_NAME,'+','.join([f'{arg2type[arg_type]}({arguments[arg_type]})' for arg_type in ['>','<','^','*','@']] ) +')']
                premises.append(f'is({arguments[">"]}, {traitname})')
                premises += constraints

                #print(  f'{head} :- {premise}.')

                premise = ',\n\t\t'.join(premises)
                propensityASP.append(f'{head} :- \n\t\t{premise}.')
        returns.append(Trait(is_default,is_num,is_trait, is_status, alternative_names, arguments, pos_propensities,propensityASP,positive_name))
    else:
        returns = [Trait(is_default,is_num,is_trait, is_status, pos_alternative_names, arguments, pos_propensities,pos_propensityASP,'')]
    return returns


def makeDistribution(low,high,pdf):
    pdf2num = {'_':0,
               '^':1,
               '.':0.33,
               '-':0.67,
               }
    import random
    if low == high:
        return lambda : low
    elif len(set(pdf)) == 1:
        return lambda : int( (high+1-low)*random.random()+low)
    else:
        step_size = (high-low)/(len(pdf)-1)
        x = low
        pieces = []
        total_area = 0
        for (s,e)  in zip(pdf[:-1],pdf[1:]):
            x0 = x
            x1 = x+step_size
            y0 = pdf2num[s]
            y1 = pdf2num[e]
            if y0 == 0 and y1 == 0:
                area = 0
            elif y0 == 0 or y1 == 0:
                area = 0.5*max(y0,y1)*step_size
            else:
                lower = min(y0,y1)
                upper = max(y0,y1)                
                area = lower*step_size + 0.5*(upper-lower)*step_size
            pieces.append((area,(x0,y0),(x1,y1)))
            total_area += area
            x += step_size
        
        def piecewise_triangle():
            import numpy as np
            R = random.random()
            for piece in pieces:
                if R < piece[0]/total_area:
                    x0,y0 = piece[1]
                    x1,y1 = piece[2]
                    lower = min(y0,y1)
                    upper = max(y0,y1)
                    #print((x0,y0),(x1,y1)) 
                    x = random.random()        
                    if y0 == y1:
                        return int(x*(x1-x0)+x0)
                    elif y0 == lower:                        
                        cutoff = y0/y1 * (x1-x0) + x0
                        x= x0 + np.sqrt(x)*(x1-x0)
                        while  x < cutoff:
                            x = random.random()  
                            x= x0 + np.sqrt(x)*(x1-x0)
                        if x1 != cutoff:
                            x= ((x-cutoff)/(x1-cutoff))*(x1-x0)+x0
                    else:
                        cutoff =x1-y1/y0 * (x1-x0)
                        x = x1 - np.sqrt((1-x)*(x1-x0)**2)
                        while x > cutoff:
                            x = random.random()              
                            x = x1 - np.sqrt((1-x)*(x1-x0)**2)
                        if cutoff != x0:
                            x = x0+(x-x0)*(x1-x0)/(cutoff-x0)                           
                    return int(np.round(x))
                else:
                    R -= piece[0]/total_area
            return int(piece[2][0])
        return piecewise_triangle
            
    return lambda : low

def castToASP(cast):
    if type(cast[0][0]) is list:
        cast = cast[0]
    cast_ = {}
    for casting in cast:
        role,distribution = parseNumChoice(casting[1][1])
        cast_[role] = distribution
    return cast_

def parseNumChoice(choice):    
    # [a-b] pdf name
    if len(choice) == 4:
        lower = int(choice[0][1])
        upper = int(choice[1][1])
        pdf = choice[2][1]
        role = choice[3][1]
    elif len(choice) == 3:
        lower = int(choice[0][1])
        upper = int(choice[1][1])
        pdf = '--'
        role = choice[2][1]
    else:
        lower = int(choice[0][1])
        upper = lower
        pdf = '--'
        role = choice[1][1]
    distribution =  makeDistribution(lower,upper,pdf)
    return role,distribution

def locationToASP(location,location_name):

    if 'Supports' not in location:
        error_log.append(f'ERROR: supports missing in location "{location_name}"')
        return None
    if 'TextualName' not in location:
        error_log.append(f'ERROR: name missing in location "{location_name}"')
    if 'Initialization' not in location and 'EachTurn' not in location:
        error_log.append(f'ERROR: No casting details in location "{location_name}"')
        
    location['Supports'] = location['Supports'][0]

    
    tags = parseTags(location)
    supported_roles = {}
    for supported in location['Supports']:
        role,distribution = parseNumChoice(supported[1])
        supported_roles[role] = distribution

    tracery_name = location['TextualName'][0][1]
    initialization = []
    each_turn = []
    if 'Initialization' in location:
        initialization = castToASP(location['Initialization'])
    if 'EachTurn' in location:
        each_turn = castToASP(location['EachTurn'])
    if 'EachTurn' in location:
        each_turn = castToASP(location['EachTurn'])
    return tracery_name,supported_roles, initialization,each_turn,tags


@dataclass
class Pattern:
    asp_str: str
    text: str
    arguments:  str  
def patternToASP(pattern,pattern_name):
    
    conditions = parseConditions(pattern['Conditions'])
    characters, constraints, arguments = parseArguments(pattern)    
    
    asp_string = f'pattern({pattern_name},' + ', '.join(arg[1] for arg in arguments) + ') :-\n\t'
    for arg1,arg2 in itertools.combinations(arguments,2):
        conditions.append(f'different({arg1[1]},{arg2[1]})')
        
    asp_string += ',\n\t'.join(conditions)     
    asp_string += '.'
    if 'RandomText' in pattern:
        randomText = pattern['RandomText'][0][1:-1]
    else:
        char_text = ', '.join([c[1] for c in characters])
        randomText = f'{pattern_name} {char_text}'
        
    return Pattern(asp_string,randomText,arguments)

class KismetModule():
    def __init__(self,module_file,tracery_files=[],
                 temperature=1.0,
                 observation_temp=1.0,
                 ignore_logit=5.0,
                 history_cutoff=10,
                action_budget = 3,
                default_cost = 3,
                clingo_exe='clingo',
                base_folder=''):
        
        self.path = os.path.abspath(os.path.dirname('.'))
        self.clingo_exe = clingo_exe
        self.temperature = temperature
        self.observation_temp = observation_temp
        self.ignore_logit = ignore_logit
        self.default_cost = default_cost
        self.timestep = 0
        self.history_cutoff = history_cutoff
        self.action_budget = action_budget
        self.history = []
        self.character_knowledge = []
        
        error_log = []
        self.module_file = os.path.basename(module_file)
        input_stream = FileStream(module_file)
        lexer = kismetLexer.kismetLexer(input_stream)
        stream = CommonTokenStream(lexer)
        parser = kismetParser(stream)
        error_listener = MyErrorListener()
        parser._listeners = [ error_listener ]
        tree = parser.world()
        
        self.tracery_files = [f for f in tracery_files]
        self.tracery_grammar = {}
        for f in tracery_files:
            grammar = json.load(open(f,'r'))
            for key in grammar:
                if key not in self.tracery_grammar:
                    self.tracery_grammar[key] = []
                self.tracery_grammar[key] = grammar[key]
        
        self.grammar = tracery.Grammar(self.tracery_grammar)
        self.grammar.add_modifiers(base_english)

        
        if len(error_listener.errors) > 0:
            print('\n\n'.join(error_listener.errors))
            print(error_listener.recognizer)
            exit()
        vis = KismetVisitor()
        world = vis.visit(tree)

        things = {  
                    'Location':{},
                    'Role':{},
                    'Trait':{},
                    'Pattern':{}}
        for thing in world:
            name = ''
            if thing[0] not in things:
                continue
            for t in thing[1]:
                if t[0] == 'Name':
                    name = t[1]
                    break
            things[thing[0]][name] = thing2dict(thing[1])
        self.traits = {trait:parseTrait(things['Trait'][trait],trait) for trait in things['Trait']}
        
        traits_ = {}
        self.alternative_names = {}
        for trait in sorted(self.traits):
            for trait_ in self.traits[trait]:
                names = trait_.alternative_names
                self.alternative_names[names[0]] = names[1:]
                traits_[names[0]] = trait_
        self.traits = traits_
        self.default_traits = []
        self.selectable_traits = []
        self.numerical_status = []
        for name,trait in sorted(self.traits.items()):
            if trait.is_trait:
                if trait.is_default:
                    self.default_traits.append(trait)
                else:
                    self.selectable_traits.append(trait)
                    
       
    
class MyErrorListener( ErrorListener ):
    def __init__(self):
        super()
        self.errors = []
        self.recognizer  = None
    def syntaxError(self, recognizer, offendingSymbol, line, column, msg, e):
        self.recognizer  =  recognizer
        self.errors.append(str(line) + ":" + str(column) + ": syntax ERROR, " + str(msg) + '---{' + str(offendingSymbol) + '}---'  )

    def reportAmbiguity(self, recognizer, dfa, startIndex, stopIndex, exact, ambigAlts, configs):
        self.errors.append( "Ambiguity ERROR, " + str(configs))

    def reportAttemptingFullContext(self, recognizer, dfa, startIndex, stopIndex, conflictingAlts, configs):
        self.errors.append( "Attempting full context ERROR, " + str(configs))


    def reportContextSensitivity(self, recognizer, dfa, startIndex, stopIndex, prediction, configs):
        self.errors.append( "Context ERROR, " + str(configs))
        

class kismet_initializationVisitor(ParseTreeVisitor):

        
    def visitChildren(self,node):
        n = node.getChildCount()
        results = []
        for i in range(n):
            c = node.getChild(i)
            childResult = c.accept(self)
            if childResult:
                results.append(childResult)
        return results
    
    # Visit a parse tree produced by kismet_initializationParser#init.
    def visitInit(self, ctx:kismet_initializationParser.InitContext):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Init',self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_initializationParser#now.
    def visitNow(self, ctx:kismet_initializationParser.NowContext):
        return ('Now',)

    # Visit a parse tree produced by kismet_initializationParser#name.
    def visitFilter_out(self, ctx):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Filter', self.visitChildren(ctx)) 

    def visitUnique_count(self, ctx):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Uniq', self.visitChildren(ctx)) 
    
    # Visit a parse tree produced by kismet_initializationParser#plus_minus.
    def visitPlus_minus(self, ctx:kismet_initializationParser.Plus_minusContext):
        return ('PlusMinus',ctx.getText())


    # Visit a parse tree produced by kismet_initializationParser#name.
    def visitName(self, ctx:kismet_initializationParser.NameContext):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Name', ctx.getText()) 

    # Visit a parse tree produced by kismet_initializationParser#var.
    def visitVar(self, ctx:kismet_initializationParser.VarContext):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Var', ctx.getText()) 

    # Visit a parse tree produced by kismet_initializationParser#comparator.
    def visitComparator(self, ctx:kismet_initializationParser.ComparatorContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Comparator', ctx.getText())
    

    # Visit a parse tree produced by kismet_initializationParser#num_choice.
    def visitNum_choice(self, ctx:kismet_initializationParser.Num_choiceContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('num_choice',self.visitChildren(ctx))



    # Visit a parse tree produced by kismet_initializationParser#num_choice.
    def visitNum_range(self, ctx:kismet_initializationParser.Num_rangeContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('num_range',self.visitChildren(ctx))



    # Visit a parse tree produced by kismet_initializationParser#pdf.
    def visitPdf(self, ctx:kismet_initializationParser.PdfContext):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('PDF', ctx.getText())


    # Visit a parse tree produced by kismetParser#num.
    def visitNum(self, ctx:kismet_initializationParser.NumContext):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())     
        
        return ('Num',ctx.getText())


    # Visit a parse tree produced by kismet_initializationParser#pos_num.
    def visitPos_num(self, ctx:kismet_initializationParser.Pos_numContext):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())        
        return ('Num',ctx.getText())


    # Visit a parse tree produced by kismet_initializationParser#random_text.
    def visitRandom_text(self, ctx:kismet_initializationParser.Random_textContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('RandomText',ctx.getText())


    # Visit a parse tree produced by kismet_initializationParser#initialization.
    def visitInitialization(self, ctx:kismet_initializationParser.InitializationContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Initialization', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_initializationParser#let.
    def visitLet(self, ctx:kismet_initializationParser.LetContext):
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Let', self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_initializationParser#create.
    def visitCreate(self, ctx:kismet_initializationParser.CreateContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Create', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_initializationParser#create.
    def visitSelect(self, ctx:kismet_initializationParser.CreateContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Select', self.visitChildren(ctx))
    
    # Visit a parse tree produced by kismet_initializationParser#create.
    def visitNegative(self, ctx:kismet_initializationParser.CreateContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Negative')
    # Visit a parse tree produced by kismet_initializationParser#options.
    def visitOptions(self, ctx:kismet_initializationParser.OptionsContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Options', self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_initializationParser#options.
    def visitConditions(self, ctx:kismet_initializationParser.OptionsContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return ('Conditions', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_initializationParser#option.
    def visitOption(self, ctx:kismet_initializationParser.OptionContext):
        
        #print(inspect.currentframe().f_code.co_name,ctx.getText())
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#assignment.
    def visitAssignment(self, ctx:kismet_initializationParser.AssignmentContext):
        
        #print(inspect.currentframe().f_code.co_name, ctx.getText())
        return ('Assignment', self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_initializationParser#assignment.
    def visitDeferred_option(self, ctx:kismet_initializationParser.AssignmentContext):
        
        #print(inspect.currentframe().f_code.co_name, ctx.getText())
        return ('DeferredOption', ctx.getText())
    # Visit a parse tree produced by kismet_initializationParser#assignment.
    def visitDeferred_assignment(self, ctx:kismet_initializationParser.AssignmentContext):
        
        #print(inspect.currentframe().f_code.co_name, ctx.getText())
        return ('DeferredAssignment', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_initializationParser#description.
    def visitDescription(self, ctx:kismet_initializationParser.DescriptionContext):
        
        #print(inspect.currentframe().f_code.co_name, ctx.getText())
        return ('Description', self.visitChildren(ctx))
    
    # Visit a parse tree produced by kismet_initializationParser#description.
    def visitOptional_check(self, ctx):
        
        #print(inspect.currentframe().f_code.co_name, ctx.getText())
        return ('Optional_check', self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_initializationParser#description.
    def visitRequired_check(self, ctx):
        
        #print(inspect.currentframe().f_code.co_name, ctx.getText())
        return ('Required_check', self.visitChildren(ctx))
    # Visit a parse tree produced by kismet_initializationParser#initialize.
    def visitInitialize(self, ctx:kismet_initializationParser.InitializeContext):
        
        #print(inspect.currentframe().f_code.co_name, ctx.getText())
        return ('Initialize', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_initializationParser#initialize.
    def visitDefault(self, ctx:kismet_initializationParser.DefaultContext):
        
        #print(inspect.currentframe().f_code.co_name, ctx.getText())
        return ('Default', self.visitChildren(ctx))

@dataclass
class RandomText:
    text: str
    def __init__(self,text):
        self.text = self.random_text_to_tracery(text)
        
    def process_nesting(self,text,count=0):
        start = -1
        inside = 0
        output = []
        for index,c in enumerate(text):
            if c == '[':
                if inside == 0:
                    count += 1
                    start = index
                inside += 1
            elif c == ']':
                inside -= 1
                if inside == 0:
                    rules,new_count = self.process_nesting(text[start+1:index],count)

                    output.append( (count,text[start:index+1]))
                    output += rules
                    count = new_count
        return output,count
    
    def random_text_to_tracery(self,text):
        rules,_ = self.process_nesting(text)
        rules.append((0,text))
        final_rules = {}
        for c1,rule in rules:
            for cs,subrule in rules:
                if len(subrule) >= len(rule):
                    continue
                rule = rule.replace(subrule,f'#{cs}#')
            if rule[0] == '[':
                rule = rule[1:-1].split('|')
                rule = [thing.replace('[','').replace(']','') for thing in rule]
            final_rules[str(c1)] = rule 
        
        return final_rules

    def __call__(self,initializations,selections,creations,module):
        rules = {**self.text, **mod.tracery_grammar}
        if not (selections is None):
            for selection_key, selection_values in sorted(selections.items()):
                assigned = []
                for thing in selection_values:
                    if isinstance(thing,str):
                        assigned.append(thing)
                if len(assigned) > 0:
                    rules[selection_key] = assigned
        grammar = tracery.Grammar(rules)
        generated_text = grammar.flatten('#0#')
        #print('GENERATED TEXT', generated_text)
        return generated_text
    

@dataclass 
class Distribution:
    string: str
    func:  Callable
    lower: int
    upper: int
    def __call__(self):
        return self.func()
    
    def __str__(self):
        return self.string
    def __hash__(self):
        return hash(self.string)

    
def makeDistribution(low,high,pdf):
    pdf2num = {'_':0,
               '^':1,
               '.':0.33,
               '-':0.67,
               }
    import random
    if low == high:
        return lambda : low
    elif len(set(pdf)) == 1:
        return lambda : int( (high+1-low)*random.random()+low)
    else:
        step_size = (high-low)/(len(pdf)-1)
        x = low
        pieces = []
        total_area = 0
        for (s,e)  in zip(pdf[:-1],pdf[1:]):
            x0 = x
            x1 = x+step_size
            y0 = pdf2num[s]
            y1 = pdf2num[e]
            if y0 == 0 and y1 == 0:
                area = 0
            elif y0 == 0 or y1 == 0:
                area = 0.5*max(y0,y1)*step_size
            else:
                lower = min(y0,y1)
                upper = max(y0,y1)                
                area = lower*step_size + 0.5*(upper-lower)*step_size
            pieces.append((area,(x0,y0),(x1,y1)))
            total_area += area
            x += step_size
        
        def piecewise_triangle():
            import numpy as np
            R = random.random()
            for piece in pieces:
                if R < piece[0]/total_area:
                    x0,y0 = piece[1]
                    x1,y1 = piece[2]
                    lower = min(y0,y1)
                    upper = max(y0,y1)
                    #print((x0,y0),(x1,y1)) 
                    x = random.random()        
                    if y0 == y1:
                        return int(x*(x1-x0)+x0)
                    elif y0 == lower:                        
                        cutoff = y0/y1 * (x1-x0) + x0
                        x= x0 + np.sqrt(x)*(x1-x0)
                        while  x < cutoff:
                            x = random.random()  
                            x= x0 + np.sqrt(x)*(x1-x0)
                        if x1 != cutoff:
                            x= ((x-cutoff)/(x1-cutoff))*(x1-x0)+x0
                    else:
                        cutoff =x1-y1/y0 * (x1-x0)
                        x = x1 - np.sqrt((1-x)*(x1-x0)**2)
                        while x > cutoff:
                            x = random.random()              
                            x = x1 - np.sqrt((1-x)*(x1-x0)**2)
                        if cutoff != x0:
                            x = x0+(x-x0)*(x1-x0)/(cutoff-x0)                           
                    return int(np.round(x))
                else:
                    R -= piece[0]/total_area
            return int(piece[2][0])
        return piecewise_triangle
            
    return lambda : low

@dataclass
class NumChoice:
    variable: str
    distribution: Distribution
    def __repr__(self):
        return f'NumChoice({self.variable},{str(self.distribution)})'
    def __hash__(self):
        return hash((self.variable, self. distribution))

    def __call__(self,initializations,selections,creations,module):
        if self.variable == 'traits':            
         
            traits = []
            trait_count = self.distribution()
            while len(traits) != trait_count:
                trait = random.choice(selections[self.variable])
                trait_name = trait.alternative_names[0]
                selectable = True
                
                for selected in traits:
                    if trait_name in selected.opposition or trait_name in selected.alternative_names:
                        selectable = False
                        break
                if selectable:
                    traits.append(trait)
            return traits
        elif self.variable in selections:
            val = self.distribution()
            
            if val <= len(selections[self.variable]):
                return random.sample(selections[self.variable],val)
            else:
                return selections[self.variable]
        elif self.variable in initializations:
            
            num_to_make = self.distribution()
            new_instantiations = []
            for _ in range(num_to_make):
                initialized = initializations[self.variable](initializations,selections,creations,module)
                if isinstance(initialized,list):
                    new_instantiations += initialized
                else:
                    new_instantiations.append(initialized)
            return new_instantiations
        else:
            raise Exception(f'Uh oh -- trying to randomly create some number of {self.variable} -- but it is unknown')
    
def parseNumChoice(choice):    
    # [a-b] pdf name
    choice = choice[1]
    if len(choice) == 4:
        lower = int(choice[0][1])
        upper = int(choice[1][1])
        pdf = choice[2][1]
        role = choice[3][1]
    elif len(choice) == 3:
        lower = int(choice[0][1])
        upper = int(choice[1][1])
        pdf = '--'
        role = choice[2][1]
    else:
        lower = int(choice[0][1])
        upper = lower
        pdf = '--'
        role = choice[1][1]
    distribution =  Distribution(f'{lower} {pdf} {upper}',makeDistribution(lower,upper,pdf),upper,lower)
    return NumChoice(role,distribution) 

@dataclass
class NumRange:
    distribution: Distribution
    def __repr__(self):
        return f'NumRange({self.distribution})'
    
    def __call__(self,ignored,ignored2,creations,module):
        return self.distribution()
    
    def __hash__(self):
        return hash(self.distribution)

def parseNumRange(choice):    
    # [a-b] pdf name
    choice = choice[1]
    if len(choice) == 3:
        lower = int(choice[0][1])
        upper = int(choice[1][1])
        pdf = choice[2][1]
    elif len(choice) == 2:
        lower = int(choice[0][1])
        upper = int(choice[1][1])
        pdf = '--'
    else:
        lower = int(choice[0][1])
        upper = lower
        pdf = '--'
    distribution =    Distribution(f'{lower} {pdf} {upper}',makeDistribution(lower,upper,pdf),lower,upper)
    return NumRange(distribution) 

@dataclass 
class DeferredAssignment:
    
    assigned_to: str
    assigned_source: str
    assigned_val: ABC    
    assignment_type: str = None

@dataclass 
class Assignment:
    is_var: bool
    assigned_to: str
    assigned_val: ABC    
    assignment_type: str = None 
    
    def is_satisfied(self, creations,initializations,selections):
        satisfactory = set()
        
        for creation in creations:
            if self.assigned_to != 'age':
                if isinstance(self.assigned_val[0],Lookup):
                    val = self.assigned_val[0](initializations,selections,creations,None)
                    if creation['status'].get((self.assigned_to,),None) == val[0]:
                        satisfactory.add(get_name(creation))
                        
                elif isinstance(self.assigned_val[0],RandomText):
                    val = self.assigned_val[0](initializations,selections,creations,None)
                    if creation['status'].get((self.assigned_to,),None) == val[0]:
                        satisfactory.add(get_name(creation))
                else:
                    print(self.assigned_val[0])
                    print('WARNING: Unsure of what to do with satisfaction condition "'+ self.assigned_to+'"')
            else:
                if 'age' not in creation:
                    continue
                if creation['age'][0] >= self.assigned_val[0].distribution.lower and\
                   creation['age'][0] <= self.assigned_val[0].distribution.upper:
                    satisfactory.add(get_name(creation))
        return satisfactory
@dataclass
class Lookup:  
    name:str
        
    def __call__(self,initializations,selections,creations,module):
        
        if self.name in initializations:
            return initializations[self.name]
        elif self.name in selections:
            return selections[self.name]
        else:
            raise Exception(f'Uh oh -- trying to lookup {self.name}, but it cant be found')
def parse_assign_val(assign_val):
    if assign_val[0] == 'num_choice':
        return parseNumChoice(assign_val)
    if assign_val[0] == 'num_range':
        return parseNumRange(assign_val)
    elif assign_val[0] == 'RandomText':
        return RandomText(assign_val[1][1:-1])
    elif assign_val[0] == 'Var':
        return Lookup(assign_val[1])
    elif assign_val[0] == 'Name':
        return  Lookup(assign_val[1])
    else:
        print(f'Uh Oh -- assignment value "{assign_val}" is unrecognized')

@dataclass
class TimeAssignment:
    direction: str
    num_range: NumChoice
        
    def __call__(self,initializations,selections,creations,module):
        time_unit = self.num_range.variable
        amount =  self.num_range.distribution()
       
        offset_time = module.time.offset(self.direction,{time_unit:amount})
        #raise Exception('STOP')
        return f'time({",".join([str(t[1]) for t in offset_time])})'
        
def parse_assignment(assignment):
    assigned_to = assignment[1][0]
    if assignment[1][1][0] == 'Now':
        if len(assignment[1]) > 2:
            plus_minus = assignment[1][2][1]
            num_choice = parseNumChoice(assignment[1][3])
        else:
            plus_minus = ''
            num_choice = NumChoice('',NumRange(Distribution(f'0',makeDistribution(0,0,'-'),0,0)))
        assigned_val = [TimeAssignment(plus_minus,num_choice)]
    else:
        assigned_val = [parse_assign_val(assigned) for assigned in assignment[1][1:]]
    
    return Assignment(assignment[1][0] == 'Var',
                      assigned_to[1],
                        assigned_val)
        
def parse_deferred_assignment(assignment):
    
    assigned_to = assignment[1][0]
    if assignment[1][1][0] == 'DeferredOption':
        return DeferredAssignment(assigned_to[1],
                            assignment[1][2][1],
                            assignment[1][3][1],
                            assignment[1][1][1])
        
    else:
        return DeferredAssignment(assigned_to[1],
                            assignment[1][1][1],
                            assignment[1][2][1])

@dataclass
class DescTrait:
    name: str
    value: int = None
    negation:bool = False
    
    def is_satisfied(self, creations,initializations,selections):
        satisfies = set()
        for creation in creations:
            relationships = creation.get('relationships',set())
            found = False
            for relationship in relationships:
                if relationship[0] == self.name:
                    if len(relationship) == 2:
                        found = True
                        
                    else:
                        print('ERROR: Relationships with values can not be used in selections at this point of time --', self.name, self.target, self.value)
            
            for trait in creation.get('traits',[]):
                if self.name in trait.alternative_names[0]:
                    found = True
            for trait in creation.get('status',[]):
                if trait[0] == self.name:
                    found = True
            if found != self.negation:
                satisfies.add(get_name(creation))
        return satisfies    
@dataclass
class Relationship:
    name: str
    target: str
    value: int = None
    negation: bool = False
    def __hash__(self):
        return hash(self.name+self.target+str(self.negation))
    
    def __lt__(self,other):
        return f'{self.name}{self.target}{self.value}{self.negation}' < f'{other.name}{other.target}{other.value}{other.negation}'
    
    def is_satisfied(self, creations,initializations,selections):
        satisfies = set()
        for creation in creations:
            relationships = creation.get('relationships',set())
            found = False
            for relationship in relationships:
                if relationship[0] == self.name:
                    if len(relationship) == 2:
                        found = True
                        
                    else:
                        print('ERROR: Relationships with values can not be used in selections at this point of time --', self.name, self.target, self.value)
            if found != self.negation:
                satisfies.add(get_name(creation))
        return satisfies
    
def parse_description(description):
    
    description = description[1]
    negative = False
    if 'Negative' in description:
        negative = True
        description = [d for d in description if d != 'Negative']
    
    if len(description) == 3:
        return Relationship(description[0][1], description[1][1],  parseNumRange(description[2]),negation= negative)
    elif len(description) == 1:
        return DescTrait(description[0][1],negation= negative)
    elif len(description) == 2:
        if description[1][0] in ['Name', 'Var']:
            return Relationship(description[0][1], description[1][1],negation= negative)
        else:
            return DescTrait(description[0][1], parseNumRange(description[1]),negation= negative)
            
    else:
        print(f'UH OH -- description "{description}" does not match any known patterns')

@dataclass
class OptionalCheck:
    name: str
    var: str
    def is_satisfied(self, creations,initializations,selections):
        satisfies = set()
        name = (self.name,)
        for creation in creations:
            if name not in creation['status']:
                satisfies.add(get_name(creation))
            else:
                var = self.var
                if var in initializations:
                    var = initializations[var]
                elif self.var in selections:
                    var = selections[var]
                if creation["status"][name] in var:
                    satisfies.add(get_name(creation))
        return satisfies

@dataclass
class RequiredCheck:
    name: str
    def is_satisfied(self, creations,initializations,selections):
        satisfies = set()
        name = (self.name,)
        for creation in creations:
            if name in creation['status']:
                satisfies.add(get_name(creation))
        return satisfies      
    
def parse_optional_check(description):
    
    description = description[1]

    return OptionalCheck(description[0][1],description[1][1])
        
def parse_required_check(description):
    
    description = description[1]

    return RequiredCheck(description[0][1])

def flatten_list(listed):
    flattened = []
    for thing in listed:
        if isinstance(thing,list):
            flattened += thing
        else:
            flattened.append(thing)
    return flattened
@dataclass
class Creation():
    num: int
    name: str
    options: list
    def __call__(self,initializations,selections,creations,module):
        to_create = self.num(initializations,selections,creations,module)
        relationships = set()
        for creation in to_create:
            for option in self.options:
                if isinstance(option,Assignment):
                    creation[option.assigned_to] = flatten_list([assigned_val(initializations,selections,creations,module) for assigned_val in option.assigned_val])
                elif isinstance(option,Relationship):
                    relationships.add((self.name,option))
                    
                elif isinstance(option,DescTrait):
                    if 'status' not in creation:
                        creation['status'] = {}
                    creation['status'][(option.name,)] = option.value
                    creation['traits'] = [trait for trait in creation.get('traits',[]) if trait.opposition != option.name]
        return to_create,relationships
    
def parse_options(all_options):
    
    options = []
    for option in all_options[1]:
        option = option[0]
        if option[0] == 'Assignment':
            options.append(parse_assignment(option))
        elif option[0] == 'Description':
            options.append(parse_description(option))
        elif option[0] == 'Optional_check':
            options.append(parse_optional_check(option))
        elif option[0] == 'Required_check':
            options.append(parse_required_check(option))
        else:
            raise Exception('Unknown Option:',option)
    return options

def parse_create(creation):
    num = None
    creation_type = None
    name = None
    options = []
    for thing in creation:
        if thing[0] == 'num_choice':
            num = parseNumChoice(thing)
        elif thing[0] == 'Name':
            name = thing[1]
        elif thing[0] == 'Options':
            options = parse_options(thing)
    return Creation(num,name,options)

def get_name(character):
    
    return character.get('name',[character.get('first_name',[''])[0] + ' ' + character.get('last_name',[''])[0]])[0]
    
@dataclass
class Selection():
    num: int
    name: str
    options: list
    conditions: list
    def __call__(self,initializations,selections,creations,used,module):
        satisfactory = set([get_name(creation) for creation in creations]) - used
        for condition in self.conditions:
            l_pre = len(satisfactory)
            satisfactory &= condition.is_satisfied(creations,initializations,selections)
        to_select = self.num(initializations,selections,creations,module)
        if len(to_select) == 0:
            return [], [], []
            
        selection_type = to_select[0]['type']
        satisfactory = {get_name(character) for character in creations if get_name(character) in satisfactory and character['type'] == selection_type}
        
       
        if len(satisfactory) >= self.num.distribution.lower:#len(to_select):
            
            to_select = random.sample(sorted(satisfactory),min(self.num.distribution.lower,len(to_select)))
            to_select = [character for character in creations if get_name(character) in to_select]
            to_create = []
        else:
            to_create = to_select
            
        relationships = set()
        for creation in to_select:
            if 'status' not in creation:
                creation['status'] = {}
            for option in self.options:
                if isinstance(option,Assignment):
                    
                    if option.assigned_to in ['last_name','first_name','name','traits','age']:
                        try:
                            creation[option.assigned_to] = flatten_list([assigned_val(initializations,selections,creations,module) for assigned_val in option.assigned_val])
                        except:
                            pass
                            #print(f'Could not find {option.assigned_val} -- most likely this is due to a circular reference or trying to access something that hasnt been assigned yet.')
                            
                    else:
                        try:
                            creation['status'][(option.assigned_to,)] = random.choice(flatten_list([assigned_val(initializations,selections,creations,module) for assigned_val in option.assigned_val]))
                        except Exception as err:
                            print('Skipping ',err)
                        
                elif isinstance(option,Relationship):
                    relationships.add((self.name,option))
                    
                elif isinstance(option,DescTrait):
                    if 'status' not in creation:
                        creation['status'] = {}
                    creation['status'][(option.name,)] = option.value
            for condition in self.conditions:
                if len(condition.is_satisfied([creation],initializations,selections)) == 0:
                    if isinstance(condition,Assignment):
                        if condition.assigned_to in ['last_name','first_name','name','traits','age']:
                            creation[condition.assigned_to] = flatten_list([assigned_val(initializations,selections,creations,module) for assigned_val in condition.assigned_val])
                        else:
                            creation['status'][(condition.assigned_to,)] = random.choice(flatten_list([assigned_val(initializations,selections,creations,module) for assigned_val in condition.assigned_val]))
                            
                    elif isinstance(condition,Relationship):
                        relationships.add((self.name,condition))

                    elif isinstance(condition,DescTrait):
                        creation['status'][(condition.name,)] = condition.value
                        creation['traits'] = [trait for trait in creation.get('traits',[]) if trait.opposition != condition.name]
            if to_create == to_select:
                to_select = []
            yield to_create,to_select,relationships
    
def parse_select(creation):
    num = None
    creation_type = None
    name = None
    options = []
    conditions = []
    for thing in creation:
        if thing[0] == 'num_choice':
            num = parseNumChoice(thing)
        elif thing[0] == 'Name':
            name = thing[1]
        elif thing[0] == 'Options':
            options = parse_options(thing)
        elif thing[0] == 'Conditions':
            conditions = parse_options(thing)
    return Selection(num,name,options,conditions)

@dataclass
class Initialization:
    name: str
    lets: list  = field(default_factory=list)
    deferred_lets: list  = field(default_factory=list)
    creates: list = field(default_factory=list)
    selects: list = field(default_factory=list)
        
    def __call__(self,initializations,selections,creations,module):
        instantiated_lets = {}
        new_selections = set()
        for let in self.lets:
            instantiated_lets[let.assigned_to] = flatten_list([assigned_val(initializations,selections,creations,module) for assigned_val in let.assigned_val])
            selections[let.assigned_to] = instantiated_lets[let.assigned_to]
            new_selections.add(let.assigned_to)
        deferred_lets = {}
        
        
        for let in self.deferred_lets:
            if let.assigned_source not in deferred_lets:
                deferred_lets[let.assigned_source] = []
            deferred_lets[let.assigned_source].append(let)
        
        
        created = defaultdict(list)
        all_relationships = set()
        all_objects = defaultdict(list)
        used = set()
        for select in self.selects:
            for created_objects,selected_objects, relationships in select(initializations,selections,creations,used,module):
                
                created[select.name] += created_objects
                used |= set([selected['id'] for selected in selected_objects])
                all_objects[select.name] += created_objects+selected_objects
                all_relationships |= relationships
                if select.name in deferred_lets:
                    for let in deferred_lets[select.name]:
                        instantiated_lets[let.assigned_to] = flatten_list([thing[let.assigned_val] for thing in all_objects[select.name] if let.assigned_val in thing]) + flatten_list([thing['status'][(let.assigned_val,)] for thing in all_objects[select.name] if (let.assigned_val,) in thing['status']])
                       
                        new_selections.add(let.assigned_to)
                        if let.assignment_type:
                            if let.assignment_type == 'first':
                                selections[let.assigned_to] = [instantiated_lets[let.assigned_to][0]]
                            elif let.assignment_type == 'last':
                                selections[let.assigned_to] = [instantiated_lets[let.assigned_to][-1]]
                            elif let.assignment_type == 'random':
                                selections[let.assigned_to] = instantiated_lets[let.assigned_to]
                            elif let.assignment_type == 'hashed':
                                index = hash(tuple(instantiated_lets[let.assigned_to])) 
                                index = index % len(instantiated_lets[let.assigned_to])
                                selections[let.assigned_to] = [instantiated_lets[let.assigned_to][index]]
                        else:
                            selections[let.assigned_to] = instantiated_lets[let.assigned_to]
                        
        
        for create in self.creates:
            created_objects, relationships = create(initializations,selections,creations,module)
            created[create.name] += created_objects
            all_objects[create.name] += created_objects
            all_relationships |= relationships
        
        for object_type in all_objects:
            uniq = {}
            for obj in all_objects[object_type]:
                uniq[obj['id']] = obj
            all_objects[object_type] = list(uniq.values())
     
            
        for relationship in sorted(all_relationships):
            source = relationship[0]
            relationship = relationship[1]
            target = relationship.target
            name = relationship.name
            val = relationship.value
            for source_char in all_objects[source]:
                s_id = source_char['id']
                if 'relationships' not in source_char:
                    source_char['relationships'] = set()
                    
                t_count = 0
                if target in all_objects:
                    for target_char in all_objects[target]:
                        t_id = target_char['id']
                        
                        if s_id == t_id:
                            continue
                        t_count += 1
                        if val is not None:
                            source_char['relationships'].add((name,t_id,val))
                        else:
                            source_char['relationships'].add((name,t_id))
                            
                else:
                    pass
                    #print(f'MISSING: {target} in {relationship}')
        
        flattened = []
        for cat in created.values():
            flattened += cat
            
        for selection in new_selections:
            del selections[selection]
        
        return flattened
    
def parse_initialization(initialization):
    initialization = initialization[1]
    lets = []
    creates = []
    selects = []
    deferred_lets = []
    for thing in initialization:
        if thing[0] == 'Name':
            name = thing[1]
        elif thing[0] == 'Let':
            for assignment in thing[1]:
                if assignment[0] == 'Assignment':
                    lets.append(parse_assignment(assignment))
                elif assignment[0] == 'DeferredAssignment':
                    deferred_lets.append(parse_deferred_assignment(assignment))
        elif thing[0] == 'Create':
            creates.append(parse_create(thing[1]))
        elif thing[0] == 'Select':
            selects.append(parse_select(thing[1]))
    return Initialization(name,lets,deferred_lets,creates,selects)

@dataclass
class Initialize:
    creates: list = field(default_factory=list)
    def __call__(self,initializations,selections,creations,module):
        if creations is None:
            creations = []
            
        for create in self.creates:
            created = create.num(initializations,selections,creations,module)
            creations += created
        
        return creations
    
def parse_initialize(initialize):
    initialize = initialize[1]
    creates = []
    for thing in initialize:
        if thing[0] == 'Create':
            creates.append(parse_create(thing[1]))
        else:
            print(f'Uh Oh -- {thing[0]} is not recognized for an initialize command' )
    return Initialize(creates)
@dataclass
class RandomChoice:
    choices:list
    def __call__(self,initializations,selections,creations,module):
        return  random.choice(self.choices)
    
@dataclass
class Default:
    name:str
    options:list
    counter = 0
    def __call__(self,initializations,selections,creations,module):
        constructed = {'type':self.name,'status':{},'id':f'{self.name}{Default.counter}'}
        Default.counter += 1
        for option in self.options:
            if isinstance(option,Assignment):
                
                
                if option.assigned_to not in set(['name','first_name','last_name','age','traits']):      
                    
                    possibilities = flatten_list([assigned_val(initializations,selections,creations,module) for assigned_val in option.assigned_val])
                    
                    constructed['status'][(option.assigned_to,)] = random.choice(possibilities)
                else:
                    constructed[option.assigned_to] = flatten_list([assigned_val(initializations,selections,creations,module) for assigned_val in option.assigned_val])
            else:
                
                constructed['status'][(option.name,)] = option.value
        return constructed
        
def parse_default(default):
    default = default[1]
    name = ''
    options = []
    for thing in default:
        if thing[0] == 'Name':
            name = thing[1]
        elif thing[0] == 'Options':
            options = parse_options(thing)
    return Default(name,options)
comparators = {
    '==': lambda x,y: x==y,
    '=': lambda x,y: x==y,
    '!=': lambda x,y: x!=y,
    '<=': lambda x,y: x<=y,
    '>=': lambda x,y: x>=y,
    '>': lambda x,y: x>y,
    '<': lambda x,y: x<y}

@dataclass
class Filter:
    category: str
    comparator: str
    num: int
    uniq: bool
    particular: str = None
    
    def __call__(self,creation):
        category = creation.get(self.category,[])
        if self.uniq:
            if self.particular is None:
                kinds = set()
                for thing in category:
                    kinds.add(thing[0])
                return comparators[self.comparator](len(kinds),self.num)
            else:
                kinds = set()
                for thing in category:
                    if thing[0] == self.particular:
                        kinds.add(thing)
                return comparators[self.comparator](len(kinds),self.num)
                
            
        else:
            return comparators[self.comparator](len(category),self.num)
        
    
    
def parse_filter(filter_text):
    filter_text = filter_text[1]
    if len(filter_text) == 3:
        uniq = filter_text[0][0] == 'Uniq'
        category = filter_text[0][1]
        comparator = filter_text[1][1]
        num = int(filter_text[2][1])
        particular = None
    elif len(filter_text) == 4:
        uniq = True
        category = filter_text[0][1]
        particular = filter_text[1][1]
        comparator = filter_text[2][1]
        num = int(filter_text[3][1])
    else:
        raise Exception(f'Unknown # of arguments for filter: {filter_text}')
    
    return Filter(category,comparator,num,uniq,particular)
class KismetInitialization():
    def __init__(self,initialization_file,kismet_module,kept=set()):
        self.module = kismet_module
        
        init_file = initialization_file
        input_stream = FileStream(init_file)
        lexer = kismet_initializationLexer(input_stream)
        stream = CommonTokenStream(lexer)
        parser = kismet_initializationParser(stream)
        error_listener = MyErrorListener()
        parser._listeners = [ error_listener ]
        tree = parser.init()
        vis = kismet_initializationVisitor()
        initialization = vis.visit(tree)
        
        if len(error_listener.errors) > 0:
            errors = [re.sub(r"^(\d+):",r"On Line #\1\n",error) for error in error_listener.errors]
            warn(f'Errors found in {initialization_file}')
            warn('\n\n'+'\n\n'.join(errors))
            raise Exception(f'Errors found in {initialization_file}')
        self.all_things = {}
        self.kept = kept
        for thing in initialization[1]:
            if thing[0] not in self.all_things:
                self.all_things[thing[0]] = []
            self.all_things[thing[0]].append(thing)

    def run_initialization(self):   
        initializations = {}
        for default in self.all_things.get('Default',[]):
            default = parse_default(default)
            initializations[default.name] = default

        for initialization in self.all_things.get('Initialization',[]):
            initialization = parse_initialization(initialization)
            initializations[initialization.name] = initialization
        
        creations = []
        
        for previously_kept in self.kept:
            if 'character' in previously_kept:
                keeping = self.module.population[previously_kept]
                keeping['type'] = 'character'
                keeping['traits'] = [self.module.traits[trait] for trait in keeping['traits']]
                print(keeping['status'])
                keeping['age'] = (keeping['status'][('age',)],)
            elif 'location' in previously_kept:
                keeping = self.module.created_locations[previously_kept]
                keeping['type'] = 'location'
                keeping['location_type'] = (keeping['location_type'],)
            else:
                print('DONT KNOW HOW TO KEEP', previously_kept)
            _relationships = []
            for relationship in keeping['relationships'] :
                if isinstance(relationship,dict):
                    val = relationship['value']
                    if val != '':
                        val = parseNumRange([[int(val)]])
                        _relationships.append((relationship['relation_name'], relationship['target'], val))
                    else:
                        _relationships.append((relationship['relation_name'], relationship['target']))
                else:
                    _relationships.append(relationship)
            keeping['relationships'] = _relationships
            keeping['name'] = [keeping['name']]
            
            creations.append(keeping)                     
            
        for initialize in self.all_things['Initialize']:  
            init = parse_initialize(initialize)           
            creations += init(initializations,{'traits':self.module.selectable_traits},creations,self.module)
        
        found = set()
        kept = []
        for creation in creations:
            if creation['id'] not in found:
                found.add(creation['id'])
                kept.append(creation)
        creations = kept
        
        eliminated = set()
        initial_size = 0
        
        while initial_size != len(creations):
            initial_size = len(creations)
            for filter_text in self.all_things.get('Filter',[]):
                filter = parse_filter(filter_text)
                for creation in creations:
                    if filter(creation): 
                        eliminated.add(creation['id'])
            creations_ = []
            for creation in creations:
                if creation['id'] not in eliminated:
                    creation['relationships'] = [relationship for relationship in creation['relationships'] if relationship[1] not in eliminated and relationship[1] in found]
                    creations_.append(creation)
            creations = creations_
        
        
        
        return creations