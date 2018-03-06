using System;

namespace StrumienieLiczb 
{
    class Program
    {
        static void Main(string[] args)
        {
            var primeStream = new PrimeStream();
            var randomStream = new RandomStream();
            var rws = new RandomWordStream();
            int primesSoFar = 0;
            int randomSoFar = 0;
            int wordsSoFar = 0;

            while (primesSoFar < 100)
            {
                Console.WriteLine("Pierwsza: " + primeStream.Next());
                ++primesSoFar;
            }

            while (randomSoFar < 100)
            {
                Console.WriteLine("Losowa: " + randomStream.Next());
                ++randomSoFar;
            }
            while (wordsSoFar < 10)
            {
                Console.WriteLine(rws.Next());
                ++wordsSoFar;
            }
        }
    }
}
