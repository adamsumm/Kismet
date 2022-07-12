# Generated from kismet_sequence.ebnf by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kismet_sequenceParser import kismet_sequenceParser
else:
    from kismet_sequenceParser import kismet_sequenceParser

# This class defines a complete listener for a parse tree produced by kismet_sequenceParser.
class kismet_sequenceListener(ParseTreeListener):

    # Enter a parse tree produced by kismet_sequenceParser#sequence.
    def enterSequence(self, ctx:kismet_sequenceParser.SequenceContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#sequence.
    def exitSequence(self, ctx:kismet_sequenceParser.SequenceContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#statement.
    def enterStatement(self, ctx:kismet_sequenceParser.StatementContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#statement.
    def exitStatement(self, ctx:kismet_sequenceParser.StatementContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#load.
    def enterLoad(self, ctx:kismet_sequenceParser.LoadContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#load.
    def exitLoad(self, ctx:kismet_sequenceParser.LoadContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#tracery_.
    def enterTracery_(self, ctx:kismet_sequenceParser.Tracery_Context):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#tracery_.
    def exitTracery_(self, ctx:kismet_sequenceParser.Tracery_Context):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#while_block.
    def enterWhile_block(self, ctx:kismet_sequenceParser.While_blockContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#while_block.
    def exitWhile_block(self, ctx:kismet_sequenceParser.While_blockContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#while_condition.
    def enterWhile_condition(self, ctx:kismet_sequenceParser.While_conditionContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#while_condition.
    def exitWhile_condition(self, ctx:kismet_sequenceParser.While_conditionContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#if_block.
    def enterIf_block(self, ctx:kismet_sequenceParser.If_blockContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#if_block.
    def exitIf_block(self, ctx:kismet_sequenceParser.If_blockContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#if_statement.
    def enterIf_statement(self, ctx:kismet_sequenceParser.If_statementContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#if_statement.
    def exitIf_statement(self, ctx:kismet_sequenceParser.If_statementContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#choose_block.
    def enterChoose_block(self, ctx:kismet_sequenceParser.Choose_blockContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#choose_block.
    def exitChoose_block(self, ctx:kismet_sequenceParser.Choose_blockContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#choose_statement.
    def enterChoose_statement(self, ctx:kismet_sequenceParser.Choose_statementContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#choose_statement.
    def exitChoose_statement(self, ctx:kismet_sequenceParser.Choose_statementContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#add.
    def enterAdd(self, ctx:kismet_sequenceParser.AddContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#add.
    def exitAdd(self, ctx:kismet_sequenceParser.AddContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#remove.
    def enterRemove(self, ctx:kismet_sequenceParser.RemoveContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#remove.
    def exitRemove(self, ctx:kismet_sequenceParser.RemoveContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#conditional_statement.
    def enterConditional_statement(self, ctx:kismet_sequenceParser.Conditional_statementContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#conditional_statement.
    def exitConditional_statement(self, ctx:kismet_sequenceParser.Conditional_statementContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#name.
    def enterName(self, ctx:kismet_sequenceParser.NameContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#name.
    def exitName(self, ctx:kismet_sequenceParser.NameContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#filename.
    def enterFilename(self, ctx:kismet_sequenceParser.FilenameContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#filename.
    def exitFilename(self, ctx:kismet_sequenceParser.FilenameContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#var.
    def enterVar(self, ctx:kismet_sequenceParser.VarContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#var.
    def exitVar(self, ctx:kismet_sequenceParser.VarContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#num.
    def enterNum(self, ctx:kismet_sequenceParser.NumContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#num.
    def exitNum(self, ctx:kismet_sequenceParser.NumContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#pos_num.
    def enterPos_num(self, ctx:kismet_sequenceParser.Pos_numContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#pos_num.
    def exitPos_num(self, ctx:kismet_sequenceParser.Pos_numContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#initialize.
    def enterInitialize(self, ctx:kismet_sequenceParser.InitializeContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#initialize.
    def exitInitialize(self, ctx:kismet_sequenceParser.InitializeContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#characters.
    def enterCharacters(self, ctx:kismet_sequenceParser.CharactersContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#characters.
    def exitCharacters(self, ctx:kismet_sequenceParser.CharactersContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#locations.
    def enterLocations(self, ctx:kismet_sequenceParser.LocationsContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#locations.
    def exitLocations(self, ctx:kismet_sequenceParser.LocationsContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#keeping.
    def enterKeeping(self, ctx:kismet_sequenceParser.KeepingContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#keeping.
    def exitKeeping(self, ctx:kismet_sequenceParser.KeepingContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#stashing.
    def enterStashing(self, ctx:kismet_sequenceParser.StashingContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#stashing.
    def exitStashing(self, ctx:kismet_sequenceParser.StashingContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#restoring.
    def enterRestoring(self, ctx:kismet_sequenceParser.RestoringContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#restoring.
    def exitRestoring(self, ctx:kismet_sequenceParser.RestoringContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#where.
    def enterWhere(self, ctx:kismet_sequenceParser.WhereContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#where.
    def exitWhere(self, ctx:kismet_sequenceParser.WhereContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#with_clause.
    def enterWith_clause(self, ctx:kismet_sequenceParser.With_clauseContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#with_clause.
    def exitWith_clause(self, ctx:kismet_sequenceParser.With_clauseContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#in_pattern.
    def enterIn_pattern(self, ctx:kismet_sequenceParser.In_patternContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#in_pattern.
    def exitIn_pattern(self, ctx:kismet_sequenceParser.In_patternContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#comparator.
    def enterComparator(self, ctx:kismet_sequenceParser.ComparatorContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#comparator.
    def exitComparator(self, ctx:kismet_sequenceParser.ComparatorContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#types.
    def enterTypes(self, ctx:kismet_sequenceParser.TypesContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#types.
    def exitTypes(self, ctx:kismet_sequenceParser.TypesContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#tags.
    def enterTags(self, ctx:kismet_sequenceParser.TagsContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#tags.
    def exitTags(self, ctx:kismet_sequenceParser.TagsContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#where_clause.
    def enterWhere_clause(self, ctx:kismet_sequenceParser.Where_clauseContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#where_clause.
    def exitWhere_clause(self, ctx:kismet_sequenceParser.Where_clauseContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#run.
    def enterRun(self, ctx:kismet_sequenceParser.RunContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#run.
    def exitRun(self, ctx:kismet_sequenceParser.RunContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#duration.
    def enterDuration(self, ctx:kismet_sequenceParser.DurationContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#duration.
    def exitDuration(self, ctx:kismet_sequenceParser.DurationContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#none.
    def enterNone(self, ctx:kismet_sequenceParser.NoneContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#none.
    def exitNone(self, ctx:kismet_sequenceParser.NoneContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#every.
    def enterEvery(self, ctx:kismet_sequenceParser.EveryContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#every.
    def exitEvery(self, ctx:kismet_sequenceParser.EveryContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#plus.
    def enterPlus(self, ctx:kismet_sequenceParser.PlusContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#plus.
    def exitPlus(self, ctx:kismet_sequenceParser.PlusContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#quantity.
    def enterQuantity(self, ctx:kismet_sequenceParser.QuantityContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#quantity.
    def exitQuantity(self, ctx:kismet_sequenceParser.QuantityContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#until.
    def enterUntil(self, ctx:kismet_sequenceParser.UntilContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#until.
    def exitUntil(self, ctx:kismet_sequenceParser.UntilContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#until_clauses.
    def enterUntil_clauses(self, ctx:kismet_sequenceParser.Until_clausesContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#until_clauses.
    def exitUntil_clauses(self, ctx:kismet_sequenceParser.Until_clausesContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#positive_find.
    def enterPositive_find(self, ctx:kismet_sequenceParser.Positive_findContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#positive_find.
    def exitPositive_find(self, ctx:kismet_sequenceParser.Positive_findContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#negative_find.
    def enterNegative_find(self, ctx:kismet_sequenceParser.Negative_findContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#negative_find.
    def exitNegative_find(self, ctx:kismet_sequenceParser.Negative_findContext):
        pass


    # Enter a parse tree produced by kismet_sequenceParser#until_clause.
    def enterUntil_clause(self, ctx:kismet_sequenceParser.Until_clauseContext):
        pass

    # Exit a parse tree produced by kismet_sequenceParser#until_clause.
    def exitUntil_clause(self, ctx:kismet_sequenceParser.Until_clauseContext):
        pass


