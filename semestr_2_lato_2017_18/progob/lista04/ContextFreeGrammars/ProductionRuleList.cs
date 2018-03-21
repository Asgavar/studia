using System.Collections.Generic;
using System.Linq;

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
            return this.ruleList.Where(rule => rule.GetFrom().Equals(symbol)).ToArray();
        }
    }
}
