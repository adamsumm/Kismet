#!/usr/bin/env python
# coding: utf-8

# In[1]:


from antlr4.error.ErrorListener import ErrorListener

error_log = []
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


# In[2]:

import os
os.system('../kismet/run_antlr kismet.ebnv')


# In[3]:


from antlr4 import *
import kismetLexer
import kismetParser

filename = './test.kismet'
input_stream = FileStream(filename)
lexer = kismetLexer.kismetLexer(input_stream)
stream = CommonTokenStream(lexer)
parser = kismetParser.kismetParser(stream)
error_listener = MyErrorListener()
parser._listeners = [ error_listener ]
###Run through the thing
tree = parser.world()
if len(error_listener.errors) > 0:
    print('\n\n'.join(error_listener.errors))
    print(error_listener.recognizer)
    exit()

# In[4]:


from kismetParser import kismetParser


# In[5]:



class kismetVisitor(ParseTreeVisitor):
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


    # Visit a parse tree produced by kismetParser#add.
    def visitAdd(self, ctx:kismetParser.AddContext):
        
        return ('Results',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#change.
    def visitChange(self, ctx:kismetParser.ChangeContext):
        
        return self.visitChildren(ctx)


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


    # Visit a parse tree produced by kismetParser#initialization.
    def visitInitialization(self, ctx:kismetParser.InitializationContext):
        
        return ('Initialization',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#each_turn.
    def visitEach_turn(self, ctx:kismetParser.Each_turnContext):
        return  ('EachTurn',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#cast.
    def visitCast(self, ctx:kismetParser.CastContext):
        return ('Cast',self.visitChildren(ctx))

    # Visit a parse tree produced by kismetParser#cast.
    def visitFree(self, ctx:kismetParser.CastContext):
        return ('Free',[])

    
    # Visit a parse tree produced by kismetParser#cast.
    def visitResponse(self, ctx):
        return ('Response',[])

    # Visit a parse tree produced by kismetParser#random_text.
    def visitRandom_text(self, ctx:kismetParser.Random_textContext):
        return ('RandomText',ctx.getText())


    # Visit a parse tree produced by kismetParser#l_name.
    def visitL_name(self, ctx:kismetParser.L_nameContext):
        return ('TextualName',self.visitChildren(ctx))


    
    def visitLocWildCard(self,ctx):
        return 'LocWildCard',ctx.getText()

    # Visit a parse tree produced by kismetParser#supports.
    def visitSupports(self, ctx:kismetParser.SupportsContext):
        
        return ('Supports',self.visitChildren(ctx))


    # Visit a parse tree produced by kismetParser#num.
    def visitNum(self, ctx:kismetParser.NumContext):
        
        return ('Num',ctx.getText())


    # Visit a parse tree produced by kismetParser#name.
    def visitName(self, ctx:kismetParser.NameContext):
        
        return ('Name',ctx.getText())


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
vis = kismetVisitor()
world = vis.visit(tree)


# In[7]:


from itertools import *
things = {  
            'Action':{},
            'Location':{},
            'Role':{},
            'Trait':{}}

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

# cond7 == NumCompare2

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
            text = [f'update({char1},{rel},{char2},Y) :- state({char1},{rel},{char2},X), X {operation} {val} = Y, ']
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
            text = [f'{comparisonMapping[conditional_type][inv]}{char1},{rel},{char2}) :- ']
            
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
        
    else:
        print(f'UH OH --- missing "{cond_type}"')
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

def actionToASP(action,action_name):
    text = ''
    constraints = []
    initiator = None
    targets = []
    indirect_objects = []
    actions = []
    characters = []


    characters, constraints, arguments = parseArguments(action)
    allLocations = []
    wildLocations = []
    namedLocations = set()

    free = 'Free' in action
    response = 'Response' in action
    
    
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
        char_text = ', '.join([''.join(c) for c in characters])
        randomText = f'{action_name} {char_text}'

    if 'visibility' in action:
        visibility = action['visibility'][0][1].count('+') - action['visibility'][0][1].count('-')
    else:
        visibility = 0
    extension = parseExtension(action)
    return constraints, tags, characters,results,randomText,visibility,extension,arguments,free,response,False

def roleToASP(role,rolename):
    characters, constraints,arguments = parseArguments(role)

    tags = parseTags(role)

    extension = parseExtension(role, True)
    conditions = []
    extends = []
    if 'Conditions' in role:
        conditions = role['Conditions']
        constraints += parseConditions(conditions)
        
    constraints += [f'at({characters[0][1]},Location)', f'castable({rolename},Location)', f'mode(casting)']
    return characters, constraints, extension, tags,arguments

def propensityToASP(propensity):
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
    
    return is_propensity,is_goto,valence,constraints,modified_tags

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

def traitToASP(trait,traitname):

    
    is_status = trait['TraitType'][0] == 'status'
    is_trait = not is_status
    _, _,arguments =parseArguments(trait)
    if len(trait['Name']) == 1:
        alternative_names =  trait['Name']
    else:
        alternative_names = [name[0] for name in trait['Name']]
    propensities = []
    
    if 'Propensity' in trait:
        propensities = [propensityToASP(prop) for prop in trait['Propensity']]

    propensityASP = []
    arguments = simpleDictify(arguments)
    
    arguments = {arg_type:arguments.get(arg_type,default_args[arg_type]) for arg_type in ['>','<','^','*','@']}
                
    asp_args = ', '.join([arguments.get(arg_type,default_args[arg_type])   for arg_type in ['>','<','^','*','@']])
    
    for is_propensity,is_goto,valence,constraints,modified_tags in propensities:
        for tag in modified_tags:
            if is_goto:
                kind = 'go_to_propensity'
            else:
                kind = 'propensity'

            head = f'{kind}({tag}, {valence}, {traitname},{asp_args} ) '            
            premises = ['binding('+','.join([f'{arg2type[arg_type]}({arguments[arg_type]})' for arg_type in ['>','<','^','*','@']] ) +')']
            premises.append(f'is({arguments[">"]}, {traitname})')
            premises += constraints
            
            #print(  f'{head} :- {premise}.')

            premise = ',\n\t\t'.join(premises)
            propensityASP.append(f'{head} :- \n\t\t{premise}.')
    returns = [(is_trait, is_status, alternative_names, arguments, propensities,propensityASP)]

    if 'Opposes' in trait:
        if type(trait['Opposes'][0][0]) is list:
            trait['Opposes'] = unsqueeze(trait['Opposes'])
        propensityASP = []
        
        if len(trait['Opposes']) == 1:
            alternative_names =  [trait['Opposes'][0][1]]
        else:
            alternative_names = [name[1] for name in trait['Opposes']]
        traitname = alternative_names[0]
        for is_propensity,is_goto,valence,constraints,modified_tags in propensities:
            for tag in modified_tags:
                if is_goto:
                    kind = 'go_to_propensity'
                else:
                    kind = 'propensity'
                

                head = f'{kind}({tag}, {-valence}, {traitname}, {asp_args} ) '

                premises = ['binding('+','.join([f'{arg2type[arg_type]}({arguments[arg_type]})' for arg_type in ['>','<','^','*','@']] ) +')']
                premises.append(f'is({arguments[">"]}, {traitname})')
                premises += constraints

                #print(  f'{head} :- {premise}.')

                premise = ',\n\t\t'.join(premises)
                propensityASP.append(f'{head} :- \n\t\t{premise}.')
        returns.append((is_trait, is_status, alternative_names, arguments, propensities,propensityASP))
    return returns

for thing in world:
    name = ''
    for t in thing[1]:
        if t[0] == 'Name':
            name = t[1]
            break
    things[thing[0]][name] = thing2dict(thing[1])

for thing in things:
    print(thing)

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
                        return x*(x1-x0)+x0
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
                    return np.round(x)
                else:
                    R -= piece[0]/total_area
            return piece[2][0]
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
    for thing in location:
        print(thing, location[thing])

    if 'Supports' not in location:
        error_log.append(f'ERROR: supports missing in location "{location_name}"')
        return None
    if 'TextualName' not in location:
        error_log.append(f'ERROR: name missing in location "{location_name}"')
    if 'Initialization' not in location and 'EachTurn' not in location:
        error_log.append(f'ERROR: No casting details in location "{location_name}"')
        
    location['Supports'] = location['Supports'][0]

    
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
    return tracery_name,supported_roles, initialization,each_turn  
        
actions = {action:actionToASP(things['Action'][action],action) for action in things['Action']}


roles = {role:roleToASP( things['Role'][role],role) for role in things['Role']}
  
traits = {trait:traitToASP(things['Trait'][trait],trait) for trait in things['Trait']}

locations = {location:locationToASP(things['Location'][location],location) for location in things['Location']}


traits_ = {}
alternative_names = {}
for trait in traits:
    for trait_ in traits[trait]:
        names = trait_[2]
        alternative_names[names[0]] = names[1:]
        traits_[names[0]] = trait_

traits = traits_

for name, role in roles.items():
    characters, constraints, extension, tags,arguments = role
    char_text = ', '.join([''.join(c) for c in characters])
    arg_dict = simpleDictify(arguments)
    location = 'Location'
    actions[f'cast_{name}'] = (constraints, tags, characters, [f'add({characters[0][1]},{name},{location}) :- '], f'cast_{name} {char_text}', 0, extension,arguments,False,False,True)


extension_graph = {}
for name in actions:
    
    extension = actions[name][6]
    if extension:
        extension = extension[0]
    extension_graph[name] = extension


actionASP = []
for name in actions:
    
    constraints, tags, characters,results,randomText,visibility,extension,arguments,free,response,is_cast = actions[name]
    ancestors = []

    ancestor = extension_graph[name]
    if ancestor:
        current = name
        while ancestor:
            ancestors.append(ancestor)
            current = ancestor
            ancestor = extension_graph[current]

        extension_arguments = extension[1]
        tags = set(tags)
        prev_arguments = arguments
        mappings = []
        
        for ancestor in ancestors:
            a_constraints, a_tags,_,a_results,_,_,_,a_arguments,_,_,a_is_cast = actions[ancestor]
            mapping = {p:c for p, c in zip(prev_arguments,a_arguments)}
            r_mapping = {c:p for p, c in zip(prev_arguments,a_arguments)}
            mappings.append((mapping,r_mapping))

            converted_constraints = []
            converted_results = []
            if a_constraints:
                for thing in a_constraints:
                    if 'cast' in thing:
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
    
    head = f'action({name}, {asp_args})'
    
    premises = [','.join([f'{arg2type[arg_type]}({arguments[arg_type]})' for arg_type in ['>','<','^','*','@']] )]
    premises += constraints
    premises += [f'different({arguments[">"]},{arguments["<"]})',f'different({arguments[">"]},{arguments["^"]})',f'different({arguments["<"]},{arguments["^"]})']
    
       
    if free:
        premises.append(f'mode(free)')
    if response:
        premises.append(f'mode(response)')
    premise = '\t\t'+',\n\t\t'.join(premises)
        
    actionASP.append(head +':-\n'+ premise + '.')

    at_location = ''
    if is_cast:
        at_location = f'at({arguments[">"]}, Location), '
    for result in results:
        actionASP.append(result + at_location +f'occurred({head}).')

    for tag in tags:
        actionASP.append(f'is({name}, {tag}).')
    actionASP.append(f'visibility({name},{visibility}).')
traitASP = []
for trait in traits:
    traitASP += traits[trait][-1]

    trait_type = 'trait'
    if traits[trait][1]:
        trait_type = 'status'
    traitASP.append(f'{trait_type}({trait}).')
locationASP = []
for location in locations:
    tracery_name,supported_roles, initialization,each_turn  = locations[location]
    for role in supported_roles:
        locationASP.append(f'castable({role},{location}).')

with open('rules.swi', 'w') as asp_file:
    text = '\n\n'.join(locationASP+actionASP+traitASP)
    options = [('(',')'),('( ',')'),('( ',' )'),('(',' )'),
               ('(',','),('( ',','),('( ',' ,'),('(',' ,'),
               (',',','),(', ',','),(', ',' ,'),(',',' ,'),
               (',',')'),(', ',')'),(', ',' )'),(',',' )')]
            
    for name in alternative_names:
        for alt in alternative_names[name]:
            for option in options:
                text = text.replace(f'{option[0]}{alt}{option[1]}',f'{option[0]}{name}{option[1]}')
    asp_file.write(text)
    
