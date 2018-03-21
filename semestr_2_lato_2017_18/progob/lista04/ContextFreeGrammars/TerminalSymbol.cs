using System.Collections.Generic;

namespace ContextFreeGrammars
{
    public class TerminalSymbol : AbstractSymbol, ISymbol
    {
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


        public List<ITerm> GetReplaceableSymbols()
        {
            return new List<ITerm>();
        }
    }
}
