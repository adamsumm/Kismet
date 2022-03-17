# Generated from kismet_initialization.ebnf by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kismet_initializationParser import kismet_initializationParser
else:
    from kismet_initializationParser import kismet_initializationParser

# This class defines a complete listener for a parse tree produced by kismet_initializationParser.
class kismet_initializationListener(ParseTreeListener):

    # Enter a parse tree produced by kismet_initializationParser#init.
    def enterInit(self, ctx:kismet_initializationParser.InitContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#init.
    def exitInit(self, ctx:kismet_initializationParser.InitContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#name.
    def enterName(self, ctx:kismet_initializationParser.NameContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#name.
    def exitName(self, ctx:kismet_initializationParser.NameContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#var.
    def enterVar(self, ctx:kismet_initializationParser.VarContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#var.
    def exitVar(self, ctx:kismet_initializationParser.VarContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#filter_out.
    def enterFilter_out(self, ctx:kismet_initializationParser.Filter_outContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#filter_out.
    def exitFilter_out(self, ctx:kismet_initializationParser.Filter_outContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#unique_count.
    def enterUnique_count(self, ctx:kismet_initializationParser.Unique_countContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#unique_count.
    def exitUnique_count(self, ctx:kismet_initializationParser.Unique_countContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#comparator.
    def enterComparator(self, ctx:kismet_initializationParser.ComparatorContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#comparator.
    def exitComparator(self, ctx:kismet_initializationParser.ComparatorContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#num_range.
    def enterNum_range(self, ctx:kismet_initializationParser.Num_rangeContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#num_range.
    def exitNum_range(self, ctx:kismet_initializationParser.Num_rangeContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#num_choice.
    def enterNum_choice(self, ctx:kismet_initializationParser.Num_choiceContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#num_choice.
    def exitNum_choice(self, ctx:kismet_initializationParser.Num_choiceContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#pdf.
    def enterPdf(self, ctx:kismet_initializationParser.PdfContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#pdf.
    def exitPdf(self, ctx:kismet_initializationParser.PdfContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#num.
    def enterNum(self, ctx:kismet_initializationParser.NumContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#num.
    def exitNum(self, ctx:kismet_initializationParser.NumContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#pos_num.
    def enterPos_num(self, ctx:kismet_initializationParser.Pos_numContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#pos_num.
    def exitPos_num(self, ctx:kismet_initializationParser.Pos_numContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#random_text.
    def enterRandom_text(self, ctx:kismet_initializationParser.Random_textContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#random_text.
    def exitRandom_text(self, ctx:kismet_initializationParser.Random_textContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#initialization.
    def enterInitialization(self, ctx:kismet_initializationParser.InitializationContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#initialization.
    def exitInitialization(self, ctx:kismet_initializationParser.InitializationContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#let.
    def enterLet(self, ctx:kismet_initializationParser.LetContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#let.
    def exitLet(self, ctx:kismet_initializationParser.LetContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#create.
    def enterCreate(self, ctx:kismet_initializationParser.CreateContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#create.
    def exitCreate(self, ctx:kismet_initializationParser.CreateContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#select.
    def enterSelect(self, ctx:kismet_initializationParser.SelectContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#select.
    def exitSelect(self, ctx:kismet_initializationParser.SelectContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#options.
    def enterOptions(self, ctx:kismet_initializationParser.OptionsContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#options.
    def exitOptions(self, ctx:kismet_initializationParser.OptionsContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#conditions.
    def enterConditions(self, ctx:kismet_initializationParser.ConditionsContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#conditions.
    def exitConditions(self, ctx:kismet_initializationParser.ConditionsContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#default.
    def enterDefault(self, ctx:kismet_initializationParser.DefaultContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#default.
    def exitDefault(self, ctx:kismet_initializationParser.DefaultContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#option.
    def enterOption(self, ctx:kismet_initializationParser.OptionContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#option.
    def exitOption(self, ctx:kismet_initializationParser.OptionContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#optional_check.
    def enterOptional_check(self, ctx:kismet_initializationParser.Optional_checkContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#optional_check.
    def exitOptional_check(self, ctx:kismet_initializationParser.Optional_checkContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#assignment.
    def enterAssignment(self, ctx:kismet_initializationParser.AssignmentContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#assignment.
    def exitAssignment(self, ctx:kismet_initializationParser.AssignmentContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#now.
    def enterNow(self, ctx:kismet_initializationParser.NowContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#now.
    def exitNow(self, ctx:kismet_initializationParser.NowContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#plus_minus.
    def enterPlus_minus(self, ctx:kismet_initializationParser.Plus_minusContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#plus_minus.
    def exitPlus_minus(self, ctx:kismet_initializationParser.Plus_minusContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#deferred_assignment.
    def enterDeferred_assignment(self, ctx:kismet_initializationParser.Deferred_assignmentContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#deferred_assignment.
    def exitDeferred_assignment(self, ctx:kismet_initializationParser.Deferred_assignmentContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#deferred_option.
    def enterDeferred_option(self, ctx:kismet_initializationParser.Deferred_optionContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#deferred_option.
    def exitDeferred_option(self, ctx:kismet_initializationParser.Deferred_optionContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#negative.
    def enterNegative(self, ctx:kismet_initializationParser.NegativeContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#negative.
    def exitNegative(self, ctx:kismet_initializationParser.NegativeContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#description.
    def enterDescription(self, ctx:kismet_initializationParser.DescriptionContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#description.
    def exitDescription(self, ctx:kismet_initializationParser.DescriptionContext):
        pass


    # Enter a parse tree produced by kismet_initializationParser#initialize.
    def enterInitialize(self, ctx:kismet_initializationParser.InitializeContext):
        pass

    # Exit a parse tree produced by kismet_initializationParser#initialize.
    def exitInitialize(self, ctx:kismet_initializationParser.InitializeContext):
        pass


