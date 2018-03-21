namespace ContextFreeGrammars
{
    public class ABGrammar : IRandomGrammar
    {
        private TerminalSymbol[] terminals;
        private NonTerminalSymbol[] nonterminals;
        private ISymbol startingSymbol;
        private RandomProductionRuleList productionRules;


        public ABGrammar()
        {
            this.terminals = {
                new TerminalSymbol("a");
                new TerminalSymbol("b");
            };

            this.nonterminals = {
                new NonTerminalSymbol("S");
            };

            this.startingSymbol = new NonTerminalSymbol("S");

            ISymbol[] aSb = {
                new TerminalSymbol("a"),
                new NonTerminalSymbol("S"),
                new TerminalSymbol("b")
            };

            ISymbol[] epsilon = {
                new TerminalSymbol("ε")
            };
                
            ProductionRule[] ruleList = {
                new ProductionRule(new NonTerminalSymbol("S"), aSb),
                new ProductionRule(new NonTerminalSymbol("S"), epsilon)
            };

            this.productionRules = new RandomProductionRuleList(ruleList);
        }


        public string GetRandomWord()
        {
            return "";
        }
    }
}
