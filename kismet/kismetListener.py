# Generated from kismet.ebnf by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kismetParser import kismetParser
else:
    from kismetParser import kismetParser

# This class defines a complete listener for a parse tree produced by kismetParser.
class kismetListener(ParseTreeListener):

    # Enter a parse tree produced by kismetParser#simulation.
    def enterSimulation(self, ctx:kismetParser.SimulationContext):
        pass

    # Exit a parse tree produced by kismetParser#simulation.
    def exitSimulation(self, ctx:kismetParser.SimulationContext):
        pass


    # Enter a parse tree produced by kismetParser#location.
    def enterLocation(self, ctx:kismetParser.LocationContext):
        pass

    # Exit a parse tree produced by kismetParser#location.
    def exitLocation(self, ctx:kismetParser.LocationContext):
        pass


    # Enter a parse tree produced by kismetParser#count.
    def enterCount(self, ctx:kismetParser.CountContext):
        pass

    # Exit a parse tree produced by kismetParser#count.
    def exitCount(self, ctx:kismetParser.CountContext):
        pass


    # Enter a parse tree produced by kismetParser#param.
    def enterParam(self, ctx:kismetParser.ParamContext):
        pass

    # Exit a parse tree produced by kismetParser#param.
    def exitParam(self, ctx:kismetParser.ParamContext):
        pass


    # Enter a parse tree produced by kismetParser#pdf.
    def enterPdf(self, ctx:kismetParser.PdfContext):
        pass

    # Exit a parse tree produced by kismetParser#pdf.
    def exitPdf(self, ctx:kismetParser.PdfContext):
        pass


    # Enter a parse tree produced by kismetParser#trait.
    def enterTrait(self, ctx:kismetParser.TraitContext):
        pass

    # Exit a parse tree produced by kismetParser#trait.
    def exitTrait(self, ctx:kismetParser.TraitContext):
        pass


    # Enter a parse tree produced by kismetParser#decay.
    def enterDecay(self, ctx:kismetParser.DecayContext):
        pass

    # Exit a parse tree produced by kismetParser#decay.
    def exitDecay(self, ctx:kismetParser.DecayContext):
        pass


    # Enter a parse tree produced by kismetParser#trait_oppositions.
    def enterTrait_oppositions(self, ctx:kismetParser.Trait_oppositionsContext):
        pass

    # Exit a parse tree produced by kismetParser#trait_oppositions.
    def exitTrait_oppositions(self, ctx:kismetParser.Trait_oppositionsContext):
        pass


    # Enter a parse tree produced by kismetParser#modifier.
    def enterModifier(self, ctx:kismetParser.ModifierContext):
        pass

    # Exit a parse tree produced by kismetParser#modifier.
    def exitModifier(self, ctx:kismetParser.ModifierContext):
        pass


    # Enter a parse tree produced by kismetParser#goto.
    def enterGoto(self, ctx:kismetParser.GotoContext):
        pass

    # Exit a parse tree produced by kismetParser#goto.
    def exitGoto(self, ctx:kismetParser.GotoContext):
        pass


    # Enter a parse tree produced by kismetParser#valence.
    def enterValence(self, ctx:kismetParser.ValenceContext):
        pass

    # Exit a parse tree produced by kismetParser#valence.
    def exitValence(self, ctx:kismetParser.ValenceContext):
        pass


    # Enter a parse tree produced by kismetParser#tags.
    def enterTags(self, ctx:kismetParser.TagsContext):
        pass

    # Exit a parse tree produced by kismetParser#tags.
    def exitTags(self, ctx:kismetParser.TagsContext):
        pass


    # Enter a parse tree produced by kismetParser#relationship.
    def enterRelationship(self, ctx:kismetParser.RelationshipContext):
        pass

    # Exit a parse tree produced by kismetParser#relationship.
    def exitRelationship(self, ctx:kismetParser.RelationshipContext):
        pass


    # Enter a parse tree produced by kismetParser#pattern.
    def enterPattern(self, ctx:kismetParser.PatternContext):
        pass

    # Exit a parse tree produced by kismetParser#pattern.
    def exitPattern(self, ctx:kismetParser.PatternContext):
        pass


    # Enter a parse tree produced by kismetParser#arguments.
    def enterArguments(self, ctx:kismetParser.ArgumentsContext):
        pass

    # Exit a parse tree produced by kismetParser#arguments.
    def exitArguments(self, ctx:kismetParser.ArgumentsContext):
        pass


    # Enter a parse tree produced by kismetParser#name.
    def enterName(self, ctx:kismetParser.NameContext):
        pass

    # Exit a parse tree produced by kismetParser#name.
    def exitName(self, ctx:kismetParser.NameContext):
        pass


    # Enter a parse tree produced by kismetParser#var.
    def enterVar(self, ctx:kismetParser.VarContext):
        pass

    # Exit a parse tree produced by kismetParser#var.
    def exitVar(self, ctx:kismetParser.VarContext):
        pass


    # Enter a parse tree produced by kismetParser#query.
    def enterQuery(self, ctx:kismetParser.QueryContext):
        pass

    # Exit a parse tree produced by kismetParser#query.
    def exitQuery(self, ctx:kismetParser.QueryContext):
        pass


    # Enter a parse tree produced by kismetParser#comparison.
    def enterComparison(self, ctx:kismetParser.ComparisonContext):
        pass

    # Exit a parse tree produced by kismetParser#comparison.
    def exitComparison(self, ctx:kismetParser.ComparisonContext):
        pass


    # Enter a parse tree produced by kismetParser#comparator.
    def enterComparator(self, ctx:kismetParser.ComparatorContext):
        pass

    # Exit a parse tree produced by kismetParser#comparator.
    def exitComparator(self, ctx:kismetParser.ComparatorContext):
        pass


    # Enter a parse tree produced by kismetParser#has.
    def enterHas(self, ctx:kismetParser.HasContext):
        pass

    # Exit a parse tree produced by kismetParser#has.
    def exitHas(self, ctx:kismetParser.HasContext):
        pass


    # Enter a parse tree produced by kismetParser#add.
    def enterAdd(self, ctx:kismetParser.AddContext):
        pass

    # Exit a parse tree produced by kismetParser#add.
    def exitAdd(self, ctx:kismetParser.AddContext):
        pass


    # Enter a parse tree produced by kismetParser#inc.
    def enterInc(self, ctx:kismetParser.IncContext):
        pass

    # Exit a parse tree produced by kismetParser#inc.
    def exitInc(self, ctx:kismetParser.IncContext):
        pass


    # Enter a parse tree produced by kismetParser#dec.
    def enterDec(self, ctx:kismetParser.DecContext):
        pass

    # Exit a parse tree produced by kismetParser#dec.
    def exitDec(self, ctx:kismetParser.DecContext):
        pass


    # Enter a parse tree produced by kismetParser#remove.
    def enterRemove(self, ctx:kismetParser.RemoveContext):
        pass

    # Exit a parse tree produced by kismetParser#remove.
    def exitRemove(self, ctx:kismetParser.RemoveContext):
        pass


    # Enter a parse tree produced by kismetParser#at.
    def enterAt(self, ctx:kismetParser.AtContext):
        pass

    # Exit a parse tree produced by kismetParser#at.
    def exitAt(self, ctx:kismetParser.AtContext):
        pass


    # Enter a parse tree produced by kismetParser#action.
    def enterAction(self, ctx:kismetParser.ActionContext):
        pass

    # Exit a parse tree produced by kismetParser#action.
    def exitAction(self, ctx:kismetParser.ActionContext):
        pass


