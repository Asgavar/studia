using System;

namespace ListaLeniwa
{
    class Program
    {
        static void Main(string[] args)
        {
            var lazyList = new LazyList();
            var primesLazyList = new PrimesLazyList();
            for (int i = 0; i < 100; i++)
            {
                Console.WriteLine($"Lista losowa, element #{i}: {lazyList.Element(i)}");
                Console.WriteLine($"Lista liczb pierwszych, element #{i}: {primesLazyList.Element(i)}");
                Console.WriteLine();
            }
        }
    }
}
