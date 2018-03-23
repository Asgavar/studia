using System;

namespace EnumerablePrimes
{
    class Program
    {
        /// <summary>
        ///   Wypisanych zostaje 101 pierwszych liczb pierwszych.
        /// </summary>
        static void Main(string[] args)
        {
            int counter = 0;
            foreach (var prime in new PrimeCollection())
            {
                Console.WriteLine(prime);
                ++counter;
                if (counter >= 100)
                {
                    break;
                }
            }
        }
    }
}
