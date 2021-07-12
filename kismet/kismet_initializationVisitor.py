# Generated from kismet_initialization.ebnf by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kismet_initializationParser import kismet_initializationParser
else:
    from kismet_initializationParser import kismet_initializationParser

# This class defines a complete generic visitor for a parse tree produced by kismet_initializationParser.

class kismet_initializationVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by kismet_initializationParser#init.
    def visitInit(self, ctx:kismet_initializationParser.InitContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#name.
    def visitName(self, ctx:kismet_initializationParser.NameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#var.
    def visitVar(self, ctx:kismet_initializationParser.VarContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#comparator.
    def visitComparator(self, ctx:kismet_initializationParser.ComparatorContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#num_range.
    def visitNum_range(self, ctx:kismet_initializationParser.Num_rangeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#num_choice.
    def visitNum_choice(self, ctx:kismet_initializationParser.Num_choiceContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#pdf.
    def visitPdf(self, ctx:kismet_initializationParser.PdfContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#num.
    def visitNum(self, ctx:kismet_initializationParser.NumContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#pos_num.
    def visitPos_num(self, ctx:kismet_initializationParser.Pos_numContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#random_text.
    def visitRandom_text(self, ctx:kismet_initializationParser.Random_textContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#initialization.
    def visitInitialization(self, ctx:kismet_initializationParser.InitializationContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#let.
    def visitLet(self, ctx:kismet_initializationParser.LetContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#create.
    def visitCreate(self, ctx:kismet_initializationParser.CreateContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#options.
    def visitOptions(self, ctx:kismet_initializationParser.OptionsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#default.
    def visitDefault(self, ctx:kismet_initializationParser.DefaultContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#option.
    def visitOption(self, ctx:kismet_initializationParser.OptionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#assignment.
    def visitAssignment(self, ctx:kismet_initializationParser.AssignmentContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#description.
    def visitDescription(self, ctx:kismet_initializationParser.DescriptionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismet_initializationParser#initialize.
    def visitInitialize(self, ctx:kismet_initializationParser.InitializeContext):
        return self.visitChildren(ctx)



del kismet_initializationParser