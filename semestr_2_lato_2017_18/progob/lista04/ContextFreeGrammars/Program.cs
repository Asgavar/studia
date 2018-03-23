using System;

namespace ContextFreeGrammars
{
    class Program
    {
        static void Main(string[] args)
        {
            for (short x = 0; x < 5; x++)
            {
                var grammar = new ABGrammar();
                var word = grammar.GetRandomWord();
                Console.WriteLine($"Wyraz {x}: {word}");
            }
        }
    }
}
