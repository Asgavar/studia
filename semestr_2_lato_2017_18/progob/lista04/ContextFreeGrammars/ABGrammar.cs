using System;

namespace ContextFreeGrammars
{
    public class ABGrammar : IRandomGrammar
    {
        private TerminalSymbol[] terminals;
        private NonTerminalSymbol[] nonterminals;
        private Term startingSymbol;
        private RandomProductionRuleList productionRules;


        public ABGrammar()
        {
            this.terminals = new TerminalSymbol[]{
                new TerminalSymbol("a"),
                new TerminalSymbol("b")
            };

            this.nonterminals = new NonTerminalSymbol[]{
                new NonTerminalSymbol("S")
            };

            this.startingSymbol = new Term(new NonTerminalSymbol("S"));

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
            while (this.startingSymbol.GetReplaceableSymbols().Count != 0)
            {
                startingSymbol.ReplaceSymbol(this.productionRules.GetRulesFor(new NonTerminalSymbol("S"))[0]);
                Console.WriteLine(startingSymbol.ToString());
            }
            return startingSymbol.ToString();
        }
    }
}
