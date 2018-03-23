using System;

namespace ContextFreeGrammars
{
    public class ABGrammar : IRandomGrammar
    {
        private const int RULES_NUMBER = 2;
        
        private TerminalSymbol[] terminals;
        private NonTerminalSymbol[] nonterminals;
        private Term startingSymbol;
        private RandomProductionRuleList productionRules;
        private Random rng;


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
            this.rng = new Random();
        }


        // TODO: generator losowy
        public string GetRandomWord()
        {
            while (this.startingSymbol.GetReplaceableSymbols().Count != 0)
            {
                int randomIndex = this.rng.Next() % RULES_NUMBER;
                startingSymbol.ReplaceSymbol(
                    this.productionRules.GetRulesFor(new NonTerminalSymbol("S"))[randomIndex]
                );
                //Console.WriteLine(startingSymbol.ToString());
            }
            return startingSymbol.ToString();
        }
    }
}
