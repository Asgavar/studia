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
            return new List<ITerm>();
        }


        public override string ToString()
        {
            return this.repr;
        }


        public override bool Equals(object obj)
        {
            return this.repr.Equals(obj.ToString());
        }


        public override int GetHashCode()
        {
            return 1234;
        }
    }
}
