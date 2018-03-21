using System.Collections.Generic;

namespace ContextFreeGrammars
{
    public interface ITerm
    {
        bool ReplaceSymbol(ProductionRule rule);
        List<ITerm> GetReplaceableSymbols();
    }
}
