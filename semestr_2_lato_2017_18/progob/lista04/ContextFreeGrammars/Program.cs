using System;

namespace ContextFreeGrammars
{
    class Program
    {
        static void Main(string[] args)
        {
            var grammar = new ABGrammar();
            var word = grammar.GetRandomWord();
            Console.WriteLine(word);
        }
    }
}
