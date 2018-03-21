namespace ContextFreeGrammars
{
    public class ProductionRule
    {
        private ISymbol from;
        private ISymbol[] to;


        public ProductionRule(ISymbol from, ISymbol[] to)
        {
            this.from = from;
            this.to = to;
        }


        public ISymbol GetFrom()
        {
            return this.from;
        }


        public ISymbol[] GetTo()
        {
            return this.to;
        }
    }
}
