using System;

namespace ContextFreeGrammars
{
    public abstract class AbstractSymbol
    {
        protected string repr;

        
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


        public bool ReplaceSymbol(ProductionRule rule)
        {
            throw new Exception();
        }
    }
}
