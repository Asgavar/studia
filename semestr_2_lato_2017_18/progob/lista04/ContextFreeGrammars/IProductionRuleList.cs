namespace ContextFreeGrammars
{
    public interface IProductionRuleList
    {
        ProductionRule[] GetRulesFor(ISymbol symb);
    }
}
