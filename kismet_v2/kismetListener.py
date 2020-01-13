# Generated from kismet.ebnv by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kismetParser import kismetParser
else:
    from kismetParser import kismetParser

# This class defines a complete listener for a parse tree produced by kismetParser.
class kismetListener(ParseTreeListener):

    # Enter a parse tree produced by kismetParser#world.
    def enterWorld(self, ctx:kismetParser.WorldContext):
        pass

    # Exit a parse tree produced by kismetParser#world.
    def exitWorld(self, ctx:kismetParser.WorldContext):
        pass


    # Enter a parse tree produced by kismetParser#trait.
    def enterTrait(self, ctx:kismetParser.TraitContext):
        pass

    # Exit a parse tree produced by kismetParser#trait.
    def exitTrait(self, ctx:kismetParser.TraitContext):
        pass


    # Enter a parse tree produced by kismetParser#trait_type.
    def enterTrait_type(self, ctx:kismetParser.Trait_typeContext):
        pass

    # Exit a parse tree produced by kismetParser#trait_type.
    def exitTrait_type(self, ctx:kismetParser.Trait_typeContext):
        pass


    # Enter a parse tree produced by kismetParser#knowledge.
    def enterKnowledge(self, ctx:kismetParser.KnowledgeContext):
        pass

    # Exit a parse tree produced by kismetParser#knowledge.
    def exitKnowledge(self, ctx:kismetParser.KnowledgeContext):
        pass


    # Enter a parse tree produced by kismetParser#propensity.
    def enterPropensity(self, ctx:kismetParser.PropensityContext):
        pass

    # Exit a parse tree produced by kismetParser#propensity.
    def exitPropensity(self, ctx:kismetParser.PropensityContext):
        pass


    # Enter a parse tree produced by kismetParser#propensity_name.
    def enterPropensity_name(self, ctx:kismetParser.Propensity_nameContext):
        pass

    # Exit a parse tree produced by kismetParser#propensity_name.
    def exitPropensity_name(self, ctx:kismetParser.Propensity_nameContext):
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


    # Enter a parse tree produced by kismetParser#action.
    def enterAction(self, ctx:kismetParser.ActionContext):
        pass

    # Exit a parse tree produced by kismetParser#action.
    def exitAction(self, ctx:kismetParser.ActionContext):
        pass


    # Enter a parse tree produced by kismetParser#add.
    def enterAdd(self, ctx:kismetParser.AddContext):
        pass

    # Exit a parse tree produced by kismetParser#add.
    def exitAdd(self, ctx:kismetParser.AddContext):
        pass


    # Enter a parse tree produced by kismetParser#change.
    def enterChange(self, ctx:kismetParser.ChangeContext):
        pass

    # Exit a parse tree produced by kismetParser#change.
    def exitChange(self, ctx:kismetParser.ChangeContext):
        pass


    # Enter a parse tree produced by kismetParser#visibility.
    def enterVisibility(self, ctx:kismetParser.VisibilityContext):
        pass

    # Exit a parse tree produced by kismetParser#visibility.
    def exitVisibility(self, ctx:kismetParser.VisibilityContext):
        pass


    # Enter a parse tree produced by kismetParser#action_location.
    def enterAction_location(self, ctx:kismetParser.Action_locationContext):
        pass

    # Exit a parse tree produced by kismetParser#action_location.
    def exitAction_location(self, ctx:kismetParser.Action_locationContext):
        pass


    # Enter a parse tree produced by kismetParser#loc.
    def enterLoc(self, ctx:kismetParser.LocContext):
        pass

    # Exit a parse tree produced by kismetParser#loc.
    def exitLoc(self, ctx:kismetParser.LocContext):
        pass


    # Enter a parse tree produced by kismetParser#action_item.
    def enterAction_item(self, ctx:kismetParser.Action_itemContext):
        pass

    # Exit a parse tree produced by kismetParser#action_item.
    def exitAction_item(self, ctx:kismetParser.Action_itemContext):
        pass


    # Enter a parse tree produced by kismetParser#role.
    def enterRole(self, ctx:kismetParser.RoleContext):
        pass

    # Exit a parse tree produced by kismetParser#role.
    def exitRole(self, ctx:kismetParser.RoleContext):
        pass


    # Enter a parse tree produced by kismetParser#extension.
    def enterExtension(self, ctx:kismetParser.ExtensionContext):
        pass

    # Exit a parse tree produced by kismetParser#extension.
    def exitExtension(self, ctx:kismetParser.ExtensionContext):
        pass


    # Enter a parse tree produced by kismetParser#arg.
    def enterArg(self, ctx:kismetParser.ArgContext):
        pass

    # Exit a parse tree produced by kismetParser#arg.
    def exitArg(self, ctx:kismetParser.ArgContext):
        pass


    # Enter a parse tree produced by kismetParser#arg_type.
    def enterArg_type(self, ctx:kismetParser.Arg_typeContext):
        pass

    # Exit a parse tree produced by kismetParser#arg_type.
    def exitArg_type(self, ctx:kismetParser.Arg_typeContext):
        pass


    # Enter a parse tree produced by kismetParser#tags.
    def enterTags(self, ctx:kismetParser.TagsContext):
        pass

    # Exit a parse tree produced by kismetParser#tags.
    def exitTags(self, ctx:kismetParser.TagsContext):
        pass


    # Enter a parse tree produced by kismetParser#comparison.
    def enterComparison(self, ctx:kismetParser.ComparisonContext):
        pass

    # Exit a parse tree produced by kismetParser#comparison.
    def exitComparison(self, ctx:kismetParser.ComparisonContext):
        pass


    # Enter a parse tree produced by kismetParser#condition.
    def enterCondition(self, ctx:kismetParser.ConditionContext):
        pass

    # Exit a parse tree produced by kismetParser#condition.
    def exitCondition(self, ctx:kismetParser.ConditionContext):
        pass


    # Enter a parse tree produced by kismetParser#cond1.
    def enterCond1(self, ctx:kismetParser.Cond1Context):
        pass

    # Exit a parse tree produced by kismetParser#cond1.
    def exitCond1(self, ctx:kismetParser.Cond1Context):
        pass


    # Enter a parse tree produced by kismetParser#cond2.
    def enterCond2(self, ctx:kismetParser.Cond2Context):
        pass

    # Exit a parse tree produced by kismetParser#cond2.
    def exitCond2(self, ctx:kismetParser.Cond2Context):
        pass


    # Enter a parse tree produced by kismetParser#cond3.
    def enterCond3(self, ctx:kismetParser.Cond3Context):
        pass

    # Exit a parse tree produced by kismetParser#cond3.
    def exitCond3(self, ctx:kismetParser.Cond3Context):
        pass


    # Enter a parse tree produced by kismetParser#cond4.
    def enterCond4(self, ctx:kismetParser.Cond4Context):
        pass

    # Exit a parse tree produced by kismetParser#cond4.
    def exitCond4(self, ctx:kismetParser.Cond4Context):
        pass


    # Enter a parse tree produced by kismetParser#cond5.
    def enterCond5(self, ctx:kismetParser.Cond5Context):
        pass

    # Exit a parse tree produced by kismetParser#cond5.
    def exitCond5(self, ctx:kismetParser.Cond5Context):
        pass


    # Enter a parse tree produced by kismetParser#cond6.
    def enterCond6(self, ctx:kismetParser.Cond6Context):
        pass

    # Exit a parse tree produced by kismetParser#cond6.
    def exitCond6(self, ctx:kismetParser.Cond6Context):
        pass


    # Enter a parse tree produced by kismetParser#cond7.
    def enterCond7(self, ctx:kismetParser.Cond7Context):
        pass

    # Exit a parse tree produced by kismetParser#cond7.
    def exitCond7(self, ctx:kismetParser.Cond7Context):
        pass


    # Enter a parse tree produced by kismetParser#operator.
    def enterOperator(self, ctx:kismetParser.OperatorContext):
        pass

    # Exit a parse tree produced by kismetParser#operator.
    def exitOperator(self, ctx:kismetParser.OperatorContext):
        pass


    # Enter a parse tree produced by kismetParser#location.
    def enterLocation(self, ctx:kismetParser.LocationContext):
        pass

    # Exit a parse tree produced by kismetParser#location.
    def exitLocation(self, ctx:kismetParser.LocationContext):
        pass


    # Enter a parse tree produced by kismetParser#initialization.
    def enterInitialization(self, ctx:kismetParser.InitializationContext):
        pass

    # Exit a parse tree produced by kismetParser#initialization.
    def exitInitialization(self, ctx:kismetParser.InitializationContext):
        pass


    # Enter a parse tree produced by kismetParser#each_turn.
    def enterEach_turn(self, ctx:kismetParser.Each_turnContext):
        pass

    # Exit a parse tree produced by kismetParser#each_turn.
    def exitEach_turn(self, ctx:kismetParser.Each_turnContext):
        pass


    # Enter a parse tree produced by kismetParser#cast.
    def enterCast(self, ctx:kismetParser.CastContext):
        pass

    # Exit a parse tree produced by kismetParser#cast.
    def exitCast(self, ctx:kismetParser.CastContext):
        pass


    # Enter a parse tree produced by kismetParser#random_text.
    def enterRandom_text(self, ctx:kismetParser.Random_textContext):
        pass

    # Exit a parse tree produced by kismetParser#random_text.
    def exitRandom_text(self, ctx:kismetParser.Random_textContext):
        pass


    # Enter a parse tree produced by kismetParser#l_name.
    def enterL_name(self, ctx:kismetParser.L_nameContext):
        pass

    # Exit a parse tree produced by kismetParser#l_name.
    def exitL_name(self, ctx:kismetParser.L_nameContext):
        pass


    # Enter a parse tree produced by kismetParser#supported_entities.
    def enterSupported_entities(self, ctx:kismetParser.Supported_entitiesContext):
        pass

    # Exit a parse tree produced by kismetParser#supported_entities.
    def exitSupported_entities(self, ctx:kismetParser.Supported_entitiesContext):
        pass


    # Enter a parse tree produced by kismetParser#supports.
    def enterSupports(self, ctx:kismetParser.SupportsContext):
        pass

    # Exit a parse tree produced by kismetParser#supports.
    def exitSupports(self, ctx:kismetParser.SupportsContext):
        pass


    # Enter a parse tree produced by kismetParser#num.
    def enterNum(self, ctx:kismetParser.NumContext):
        pass

    # Exit a parse tree produced by kismetParser#num.
    def exitNum(self, ctx:kismetParser.NumContext):
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


    # Enter a parse tree produced by kismetParser#comparator.
    def enterComparator(self, ctx:kismetParser.ComparatorContext):
        pass

    # Exit a parse tree produced by kismetParser#comparator.
    def exitComparator(self, ctx:kismetParser.ComparatorContext):
        pass


    # Enter a parse tree produced by kismetParser#num_choice.
    def enterNum_choice(self, ctx:kismetParser.Num_choiceContext):
        pass

    # Exit a parse tree produced by kismetParser#num_choice.
    def exitNum_choice(self, ctx:kismetParser.Num_choiceContext):
        pass


    # Enter a parse tree produced by kismetParser#pdf.
    def enterPdf(self, ctx:kismetParser.PdfContext):
        pass

    # Exit a parse tree produced by kismetParser#pdf.
    def exitPdf(self, ctx:kismetParser.PdfContext):
        pass


