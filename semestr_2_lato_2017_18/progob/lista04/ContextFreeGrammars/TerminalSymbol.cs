using System;
using System.Collections.Generic;

namespace ContextFreeGrammars
{
    public class TerminalSymbol : ISymbol
    {
        private string repr;


        public TerminalSymbol(string repr)
        {
            this.repr = repr;
        }
        
        
        public string GetRepresentation()
        {
            return this.repr;
        }


        public bool IsTerminal()
        {
            return true;
        }


        public bool ReplaceSymbol(ProductionRule rule)
        {
            throw new Exception();
        }


        public List<ITerm> GetReplaceableSymbols()
        {
            var ret = new List<ITerm>();
            ret.Add(this);
            return ret;
        }
    }
}
