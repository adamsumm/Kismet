# Generated from kismet_sequence.ebnf by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kismet_sequenceParser import kismet_sequenceParser
else:
    from kismet_sequenceParser import kismet_sequenceParser

# This class defines a complete generic visitor for a parse tree produced by kismet_sequenceParser.

class kismet_sequenceVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by kismet_sequenceParser#sequence.
    def visitSequence(self, ctx:kismet_sequenceParser.SequenceContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#statement.
    def visitStatement(self, ctx:kismet_sequenceParser.StatementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#load.
    def visitLoad(self, ctx:kismet_sequenceParser.LoadContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#tracery_.
    def visitTracery_(self, ctx:kismet_sequenceParser.Tracery_Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#while_block.
    def visitWhile_block(self, ctx:kismet_sequenceParser.While_blockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#while_condition.
    def visitWhile_condition(self, ctx:kismet_sequenceParser.While_conditionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#if_block.
    def visitIf_block(self, ctx:kismet_sequenceParser.If_blockContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#if_statement.
    def visitIf_statement(self, ctx:kismet_sequenceParser.If_statementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#add.
    def visitAdd(self, ctx:kismet_sequenceParser.AddContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#remove.
    def visitRemove(self, ctx:kismet_sequenceParser.RemoveContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#conditional_statement.
    def visitConditional_statement(self, ctx:kismet_sequenceParser.Conditional_statementContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#name.
    def visitName(self, ctx:kismet_sequenceParser.NameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#filename.
    def visitFilename(self, ctx:kismet_sequenceParser.FilenameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#var.
    def visitVar(self, ctx:kismet_sequenceParser.VarContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#num.
    def visitNum(self, ctx:kismet_sequenceParser.NumContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#pos_num.
    def visitPos_num(self, ctx:kismet_sequenceParser.Pos_numContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#initialize.
    def visitInitialize(self, ctx:kismet_sequenceParser.InitializeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#characters.
    def visitCharacters(self, ctx:kismet_sequenceParser.CharactersContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#locations.
    def visitLocations(self, ctx:kismet_sequenceParser.LocationsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#keeping.
    def visitKeeping(self, ctx:kismet_sequenceParser.KeepingContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#stashing.
    def visitStashing(self, ctx:kismet_sequenceParser.StashingContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#restoring.
    def visitRestoring(self, ctx:kismet_sequenceParser.RestoringContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#where.
    def visitWhere(self, ctx:kismet_sequenceParser.WhereContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#with_clause.
    def visitWith_clause(self, ctx:kismet_sequenceParser.With_clauseContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#in_pattern.
    def visitIn_pattern(self, ctx:kismet_sequenceParser.In_patternContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#comparator.
    def visitComparator(self, ctx:kismet_sequenceParser.ComparatorContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#types.
    def visitTypes(self, ctx:kismet_sequenceParser.TypesContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#tags.
    def visitTags(self, ctx:kismet_sequenceParser.TagsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#where_clause.
    def visitWhere_clause(self, ctx:kismet_sequenceParser.Where_clauseContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#run.
    def visitRun(self, ctx:kismet_sequenceParser.RunContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#duration.
    def visitDuration(self, ctx:kismet_sequenceParser.DurationContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#none.
    def visitNone(self, ctx:kismet_sequenceParser.NoneContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#every.
    def visitEvery(self, ctx:kismet_sequenceParser.EveryContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#plus.
    def visitPlus(self, ctx:kismet_sequenceParser.PlusContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#quantity.
    def visitQuantity(self, ctx:kismet_sequenceParser.QuantityContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#until.
    def visitUntil(self, ctx:kismet_sequenceParser.UntilContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#until_clauses.
    def visitUntil_clauses(self, ctx:kismet_sequenceParser.Until_clausesContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#positive_find.
    def visitPositive_find(self, ctx:kismet_sequenceParser.Positive_findContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#negative_find.
    def visitNegative_find(self, ctx:kismet_sequenceParser.Negative_findContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_sequenceParser#until_clause.
    def visitUntil_clause(self, ctx:kismet_sequenceParser.Until_clauseContext):
        return self.visitChildren(ctx)



del kismet_sequenceParser