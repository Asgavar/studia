using System;
using System.Collections.Generic;

namespace ContextFreeGrammars
{
    public class NonTerminalSymbol : AbstractSymbol, ISymbol
    {
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


        public List<ITerm> GetReplaceableSymbols()
        {
            var ret = new List<ITerm>();
            ret.Add(this);
            return ret;
        }
    }
}
