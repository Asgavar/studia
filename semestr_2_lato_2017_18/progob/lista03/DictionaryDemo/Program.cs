using System;
using System.Linq;

using Dictionary;

namespace DictionaryDemo
{
    class Program
    {
        static void Main(string[] args)
        {
            var dict = new Dictionary<int, string>();
            dict.Add(42, "czterdzieści dwa");
            dict.Add(44, "czterdzieści cztery");
            Console.WriteLine(dict.Get(42));
            Console.WriteLine(dict.Get(44));
            // czy rzeczywiscie bedzie rosl?
            foreach (var i in Enumerable.Range(50, 600))
            {
                dict.Add(i, "eee");
            }
            Console.WriteLine(dict);
        }
    }
}
