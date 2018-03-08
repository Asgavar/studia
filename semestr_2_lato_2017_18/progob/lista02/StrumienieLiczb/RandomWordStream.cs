using System;
using System.Linq;
using System.Globalization;
using System.Text;

namespace StrumienieLiczb
{
    public class RandomWordStream
    {
        private PrimeStream primeStream;
        private RandomStream rng;

        public RandomWordStream()
        {
            this.primeStream = new PrimeStream();
            this.rng = new RandomStream();
        }

        public string Next()
        {
            int desiredLength = primeStream.Next();
            var builder = new StringBuilder();
            for (int i = 0; i < desiredLength; i++)
            {
                builder.Append(GetRandomLatinLetter());
            }
            return builder.ToString();
        }

        private char GetRandomLatinLetter()
        {
            int offset = rng.Next() % 26;
            return (char) ('a' + offset);
        }
    }
}
