using System;
using System.Collections.Generic;

namespace ContextFreeGrammars
{
    public class NonTerminalSymbol : ISymbol
    {
        private string repr;


        public NonTerminalSymbol(string repr)
        {
            this.repr = repr;
        }
        

        public string GetRepresentation()
        {
            return repr;
        }


        public bool IsTerminal()
        {
            return false;
        }


        public bool ReplaceSymbol(ProductionRule rule)
        {
            throw new Exception();
        }


        public List<ISymbol> GetReplaceableSymbols()
        {
            return new List<ISymbol>();
        }
    }
}
