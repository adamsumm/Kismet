
if __name__ == 'KismetSequence' or __name__ == '__main__':
    import kismet_sequenceLexer
    from kismet_sequenceParser import kismet_sequenceParser 
    import Kismet
    from Kismet import KismetModule
    import KismetInitialization
else:    
    from . import kismet_sequenceLexer
    from .kismet_sequenceParser import kismet_sequenceParser
    from . import Kismet
    from .Kismet import KismetModule
    from . import KismetInitialization
    
from antlr4 import *
from antlr4.error.ErrorListener import ErrorListener
import re
from warnings import warn
import itertools
from dataclasses import dataclass, field
import os
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

class kismet_sequenceVisitor(ParseTreeVisitor):
    
    def visitChildren(self,node):
        n = node.getChildCount()
        results = []
        for i in range(n):
            c = node.getChild(i)
            childResult = c.accept(self)
            if childResult:
                results.append(childResult)
        return results
    # Visit a parse tree produced by kismet_sequenceParser#sequence.
    def visitSequence(self, ctx:kismet_sequenceParser.SequenceContext):
        return ('Sequence', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#name.
    def visitName(self, ctx:kismet_sequenceParser.NameContext):
        return ('Name',ctx.getText())


    # Visit a parse tree produced by kismet_sequenceParser#name.
    def visitFilename(self, ctx:kismet_sequenceParser.NameContext):
        return ('File',ctx.getText())


    # Visit a parse tree produced by kismet_sequenceParser#var.
    def visitVar(self, ctx:kismet_sequenceParser.VarContext):
        return ('Var',ctx.getText())

    # Visit a parse tree produced by kismet_sequenceParser#num.
    def visitNum(self, ctx:kismet_sequenceParser.NumContext):
        
        return ('Num',ctx.getText())


    # Visit a parse tree produced by kismet_sequenceParser#pos_num.
    def visitPos_num(self, ctx:kismet_sequenceParser.Pos_numContext):
        
        return ('Num',ctx.getText())


    # Visit a parse tree produced by kismet_sequenceParser#load.
    def visitLoad(self, ctx:kismet_sequenceParser.LoadContext):
        return ('Load',self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#initialize.
    def visitInitialize(self, ctx:kismet_sequenceParser.InitializeContext):
        return ('Initialize', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#characters.
    def visitCharacters(self, ctx:kismet_sequenceParser.CharactersContext):
        return ('Characters',)

    # Visit a parse tree produced by kismet_sequenceParser#statement.
    def visitStatement(self, ctx:kismet_sequenceParser.StatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#while_block.
    def visitWhile_block(self, ctx:kismet_sequenceParser.While_blockContext):
        return ('While', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#while_condition.
    def visitWhile_condition(self, ctx:kismet_sequenceParser.While_conditionContext):
        return ('WhileCondition', self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_sequenceParser#if_block.
    def visitIf_block(self, ctx:kismet_sequenceParser.If_blockContext):
        return ('IfBlock', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#if_statement.
    def visitIf_statement(self, ctx:kismet_sequenceParser.If_statementContext):
        return ('IfStatement',self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_sequenceParser#locations.
    def visitLocations(self, ctx:kismet_sequenceParser.LocationsContext):
        return ('Locations',)


    # Visit a parse tree produced by kismet_sequenceParser#keeping.
    def visitKeeping(self, ctx:kismet_sequenceParser.KeepingContext):
        return ('Keeping', self.visitChildren(ctx))



    # Visit a parse tree produced by kismet_sequenceParser#stashing.
    def visitStashing(self, ctx:kismet_sequenceParser.StashingContext):
        return ('Stashing',self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#restoring.
    def visitRestoring(self, ctx:kismet_sequenceParser.RestoringContext):
        return ('Restoring',self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_sequenceParser#add.
    def visitAdd(self, ctx:kismet_sequenceParser.AddContext):
        return ('AddFile',self.visitChildren(ctx))

    def visitTracery_(self, ctx:kismet_sequenceParser.Tracery_Context):
        return ('TRACERY', self.visitChildren(ctx))
    # Visit a parse tree produced by kismet_sequenceParser#remove.
    def visitRemove(self, ctx:kismet_sequenceParser.RemoveContext):
        return ('RemoveFile', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#conditional_statement.
    def visitConditional_statement(self, ctx:kismet_sequenceParser.Conditional_statementContext):
        return ('ConditionalStatement', self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_sequenceParser#where.
    def visitWhere(self, ctx:kismet_sequenceParser.WhereContext):
        return ('Where', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#in_pattern.
    def visitIn_pattern(self, ctx:kismet_sequenceParser.In_patternContext):
        return ('InPattern', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#comparator.
    def visitComparator(self, ctx:kismet_sequenceParser.ComparatorContext):
        return ('Comparator',ctx.getText(),self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#types.
    def visitTypes(self, ctx:kismet_sequenceParser.TypesContext):
        return ('Types',)


    # Visit a parse tree produced by kismet_sequenceParser#tags.
    def visitTags(self, ctx:kismet_sequenceParser.TagsContext):
        return ('Tags',)


    # Visit a parse tree produced by kismet_sequenceParser#where_clause.
    def visitWhere_clause(self, ctx:kismet_sequenceParser.Where_clauseContext):
        return  ('WhereClause', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#run.
    def visitRun(self, ctx:kismet_sequenceParser.RunContext):
        return  ('Run', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#duration.
    def visitDuration(self, ctx:kismet_sequenceParser.DurationContext):
        return  ('Duration', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#none.
    def visitNone(self, ctx:kismet_sequenceParser.NoneContext):
        return  ('None',)


    # Visit a parse tree produced by kismet_sequenceParser#every.
    def visitEvery(self, ctx:kismet_sequenceParser.EveryContext):
        return  ('Every',)


    # Visit a parse tree produced by kismet_sequenceParser#quantity.
    def visitQuantity(self, ctx:kismet_sequenceParser.QuantityContext):
        return ('Quantity', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#until.
    def visitWith_clause(self, ctx):
        return ('WithClause', self.visitChildren(ctx))

    # Visit a parse tree produced by kismet_sequenceParser#until.
    def visitUntil(self, ctx:kismet_sequenceParser.UntilContext):
        return ('Until', self.visitChildren(ctx))
    
    def visitPlus(self, ctx:kismet_sequenceParser.UntilContext):
        return ('Plus',)



    # Visit a parse tree produced by kismet_sequenceParser#until_clauses.
    def visitUntil_clauses(self, ctx:kismet_sequenceParser.Until_clausesContext):
        return ('UntilClauses', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#positive_find.
    def visitPositive_find(self, ctx:kismet_sequenceParser.Positive_findContext):
        return ('Find', self.visitChildren(ctx))


    # Visit a parse tree produced by kismet_sequenceParser#negative_find.
    def visitNegative_find(self, ctx:kismet_sequenceParser.Negative_findContext):
        return ('NegFind')


    # Visit a parse tree produced by kismet_sequenceParser#until_clause.
    def visitUntil_clause(self, ctx:kismet_sequenceParser.Until_clauseContext):
        return ('UntilClause', self.visitChildren(ctx))
@dataclass
class Keep:
    keep_type: str
    conditions: list
    
    def __call__(self,module,state):
        
        return module, state
    
    def find_kept(self,module,state,already_kept):
        if self.keep_type == 'Characters':
            population_file = os.path.join(module.path,f'{module.module_file}_population.lp')
            keep_file = os.path.join(module.path,f'{module.module_file}_keep.lp')
            with open(keep_file,'w') as keep_asp_file:
                for where in self.conditions:
                    keep_asp_file.write(f'keep(Characters) :- {",".join([clause.logic for clause in where.conditions])}.\n\n')
                for keep in already_kept:
                    keep_asp_file.write(f'kept({keep}).\n')
                keep_asp_file.write('#show keep/1.')
            solution = Kismet.solve([population_file, keep_file, '-t','8'],clingo_exe=module.clingo_exe)[0]['keep']
            asp_names = set([keep[0]['terms'][0]['predicate'] for keep in solution])
            return asp_names
        return kept
    
    @staticmethod
    def parse(datum):
        datum = datum[1:][0]
        keep_type = datum[0][0]
        
        datum = datum[1:]
        conditions = [Where.parse(where,keep_type) for where in datum]
        
        return Keep(keep_type,conditions)
    
@dataclass
class Initialize:
    filename: str
    keeps: list
    def __call__(self,module,state):
        #self.initialization = KismetInitialization.KismetInitialization(initialization_file,self)
        to_keep = set()
        for keep in self.keeps:
            to_keep |= keep.find_kept(module,state,to_keep)
#              kept = []
#             for character in state['characters']:
#                 if module.aspify_name(character['name']) in asp_names:
#                     kept.append(character)
#             return {'characters':kept}
        module.make_population(KismetInitialization.KismetInitialization(self.filename,module))
        
        new_state = module.to_json()
        
        for category in ['characters','locations']:
            for entity in state.get(category,[]):
                if module.aspify_name(entity['name']) in to_keep:
                    new_state[category].append(entity)
                    
        for relation_type in state.get('relations',[]):
            kept_relations = []
            for relation in state['relations'][relation_type]:
                #ONLY KEEP RELATIONS AROUND IF ALL MEMBERS ARE STILL A PART OF THE SIMULATION
                for char in relation:
                    if type(char) is str:
                        if module.aspify_name(char) not in to_keep:
                            bad = True
                            break
                    if bad:
                        break
                if not bad:
                    kept_relations.append(relation)
            new_state[relation_type] = new_state.get(relation_type,[]) + kept_relations
        
        kept_history = []
        for step in state.get('history',[]):
            kept_actions = []
            for action in step:
                good = False
                for char in action:
                    if module.aspify_name(char) in to_keep:
                        good = True
                        break
                if good:
                    kept_actions.append(action)
            if len(kept_actions) > 0:
                kept_history.append(kept_actions)
                
        new_state['history'] =  kept_history + state.get('history',[]) 
        new_state['times'] = state.get('time',[]) 
        module.from_json(new_state)
        
        return module, new_state
    def __str__(self):
        return f'Initializing from {self.filename}'
    
    @staticmethod
    def parse(datum):
        datum = datum[1]
        file = datum[0][1]
        keeps = []
        restores = []
        print('INITIALIZATION', datum[1:])
        if len(datum) > 1:
            for thing in datum[1:]:
                if thing[0] == 'Keeping':
                    keeps.append(Keep.parse(thing))
                elif thing[0] == 'Restoring':
                    restores.append(Restore.parse(keep))                    
                else:
                    print(f'Dont know what to do with: {thing} in Initialization')
        return Initialize(file,keeps)
    
@dataclass
class Sequence:
    actions: list

@dataclass
class Load:
    filenames: list
    tracery_files: list
    def __call__(self,module,state):
        import shutil

#         with open('kismet_conglomeration.kismet','wb') as wfd:
#             for f in filenames:
#                 with open(f,'rb') as fd:
#                     shutil.copyfileobj(fd, wfd)
                    
        module =  KismetModule(self.filenames,
                            self.tracery_files, 
                                    ignore_logit=3.0, 
                                    observation_temp=1.5,
                                    history_cutoff=10,
                                    action_budget = 3,
                                    default_cost = 3,)
        module.from_json(state)
        return module, state
    
    @staticmethod
    def parse(datum):
        kismet_files = []
        tracery_files = []
        to_fill = kismet_files
        for d in datum[1]:
            if d[0] == 'TRACERY':
                to_fill = tracery_files
            else:
                to_fill.append(d[1])
        return Load(kismet_files, tracery_files)
    
    def __str__(self):
        return f'Loading {self.filenames} with Tracery Files {self.tracery_files}'
    
@dataclass
class WhereClause:
    logic: str
    
    @staticmethod
    def parse(datum,keep_type,counter):
        print("WHERECLAUSE", datum)
        datum = datum[1][0]
        logic = ''
        
        if datum[0] == 'InPattern' and len(datum[1]) == 2:
            pattern_name = datum[1][0][1]
            pattern_count = int(datum[1][1][1])
            combos = [f'pattern({pattern_name},{",".join(p)})' for p in set(itertools.permutations(['_']*(pattern_count-1)+ [keep_type], pattern_count))  ]
            logic = ";".join(combos)
            logic = '1{'+ logic +'}'
        elif datum[0] == 'InPattern' and len(datum[1]) == 3:
       
            pattern_name = datum[1][0][1]
            pattern_count = int(datum[1][1][1])
            
            if len(datum[1][2][1]) != 0:
                other_pattern_name = datum[1][2][1][0][1][0][1]
                other_pattern_count = int(datum[1][2][1][0][1][1][1])
                combos = [f'pattern({other_pattern_name},{",".join(p)})' for p in set(itertools.permutations(['_']*(other_pattern_count-1)+ ['Other'+str(counter)], other_pattern_count))  ]
                other_logic = ";".join(combos)
                other_logic = '1{'+ other_logic +'}'
            else:
                other_logic = 'kept(Other)'
                
            combos = [f'pattern({pattern_name},{",".join(p)})' for p in set(itertools.permutations(['_']*(pattern_count-2)+ [keep_type,'Other'+str(counter)], pattern_count))  ]
            logic = ";".join(combos)
            logic = '1{'+ logic +'}, ' + other_logic
            logic += ', entity('+ 'Other'+str(counter)+ '), entity('+keep_type+')'
            
        elif datum[0] == 'Name' and len(datum) == 2:
            logic = f'is({keep_type},{datum[1]})'
        else:
            print("Unknown Where Clause Configuration")
        return WhereClause(logic)
    
@dataclass
class Where:
    conditions: list
    
    def __call__(self,module,state):        
        return module, state
    
    @staticmethod
    def parse(datum,keep_type):
        datum = datum[1]
        
        
        conditions = [WhereClause.parse(clause,keep_type,i) for i, clause in enumerate(datum)]
       
        return Where(conditions)
    
@dataclass
class Run:
    disjunctive_untils: list
    
    def __call__(self,module,state):  
        
        module.mark_time()
        
        while not self.passes(module,state):
            module.step_actions()
        
        return module, module.to_json()
    
    def passes(self,module,state):
        
        
        for until_clauses in self.disjunctive_untils:
            passes = True
            for clause in until_clauses:
                passes = passes and clause.passes(module)
                #print(f'TESTING {clause}: {passes}')
                if not passes:
                    break
            if passes:
                return True
        return False
    def __str__(self):
        return f'Running...'
    @staticmethod
    def parse(datum):
        datum = datum[1][0]
        disjunctive_untils = []
        duration = (-1, None)
        if datum[0] == 'Until':
            datum = datum[1]
            
            for until_clauses in datum:
                until_clauses = until_clauses[1]
                if until_clauses[0][0] == 'Duration': 
                    until_clause = until_clauses[0]
                    val = int(until_clause[1][0][1])
                    units = until_clause[1][1][1]
                    disjunctive_untils.append([Duration(val,units)])
                else:
                    conjunctions = []
                    disjunctive_untils.append(conjunctions)
                    for until_clause in until_clauses:
                        if until_clause[0] == 'UntilClause':
                            conjunctions.append(UntilClause.parse(until_clause[1]))
        return Run(disjunctive_untils)

@dataclass
class Quantity:
    lowerBound: str
    upperBound: str
    @staticmethod
    def parse(datum):
        lowerBound =''
        upperBound =''
        datum = datum[1]
        if len(datum) == 1:            
            upperBound = lowerBound = datum[0][1]
        elif len(datum) == 2:
            if datum[1][0] == 'Plus':
                lowerBound = datum[0][1]
            else:
                val = datum[1][1]
                comparator = datum[0][1]
                if comparator in ['=','==']:
                    upperBound = lowerBound = val
                elif comparator == '>=':
                    lowerBound = val
                elif comparator == '>':
                    lowerBound = str(int(val)+1)
                elif comparator == '<=':
                    upperBound = val
                elif comparator == '<':
                    upperBound = str(int(val)-1)
                
        return Quantity(lowerBound,upperBound)    
comparators: dict = {'=': lambda x,y: x==y,
                           '==': lambda x,y: x==y,
                           '!=': lambda x,y: x!=y,
                           '<': lambda x,y: x<y,
                           '<=': lambda x,y: x<=y,
                           '>': lambda x,y: x>y,
                           '>=': lambda x,y: x>=y}    
@dataclass
class Duration:
    val: int
    unit: str
    comparator: str = '='
    
    def __str__(self):
        return f'Duration Comparison: {self.unit} {self.comparator} {self.val}'
    def passes(self,module):
        
        if self.unit in ['step','steps']:
            return comparators[self.comparator](module.tempstep,self.val)
        else:
            print(f'Unsure of what to do with time unit "{self.unit}" in {self}')
        return True
@dataclass
class UntilClause:
    logic:str
    aux_pattern:str
        
    def passes(self,module):
        return True
    
    @staticmethod
    def parse(datum):
        type1 = datum[0][0]
        logic = ''
        aux_pattern = ''
        if type1 == 'Quantity':
            quantity = Quantity.parse(datum[0])
            thingType = datum[2][1]
            type2 = datum[2][0]
            datum = datum[1:]
            if type2 == 'InPattern':
                datum = datum[1][1]
                pattern_name = datum[0][1]
                arity = int(datum[1][1])
                logic = f'pattern({pattern_name},{",".join(["_"]*arity)})'
                
            elif type2 in ('Find','NegFind') :
                if type2 == 'Find':
                    pass
                else:
                    pass
                if len(datum) == 3:
                    arity = 1
                else:
                    arity = int(datum[3][1])
                
                name = datum[2][1]
                logic =  f'is({name}, {",".join(["_"]*arity)})'
            else:
                name = datum[1][1] 
                comparator = datum[2][1]
                if len(datum) == 4:
                    compared_val = datum[3][1]
                    arity = 1
                else:
                    compared_val = datum[4][1]
                    arity = int(datum[3][1])
                comparator_names = {'<':'lt' , 
                                    '>':'gt' ,
                                    '<=':'lte',
                                    '>=':'gte' ,
                                    '=':'eq' ,
                                    '==':'eq' ,}   
                comp_name = comparator_names[comparator]
                params = [f'Arg{i}' for i in range(arity)]
                logic =  f'is({name}, {",".join(params)}, V)'
                aux_name = f'{name}_{comp_name}_{compared_val}'
                aux_pattern = f'{aux_name}({",".join(params)}) :- {logic}, V {comparator} {compared_val}'
                logic = f'{aux_name}({",".join(params)})'
                
            
            logic = f'{quantity.lowerBound} {{{logic}}} {quantity.upperBound}'
        elif type1 == 'Name':
            return Duration(int(datum[-1][1]), datum[0][1], datum[1][1])
        else:
            
            print('UH OH UntilClause doesnt know how to handle', datum)
        return UntilClause(logic,aux_pattern)
    
def parse_statement(statement):
    statement_type = statement[0]
    if statement_type == 'Load':
        return (Load.parse(statement))
    elif statement_type == 'Initialize':
        return (Initialize.parse(statement))
    elif statement_type == 'Run':
        return (Run.parse(statement))
    elif statement_type == 'While':
        return (WhileLoop.parse(statement))
    elif isinstance(statement_type,tuple):
        return parse_statement(statement_type)
    else:
        print(f'DONT KNOW WHAT TO DO WITH "{statement_type}":\n\t',  statement)
    
@dataclass
class WhileLoop:
    condition:list
    actions:list
        
    def __call__(self,module,state):  

        return module, module.to_json()
    
    @staticmethod
    def parse(datum):
        datum = datum[1]
        condition = datum[0][1]
        if len(condition) == 2:
            comparator = condition[0][1]
            if comparator not in ['<','<=']:
                raise Exception(f'ERROR: Only "<" and "<=" are valid in while loops at this time!')
            val = int(condition[1][1])
        condition = (comparator, val)
        
        actions = []
        statements = datum[1:]
        for statement in statements[1]:
            print('WHILE LOOP STATEMENT', statement)
            actions.append(parse_statement(statement))
        return WhileLoop(condition,actions)
    
    

class KismetSequence():
    def __init__(self,sequence_file):
        self.sequence_file = sequence_file
        input_stream = FileStream(sequence_file)
        lexer = kismet_sequenceLexer.kismet_sequenceLexer(input_stream)
        stream = CommonTokenStream(lexer)
        parser = kismet_sequenceParser(stream)
        error_listener = MyErrorListener()
        parser._listeners = [ error_listener ]
        tree = parser.sequence()
        vis = kismet_sequenceVisitor()
        sequence = vis.visit(tree)

        if len(error_listener.errors) > 0:
            errors = [re.sub(r"^(\d+):",r"On Line #\1\n",error) for error in error_listener.errors]
            warn(f'Errors found in {sequence_file}')
            warn('\n\n'+'\n\n'.join(errors))
            raise Exception(f'Errors found in {sequence_file}')
        
        self.actions = []
        for statement in sequence[1]:
            print('SEQUENCE STATEMENT', statement)
            self.actions.append(parse_statement(statement))
    
    def __call__(self):
        print(f'Running Kismet Sequence from "{self.sequence_file}"')
        active_module = None
        state = {'characters':[],
                 'relations':{},
                 'locations':[],
                 'history':[],
                 'location_history':[],
                 'times':[]}
        
        for action in self.actions:
            
            print(f'Starting New Step: {action}')
            active_module, state = action(active_module,state)
        self.active_module = active_module
        self.state = state