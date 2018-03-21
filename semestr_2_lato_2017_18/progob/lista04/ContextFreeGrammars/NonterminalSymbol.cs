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


        public List<ITerm> GetReplaceableSymbols()
        {
            var ret = new List<ITerm>();
            ret.Add(this);
            return ret;
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
