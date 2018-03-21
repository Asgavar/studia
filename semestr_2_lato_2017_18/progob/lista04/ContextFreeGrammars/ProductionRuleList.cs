using System.Collections.Generic;

namespace ContextFreeGrammars
{
    public class RandomProductionRuleList : IProductionRuleList
    {
        private List<ProductionRule> ruleList;


        public RandomProductionRuleList(ProductionRule[] ruleList)
        {
            this.ruleList = new List<ProductionRule>(ruleList);
        }
        

        public ProductionRule[] GetRulesFor(ISymbol symbol)
        {
            // tu randomizacja
            return null;
        }
    }
}
