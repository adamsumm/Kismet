
if __name__ == 'Kismet':
    import kismetLexer
    from kismetParser import kismetParser 
    import KismetInitialization
    import mod
else:    
    
    from . import KismetInitialization
    from . import kismetLexer
    from .kismetParser import kismetParser
    from . import mod
    
from warnings import warn
import tracery
from tracery.modifiers import base_english
from antlr4.error.ErrorListener import ErrorListener
from itertools import *
import os
from antlr4 import *
import json
from collections import namedtuple
import random 
import itertools
import collections
import subprocess
import random
import sys
import numpy as np
from dataclasses import dataclass
from sys import exit
import re
import shutil
import functools
module_singleton = None
import platform

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
    #    print('ERROR',err)
        
    out = outb.decode("utf-8")
    if len(out) == 0:
        print(f'Command "{" ".join(args)}" failed.')
        print(outb)
        print(out)
        
    with open('dump.lp', 'w') as outfile:
        result = json.loads(out)
        if len( result['Call'][0]) == 0:
            print('ERROR', ' '.join(print_args))
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

    # Visit a parse tree produced by kismetParser#randomized.
    def visitRandomized(self, ctx:kismetParser.RandomizedContext):
        return ('Randomized',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#event.
    def visitEvent(self, ctx:kismetParser.EventContext):
        return ('Event',self.visitChildren(ctx))


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


    # Visit a parse tree produced by kismetParser#time.
    def visitTime(self, ctx:kismetParser.TimeContext):
        return ('Time', self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#num_range.
    def visitNum_range(self, ctx:kismetParser.Num_rangeContext):
        return ('NumRange', self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#time_statement.
    def visitTime_statement(self, ctx:kismetParser.Time_statementContext):
        return ('TimeStatement', self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#time_start_modifier.
    def visitTime_start_modifier(self, ctx:kismetParser.Time_start_modifierContext):
        return ('TimeStartModifier',ctx.getText())


    # Visit a parse tree produced by kismetParser#time_iteration_modifier.
    def visitTime_iteration_modifier(self, ctx:kismetParser.Time_iteration_modifierContext):
        return ('TimeIterationModifier',ctx.getText(), self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#list_range.
    def visitList_range(self, ctx:kismetParser.List_rangeContext):
        return ('TimeType', self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#time_type.
    def visitTime_type(self, ctx:kismetParser.Time_typeContext):
        return  ('TimeType', self.visitChildren(ctx))



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

    # Visit a parse tree produced by kismetParser#cond7.
    def visitCond8(self, ctx:kismetParser.Cond7Context):
        children = self.visitChildren(ctx)
        return ('SetSelfValue',children)

    # Visit a parse tree produced by kismetParser#cond7.
    def visitCond9(self, ctx:kismetParser.Cond7Context):
        children = self.visitChildren(ctx)
        return ('DualCompare',children)

    # Visit a parse tree produced by kismetParser#cond7.
    def visitCond10(self, ctx:kismetParser.Cond7Context):
        children = self.visitChildren(ctx)
        return ('DualCompareRelations',children)
    
    # Visit a parse tree produced by kismetParser#condTime.
    def visitCondTime(self, ctx:kismetParser.CondTimeContext):
        return ('Time', self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#condTimeComparator.
    def visitCondTimeComparator(self, ctx:kismetParser.CondTimeComparatorContext):
        return ('TimeCompare', self.visitChildren(ctx))
    
    # Visit a parse tree produced by kismetParser#condTimeHistory.
    def visitCondTimeHistory(self, ctx:kismetParser.CondTimeHistoryContext):
        return ('TimeHistory', self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#condTimePersonal.
    def visitCondTimePersonal(self, ctx:kismetParser.CondTimePersonalContext):
        return ('TimePersonal', self.visitChildren(ctx))

    # Visit a parse tree produced by kismetParser#condTimePersonal.
    def visitCondTimePersonalAssignment(self, ctx:kismetParser.CondTimePersonalAssignmentContext):
        return ('TimePersonalAssignment', self.visitChildren(ctx))
    
    def visitCondTimePersonalRelativeAssignment(self, ctx:kismetParser.CondTimePersonalRelativeAssignmentContext):
        return ('TimePersonalRelativeAssignment',self.visitChildren(ctx))
    
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

# In[7]:


def thing2dict(thing):
    id = 0
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
    operator_mapping = {'+=':'plus',
                        '-=':'minus',
                        '=':'eq'}
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
        
        arg2 = arg2
        comparison = arguments[1][1]
        text = f'{comparisonMapping[conditional_type][comparison]}{arg1}, {arg2})'
        if conditional_type == 'Result':
            text += ' :- '
            text = [text]
    elif cond_type == 'Update':
        if arguments[-1][0] == 'Num':
            char1 = arguments[0][1][1]
            rel = arguments[1][1]
            rel = rel
            char2 = arguments[2][1][1]
            operation = arguments[3]       
            val = arguments[4][1]
            if len(operation) == 2:
                operator_text = f'X {operation[0]} {val} = Y'
            else:
                operator_text = f'{val} = Y'
            text = [f'update({char1},{rel},{char2},Y) :- is({char1},{rel},{char2},X), {operator_text}, ']
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
                
            rel = rel
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
        rel = rel
        # A and B like each other -=5
        if arguments[-1][0] == 'Num':
            operation = arguments[-2]#[0]
            
            val = arguments[-1][1]  
            
            if len(operation) == 2:
                operator_text = f'X {operation[0]} {val} = Y'
            else:
                operator_text = f'{val} = Y'
            
            text = [f'update({char1},{rel},{char2},Y) :- is({char1},{rel},{char2},X), {operator_text},',    
                    f'update({char2},{rel},{char1},Y) :- is({char2},{rel},{char1},X), {operator_text},']
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
    elif cond_type == 'DualCompare':
        char1 = arguments[0][1][1]
        stat1 = arguments[1][1]
        operator = arguments[2][1]
        char2 = arguments[3][1][1]
        stat2 = arguments[4][1]
        
        text = f'is({char1},{stat1},V_{char1}_{stat1}), is({char2},{stat2},V_{char2}_{stat2}), V_{char1}_{stat1} {operator} V_{char2}_{stat2}'
    elif cond_type == 'DualCompareRelations':
        char1 = arguments[0][1][1]
        stat1 = arguments[1][1]
        target1 = arguments[2][1][1]
        operator = arguments[3][1]
        char2 = arguments[4][1][1]
        stat2 = arguments[5][1]
        target2 = arguments[6][1][1]
        
        text = f'is({char1},{stat1},{target1},V_{char1}_{stat1}_{target1}), is({char2},{stat2},{target2},V_{char2}_{stat2}_{target2}), V_{char1}_{stat1}_{target1} {operator} V_{char2}_{stat2}_{target2}'
    elif cond_type == 'SetSelfValue':
        
        char1 = arguments[0][1][1]
        stat = arguments[1][1]
        
        operator = arguments[2]
        val = arguments[3][1]
        
        if len(operator) == 2:
            operator_text = f'X {operator[0]} {val} = Y'
        else:
            operator_text = f'{val} = Y'
            
        
        text = [f'update({char1},{stat},Y) :- is({char1},{stat},X), {operator_text}, ']
    elif cond_type == 'CondPattern':
        name = arguments[0][1]
        args = [name] + [arg[1][1] for arg in arguments[1:]]
        text = f'pattern({",".join(args)})'
    elif cond_type == 'Time':
        timeVar = arguments[0][1]
        timeVal = arguments[1][1]
        
        args = []
        for loop in module_singleton.time.time_loops:
            if loop.name == timeVar:
                args.append(f'T_{timeVar}')
            else:
                args.append('_')
        text = f'now(time({",".join(args)})), T_{timeVar} = {timeVal}'
        
    elif cond_type == 'TimeCompare':
        timeVar = arguments[0][1]
        comparator = arguments[1][1]
        timeVal = arguments[2][1]
        
        args = []
        for loop in module_singleton.time.time_loops:
            if loop.name == timeVar:
                args.append(f'T_{timeVar}')
            else:
                args.append('_')
        text = f'now(time({",".join(args)})), T_{timeVar} {comparator} {timeVal}'
    elif cond_type == 'TimeHistory':
        comparator = arguments[0][1]
        num = arguments[1][1]
        time_unit = arguments[2][1]
        event = arguments[3][1][1]
        text = f'time_since(T_{event},{time_unit},N_{event}), N_{event} {comparator} {num}, {event} = action(_,_,_,_,_,_,T_{event})'
        
    elif cond_type == 'TimePersonal':
        comparator = arguments[0][1]
        num = arguments[1][1]
        time_unit = arguments[2][1]
        character = arguments[3][1][1]
        event = arguments[4][1]
        uniq = f'{character}_{event}'.lower()
        text = f'time_since(T_{uniq},{time_unit},N_{uniq}), N_{uniq} {comparator} {num}, is({character},{event},T_{uniq})'
    elif cond_type == 'TimePersonalAssignment':
        character = arguments[0][1][1]
        event = arguments[1][1]
        uniq = f'{character}_{event}'.lower()
        text = [f'update({character},{event},Now) :- now(Now),']
    elif cond_type == 'TimePersonalRelativeAssignment':
        character = arguments[0][1][1]
        event = arguments[1][1]
        uniq = f'{character}_{event}'.lower()
        
        variable = arguments[2][1]
        operator = operator_mapping[arguments[3]]
        offset = arguments[4][1]
            
        text = [f'update_date({character},{event},{variable},{operator},{offset}) :- ']
    else:
        raise Exception(f'UH OH --- Unknown Conditional Type -- missing "{cond_type}"')
    return text

def get_unique_name(name):
    return module_singleton.name2uniq.get(name,[name])[0]

def get_common_name(name):
    return module_singleton.uniq2name.get(name,name)

def parseConditions(conditions,conditional_type='Conditional'):
    if type(unsqueeze(conditions)[0]) is list:
        conditions = unsqueeze(conditions)
    return [parseConditional(condition,conditional_type) for condition in conditions]

def parseArguments(thing):
    
    constraints = []
    characters = []
    arguments = []
    
    for argument in thing.get('Arguments',[]):
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
    
@dataclass
class Event:
    constraints: str
    tags: str
    characters: str
    results: str
    text: str
    visibility: str
    extensions: str
    arguments: str
    randomized: bool
        
def parseActionOrEvent(action,action_name,is_event=False):
    text = ''
    constraints = []
    initiator = None
    targets = []
    indirect_objects = []
    actions = []
    characters = []
    cost = -100

    characters, constraints, arguments = parseArguments(action)
    randomized = False
    if is_event:
        randomized = 'Randomized' in action
        
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
    namedLocations = [location for location in namedLocations if location[0].isupper()]
    for locCombo in combinations(namedLocations, 2):
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
    if is_event:
        return Event(constraints, tags,
                      characters,results,
                      randomText,visibility,
                      extension,arguments,
                      randomized)
    else:
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
        
    constraints += [f'at({characters[0][1]},Location)', f'castable({get_common_name(rolename)},Location)', f'mode(casting)']
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

Trait = namedtuple('Trait',['is_default','is_num','is_trait','is_status','alternative_names','arguments','propensities','propensityASP','opposition'])
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
    
    orig_arguments = arguments
    
    
    for is_propensity,is_goto,valence,constraints,modified_tags in pos_propensities:
        if len(modified_tags) == 0:
            modified_tags = ['go_to_location']
        for tag in modified_tags:
            if is_goto:
                kind = 'go_to_propensity'
                arguments = {arg_type:orig_arguments.get(arg_type,default) for arg_type,default in [('>','null'),('<','null'),('^','null'),('*','null'),('@','LOCATION')]}
                asp_args = ', '.join([orig_arguments.get(arg_type,default) for arg_type,default in [('>','null'),('<','null'),('^','null'),('*','null'),('@','LOCATION')]])
            else:
                kind = 'propensity'
                arguments = {arg_type:orig_arguments.get(arg_type,default_args[arg_type]) for arg_type in ['>','<','^','*','@']}           
                asp_args = ', '.join([orig_arguments.get(arg_type,default_args[arg_type])   for arg_type in ['>','<','^','*','@']])
                
            head = f'{kind}({tag}, {valence}, {get_common_name(traitname)},{asp_args} ) ' 
            if kind == 'propensity':
                premises = ['action(ACTION_NAME,'+','.join([f'{arguments[arg_type]}' for arg_type in ['>','<','^','*','@']] ) +')']
            else:
                premises = []
            premises.append(f'is({arguments[">"]}, {get_common_name(traitname)})')
            
            constraints = unsqueeze(constraints)
            if (type(constraints) is list):
                premises += constraints
            else:
                premises.append(constraints)
            if tag != 'go_to_location':
                if kind == 'propensity':
                    premises.append(f'is(ACTION_NAME,{tag})')
                else:
                    premises.append(f'is({arguments["@"]},{tag})')
                
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
                    arguments = {arg_type:orig_arguments.get(arg_type,default) for arg_type,default in [('>','null'),('<','null'),('^','null'),('*','null'),('@','LOCATION')]}
                    asp_args = ', '.join([orig_arguments.get(arg_type,default) for arg_type,default in [('>','null'),('<','null'),('^','null'),('*','null'),('@','LOCATION')]])
                    
                else:
                    kind = 'propensity'
                    arguments = {arg_type:orig_arguments.get(arg_type,default_args[arg_type]) for arg_type in ['>','<','^','*','@']}
                    asp_args = ', '.join([orig_arguments.get(arg_type,default_args[arg_type])   for arg_type in ['>','<','^','*','@']])
                

                head = f'{kind}({tag}, {-valence}, {traitname}, {asp_args} ) '

                if kind == 'propensity':
                    premises = ['action(ACTION_NAME,'+','.join([f'{arguments[arg_type]}' for arg_type in ['>','<','^','*','@']] ) +')']
                else:
                    premises = []
                premises.append(f'is({arguments[">"]}, {traitname})')
                premises += constraints

                if tag != 'go_to_location':
                    if kind == 'propensity':
                        premises.append(f'is(ACTION_NAME,{tag})')
                    else:
                        premises.append(f'is({arguments["@"]},{tag})')
                

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
    return [casting[1][1] for casting in cast]

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


def parseNumRange(choice):    
    # [a-b] pdf name
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
    return  makeDistribution(lower,upper,pdf)

@dataclass
class TimeLoop:
    name: str
    startModifier: list
    iterationModifier: list
    time:list
    
    @staticmethod
    def sanitize(label):
        if type(label) is str:
            label = label.strip().rstrip()  
            if label.isnumeric():
                return int(label)
            else:
                return label
        else:
            return label
    
    def init(self):
        if self.startModifier:
            self.time()
        self.time.loop_type, _ = self.iterationModifier()
    def __call__(self):
        return self.time.step(self.iterationModifier)
    
    def get_counter(self,label):
        return self.time.get_counter(TimeLoop.sanitize(label))
    
    def __len__(self):
        return len(self.time)
    
    def get(self):
        return self.time.get()
@dataclass
class TimeRange:
    distribution: list
    current:int
    lower:int
    upper:int
        
    def __call__(self):
        self.current = self.distribution()
    
    def get(self):
        return self.current
    
    def get_counter(self, label):
        if self.loop_type == '*':
            return label-self.lower+1
        else:
            return label
    
    def __len__(self):
        return self.upper-self.lower+1
    
    def step(self,step_function):
        loop_type, step = step_function()
        self.current += step
        loops = 0
        if self.loop_type == '*':
            if loop_type == '*':
                while  self.current > self.upper:
                    loops += 1
                    self.current -= (self.upper-self.lower)
        return loops
    
    
    def increment(self):
        self.current += 1
        loops = 0
        
        if self.loop_type == '*':
            while  self.current >  self.upper:
                loops += 1
                self.current -= (self.upper-self.lower)
        return loops
    
    def reverse_increment(self):
        self.current -= 1
        loops = 0
        
        if self.loop_type == '*':
            if self.current < self.lower:
                loops += 1
                self.current += (self.upper-self.lower)
        return loops
    
@dataclass 
class TimeList:
    members: list
    current: int = 0
    
    label2index: dict = None
    def __call__(self):
        self.current =  random.randrange(len(self.members))
    def get(self):
        return self.members[self.current]
    
    def get_counter(self, label):
        if self.label2index is None:
            self.label2index = {label:index for index, label in enumerate(self.members)}
        return self.label2index[label]
    
    def __len__(self):
        return len(self.members)
    
    def step(self, step_function):
        loops = 0
        loop_type, step = step_function()
        self.current =  self.current + step
        
        while  self.current >= len(self.members):
            loops += 1
            self.current -= len(self.members)
        return loops
    
    
    def increment(self):
        self.current += 1
        loops = 0
        while  self.current >= len(self.members):
            loops += 1
            self.current -= len(self.members)
            
        return loops
    def reverse_increment(self):
        self.current -= 1
        loops = 0
        if self.current < 0:
            loops += 1
            self.current += len(self.members)
        return loops
            
def parseTimeLoop(statement):
    name = ''
    startModifier = None
    iterationModifier = lambda: ('+', 1)
    time = None
    arguments = ['']
    for kind, *arguments in statement:
        if kind == 'Name':
            name = arguments[0]
        elif kind == 'TimeStartModifier':
            startModifier = arguments[0]
        elif kind == 'TimeType':
            timeType, *arguments = unsqueeze(arguments)
            arguments = unsqueeze(arguments)
            if timeType == 'NumRange':
                lower = int(arguments[0][1])
                upper = int(arguments[1][1])
                num_range = parseNumRange(arguments)
                time = TimeRange(num_range,lower,lower,upper)
            elif timeType == 'TimeType':
                arguments = [a[1] for a in arguments]
                time = TimeList(arguments)
            else:
                print(f'Dont know what to do with TimeType: {timeType}')
        elif kind == 'TimeIterationModifier':
            raw, *parameters = arguments
            parameters = unsqueeze(parameters)
            if len(raw) == 1:
                if raw == '+':
                    pass
                elif raw == '?':
                    iterationModifier = lambda: (raw[0], random.randrange(len(arguments)))
                else:
                    iterationModifier = lambda: ('*', 1)
                    
            elif len(parameters) == 1:
                iterationModifier = lambda: (raw[0],int(parameters[0][1]))
            else:
                distribution = parseNumRange(parameters[1])
                iterationModifier = lambda: (raw[0], distribution())
                
        else:
            print(f'DONT KNOW WHAT TO DO WITH {kind} {arguments} when Parsing A Time Loop')
    timeLoop = TimeLoop(name, startModifier, iterationModifier, time)
    timeLoop.init()
    return timeLoop

@dataclass
class Time:
    time_loops: list
    current_time: list = None
    common_denominator:list = None
    def __call__(self):
        for loop in self.time_loops:
            looped = loop()
            if looped == 0:
                break
        self.current_time = [(loop.name, loop.get()) for loop in self.time_loops]
        
        #print(self.delta([('day', 25), ('month', 'feb'), ('year', 1899)],self.current_time))
            
        return self.current_time
    
    
    def offset_other(self,other,direction, offsets):
        
        originals = [loop.time.current for loop in self.time_loops]
        for o, loop in zip(other,self.time_loops):
            loop.time.current =loop.time.get_counter(o)
        
        if direction == '+':
            previous_loops = 0
            for loop in self.time_loops:
                looped = 0
                if loop.name in offsets:
                    for _ in range(offsets[loop.name]+previous_loops):
                        looped += loop.time.increment()
                elif previous_loops != 0:
                    for _ in range(previous_loops):
                        looped += loop.time.increment()
                    
                previous_loops = looped
        elif direction == '-':
            previous_loops = 0
            for loop in self.time_loops:
                looped = 0
                if loop.name in offsets:
                    for _ in range(offsets[loop.name]+previous_loops):
                        looped += loop.time.reverse_increment()
                elif previous_loops != 0:
                    for _ in range(previous_loops):
                        looped += loop.time.reverse_increment()
                    
                previous_loops = looped
        else:
            pass
        
        offset_time =  [(loop.name, loop.get()) for loop in self.time_loops]
        
        for original, loop in zip(originals,self.time_loops):
            loop.time.current = original
        return offset_time 
    
        
        
    
    def offset(self,direction,offsets):
        
        originals = [loop.time.current for loop in self.time_loops]
        
        if direction == '+':
            previous_loops = 0
            for loop in self.time_loops:
                looped = 0
                if loop.name in offsets:
                    for _ in range(offsets[loop.name]+previous_loops):
                        looped += loop.time.increment()
                elif previous_loops != 0:
                    for _ in range(previous_loops):
                        looped += loop.time.increment()
                    
                previous_loops = looped
        elif direction == '-':
            previous_loops = 0
            for loop in self.time_loops:
                looped = 0
                if loop.name in offsets:
                    for _ in range(offsets[loop.name]+previous_loops):
                        looped += loop.time.reverse_increment()
                elif previous_loops != 0:
                    for _ in range(previous_loops):
                        looped += loop.time.reverse_increment()
                    
                previous_loops = looped
        else:
            pass
        
        offset_time =  [(loop.name, loop.get()) for loop in self.time_loops]
        
        for original, loop in zip(originals,self.time_loops):
            loop.time.current = original
        return offset_time
    def delta(self, earlier, later):
        earlier_indices =  [loop.get_counter(label[1]) for loop, label in zip(self.time_loops,earlier)]
        later_indices =  [loop.get_counter(label[1]) for loop, label in zip(self.time_loops,later)]
        if self.common_denominator is None:
            loop_lengths = [len(loop) for loop in self.time_loops]
            self.common_denominator = [1]
            for i in range(1,len(loop_lengths)):
                self.common_denominator.append(self.common_denominator[i-1]*loop_lengths[i-1])
        diffs = [ (l-e)*cd for l,e,cd in zip(later_indices, earlier_indices,self.common_denominator)]
        d = functools.reduce(lambda x,y: x+y, diffs)
        diffs = [d//cd for cd in self.common_denominator]
        return diffs, [(loop.name, delta) for loop, delta in zip(self.time_loops,diffs)] 
    
def parseTime(raw):
    raw = raw['TimeStatement']
    time_loops = [parseTimeLoop(unsqueeze(statement)) for statement in raw]
    t = Time(list(reversed(time_loops)))
    return Time(list(reversed(time_loops)))

@dataclass 
class Location:
    supports: dict
    each_turn: list
    tags: list
        
def locationToASP(location,location_name):

    #if 'Supports' not in location:
    #    error_log.append(f'ERROR: supports missing in location "{location_name}"')
    #    return None
    #if 'TextualName' not in location:
    #    error_log.append(f'ERROR: name missing in location "{location_name}"')
    #if 'Initialization' not in location and 'EachTurn' not in location:
    #    error_log.append(f'ERROR: No casting details in location "{location_name}"')
        
    location['Supports'] = location['Supports'][0]
    if not isinstance(location['Supports'][0],list):
        location['Supports'] = [location['Supports']]
    
    tags = parseTags(location)
    supported_roles = {}
    for supported in location['Supports']:
        role,distribution = parseNumChoice(supported[1])
        supported_roles[role] = distribution

    initialization = []
    each_turn = []
    if 'EachTurn' in location:
        each_turn = castToASP(location['EachTurn'])
    return Location(supported_roles, each_turn, tags)


@dataclass
class Pattern:
    asp_str: str
    text: str
    arguments:  str  
def patternToASP(pattern,pattern_name):
    
    conditions = parseConditions(pattern['Conditions'])
    characters, constraints, arguments = parseArguments(pattern)    
    pattern_name = get_common_name(pattern_name)
    if len(arguments) > 0:
        asp_string = f'pattern({pattern_name},' + ', '.join(arg[1] for arg in arguments) + ') :-\n\t'
    else:
        asp_string = f'pattern({pattern_name}) :-\n\t'
    
    
    #for arg1,arg2 in itertools.combinations(arguments,2):
    #    conditions.append(f'different({arg1[1]},{arg2[1]})')
    for arg1,arg2 in itertools.combinations(arguments,2):
        conditions.append(f'{arg1[1]} != {arg2[1]}')
    asp_string += ',\n\t'.join(conditions)     
    asp_string += '.'
    if 'RandomText' in pattern:
        randomText = pattern['RandomText'][0][1:-1]
    else:
        char_text = ', '.join([c[1] for c in characters])
        randomText = f'{pattern_name} {char_text}'
        
    return Pattern(asp_string,randomText,arguments)

class KismetModule():
    def __init__(self,module_files,
                 tracery_files=[],
                 temperature=1.0,
                 observation_temp=1.0,
                 ignore_logit=5.0,
                 history_cutoff=10,
                action_budget = 3,
                default_cost = 3,
                clingo_exe='./clingo',
                base_folder=''):
        
        
        global module_singleton
        module_singleton = self
            
        if platform.system() == 'Windows':
            clingo_exe = 'clingo'

                                
                    
        self.path = os.path.abspath(os.path.dirname(__file__))
        self.module_files = module_files
        all_files = ''.join(self.module_files)
        all_files = all_files.replace('/','_').replace('\\','_').replace('..','_')
        self.module_file = os.path.basename(all_files+'_conglomeration.kismet')
        with open(self.module_file,'wb') as wfd:
            for f in self.module_files:
                with open(f,'rb') as fd:
                    shutil.copyfileobj(fd, wfd)
        
        self.clingo_exe = clingo_exe
        self.temperature = temperature
        self.observation_temp = observation_temp
        self.ignore_logit = ignore_logit
        self.default_cost = default_cost
        self.timestep = 0
        self.tempstep = 0
        self.history_cutoff = history_cutoff
        self.action_budget = action_budget
        self.history = []
        self.event_history = []
        self.times = []
        self.location_history = []
        self.character_knowledge = []
        
        error_log = []
        input_stream = FileStream(self.module_file)
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
        mod.tracery_grammar = self.tracery_grammar 
        self.grammar.add_modifiers(base_english)

        
        if len(error_listener.errors) > 0:
            warn(f'Errors found in {self.module_file}')
            warn('\n\n'.join(error_listener.errors))
            raise Exception(f'Errors found in {self.module_file}')
        vis = KismetVisitor()
        world = vis.visit(tree)

        things = {  
                    'Action':{},
                    'Location':{},
                    'Role':{},
                    'Trait':{},
                    'Pattern':{},
                    'Time':{},
                    'Event':{}}
        uniq_id = 0
        self.name2uniq = {}
        self.uniq2name = {}
        for thing in world:
            name = ''
            for t in thing[1]:
                if t[0] == 'Name':
                    name = t[1]
                    break
            
            uniq_name = name + str(uniq_id)
            uniq_id += 1
            if name not in self.name2uniq:
                self.name2uniq[name] = []
            self.name2uniq[name].append(uniq_name)
            self.uniq2name[uniq_name] = name
            name = uniq_name
            things[thing[0]][name] = thing2dict(thing[1])
            
        self.time = parseTime(list(things['Time'].values())[0])
        self.current_time = self.time()
        
        self.actions = {action:parseActionOrEvent(things['Action'][action],action) for action in things['Action']}
        self.events = {event:parseActionOrEvent(things['Event'][event],event,is_event=True) for event in things['Event']}
        for name,action in self.actions.items():
            if action.cost <= 0:
                action.cost = self.default_cost

        self.roles = {role:parseRole( things['Role'][role],role) for role in things['Role']}
        self.traits = {trait:parseTrait(things['Trait'][trait],trait) for trait in things['Trait']}
        
        self.locations = {location:locationToASP(things['Location'][location],location) for location in things['Location']}
        
        self.patterns = {pattern:patternToASP(things['Pattern'][pattern],pattern) for pattern in things['Pattern']}
        
        traits_ = {}
        self.alternative_names = {}
        for trait in self.traits:
            for trait_ in self.traits[trait]:
                names = trait_.alternative_names
                self.alternative_names[names[0]] = names[1:]
                traits_[names[0]] = trait_
        self.name_map = {}
        for name in self.alternative_names:
            self.name_map[name] = name
            for other in self.alternative_names[name]:
                self.name_map[other] = name
                
        self.traits = traits_
        self.default_traits = []
        self.selectable_traits = []
        self.numerical_status = []
        for name,trait in self.traits.items():
            if trait.is_trait:
                if trait.is_default:
                    self.default_traits.append(trait)
                else:
                    self.selectable_traits.append(trait)
            if trait.is_num:
                self.numerical_status.append(trait)
        for name, role in self.roles.items():
            
            characters, constraints, extension, tags,arguments = role
            char_text = ', '.join([''.join(c) for c in characters])
            arg_dict = simpleDictify(arguments)
            location = 'Location'
            self.actions[f'cast_{name}'] = Action(constraints, tags, characters, [f'add({characters[0][1]},{get_common_name(name)},{location}) :- '], f'cast_{name} {char_text}', 0, extension,arguments,False,False,True,1)
            
            self.name2uniq[f'cast_{self.uniq2name[name]}'] = [f'cast_{name}']
            self.uniq2name[f'cast_{name}'] = f'cast_{self.uniq2name[name]}'
        self.extension_graph = {}
        for name in self.actions:
            extension = self.actions[name].extensions
            if extension:
                extension = extension[0]
            self.extension_graph[name] = extension
        
        for name in self.events:
            extension = self.events[name].extensions
            if extension:
                extension = extension[0]
            self.extension_graph[name] = extension
           
        self.traitASP = []
        for trait in self.traits:
            self.traitASP += self.traits[trait].propensityASP

            trait_type = 'trait'
            if self.traits[trait].is_status:
                trait_type = 'status'
            self.traitASP.append(f'{trait_type}({get_common_name(trait)}).')
        self.locationASP = []
        
        for location in self.locations:
            supported_roles = self.locations[location].supports
            tags = self.locations[location].tags
            for role in supported_roles:
                self.locationASP.append(f'castable({get_common_name(role)},{get_common_name(location)}).')
            for tag in tags:                
                self.locationASP.append(f'is({get_common_name(location)},{tag}).')
        
        self.patternASP = [pattern.asp_str for pattern in self.patterns.values()]
        
        self.actions2rules()
        with open(os.path.join(self.path,f'{self.module_file}_rules.lp'), 'w') as asp_file:
            text = '\n\n'.join(self.locationASP+self.actionASP+self.traitASP+self.patternASP)
            options = [('(',')'),('( ',')'),('( ',' )'),('(',' )'),
                       ('(',','),('( ',','),('( ',' ,'),('(',' ,'),
                       (',',','),(', ',','),(', ',' ,'),(',',' ,'),
                       (',',')'),(', ',')'),(', ',' )'),(',',' )')]

            for name in self.alternative_names:
                for alt in self.alternative_names[name]:
                    for option in options:
                        text = text.replace(f'{option[0]}{alt}{option[1]}',f'{option[0]}{name}{option[1]}')
            asp_file.write(text)
            
            
        ####################### EVENTS ##############################
        self.events2rules()
        
        with open(os.path.join(self.path,f'{self.module_file}_event_rules.lp'), 'w') as asp_file:
            text = '\n\n'.join(self.locationASP+self.eventASP+self.traitASP+self.patternASP)
            options = [('(',')'),('( ',')'),('( ',' )'),('(',' )'),
                       ('(',','),('( ',','),('( ',' ,'),('(',' ,'),
                       (',',','),(', ',','),(', ',' ,'),(',',' ,'),
                       (',',')'),(', ',')'),(', ',' )'),(',',' )')]

            for name in self.alternative_names:
                for alt in self.alternative_names[name]:
                    for option in options:
                        text = text.replace(f'{option[0]}{alt}{option[1]}',f'{option[0]}{name}{option[1]}')
            asp_file.write(text)
            
       
        self.sanity_check()    
    
    def events2rules(self):
        self.eventASP = []
        
        for name in self.events:
            constraints = self.events[name].constraints
            tags = self.events[name].tags
            characters = self.events[name].characters
            results = self.events[name].results
            randomText = self.events[name].text
            visibility = self.events[name].visibility
            arguments = self.events[name].arguments
            randomized = self.events[name].randomized
            
            ancestors = []
            
            #Here we go through and follow the extensions
            ancestor = self.extension_graph[name]
            if ancestor:
                current = name
                while ancestor:
                    ancestors.append(ancestor)
                    current = ancestor
                    current = self.name2uniq[current][0]
                    ancestor = self.extension_graph[current]

                extension_arguments = extension[1]
                tags = set(tags)
                prev_arguments = arguments
                mappings = []

                for ancestor in ancestors:
                    ancestor = self.name2uniq[ancestor][0]
                    a_constraints = self.events[ancestor].constraints
                    a_tags = self.events[ancestor].tags
                    a_characters = self.events[ancestor].characters
                    a_results = self.events[ancestor].results
                    a_arguments = self.events[ancestor].arguments
                    
                    mapping = {p:c for p, c in zip(prev_arguments,a_arguments)}
                    r_mapping = {c:p for p, c in zip(prev_arguments,a_arguments)}
                    mappings.append((mapping,r_mapping))

                    converted_constraints = []
                    converted_results = []
                    if a_constraints:
                        for thing in a_constraints:
                            if 'mode' in thing:
                                continue
                            converted_thing = thing
                            for mapping in reversed(mappings):
                                for i, (c,p) in enumerate(mapping[1].items()):
                                    converted_thing = converted_thing.replace(c[1],'!@'*(i+1))
                                for i, (c,p) in reversed(list(enumerate(mapping[1].items()))):
                                    converted_thing = converted_thing.replace('!@'*(i+1),p[1])
                            converted_constraints.append(converted_thing)

                    if a_results:
                        for thing in a_results:
                            converted_thing = thing
                            for mapping in reversed(mappings):
                                for i, (c,p) in enumerate(mapping[1].items()):
                                    converted_thing = converted_thing.replace(c[1],'!@'*(i+1))
                                for i, (c,p) in reversed(list(enumerate(mapping[1].items()))):
                                    converted_thing = converted_thing.replace('!@'*(i+1),p[1])
                            converted_results.append(converted_thing)
                    if not results:
                        results = []
                    results += converted_results
                    constraints += converted_constraints
                    tags |= set(a_tags)

            results = set(results)
            constraints = set(constraints)
            arguments = simpleDictify(arguments)
            arguments = {arg_type:arguments.get(arg_type,'null') for arg_type in ['>','<','^','*','@']}                
            asp_args = ', '.join([arguments.get(arg_type,'null')   for arg_type in ['>','<','^','*','@']])

            head = f'to_occur({get_common_name(name)}, {asp_args})'

            premises = [','.join([f'{arg2type[arg_type]}({arguments[arg_type]})' for arg_type in ['>','<','^','*','@']] )]
            premises += constraints
            if arguments["<"] != 'null':
                premises.append(f'{arguments[">"]} != {arguments["<"]}')
            if arguments["^"] != 'null':
                premises.append(f'{arguments[">"]} != {arguments["^"]}')
            if arguments["<"] != 'null' and arguments["^"] != 'null':
                premises.append(f'{arguments["<"]} != {arguments["^"]}')
                
            for argument in ['>','<','^']:
                if arguments[argument] != 'null':
                    premises.append(f'{arguments[argument]} != null')


            if randomized:
                premises.append(f'mode(randomized)')
            premise = '\t\t'+',\n\t\t'.join(premises)

            self.eventASP.append(head +':-\n'+ premise + '.')

            at_location = ''
          
            for result in results:
                self.eventASP.append(result + at_location +f'occurred({head}).')

            for tag in tags:
                self.eventASP.append(f'is({get_common_name(name)}, {tag}).')
                
            self.eventASP.append(f'visibility({get_common_name(name)},{visibility}).')
            
    
    def actions2rules(self):
        self.actionASP = []
        for name in self.actions:
            constraints = self.actions[name].constraints
            tags = self.actions[name].tags
            characters = self.actions[name].characters
            results = self.actions[name].results
            randomText = self.actions[name].text
            visibility = self.actions[name].visibility
            extension = self.actions[name].extensions
            arguments = self.actions[name].arguments
            free = self.actions[name].free
            response = self.actions[name].response
            is_cast = self.actions[name].is_cast
            cost = self.actions[name].cost
            ancestors = []
            
            #Here we go through and follow the extensions
            ancestor = self.extension_graph[name]
            if ancestor:
                current = name
                while ancestor:
                    ancestors.append(ancestor)
                    current = ancestor
                    current = self.name2uniq[current][0]
                    ancestor = self.extension_graph[current]

                extension_arguments = extension[1]
                tags = set(tags)
                prev_arguments = arguments
                mappings = []

                for ancestor in ancestors:
                    ancestor = self.name2uniq[ancestor][0]
                    a_constraints = self.actions[ancestor].constraints
                    a_tags = self.actions[ancestor].tags
                    a_characters = self.actions[ancestor].characters
                    a_results = self.actions[ancestor].results
                    a_is_cast = self.actions[ancestor].is_cast
                    a_arguments = self.actions[ancestor].arguments
                    
                    mapping = {p:c for p, c in zip(prev_arguments,a_arguments)}
                    r_mapping = {c:p for p, c in zip(prev_arguments,a_arguments)}
                    mappings.append((mapping,r_mapping))

                    converted_constraints = []
                    converted_results = []
                    if a_constraints:
                        for thing in a_constraints:
                            if 'mode' in thing:
                                continue
                            converted_thing = thing
                            for mapping in reversed(mappings):
                                for i, (c,p) in enumerate(mapping[1].items()):
                                    converted_thing = converted_thing.replace(c[1],'!@'*(i+1))
                                for i, (c,p) in reversed(list(enumerate(mapping[1].items()))):
                                    converted_thing = converted_thing.replace('!@'*(i+1),p[1])
                            converted_constraints.append(converted_thing)

                    if a_results:
                        for thing in a_results:
                            converted_thing = thing
                            for mapping in reversed(mappings):
                                for i, (c,p) in enumerate(mapping[1].items()):
                                    converted_thing = converted_thing.replace(c[1],'!@'*(i+1))
                                for i, (c,p) in reversed(list(enumerate(mapping[1].items()))):
                                    converted_thing = converted_thing.replace('!@'*(i+1),p[1])
                            converted_results.append(converted_thing)
                    if not results:
                        results = []
                    results += converted_results
                    constraints += converted_constraints
                    tags |= set(a_tags)
                    is_cast = is_cast or a_is_cast

            results = set(results)
            constraints = set(constraints)
            arguments = simpleDictify(arguments)
            arguments = {arg_type:arguments.get(arg_type,'null') for arg_type in ['>','<','^','*','@']}                
            asp_args = ', '.join([arguments.get(arg_type,'null')   for arg_type in ['>','<','^','*','@']])

            head = f'action({get_common_name(name)}, {asp_args})'

            premises = [','.join([f'{arg2type[arg_type]}({arguments[arg_type]})' for arg_type in ['>','<','^','*','@']] )]
            premises += constraints
            #premises += [f'different({arguments[">"]},{arguments["<"]})',f'different({arguments[">"]},{arguments["^"]})',f'different({arguments["<"]},{arguments["^"]})']
            
            if arguments["<"] != 'null':
                premises.append(f'{arguments[">"]} != {arguments["<"]}')
            if arguments["^"] != 'null':
                premises.append(f'{arguments[">"]} != {arguments["^"]}')
            if arguments["<"] != 'null' and arguments["^"] != 'null':
                premises.append(f'{arguments["<"]} != {arguments["^"]}')
            for argument in ['>','<','^']:
                if arguments[argument] != 'null':
                    premises.append(f'{arguments[argument]} != null')


            if free:
                premises.append(f'mode(free)')
            if response:
                premises.append(f'mode(response)')
            premise = '\t\t'+',\n\t\t'.join(premises)

            self.actionASP.append(head +':-\n'+ premise + '.')

            at_location = ''
            if is_cast:
                at_location = f'at({arguments[">"]}, Location), '
            for result in results:
                self.actionASP.append(result + at_location +f'occurred({head}).')

            for tag in tags:
                self.actionASP.append(f'is({get_common_name(name)}, {tag}).')
            self.actionASP.append(f'visibility({get_common_name(name)},{visibility}).')
    
    def strip_constraint(self,constraint):
        current = ''
        parts = []
        stack = []
        for c in constraint:
            if c == '(':
                parts.append(current)
                current = ''
                stack.append(parts)
                parts = []
            elif c == ')':
                parts.append(current)
                current = ''
                prev = stack.pop()
                prev.append(parts)
                parts = prev
                
            elif c == ',':
                if current != '':
                    parts.append(current)
                current = ''
            else:
                current += c
            
        if current != '':
            parts.append(current)
            
        all_constraints = []
        for thing, next_thing in zip(parts,parts[1:]):
            if isinstance(thing,str) and isinstance(next_thing,list):
                current_constraint = {}
                current_constraint['name'] = thing.replace('not ','').strip()
                current_constraint['args'] = [t.strip() for t in next_thing]
                all_constraints.append(current_constraint)
        return all_constraints
    
    
    def mark_time(self):
        self.tempstep = 0
        
    def sanity_check(self):
        
        
        found_locations = set()
        found_traits = set(['age'])
        found_tags = set()
        found_roles = {get_common_name(role_name) for role_name in self.roles}
        found_actions = set()
        found_patterns = set()
        
        required_locations = set()
        required_traits = set()
        required_tags = set()
        required_actions = set()
        required_patterns = set()
        
        action_to_requirement = {}
        action_to_found = {}
        
        trait_to_requirement = {}
        trait_to_found = {}
        
        name_to_type = {}
        
        for name, action in self.actions.items():
            location_vars = set()
            people_vars = set()
            action_vars = set()
            name = get_common_name(name)
            name_to_type[name] = 'Action'
            action_to_requirement[name] = set()
            action_to_found[name] = set()
            found_tags |= set(action.tags)
            for argtype,arg_name in action.arguments:
                
                if argtype in '><^':
                    people_vars.add(arg_name)
                elif argtype == '*':
                    action_vars.add(arg_name)
                elif argtype == '@':
                    location_vars.add(arg_name)
            mentions = {}
            for constraint in action.constraints:
                constraint_parts = self.strip_constraint(constraint)
                for constraint in constraint_parts:
                    if constraint['name'] == 'is':
                        var_name = constraint['args'][0]
                        tag = constraint['args'][1]
                        if var_name not in mentions:
                            mentions[var_name] = set()
                        mentions[var_name].add(tag)
                        
                        action_to_requirement[name].add(tag)
                    elif constraint['name'] == 'pattern':
                        required_patterns.add(constraint['args'][0])
                        action_to_requirement[name].add(constraint['args'][0])
                    elif constraint['name'] == 'at':
                        location_vars.add(constraint['args'][1])
                    else:
                        pass
                        #print(f'DONT KNOW HOW TO HANDLE "{constraint["name"]}"')
                        #print('\t', constraint)
                        

            for mention in mentions:
                if mention in location_vars:
                    required_locations |= mentions[mention]
                elif mention in people_vars:
                    required_traits |= mentions[mention]
                elif mention in action_vars:
                    required_tags  |= mentions[mention]
                    
            mentions = {}
            for result in action.results:
                result = result.split(':-')
                for result_piece in result:
                    if result_piece != " ":
                        result_parts = self.strip_constraint(result_piece)

                        for result in result_parts:
                            if result['name'] in ['add','update','is','del','update_date']:
                                var_name = result['args'][0]
                                tag = result['args'][1]
                                if var_name not in mentions:
                                    mentions[var_name] = set()
                                mentions[var_name].add(tag)
                                action_to_found[name].add(tag)
                            else:
                                pass#print('RESULT TYPE', result['name'])           
            
            for mention in mentions:
                if mention in location_vars:
                    #found_locations |= mentions[mention]
                    required_traits |= mentions[mention]
                    
                elif mention in people_vars:
                    #found_traits |= mentions[mention]
                    required_traits |= mentions[mention]
                    
        for location in self.locations:
            found_locations.add(get_common_name(location))
            
        for name,  trait in self.traits.items():    
            name =get_common_name(name)
            
            name_to_type[name] = 'Trait'
            trait_to_requirement[name] = set()
            found_traits.add(get_common_name(name))            
            for propensity in trait.propensities:
                if propensity.is_goto:
                    required_locations |= set(propensity.modified_tags)
                    trait_to_requirement[name] |=  set(propensity.modified_tags)
                else:
                    required_tags |= set(propensity.modified_tags)
                    trait_to_requirement[name] |=  set(propensity.modified_tags)
            
        for t in found_traits:
            name_to_type[t] = 'Trait' 
            
        for t in required_traits:
            name_to_type[t] = 'Trait'
            
        for pattern_name,pattern in self.patterns.items():
            pattern_name = get_common_name(pattern_name)
            #print(pattern_name,pattern)
            
            name_to_type[pattern_name] = 'Pattern'
            found_patterns.add(pattern_name)
          
        found_traits = set([self.name_map.get(n,n) for n in found_traits])
        required_traits = set([self.name_map.get(n,n) for n in required_traits])              
         
        l_f_r = found_locations-required_locations
        l_r_f = required_locations-found_locations
        
        t_f_r = found_tags-required_tags
        t_r_f = required_tags-found_tags
        
        tr_f_r= found_traits-required_traits
        tr_r_f= (required_traits-found_traits)-found_roles
        
        p_f_r= found_patterns-required_patterns
        p_r_f= required_patterns-found_patterns
        
        all_kinds = [('Locations: Not referenced in actions or traits', l_f_r),
                     ('Locations: Referenced but not found', l_r_f),
                     ('Tags: Not referenced in traits', t_f_r),
                     ('Tags: Referenced in traits but not found in actions', t_r_f),
                     ('Traits: Not referenced in actions', tr_f_r),
                     ('Traits: Referenced in actions but not found', tr_r_f),
                     ('Patterns: Not referenced in actions or traits', p_f_r),
                     ('Patterns: Referenced but not found', p_r_f)]
        found_problems = False
        for _, s in all_kinds:
            if len(s) > 0:
                found_problems = True
                break
        if found_problems:
            print('*************************POTENTIAL PROBLEMS*************************')
            for label, problems in all_kinds:
                if len(problems) > 0:
                    print(label)
                    print('\t'+'\n\t'.join(problems))
                
        component_to_whole = {}
        
        print('*************************Reference Section*************************')
        for mapping in [action_to_requirement, action_to_found, trait_to_requirement]:
            for name, subs in mapping.items():      
                name = get_common_name(name)
                for n in subs:
                    n = self.name_map.get(n,n)
                    if n not in component_to_whole:
                        component_to_whole[n] = set()
                    component_to_whole[n].add(name)
                    
        for component, whole in component_to_whole.items():
           
            name_to_type[component] = name_to_type.get(component,'Tag')
             
                
        for role_name, role in self.roles.items():
            role_name = get_common_name(role_name)
            name_to_type[role_name] = 'Role'
            
        type_to_name = {}
        for name, type_ in name_to_type.items():
            if type_ not in type_to_name:
                type_to_name[type_] = set()
            type_to_name[type_].add(get_common_name(name))
        
        for type_, names in sorted(type_to_name.items()):
            print(type_+'s')
            for n in names:
                print('\t'+n)
                if n in component_to_whole:
                    print('\t\t referenced in:',', '.join(component_to_whole[n]))
        
        print('Requirements:')
        for mapping in [action_to_requirement, trait_to_requirement]:
            for name, subs in mapping.items():
                print(name)
                if len(subs) > 0:
                    print('\tReferences:' ,', '.join(subs))
            
        
        #print(component_to_whole)
            
    def aspify_name(self,name):
        return name.replace(' ','_').replace("'",'_').lower()
        
    def make_population(self,initialization):
        
        population = initialization.run_initialization()
        
        self.population = {}
        self.created_locations = {}
        for thing in population:
            if thing['type'] == 'character':
                name = KismetInitialization.get_name(thing)
                asp_name = self.aspify_name(name)
                status = thing.get('status',{})
                status = {name:None if val is None else val(None,None,None,self) for name,val in status.items()}
                
                person = {'name':name,'asp_name':asp_name}
                self.population[asp_name] = person
                relation_pairs = {(r[0], self.aspify_name(r[1])):None for r in thing.get('relationships',{}) if len(r) == 2}
                relation_triples = {(r[0], self.aspify_name(r[1])):r[2](None,None,None) for r in thing.get('relationships',{}) if len(r) == 3}
                person['traits'] = set( [trait.alternative_names[0] for trait in thing['traits']])
                for trait in self.default_traits:
                    person['traits'].add(trait.alternative_names[0])
                person['status'] = {**status, 
                                    **relation_pairs,
                                    **relation_triples,
                                    **{('age',):thing['age'][0]}}
            elif thing['type'] == 'location':
                location_type = thing['location_type'][0]
                
                name = thing.get('name',[location_type])[0]
                asp_name = self.aspify_name(name)
                uniq_name =get_unique_name(location_type)
                self.created_locations[asp_name] = {'name':name,
                                                    'location_type':location_type,
                                                    'relationships':thing.get('relationships',[])}
            else:
                print(f'Unknown Object Type {thing["type"]} for {thing}')
        for name in self.population:
            person = self.population[name]
            for status in self.numerical_status:
                status_args = 0
                for arg_type in ['<','^']:
                    if 'DEFAULT' not in status.arguments.get(arg_type,'DEFAULT'):
                        status_args += 1
                for args in itertools.product(self.population.keys(), repeat=status_args):
                    key = tuple([status.alternative_names[0]]+list(args))
                    if key not in person['status']:
                        person['status'][key] = 0
        
                        
    def population2asp(self):
        important_times = set()
        with open(os.path.join(self.path,f'{self.module_file}_population.lp'),'w') as population:
            for name in self.population:
                character = self.population[name]
                population.write(f'person({name}).\n')
                for trait in character['traits']:
                    population.write(f'is({name},{trait}).\n')
                population.write('\n')
                
                for combo in character['status']:
                    val = character["status"][combo]
                    if type(val) is str:
                        if 'time' in val:
                            times = val.split('(')[1].split(')')[0].split(',')
                            times = [('',int(t)) if t.isnumeric() else ('',t) for t in times]

                            _, category_deltas =  self.time.delta(times,self.current_time)
                            time = [str(t[1]) for t in times]
                            for label, delta in category_deltas:
                                time_since = f'time_since(time({",".join(time)}), {label}, {delta}).'
                                population.write(f'{time_since}\n')
                            
                    combo = tuple([c for c in combo])
                    if val is not None:
                        population.write(f'is({name},{",".join(combo)},{val}).\n')
                    else:
                        population.write(f'is({name},{",".join(combo)}).\n')
            population.write('\n')
            for name in self.created_locations:
                population.write(f'location({name}).\n')
                population.write(f'is({name},{self.created_locations[name]["location_type"]}).\n')
                for relationship in self.created_locations[name]['relationships']:
                    role, char_name = relationship
                    char_name = self.aspify_name(char_name)
                    population.write(f'cast({name},{role},{char_name}).\n')
                population.write('\n')
    def compute_actions(self,volitions):
        volitions_by_actor = {}
        for volition in volitions[0]['likelihood']:
            logit,action,actor = parse_likelihood(volition)
            if actor not in volitions_by_actor:
                volitions_by_actor[actor] = [[],[]]
            volitions_by_actor[actor][0].append(logit)
            volitions_by_actor[actor][1].append(action)
        chosen_actions = []
        for actor in volitions_by_actor:
            logits = np.array(volitions_by_actor[actor][0])
            logits = np.exp(logits/self.temperature)
            probs = logits/np.sum(logits)
            chosen_actions.append(volitions_by_actor[actor][1][np.argmax(np.random.multinomial(1,probs))])
            
        return chosen_actions
    def actions2asp(self,actions):
        action_str = ''
        with open(os.path.join(self.path,f'{self.module_file}_actions.lp'),'w') as action_file:
            for action in actions:
                action_str += f'occurred(action({",".join(action)})).\n'
                action_file.write(f'occurred(action({",".join(action)})).\n')
    def calculate_events(self):
        events = solve([os.path.join(self.path,t) for t in ['default.lp', f'{self.module_file}_event_rules.lp', f'{self.module_file}_population.lp', f'{self.module_file}_population_locations.lp','volition.lp',f'{self.module_file}_history.lp']]+['-t','8'],clingo_exe=self.clingo_exe)
        
        events = [[parse_predicate(pred) for pred in event[0]['terms']] for event in  events[0]['to_occur']]
        self.event_history.append(events)
        
        with open(os.path.join(self.path,f'{self.module_file}_occurred_events.lp'),'w') as event_file:
            
            for event in events:
                event_file.write(f'occurred(to_occur({",".join(event)})).\n')
        
        updates = solve([os.path.join(self.path,t) for t in ['default.lp', f'{self.module_file}_event_rules.lp', f'{self.module_file}_population.lp',f'{self.module_file}_occurred_events.lp', f'{self.module_file}_population_locations.lp','volition.lp',f'{self.module_file}_history.lp','results_processing.lp']]+['-t','8'],clingo_exe=self.clingo_exe)[0]
        for result in updates['add']:

            result = [term['predicate'] for term in  result[0]['terms']]
            character = self.population[result[0]]
            result_key = tuple(result[1:])
            character['status'][result_key] = None

        for result in updates['del']:
            result = [term['predicate'] for term in  result[0]['terms']]            
            character = self.population[result[0]]
            result_key = tuple(result[1:])
            if result_key in character['status']:
                del character['status'][result_key]

        for result in updates['update']:
            raw_result = result
            result = [term['predicate'] for term in  result[0]['terms']]
            character = self.population[result[0]]
            result_key = tuple(result[1:-1])
            #If it isn't a number, treat it as an ASP predicate
            if result[-1][0] in 'abcdefghijklmnopqrstuvwxyz_':
                val = self.json2asp(raw_result[0]['terms'][-1])
            else:
                val = int(result[-1])
            character['status'][result_key] = val
            
        for result in updates['update_date']:
            raw_result = result
            result = [term['predicate'] for term in  result[0]['terms']]
            character = self.population[result[0]]
            result_key = (result[1],)
            time_variable = result[2]
            direction = result[3]
            amount = int(result[4])
            
            original_time = character['status'][result_key]
            original_time = original_time.split('(')[1].split(')')[0].split(',')
            original_time = [TimeLoop.sanitize(o) for o in original_time]
            direction = '+' if direction == 'plus' else '-'
            new_time = self.time.offset_other(original_time,direction,{time_variable:amount})
            new_time = f'time({",".join([str(t[1]) for t in new_time])})'
              
            character['status'][result_key] = new_time
            
    def calculate_volitions(self):        
        #print(' '.join([os.path.join(self.path,t) for t in ['default.lp', f'{self.module_file}_rules.lp', f'{self.module_file}_population.lp', 'testing.lp','volition.lp',f'{self.module_file}_history.lp']]))
        
        volitions = solve([os.path.join(self.path,t) for t in ['default.lp', f'{self.module_file}_rules.lp', f'{self.module_file}_population.lp', f'{self.module_file}_population_locations.lp','volition.lp',f'{self.module_file}_history.lp']]+['-t','8'],clingo_exe=self.clingo_exe)
        
        #Only select one of a given Actor, Action Type pair -- this is to stop combinatorics from dominating the likelihood
        volitions_by_actor = {}
        for volition in volitions[0]['likelihood']:
            logit,action,actor = parse_likelihood(volition)
            action_key = tuple(action[:2])
            if action_key not in volitions_by_actor:
                volitions_by_actor[action_key] = []
            volitions_by_actor[action_key].append(volition)
            
        possible_actions = []
        for action_key in volitions_by_actor:
            possible_actions.append(random.choice(volitions_by_actor[action_key]))
        
        return [{'likelihood':possible_actions}]
    def calculate_action_results(self):
        action_results = solve([os.path.join(self.path,t) for t in ['default.lp', f'{self.module_file}_rules.lp', f'{self.module_file}_population.lp', f'{self.module_file}_actions.lp',f'{self.module_file}_population_locations.lp',f'{self.module_file}_history.lp','results_processing.lp']]+['-t','8'],clingo_exe=self.clingo_exe)
       
        return action_results
    
    def calculate_observability(self):
        visibility_results = solve([os.path.join(self.path,t) for t in ['default.lp', f'{self.module_file}_rules.lp', f'{self.module_file}_population.lp', f'{self.module_file}_actions.lp',f'{self.module_file}_population_locations.lp','observation.lp']]+['-t','8'],clingo_exe=self.clingo_exe)
        return visibility_results
    
    def knowledge2asp(self):        
        with open(os.path.join(self.path,f'{self.module_file}_history.lp'),'w') as history_file:
            history_file.write(f'now(time({",".join([str(t[1]) for t in self.current_time])})).\n')
           
            for time in self.times:
                _, category_deltas =  self.time.delta(time,self.current_time)
                time = [str(t[1]) for t in time]
                for label, delta in category_deltas:
                    time_since = f'time_since(time({",".join(time)}), {label}, {delta}).'
                    history_file.write(f'{time_since}\n')
            for time, phase in zip(self.times[-self.history_cutoff:],self.history[-self.history_cutoff:]):
                
                    
                _, category_deltas =  self.time.delta(time,self.current_time)
                time = [str(t[1]) for t in time]
                for step in phase:
                    for action in step:
                        action = action + [f'time({",".join(time)})']
                        history_file.write(f'did({action[1]},action({",".join(action)})).\n')
                        history_file.write(f'received({action[2]},action({",".join(action)})).\n')
    
            for time, step in zip(self.times,self.character_knowledge[-self.history_cutoff:]):
                for knowledge in step:
                    kind = knowledge[0]
                    character = knowledge[1]
                    action = ",".join(knowledge[-1])
                    history_file.write(f'{kind}({character},action({action})).\n')
                    
    def pretty_print_random_text(self, object_type, text_object):
        name = self.name2uniq[text_object[0]][0]
        if object_type == 'action':
            random_text = self.actions[name].text
            arguments = self.actions[name].arguments
        else:
            random_text = self.patterns[name].text   
            arguments = self.patterns[name].arguments
        for ii, (e_type, character) in enumerate(arguments):
            replacement_name = ''
            e_index = '_><^*@'.index(e_type)
            if object_type == 'action':
                ii = e_index
            else:
                ii = ii+1
            if e_index <= 3:
                replacement_name = self.population[text_object[ii]]['name']
            else:
                replacement_name = text_object[ii]

            random_text = random_text.replace(character, replacement_name)
        rules = random_text_to_tracery(random_text)
        rules = {**rules, **self.tracery_grammar}
        grammar = tracery.Grammar(rules)
        return grammar.flatten('#0#')
        
    def pretty_print_history(self,start = 0, end = float('inf')):
        history_text = []
        if end == float('inf'):
            end = len(self.history)
            
        for ind, (time, phase) in enumerate(zip(self.times[start:end],self.history[start:end])):
            action_by_location = {}
            print(time)
            for step in phase:
                for action in step:
                    location = self.location_history[start+ind][action[1]]
                    if location not in action_by_location:
                        action_by_location[location] = []
                    
                    action_by_location[location].append(self.pretty_print_random_text('action',action))
            for location in sorted(action_by_location):
                print(f'At {self.created_locations.get(location,{"name":"their own mind"})["name"]}:')
                print('\t'+'\n\t'.join(action_by_location[location]))
            print('-------')
    
    def display_traits(self,person_filter=None,ignore_default_traits=True):
        if person_filter is None:
            person_filter =  self.population
            default_traits = set([trait for trait in self.traits if self.traits[trait].is_default])
        for person in person_filter:
            if person not in self.population:
                print(f'Could not find person with id="{person}"')
            else:
                print(self.population[person]['name'] + ':\n\t' + '\n\t'.join([trait_name for trait_name in self.population[person]['traits'] if not ignore_default_traits or trait_name not in default_traits]))
    def to_pretty_name(self,iterable):
        return [self.population.get(thing,self.created_locations.get(thing,{'name':thing}))['name'] for thing in iterable]
        
    def print_status(self,status):
        if status is None:
            return ''
        else:
            return ' : ' + str(status)
        
    def display_statuses(self,person_filter=None):
        if person_filter is None:
            person_filter =  self.population
            default_traits = set([trait for trait in self.traits if self.traits[trait].is_default])
        for person in person_filter:
            if person not in self.population:
                print(f'Could not find person with id="{person}"')
            else:
                print(self.population[person]['name'] + ':\n\t' + \
                      '\n\t'.join(' '.join(self.to_pretty_name(trait_name)) + self.print_status(self.population[person]['status'][trait_name])  for trait_name in self.population[person]['status']) + '\n\t' + \
                      '\n\t'.join([trait_name for trait_name in self.population[person]['traits']]))
    
    
    def from_json_file(self,json_file):
        with open(json_file) as in_file:
            kismet_module = json.load(in_file)
        self.from_json(kismet_module)
        
    def from_json(self,kismet_module):
        characters = kismet_module['characters']
        relations = kismet_module['relations']
        locations = kismet_module['locations']
        history = kismet_module['history']
        location_history = kismet_module['location_history']
        
        self.population = {}
        for character in characters:
            name = character['name']
            asp_name = self.aspify_name(name)
            statuses = {}
            for status in character['statuses']:
                if len(status[-1]) == 0:
                    statuses[tuple(status[:-1])] = None
                else:
                    statuses[tuple(status[:-1])] = status[-1][0]
                    
            character_dictionary = {'name':name,
                                    'asp_name':asp_name,
                                    'traits':set(character['traits']),
                                    'status':statuses}
            self.population[asp_name] = character_dictionary
            
        for relation_type, all_relations in relations.items():
            for relation in all_relations:
                source_asp = self.aspify_name(relation[0])
                target_asp = self.aspify_name(relation[1])
                val = None
                if len(relation) > 2:
                    val = relation[-1]
                self.population[source_asp][(relation_type,target_asp)] = val
        
        self.created_locations = {}
        for location in locations:
            asp_name = self.aspify_name(location['name'])
            self.created_locations[asp_name] = location
        
        self.history = [ [[[self.aspify_name(binding) for binding in action] + ['null']*(5-len(action)) for action in step]] for step in history]
        self.times = kismet_module['times']
        self.location_history = []
        
        for step in location_history:
            locations_at_step = {}
            for location in step:
                asp_location = self.aspify_name(location)
                for person in step[location]:
                    locations_at_step[self.aspify_name(person)] = asp_location
            self.location_history.append(locations_at_step)
            
        self.knowledge2asp()
        self.population2asp()
            
    def to_json(self,person_filter=None):         
        if person_filter is None:
            person_filter =  self.population
            default_traits = set([trait for trait in self.traits if self.traits[trait].is_default])
        relations = {}
        characters = {}
        
        history = []
        for ur_step in self.history:
            actions = []
            for step in ur_step:
                for action in step:
                    action_name = action[0]
                    action_arguments = self.to_pretty_name([thing for thing in action[1:] if thing != 'null'])
                    actions.append([action_name] + action_arguments)
        
            history.append(actions)
        location_history = []
        for step in self.location_history:
            location_characters = {}
            for person,location in step.items():
                person,location = self.to_pretty_name([person,location])
                if location not in location_characters:
                    location_characters[location] = []
                location_characters[location].append(person)
            location_history.append(location_characters)
        
        default_traits = set([trait for trait in self.traits if self.traits[trait].is_default])
        locations = list(self.created_locations.values())
        for person in person_filter:
            if person not in self.population:
                print(f'Could not find person with id="{person}"')
            else:
                source = self.population[person]['name']
                
                characters[source] = {'name':source,
                                      'traits':[],
                                      'statuses':[]}
                for trait in self.population[person]['traits']:
                    if trait not in default_traits:
                        characters[source]['traits'].append(get_common_name(trait))
                for relation in self.population[person]['status']:
                    if len(relation) == 1:
                        relation_name  = get_common_name(relation[0])
                        if self.population[person]['status'][relation] is not None:
                            val = self.population[person]['status'][relation]
                            #print('Adding status', [relation_name,val])
                            characters[source]['statuses'].append([relation_name,[val]])
                        else:
                            #print('Adding status', [relation_name])
                            characters[source]['statuses'].append([relation_name,[]])
                            
                    elif len(relation) > 1:
                        source = self.population[person]['name']
                        target = self.to_pretty_name([relation[1]])[0]
                        relation_name = get_common_name(relation[0])
                        
                        if relation_name not in relations:
                            relations[relation_name] = []
                        if self.population[person]['status'][relation] is not None:
                
                            val = self.population[person]['status'][relation]
                            relations[relation_name].append([source,target,val])
                        else:
                            relations[relation_name].append([source,target])
        return {'characters':list(characters.values()),'relations':relations,
                'locations':locations,'history':history,'location_history':location_history,'times':self.times}
                            
    def display_patterns(self,pattern_filter=None,person_filter=None):
        if pattern_filter is None:
            pattern_filter = list(self.patterns)
        lengths =set()    
        
        pattern_filter_text = []
        for pattern in pattern_filter:
            lengths.add(len(self.patterns[pattern].arguments)+1)
            args = [f'ARG{ID}' for ID in range(len(self.patterns[pattern].arguments))]
            pattern_filter_text.append(f'display_pattern({",".join([get_common_name(pattern)] + args)}) :- pattern({",".join([get_common_name(pattern)] + args)}).')
        for length in sorted(lengths):
            pattern_filter_text.append(f'#show display_pattern\\{length}.')
        with open(os.path.join(self.path,'pattern_filter.lp'),'w') as outfile:
            outfile.write('\n'.join(pattern_filter_text))
        patterns = solve([os.path.join(self.path,t) for t in 
                          ['default.lp', f'{self.module_file}_rules.lp', f'{self.module_file}_population.lp',f'{self.module_file}_history.lp','pattern_filter.lp']] + ['-t','8'],clingo_exe=self.clingo_exe)
        if person_filter:
            person_filter = set(person_filter)
        for pattern in patterns[0]['display_pattern']:
            
            pattern = pattern[0]
            pattern = [pred['predicate'] for pred in pattern['terms']]
            if person_filter:
                can_display = False
            else:
                can_display = True
                
            for arg in pattern:
                if can_display:
                    break
                if person_filter and arg in person_filter:
                    can_display = True
            if can_display:
                print(self.pretty_print_random_text("pattern",pattern))
                
    def patterns_to_json(self,pattern_filter=None,person_filter=None):
        if pattern_filter is None:
            pattern_filter = list(self.patterns)
        lengths =set()    
        
        pattern_filter_text = []
        for pattern in pattern_filter:
            lengths.add(len(self.patterns[pattern].arguments)+1)
            args = [f'ARG{ID}' for ID in range(len(self.patterns[pattern].arguments))]
            pattern_filter_text.append(f'display_pattern({pattern},{",".join(args)}) :- pattern({pattern},{",".join(args)}).')
        for length in sorted(lengths):
            pattern_filter_text.append(f'#show display_pattern\\{length}.')
        with open(os.path.join(self.path,'pattern_filter.lp'),'w') as outfile:
            outfile.write('\n'.join(pattern_filter_text))
        patterns = solve([os.path.join(self.path,t) for t in 
                          ['default.lp', f'{self.module_file}_rules.lp', f'{self.module_file}_population.lp',f'{self.module_file}_history.lp','pattern_filter.lp']] + ['-t','8'],clingo_exe=self.clingo_exe)
        if person_filter:
            person_filter = set(person_filter)
            
        found_patterns = {}
        for pattern in patterns[0]['display_pattern']:
            
            pattern = pattern[0]
            pattern = [pred['predicate'] for pred in pattern['terms']]
            if person_filter:
                can_display = False
            else:
                can_display = True
                
            for arg in pattern:
                if can_display:
                    break
                if person_filter and arg in person_filter:
                    can_display = True
            if can_display:
                pattern_name = get_common_name(pattern[0])
                if pattern_name not in found_patterns:
                    found_patterns[pattern_name] = {'arguments':[var[1] for var in self.patterns[pattern_name].arguments],
                                                    'reified':[]}
                renamed_args = []
                for argument, reified_arg in zip(self.patterns[pattern_name].arguments, pattern[1:]):
                    e_type = argument[0]
                    e_index = '_><^*@'.index(e_type)
                      
                    if e_index <= 3:
                        reified_arg = self.population[reified_arg]['name']
                    renamed_args.append(reified_arg)                        
                    
                found_patterns[pattern_name]['reified'].append(renamed_args)
        return found_patterns
    
    
    def determine_character_locations(self):
        shuffled = [name for name in self.population]
        random.shuffle(shuffled)
        
        locations = [location for location in  self.created_locations]
        random.shuffle(locations)
        
        available_slots = {}
        
        location_assignments = {}
        for location in locations:
            location_type = self.created_locations[location]['location_type']            
           
            uniq = get_unique_name(location_type)
            
            supported_roles = self.locations[uniq].supports
            
            role_slots = {}
            for role in supported_roles:
                role_slots[role] = supported_roles[role]()
                
            for relationship in self.created_locations[location]['relationships']:
                role, name = relationship
                asp_name = self.aspify_name(name)
                if asp_name not in location_assignments:
                    location_assignments[asp_name] = {}
                if location not in location_assignments[asp_name]:
                    location_assignments[asp_name][location] = []
                location_assignments[asp_name][location].append(role)
                role_slots[role] -= 1
                
            each_turn = self.locations[uniq].each_turn
            
            for role in each_turn:
                available_slots[(location,role)] = role_slots[role]
                
        #print('LOCATION VOLITION', ' '.join([os.path.join(self.path,t) for t in ['default.lp', f'{self.module_file}_rules.lp', f'{self.module_file}_population.lp','location_volition.lp']]))       
        goto_volitions = solve([os.path.join(self.path,t) for t in ['default.lp', f'{self.module_file}_rules.lp', f'{self.module_file}_population.lp','location_volition.lp']]+['-t','8'],clingo_exe=self.clingo_exe)
                
        volitions_by_actor = {}
        for volition in goto_volitions[0]['go_to']:
            volition = volition[0]['terms']
            name = volition[0]['predicate']
            location = volition[1]['predicate']
            value = volition[2]['predicate']
            if name not in volitions_by_actor:
                volitions_by_actor[name] = []
            volitions_by_actor[name].append((value,location))
        
        chosen_locations = []    
        for actor in shuffled:
            available_locations = {slot[0] for slot in available_slots if available_slots[slot] > 0}
            available_locations |= {location for location in location_assignments.get(actor,[])}
                
            volitions_by_actor[actor] = [(logit,location) for logit, location in volitions_by_actor[actor] if location in available_locations]
            
            if len(volitions_by_actor[actor]) == 0:
                chosen_locations.append((actor, (actor,'by_themself')))
            else :   
                logits = np.array([float(logit) for logit,_ in volitions_by_actor[actor]])
                logits = np.exp(logits/self.temperature)
                probs = logits/np.sum(logits)
                chosen_location = volitions_by_actor[actor][np.argmax(np.random.multinomial(1,probs))][1]
                possible_roles = [(location,role) for location,role in available_slots if location == chosen_location and available_slots[(location,role)] > 0]
                for location in location_assignments.get(actor,[]):                    
                    possible_roles += [(location,role) for role in location_assignments[actor][location]]
                    
                chosen_role = random.choice(possible_roles)
                if chosen_role in available_slots:
                    available_slots[chosen_role] -= 1
                chosen_locations.append((actor, chosen_role))
                
           
        with open(os.path.join(self.path,f'{self.module_file}_population_locations.lp'),'w') as location_file:
            for actor, (location, role) in chosen_locations:
                if actor not in location_assignments or location not in location_assignments[actor]:
                    location_file.write(f'cast({location},{role},{actor}).\n')
                location_file.write(f'at({actor},{location}).\n\n')
            location_file.write('is(Actor,Role,RoleLocation) :- cast(RoleLocation, Role, Actor).\n')
        self.location_history.append({actor:location for actor, (location, role) in chosen_locations})
        
    def json2asp(self,json):
        predicate = json['predicate']
        if 'terms' in json:
            return f'{predicate}({", ".join([self.json2asp(term) for term in json["terms"]])})'
        else:
            return predicate
        
    def step_actions(self):
        self.timestep += 1
        self.tempstep += 1
        self.current_time = self.time()
        print(self.current_time)
        simple_time = [str(t[1]) for t in self.current_time]
        asp_time = f'time({",".join(simple_time)})' 
        self.history.append([])
        self.times.append(self.current_time)
        
        self.knowledge2asp()
        self.population2asp()
        self.determine_character_locations()
        
        character_action_budget = {name:self.action_budget for name in self.population}
        
        self.calculate_events()
        
        while len(character_action_budget) > 0:
            self.knowledge2asp()
            self.population2asp()
            
            volitions = self.calculate_volitions()
            
            chosen_actions = self.compute_actions(volitions)
            _chosen_actions = []
            for action in chosen_actions:
                name = self.name2uniq[action[0]][0]
                
                initiator = action[1]
                if initiator not in character_action_budget:
                    continue
                cost = self.actions[name].cost
                character_action_budget[initiator] -= cost
                if character_action_budget[initiator] <= 0:
                    del character_action_budget[initiator]
                _chosen_actions.append(action)
            if len(_chosen_actions) == 0:
                break
            chosen_actions = _chosen_actions
            self.history[-1].append(chosen_actions)

            self.actions2asp(chosen_actions)
            action_results = self.calculate_action_results()[0]
            
            for result in action_results['add']:
                
                result = [term['predicate'] for term in  result[0]['terms']]
                character = self.population[result[0]]
                result_key = tuple(result[1:])
                character['status'][result_key] = None

            for result in action_results['del']:
                result = [term['predicate'] for term in  result[0]['terms']]            
                character = self.population[result[0]]
                result_key = tuple(result[1:])
                if result_key in character['status']:
                    del character['status'][result_key]
            
            for result in action_results['update']:
                raw_result = result
                result = [term['predicate'] for term in  result[0]['terms']]
                character = self.population[result[0]]
                result_key = tuple(result[1:-1])
                #If it isn't a number, treat it as an ASP predicate
                if result[-1][0] in 'abcdefghijklmnopqrstuvwxyz_':
                    val = self.json2asp(raw_result[0]['terms'][-1])
                else:
                    val = int(result[-1])
                character['status'][result_key] = val


            visibility_results = self.calculate_observability()
            self.character_knowledge.append([])
            for observability in visibility_results[0]['observability']:
                terms = [term['predicate'] for term in observability[0]['terms']]

                action = tuple(terms[:5] + [asp_time])
                observer = terms[6]
                location = terms[7]
                observability = int(terms[8])
                probs = np.exp(np.array([observability, self.ignore_logit])/self.observation_temp)
                probs /= np.sum(probs)
                if np.argmax(np.random.multinomial(1,probs)) == 0:
                    self.character_knowledge[-1].append(('saw', observer, location, action))
            