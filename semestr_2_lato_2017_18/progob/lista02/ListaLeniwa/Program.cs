using System;

namespace ListaLeniwa
{
    class Program
    {
        static void Main(string[] args)
        {
            var lazyList = new LazyList();
            for (int i = 0; i < 100; i++)
            {
                Console.WriteLine(lazyList.Element(i));
            }
        }
    }
}
