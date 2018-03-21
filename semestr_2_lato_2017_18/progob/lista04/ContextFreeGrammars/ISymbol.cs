namespace ContextFreeGrammars
{
    public interface ISymbol : ITerm
    {
        string GetRepresentation();
        bool IsTerminal();
    }
}
