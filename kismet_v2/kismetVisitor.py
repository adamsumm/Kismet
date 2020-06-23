# Generated from kismet.ebnv by ANTLR 4.7.2
from antlr4 import *
if __name__ is not None and "." in __name__:
    from .kismetParser import kismetParser
else:
    from kismetParser import kismetParser

# This class defines a complete generic visitor for a parse tree produced by kismetParser.

class kismetVisitor(ParseTreeVisitor):

    # Visit a parse tree produced by kismetParser#world.
    def visitWorld(self, ctx:kismetParser.WorldContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#opposition.
    def visitOpposition(self, ctx:kismetParser.OppositionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#trait.
    def visitTrait(self, ctx:kismetParser.TraitContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#trait_type.
    def visitTrait_type(self, ctx:kismetParser.Trait_typeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#propensity.
    def visitPropensity(self, ctx:kismetParser.PropensityContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#propensity_name.
    def visitPropensity_name(self, ctx:kismetParser.Propensity_nameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#modifier.
    def visitModifier(self, ctx:kismetParser.ModifierContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#goto.
    def visitGoto(self, ctx:kismetParser.GotoContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#valence.
    def visitValence(self, ctx:kismetParser.ValenceContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#action.
    def visitAction(self, ctx:kismetParser.ActionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#free.
    def visitFree(self, ctx:kismetParser.FreeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#response.
    def visitResponse(self, ctx:kismetParser.ResponseContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#add.
    def visitAdd(self, ctx:kismetParser.AddContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#change.
    def visitChange(self, ctx:kismetParser.ChangeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#visibility.
    def visitVisibility(self, ctx:kismetParser.VisibilityContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#action_location.
    def visitAction_location(self, ctx:kismetParser.Action_locationContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#loc.
    def visitLoc(self, ctx:kismetParser.LocContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#locWildCard.
    def visitLocWildCard(self, ctx:kismetParser.LocWildCardContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#action_item.
    def visitAction_item(self, ctx:kismetParser.Action_itemContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#role.
    def visitRole(self, ctx:kismetParser.RoleContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#extension.
    def visitExtension(self, ctx:kismetParser.ExtensionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#cast_name.
    def visitCast_name(self, ctx:kismetParser.Cast_nameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#arg.
    def visitArg(self, ctx:kismetParser.ArgContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#sub.
    def visitSub(self, ctx:kismetParser.SubContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#arg_type.
    def visitArg_type(self, ctx:kismetParser.Arg_typeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#tags.
    def visitTags(self, ctx:kismetParser.TagsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#comparison.
    def visitComparison(self, ctx:kismetParser.ComparisonContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#knowledge.
    def visitKnowledge(self, ctx:kismetParser.KnowledgeContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#condition.
    def visitCondition(self, ctx:kismetParser.ConditionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#cond3.
    def visitCond3(self, ctx:kismetParser.Cond3Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#cond1.
    def visitCond1(self, ctx:kismetParser.Cond1Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#cond4.
    def visitCond4(self, ctx:kismetParser.Cond4Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#inversion.
    def visitInversion(self, ctx:kismetParser.InversionContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#cond5.
    def visitCond5(self, ctx:kismetParser.Cond5Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#cond6.
    def visitCond6(self, ctx:kismetParser.Cond6Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#cond7.
    def visitCond7(self, ctx:kismetParser.Cond7Context):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#tag_compare.
    def visitTag_compare(self, ctx:kismetParser.Tag_compareContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#operator.
    def visitOperator(self, ctx:kismetParser.OperatorContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#location.
    def visitLocation(self, ctx:kismetParser.LocationContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#initialization.
    def visitInitialization(self, ctx:kismetParser.InitializationContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#each_turn.
    def visitEach_turn(self, ctx:kismetParser.Each_turnContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#cast.
    def visitCast(self, ctx:kismetParser.CastContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#random_text.
    def visitRandom_text(self, ctx:kismetParser.Random_textContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#l_name.
    def visitL_name(self, ctx:kismetParser.L_nameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#supported_entities.
    def visitSupported_entities(self, ctx:kismetParser.Supported_entitiesContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#supports.
    def visitSupports(self, ctx:kismetParser.SupportsContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#num.
    def visitNum(self, ctx:kismetParser.NumContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#name.
    def visitName(self, ctx:kismetParser.NameContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#var.
    def visitVar(self, ctx:kismetParser.VarContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#comparator.
    def visitComparator(self, ctx:kismetParser.ComparatorContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#num_choice.
    def visitNum_choice(self, ctx:kismetParser.Num_choiceContext):
        return self.visitChildren(ctx)


    # Visit a parse tree produced by kismetParser#pdf.
    def visitPdf(self, ctx:kismetParser.PdfContext):
        return self.visitChildren(ctx)



del kismetParser